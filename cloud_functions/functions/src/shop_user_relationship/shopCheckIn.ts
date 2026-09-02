import {onCall, HttpsError} from "firebase-functions/v2/https";
import {getFirestore, Timestamp} from "firebase-admin/firestore";
import {getMessaging} from "firebase-admin/messaging";
import * as logger from "firebase-functions/logger";
import {
  CheckInUserRequest,
  AddOfferRequest,
  CheckInResponse,
  ShopFollowApiResponse,
  SHOP_FOLLOW_ERROR_CODES,
} from "../types";
import {followUserToShop} from "./shopFollow";
import {createActivityLog, resolvePhoneNumber} from "../activityLog";

const db = getFirestore();
const messaging = getMessaging();

/**
 * Helper function to check if scanner is authorized (vendor or staff)
 * @param {string} scannerId - The ID of the user attempting to scan
 * @param {string} shopId - The ID of the shop
 * @return {Promise<Object>} Object indicating if scanner is owner or staff
 */
async function validateScanner(scannerId: string, shopId: string): Promise<{ isOwner: boolean; isStaff: boolean }> {
  // Check if scanner is the shop owner
  const shopDoc = await db.collection("shops").doc(shopId).get();
  if (!shopDoc.exists) {
    throw new HttpsError(
      "not-found",
      "Shop not found",
      SHOP_FOLLOW_ERROR_CODES.SHOP_NOT_FOUND
    );
  }

  const shopData = shopDoc.data();
  const isOwner = shopData?.shopOwnerId === scannerId;

  // Check if scanner is active staff
  let isStaff = false;
  if (!isOwner) {
    // const staffDoc = await db.collection("shopStaff").doc(`${shopId}_${scannerId}`).get();
    // if (staffDoc.exists && staffDoc.data()?.status === "active") {
    //   isStaff = true;
    // }
    const requesterDoc = await db.collection("users").doc(scannerId).get();
    if (!requesterDoc.exists) {
      throw new HttpsError(
        "not-found",
        "Requester not found",
        SHOP_FOLLOW_ERROR_CODES.UNAUTHORIZED
      );
    }

    const requesterData = requesterDoc.data();
    const staffShopIds = requesterData?.staffShopIds || [];

    if (!Array.isArray(staffShopIds) || !staffShopIds.includes(shopId)) {
      throw new HttpsError(
        "permission-denied",
        "You are not authorized to add followers for this shop",
        SHOP_FOLLOW_ERROR_CODES.UNAUTHORIZED
      );
    }

    isStaff = true;
  }

  return {isOwner, isStaff};
}

/**
 * Helper function to check if user already checked in today
 * @param {Timestamp | null} lastCheckInDate - The timestamp of the last check-in
 * @return {boolean} True if user already checked in today
 */
function isCheckedInToday(lastCheckInDate: Timestamp | null): boolean {
  if (!lastCheckInDate) {
    return false;
  }

  const now = new Date();
  const lastCheckIn = lastCheckInDate.toDate();

  // Simple day comparison (same calendar day)
  return (
    now.getFullYear() === lastCheckIn.getFullYear() &&
    now.getMonth() === lastCheckIn.getMonth() &&
    now.getDate() === lastCheckIn.getDate()
  );
}

/**
 * Helper function to check if last check-in was yesterday
 * @param {Timestamp | null} lastCheckInDate - The timestamp of the last check-in
 * @return {boolean} True if user checked in yesterday
 */
function wasCheckedInYesterday(lastCheckInDate: Timestamp | null): boolean {
  if (!lastCheckInDate) {
    return false;
  }

  const now = new Date();
  const yesterday = new Date(now);
  yesterday.setDate(yesterday.getDate() - 1);

  const lastCheckIn = lastCheckInDate.toDate();

  return (
    yesterday.getFullYear() === lastCheckIn.getFullYear() &&
    yesterday.getMonth() === lastCheckIn.getMonth() &&
    yesterday.getDate() === lastCheckIn.getDate()
  );
}

/**
 * Check In User
 * Vendor or staff scans user QR code for daily check-in
 * Handles cumulative streak, consecutive days, multiplier bonus, and gift day detection
 */
export const checkInUser = onCall<CheckInUserRequest, Promise<CheckInResponse>>(
  async (request) => {
    // Verify authentication
    if (!request.auth) {
      throw new HttpsError(
        "unauthenticated",
        "User must be authenticated",
        SHOP_FOLLOW_ERROR_CODES.UNAUTHORIZED
      );
    }

    const scannerId = request.auth.uid;
    const {userId, shopId} = request.data;
    // Resolved once the customer doc is fetched; stays null if that never happens (e.g. early failure)
    let customerPhoneNumber: string | null = null;

    // Validate input
    if (!userId || !shopId) {
      throw new HttpsError(
        "invalid-argument",
        "userId and shopId are required"
      );
    }

    try {
      // 1. Validate scanner authorization (vendor or staff)
      const {isOwner, isStaff} = await validateScanner(scannerId, shopId);

      if (!isOwner && !isStaff) {
        throw new HttpsError(
          "permission-denied",
          "You are not authorized to check in users at this shop",
          SHOP_FOLLOW_ERROR_CODES.SCANNER_NOT_AUTHORIZED
        );
      }

      // Get scanner details for logging
      const scannerDoc = await db.collection("users").doc(scannerId).get();
      const scannerData = scannerDoc.data();
      const scannerName = scannerData?.userName || scannerData?.displayName || "Unknown";
      const scannerType = isOwner ? "owner" : "staff";

      // Get customer details for FCM and audit logging (phone number)
      const userDoc = await db.collection("users").doc(userId).get();
      const userData = userDoc.data();
      const fcmToken = userData?.fcmToken;
      customerPhoneNumber = resolvePhoneNumber(userData);

      // 2. Get shop data for gift configuration
      const shopDoc = await db.collection("shops").doc(shopId).get();
      const shopData = shopDoc.data();

      const associatedCampaignId = shopData?.associatedCampaignId || null;
      const campaignName = shopData?.campaignName || "";
      const giftCycleDay = shopData?.giftCycleDay || null;
      const bonusIncrementDaysRequired = shopData?.bonusIncrementDaysRequired || null;
      const bonusIncrementValue = shopData?.bonusIncrementValue || null;
      const shopName = shopData?.name || shopData?.shopName || "Shop";

      // 3. Get follower document - check if user is following
      const followerRef = db.collection("shops").doc(shopId).collection("followers").doc(userId);
      const followerDoc = await followerRef.get();

      let wasAutoFollowed = false;

      if (!followerDoc.exists) {
        // User is not following - auto-follow them first
        logger.info("User not following shop, auto-following before check-in", {
          scannerId,
          userId,
          shopId,
          scannerType,
        });

        try {
          // Auto-follow with initial streak of 1 and consecutive days of 1
          await followUserToShop(userId, shopId, 1, 1);
          wasAutoFollowed = true;
        } catch (followError: any) {
          // If already following error, continue (race condition)
          if (followError.code !== "already-exists") {
            throw followError;
          }
        }
      }

      // Re-fetch follower document after potential auto-follow
      const updatedFollowerDoc = await followerRef.get();

      if (!updatedFollowerDoc.exists) {
        throw new HttpsError(
          "internal",
          "Failed to create follower relationship",
          SHOP_FOLLOW_ERROR_CODES.TRANSACTION_FAILED
        );
      }

      const followerData = updatedFollowerDoc.data();
      const lastCheckInDate = followerData?.lastCheckInDate || null;

      // If user was auto-followed, they already have streak of 1, so return success immediately
      if (wasAutoFollowed) {
        logger.info("User auto-followed and checked in", {
          scannerId,
          userId,
          shopId,
          isOwner,
          isStaff,
        });

        // Log follower_added activity
        await createActivityLog(`shops/${shopId}/activityLogs`, {
          action: "follower_added",
          success: true,
          actorId: scannerId,
          actorRole: isOwner ? "owner" : "staff",
          functionName: "checkInUser",
          customerId: userId,
          addedMethod: "auto_check_in",
          initialStreak: 1,
          shopId,
        });

        // Log check_in_success activity
        await createActivityLog(`shops/${shopId}/activityLogs`, {
          action: "check_in_success",
          success: true,
          actorId: scannerId,
          actorRole: isOwner ? "owner" : "staff",
          functionName: "checkInUser",
          customerId: userId,
          shopId,
          cumulativeStreak: 1,
          consecutiveDays: 1,
          bonusApplied: false,
          bonusValue: null,
          isGiftDay: false,
          campaignId: null,
          wasAutoFollowed: true,
          previousStreak: 0,
          phoneNumber: customerPhoneNumber,
        });

        // 7. Send FCM notification to the user
        try {
          if (fcmToken) {
            const message = {
              data: {
                type: "check_in",
                shopId: shopId,
                shopName: shopName,
                currentStreak: "1",
                isGiftDay: "false",
                bonusApplied: "false",
              },
              token: fcmToken,
            };

            await messaging.send(message);
            logger.info("FCM data message sent successfully", {userId, shopId, isGiftDay: false});
          } else {
            logger.warn("User does not have FCM token, skipping notification", {userId});
          }
        } catch (fcmError) {
          logger.error("FCM notification failed, continuing with check-in success:", fcmError);
        }

        return {
          success: true,
          message: "User was added as follower and checked in successfully",
          data: {
            cumulativeStreak: 1,
            consecutiveDays: 1,
            bonusApplied: false,
            isGiftDay: false,
            isNewUser: true,
            wasAutoFollowed: true,
            giftInfo: undefined,
          },
        };
      }

      // 4. Check if already checked in today
      if (isCheckedInToday(lastCheckInDate)) {
        throw new HttpsError(
          "already-exists",
          "User has already checked in today",
          SHOP_FOLLOW_ERROR_CODES.ALREADY_CHECKED_IN_TODAY
        );
      }

      // 5. Calculate streak updates
      const currentCumulativeStreak = followerData?.cumulativeStreak || 0;
      const currentConsecutiveDays = followerData?.consecutiveDays || 0;
      const lastGiftDayStreak = followerData?.lastGiftDayStreak || null;
      const lastBonusDate = followerData?.lastBonusDate || null;

      // Determine if consecutive streak continues
      const consecutiveContinues = wasCheckedInYesterday(lastCheckInDate);
      const newConsecutiveDays = consecutiveContinues ? currentConsecutiveDays + 1 : 1;

      // Check if eligible for multiplier bonus
      let bonusApplied = false;
      let streakIncrement = 1;

      if (
        bonusIncrementDaysRequired &&
        bonusIncrementValue &&
        consecutiveContinues &&
        newConsecutiveDays % bonusIncrementDaysRequired === 0
      ) {
        // Check if bonus wasn't applied today already (shouldn't happen, but safety check)
        if (!lastBonusDate || !isCheckedInToday(lastBonusDate)) {
          streakIncrement = bonusIncrementValue;
          bonusApplied = true;
        }
      }

      const newCumulativeStreak = currentCumulativeStreak + streakIncrement;

      // Check if it's a gift day
      let isGiftDay = false;
      let giftInfo = undefined;

      if (
        associatedCampaignId &&
        giftCycleDay &&
        newCumulativeStreak % giftCycleDay === 0 &&
        (!lastGiftDayStreak || lastGiftDayStreak < newCumulativeStreak)
      ) {
        isGiftDay = true;
        giftInfo = {
          campaignId: associatedCampaignId,
          campaignName: campaignName,
          message: `Congratulations! You've reached ${newCumulativeStreak} check-ins. It's gift day!`,
        };
      }

      const now = Timestamp.now();

      // 6. Run transaction to update streak data
      await db.runTransaction(async (transaction) => {
        // Update follower document with new streak data
        const updateData: any = {
          cumulativeStreak: newCumulativeStreak,
          consecutiveDays: newConsecutiveDays,
          lastCheckInDate: now,
          updatedAt: now,
        };

        if (bonusApplied) {
          updateData.lastBonusDate = now;
        }

        if (isGiftDay) {
          updateData.lastGiftDayStreak = newCumulativeStreak;
        }

        transaction.update(followerRef, updateData);

        // Update user's following document (read-only copy)
        const userFollowingRef = db
          .collection("users")
          .doc(userId)
          .collection("followedShops")
          .doc(shopId);

        transaction.update(userFollowingRef, {
          cumulativeStreak: newCumulativeStreak,
          consecutiveDays: newConsecutiveDays,
          lastCheckInDate: now,
          updatedAt: now,
        });

        // Create check-in log entry
        const checkInLogRef = db
          .collection("shops")
          .doc(shopId)
          .collection("followers")
          .doc(userId)
          .collection("checkInLogs")
          .doc();

        const checkInLogData = {
          scannerId: scannerId,
          scannerName: scannerName,
          scannerType: scannerType,
          scanTime: now,
          isGiftDay: isGiftDay,
          cumulativeStreak: newCumulativeStreak,
          consecutiveDays: newConsecutiveDays,
          comment: "",
        };

        transaction.set(checkInLogRef, checkInLogData);
      });

      logger.info("User checked in successfully", {
        scannerId,
        userId,
        shopId,
        isOwner,
        isStaff,
        newCumulativeStreak,
        newConsecutiveDays,
        bonusApplied,
        isGiftDay,
      });

      // Activity log — written outside transaction
      await createActivityLog(`shops/${shopId}/activityLogs`, {
        action: "check_in_success",
        success: true,
        actorId: scannerId,
        actorRole: isOwner ? "owner" : "staff",
        functionName: "checkInUser",
        customerId: userId,
        shopId,
        cumulativeStreak: newCumulativeStreak,
        consecutiveDays: newConsecutiveDays,
        bonusApplied,
        bonusValue: bonusApplied ? streakIncrement : null,
        isGiftDay,
        campaignId: isGiftDay ? associatedCampaignId : null,
        wasAutoFollowed: false,
        previousStreak: currentCumulativeStreak,
        phoneNumber: customerPhoneNumber,
      });

      // 7. Send FCM notification to the user
      try {
        if (fcmToken) {
          const message = {
            data: {
              type: "check_in",
              shopId: shopId,
              shopName: shopName,
              currentStreak: newCumulativeStreak.toString(),
              isGiftDay: isGiftDay.toString(),
              bonusApplied: bonusApplied.toString(),
            },
            token: fcmToken,
          };

          await messaging.send(message);
          logger.info("FCM data message sent successfully", {userId, shopId, isGiftDay});
        } else {
          logger.warn("User does not have FCM token, skipping notification", {userId});
        }
      } catch (fcmError) {
        logger.error("FCM notification failed, continuing with check-in success:", fcmError);
        // Continue even if notification fails - check-in was successful
      }

      // 8. Return response
      return {
        success: true,
        message: isGiftDay ? "Check-in successful! It's gift day!" : "Check-in successful",
        data: {
          cumulativeStreak: newCumulativeStreak,
          consecutiveDays: newConsecutiveDays,
          bonusApplied,
          isGiftDay,
          isNewUser: false,
          wasAutoFollowed: false,
          giftInfo,
        },
      };
    } catch (error: any) {
      if (error instanceof HttpsError) {
        throw error;
      }

      logger.error("Error in checkInUser:", error);

      const errorCode = error instanceof HttpsError ? error.code : "unknown";
      const errorMessage = error instanceof Error ? error.message : String(error);
      await createActivityLog(`shops/${shopId}/activityLogs`, {
        action: "check_in_failed",
        success: false,
        actorId: scannerId,
        actorRole: "system",
        functionName: "checkInUser",
        customerId: userId,
        shopId,
        failureReason: errorCode,
        errorCode,
        errorMessage,
        phoneNumber: customerPhoneNumber,
      });

      throw new HttpsError(
        "internal",
        "Failed to check in user",
        SHOP_FOLLOW_ERROR_CODES.TRANSACTION_FAILED
      );
    }
  }
);

/**
 * Add Offer to Shop
 * Vendor adds a promotional offer and notifies all followers
 */
export const addOfferToShop = onCall<AddOfferRequest, Promise<ShopFollowApiResponse>>(
  async (request) => {
    // Verify authentication
    if (!request.auth) {
      throw new HttpsError(
        "unauthenticated",
        "User must be authenticated",
        SHOP_FOLLOW_ERROR_CODES.UNAUTHORIZED
      );
    }

    const vendorId = request.auth.uid;
    const {shopId, name, description, startDate, endDate} = request.data;

    // Validate input
    if (!shopId || !name || !description || !startDate || !endDate) {
      throw new HttpsError(
        "invalid-argument",
        "shopId, name, description, startDate, and endDate are required"
      );
    }

    try {
      // 1. Validate shop ownership
      const shopDoc = await db.collection("shops").doc(shopId).get();
      if (!shopDoc.exists) {
        throw new HttpsError(
          "not-found",
          "Shop not found",
          SHOP_FOLLOW_ERROR_CODES.SHOP_NOT_FOUND
        );
      }

      const shopData = shopDoc.data();
      if (shopData?.shopOwnerId !== vendorId) {
        throw new HttpsError(
          "permission-denied",
          "You do not own this shop",
          SHOP_FOLLOW_ERROR_CODES.NOT_SHOP_OWNER
        );
      }

      if (shopData?.shopStatus !== "active") {
        throw new HttpsError(
          "failed-precondition",
          "Shop is not active",
          SHOP_FOLLOW_ERROR_CODES.SHOP_INACTIVE
        );
      }

      // 2. Validate dates
      const startDateObj = new Date(startDate);
      const endDateObj = new Date(endDate);

      if (isNaN(startDateObj.getTime()) || isNaN(endDateObj.getTime())) {
        throw new HttpsError(
          "invalid-argument",
          "Invalid date format. Use ISO date strings."
        );
      }

      if (endDateObj <= startDateObj) {
        throw new HttpsError(
          "invalid-argument",
          "End date must be after start date",
          SHOP_FOLLOW_ERROR_CODES.OFFER_INVALID_DATES
        );
      }

      const now = Timestamp.now();
      const shopName = shopData?.name || shopData?.shopName || "Shop";

      // 3. Create offer document
      const offerRef = db.collection("shops").doc(shopId).collection("offers").doc();

      const offerData = {
        offerId: offerRef.id,
        name,
        description,
        startDate: Timestamp.fromDate(startDateObj),
        endDate: Timestamp.fromDate(endDateObj),
        status: startDateObj <= new Date() ? "active" : "inactive",
        createdBy: vendorId,
        createdAt: now,
        updatedAt: now,
      };

      await offerRef.set(offerData);

      // 4. Send FCM notification to all followers
      let notificationsSent = 0;
      try {
        const message = {
          notification: {
            title: `New Offer at ${shopName}!`,
            body: `${name} - ${description}`,
          },
          data: {
            type: "new_offer",
            shopId: shopId,
            offerId: offerRef.id,
            offerName: name,
            offerDescription: description,
          },
          topic: shopId,
        };

        await messaging.send(message);

        // Count followers for reporting (approximate)
        const followersSnapshot = await db
          .collection("shops")
          .doc(shopId)
          .collection("followers")
          .where("notificationEnabled", "==", true)
          .count()
          .get();

        notificationsSent = followersSnapshot.data().count;
      } catch (fcmError) {
        logger.error("FCM notification failed:", fcmError);
        // Continue even if notification fails
      }

      logger.info("Offer added to shop", {
        vendorId,
        shopId,
        offerId: offerRef.id,
        notificationsSent,
      });

      return {
        success: true,
        message: "Offer added successfully",
        data: {
          offerId: offerRef.id,
          name,
          description,
          startDate: startDateObj.toISOString(),
          endDate: endDateObj.toISOString(),
          status: offerData.status,
          notificationsSent,
          createdAt: now.toDate().toISOString(),
        },
      };
    } catch (error: any) {
      if (error instanceof HttpsError) {
        throw error;
      }

      logger.error("Error in addOfferToShop:", error);
      throw new HttpsError(
        "internal",
        "Failed to add offer",
        SHOP_FOLLOW_ERROR_CODES.TRANSACTION_FAILED
      );
    }
  }
);
