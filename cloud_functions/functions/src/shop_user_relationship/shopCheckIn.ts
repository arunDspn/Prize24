import {CallableRequest, onCall, HttpsError} from "firebase-functions/v2/https";
import {createHash} from "node:crypto";
import {FieldValue, getFirestore, Timestamp} from "firebase-admin/firestore";
import {getMessaging} from "firebase-admin/messaging";
import * as logger from "firebase-functions/logger";
import {
  CheckInUserRequest,
  AddOfferRequest,
  CheckInResponse,
  ShopFollowApiResponse,
  SHOP_FOLLOW_ERROR_CODES,
} from "../types";
import {createActivityLog, resolvePhoneNumber} from "../activityLog";

const db = getFirestore();
const messaging = getMessaging();
const BILL_NUMBER_MAX_LENGTH = 64;

type BillAmount = {
  amount: number;
  minorUnits: number;
};

/**
 * Validates and normalizes a bill number for storage and comparison.
 * @param {unknown} value Raw bill number
 * @return {{billNumber: string, normalizedBillNumber: string}} Validated bill number values
 */
export function validateBillNumber(value: unknown): {billNumber: string; normalizedBillNumber: string} {
  if (typeof value !== "string") {
    throw new HttpsError(
      "invalid-argument",
      "billNumber is required",
      SHOP_FOLLOW_ERROR_CODES.INVALID_BILL_NUMBER
    );
  }

  const billNumber = value.trim();
  if (billNumber.length === 0 || billNumber.length > BILL_NUMBER_MAX_LENGTH) {
    throw new HttpsError(
      "invalid-argument",
      `billNumber must contain between 1 and ${BILL_NUMBER_MAX_LENGTH} characters`,
      SHOP_FOLLOW_ERROR_CODES.INVALID_BILL_NUMBER
    );
  }

  return {
    billNumber,
    normalizedBillNumber: billNumber.normalize("NFKC").toUpperCase(),
  };
}

/**
 * Validates an amount and converts it to exact integer minor units.
 * @param {unknown} value Raw bill amount
 * @return {BillAmount} Validated decimal and minor-unit amount
 */
export function validateBillAmount(value: unknown): BillAmount {
  if (typeof value !== "number" || !Number.isFinite(value) || value <= 0) {
    throw new HttpsError(
      "invalid-argument",
      "billAmount must be a finite number greater than zero",
      SHOP_FOLLOW_ERROR_CODES.INVALID_BILL_AMOUNT
    );
  }

  const scaledAmount = value * 100;
  const minorUnits = Math.round(scaledAmount);
  if (!Number.isSafeInteger(minorUnits) || Math.abs(scaledAmount - minorUnits) > 1e-7) {
    throw new HttpsError(
      "invalid-argument",
      "billAmount must have at most two decimal places",
      SHOP_FOLLOW_ERROR_CODES.INVALID_BILL_AMOUNT
    );
  }

  return {amount: minorUnits / 100, minorUnits};
}

/**
 * Converts a persisted decimal amount to minor units, defaulting missing values to zero.
 * @param {unknown} value Persisted decimal amount
 * @return {number} Integer minor-unit amount
 */
function persistedAmountToMinorUnits(value: unknown): number {
  if (typeof value !== "number" || !Number.isFinite(value)) {
    return 0;
  }
  const minorUnits = Math.round(value * 100);
  return Number.isSafeInteger(minorUnits) ? minorUnits : 0;
}

/**
 * Returns the highest gift milestone crossed by this check-in, or null.
 * @param {number} previousStreak Streak before this check-in
 * @param {number} newStreak Streak after this check-in
 * @param {number | null} giftCycleDay Configured gift interval
 * @param {number | null} lastGiftDayStreak Last awarded gift milestone
 * @return {number | null} Highest crossed, unawarded milestone
 */
export function crossedGiftMilestone(
  previousStreak: number,
  newStreak: number,
  giftCycleDay: number | null,
  lastGiftDayStreak: number | null
): number | null {
  if (!giftCycleDay || giftCycleDay <= 0 || newStreak <= previousStreak) {
    return null;
  }

  const highestCrossedMilestone = Math.floor(newStreak / giftCycleDay) * giftCycleDay;
  const nextMilestone = (Math.floor(previousStreak / giftCycleDay) + 1) * giftCycleDay;
  if (
    highestCrossedMilestone < nextMilestone ||
    (lastGiftDayStreak !== null && highestCrossedMilestone <= lastGiftDayStreak)
  ) {
    return null;
  }

  return highestCrossedMilestone;
}

type BillTotals = {
  cycleBillSum: number;
  previousCycleBillSum: number;
  cumulativeBillSum: number;
};

/**
 * Calculates the post-check-in bill totals using integer minor units.
 * @param {unknown} cycleBillSum Current open-cycle sum
 * @param {unknown} previousCycleBillSum Most recently completed cycle sum
 * @param {unknown} cumulativeBillSum Lifetime sum
 * @param {number} billMinorUnits New bill amount in minor units
 * @param {boolean} closesCycle Whether this check-in closes the current cycle
 * @return {BillTotals} Normalized post-check-in totals
 */
export function calculateBillTotals(
  cycleBillSum: unknown,
  previousCycleBillSum: unknown,
  cumulativeBillSum: unknown,
  billMinorUnits: number,
  closesCycle: boolean
): BillTotals {
  const currentCycleMinor = persistedAmountToMinorUnits(cycleBillSum);
  const previousCycleMinor = persistedAmountToMinorUnits(previousCycleBillSum);
  const cumulativeMinor = persistedAmountToMinorUnits(cumulativeBillSum);
  const closingCycleMinor = currentCycleMinor + billMinorUnits;

  return {
    cycleBillSum: (closesCycle ? 0 : closingCycleMinor) / 100,
    previousCycleBillSum: (closesCycle ? closingCycleMinor : previousCycleMinor) / 100,
    cumulativeBillSum: (cumulativeMinor + billMinorUnits) / 100,
  };
}

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

type CheckInTransactionResult = {
  cumulativeStreak: number;
  consecutiveDays: number;
  bonusApplied: boolean;
  isGiftDay: boolean;
  crossedMilestone: number | null;
  wasAutoFollowed: boolean;
};

/**
 * Handles the bill-aware check-in callable.
 * @param {CallableRequest<CheckInUserRequest>} request Callable request
 * @return {Promise<CheckInResponse>} Check-in response
 */
async function handleCheckInUser(
  request: CallableRequest<CheckInUserRequest>
): Promise<CheckInResponse> {
  if (!request.auth) {
    throw new HttpsError(
      "unauthenticated",
      "User must be authenticated",
      SHOP_FOLLOW_ERROR_CODES.UNAUTHORIZED
    );
  }

  const scannerId = request.auth.uid;
  const {userId, shopId} = request.data;
  const {billNumber, normalizedBillNumber} = validateBillNumber(request.data.billNumber);
  const validatedBillAmount = validateBillAmount(request.data.billAmount);
  let customerPhoneNumber: string | null = null;

  if (!userId || !shopId) {
    throw new HttpsError(
      "invalid-argument",
      "userId, shopId, billNumber, and billAmount are required"
    );
  }

  try {
    const {isOwner, isStaff} = await validateScanner(scannerId, shopId);
    if (!isOwner && !isStaff) {
      throw new HttpsError(
        "permission-denied",
        "You are not authorized to check in users at this shop",
        SHOP_FOLLOW_ERROR_CODES.SCANNER_NOT_AUTHORIZED
      );
    }

    const [scannerDoc, userDoc, shopDoc] = await Promise.all([
      db.collection("users").doc(scannerId).get(),
      db.collection("users").doc(userId).get(),
      db.collection("shops").doc(shopId).get(),
    ]);

    if (!userDoc.exists) {
      throw new HttpsError(
        "not-found",
        "User not found",
        SHOP_FOLLOW_ERROR_CODES.USER_NOT_FOUND
      );
    }
    if (!shopDoc.exists) {
      throw new HttpsError(
        "not-found",
        "Shop not found",
        SHOP_FOLLOW_ERROR_CODES.SHOP_NOT_FOUND
      );
    }

    const scannerData = scannerDoc.data();
    const scannerName = scannerData?.userName || scannerData?.displayName || "Unknown";
    const scannerType = isOwner ? "owner" : "staff";
    const userData = userDoc.data();
    const userName = userData?.name || userData?.userName || "Anonymous User";
    const userProfilePic = userData?.userAvatar || userData?.photoURL || null;
    const fcmToken = userData?.fcmToken;
    customerPhoneNumber = resolvePhoneNumber(userData);

    const shopData = shopDoc.data();
    const associatedCampaignId = shopData?.associatedCampaignId || null;
    const campaignName = shopData?.campaignName || "";
    const giftCycleDay = shopData?.giftCycleDay || null;
    const bonusIncrementDaysRequired = shopData?.bonusIncrementDaysRequired || null;
    const bonusIncrementValue = shopData?.bonusIncrementValue || null;
    const shopName = shopData?.name || shopData?.shopName || "Shop";
    const shopDescription = shopData?.description || shopData?.shopDescription || "";
    const shopAddress = shopData?.address || shopData?.shopAddress || "";
    const shopPhone = shopData?.phone || shopData?.shopPhone || "";
    const now = Timestamp.now();

    const followerRef = db.collection("shops").doc(shopId).collection("followers").doc(userId);
    const userFollowingRef = db.collection("users").doc(userId).collection("followedShops").doc(shopId);
    const billHash = createHash("sha256").update(normalizedBillNumber).digest("hex");
    const processedBillRef = db.collection("shops").doc(shopId).collection("processedBills").doc(billHash);
    const checkInLogRef = followerRef.collection("checkInLogs").doc();
    const activityLogRef = db.collection("shops").doc(shopId).collection("activityLogs").doc();
    const followerAddedLogRef = db.collection("shops").doc(shopId).collection("activityLogs").doc();

    const result = await db.runTransaction<CheckInTransactionResult>(async (transaction) => {
      const [followerDoc, processedBillDoc] = await transaction.getAll(followerRef, processedBillRef);
      const followerData = followerDoc.data();
      const lastCheckInDate = (followerData?.lastCheckInDate as Timestamp | null | undefined) || null;

      if (isCheckedInToday(lastCheckInDate)) {
        throw new HttpsError(
          "already-exists",
          "User has already checked in today",
          SHOP_FOLLOW_ERROR_CODES.ALREADY_CHECKED_IN_TODAY
        );
      }
      if (processedBillDoc.exists) {
        throw new HttpsError(
          "already-exists",
          "This bill number has already been used for this shop",
          SHOP_FOLLOW_ERROR_CODES.BILL_NUMBER_ALREADY_USED
        );
      }

      const wasAutoFollowed = !followerDoc.exists;
      const currentCumulativeStreak = Number(followerData?.cumulativeStreak) || 0;
      const currentConsecutiveDays = Number(followerData?.consecutiveDays) || 0;
      const lastGiftDayStreak = (followerData?.lastGiftDayStreak as number | null | undefined) ?? null;
      const lastBonusDate = (followerData?.lastBonusDate as Timestamp | null | undefined) || null;
      const consecutiveContinues = wasCheckedInYesterday(lastCheckInDate);
      const newConsecutiveDays = consecutiveContinues ? currentConsecutiveDays + 1 : 1;

      let bonusApplied = false;
      let streakIncrement = 1;
      if (
        bonusIncrementDaysRequired &&
        bonusIncrementValue &&
        consecutiveContinues &&
        newConsecutiveDays % bonusIncrementDaysRequired === 0 &&
        (!lastBonusDate || !isCheckedInToday(lastBonusDate))
      ) {
        streakIncrement = bonusIncrementValue;
        bonusApplied = true;
      }

      const newCumulativeStreak = currentCumulativeStreak + streakIncrement;
      const milestone = associatedCampaignId ? crossedGiftMilestone(
        currentCumulativeStreak,
        newCumulativeStreak,
        giftCycleDay,
        lastGiftDayStreak
      ) : null;
      const isGiftDay = milestone !== null;

      const billTotals = calculateBillTotals(
        followerData?.cycleBillSum,
        followerData?.previousCycleBillSum,
        followerData?.cumulativeBillSum,
        validatedBillAmount.minorUnits,
        isGiftDay
      );
      const {
        cycleBillSum: newCycleBillSum,
        previousCycleBillSum: newPreviousCycleBillSum,
        cumulativeBillSum: newCumulativeBillSum,
      } = billTotals;

      const relationshipUpdate = {
        cumulativeStreak: newCumulativeStreak,
        consecutiveDays: newConsecutiveDays,
        lastCheckInDate: now,
        cycleBillSum: newCycleBillSum,
        previousCycleBillSum: newPreviousCycleBillSum,
        cumulativeBillSum: newCumulativeBillSum,
        updatedAt: now,
        ...(bonusApplied ? {lastBonusDate: now} : {}),
        ...(isGiftDay ? {lastGiftDayStreak: milestone} : {}),
      };

      if (wasAutoFollowed) {
        transaction.set(followerRef, {
          userId,
          userName,
          userProfilePic,
          notificationEnabled: true,
          lastGiftDayStreak: isGiftDay ? milestone : null,
          lastBonusDate: bonusApplied ? now : null,
          followedAt: now,
          createdAt: now,
          ...relationshipUpdate,
        });
        transaction.set(userFollowingRef, {
          shopId,
          shopName,
          shopDescription,
          shopAddress,
          shopPhone,
          notificationEnabled: true,
          followedAt: now,
          ...relationshipUpdate,
        });
        transaction.set(db.collection("users").doc(userId), {
          totalFollowing: FieldValue.increment(1),
          subscribedShopTopics: FieldValue.arrayUnion(shopId),
        }, {merge: true});
        transaction.set(db.collection("shops").doc(shopId), {
          totalFollowers: FieldValue.increment(1),
        }, {merge: true});
        transaction.set(followerAddedLogRef, {
          logId: followerAddedLogRef.id,
          timestamp: now,
          action: "follower_added",
          success: true,
          actorId: scannerId,
          actorRole: scannerType,
          functionName: "checkInUser",
          customerId: userId,
          addedMethod: "auto_check_in",
          initialStreak: newCumulativeStreak,
          shopId,
        });
      } else {
        transaction.update(followerRef, relationshipUpdate);
        transaction.set(userFollowingRef, relationshipUpdate, {merge: true});
      }

      transaction.create(processedBillRef, {
        billNumber,
        normalizedBillNumber,
        billAmount: validatedBillAmount.amount,
        customerId: userId,
        scannerId,
        checkInLogId: checkInLogRef.id,
        activityLogId: activityLogRef.id,
        processedAt: now,
      });

      const billLogData = {
        billNumber,
        billAmount: validatedBillAmount.amount,
        cycleBillSum: newCycleBillSum,
        previousCycleBillSum: newPreviousCycleBillSum,
        cumulativeBillSum: newCumulativeBillSum,
      };
      transaction.set(checkInLogRef, {
        scannerId,
        scannerName,
        scannerType,
        scanTime: now,
        isGiftDay,
        cumulativeStreak: newCumulativeStreak,
        consecutiveDays: newConsecutiveDays,
        bonusApplied,
        comment: "",
        ...billLogData,
      });
      transaction.set(activityLogRef, {
        logId: activityLogRef.id,
        timestamp: now,
        action: "check_in_success",
        success: true,
        actorId: scannerId,
        actorRole: scannerType,
        functionName: "checkInUser",
        customerId: userId,
        shopId,
        cumulativeStreak: newCumulativeStreak,
        consecutiveDays: newConsecutiveDays,
        bonusApplied,
        bonusValue: bonusApplied ? streakIncrement : null,
        isGiftDay,
        campaignId: isGiftDay ? associatedCampaignId : null,
        wasAutoFollowed,
        previousStreak: currentCumulativeStreak,
        phoneNumber: customerPhoneNumber,
        crossedMilestone: milestone,
        ...billLogData,
      });

      return {
        cumulativeStreak: newCumulativeStreak,
        consecutiveDays: newConsecutiveDays,
        bonusApplied,
        isGiftDay,
        crossedMilestone: milestone,
        wasAutoFollowed,
      };
    });

    if (result.wasAutoFollowed && typeof fcmToken === "string" && fcmToken.trim().length > 0) {
      try {
        await messaging.subscribeToTopic([fcmToken], shopId);
      } catch (fcmError) {
        logger.error("FCM subscription failed after check-in:", fcmError);
      }
    }

    try {
      if (typeof fcmToken === "string" && fcmToken.trim().length > 0) {
        await messaging.send({
          data: {
            type: "check_in",
            shopId,
            shopName,
            currentStreak: result.cumulativeStreak.toString(),
            isGiftDay: result.isGiftDay.toString(),
            bonusApplied: result.bonusApplied.toString(),
          },
          token: fcmToken,
        });
      } else {
        logger.warn("User does not have FCM token, skipping notification", {userId});
      }
    } catch (fcmError) {
      logger.error("FCM notification failed, continuing with check-in success:", fcmError);
    }

    logger.info("User checked in successfully", {
      scannerId,
      userId,
      shopId,
      isOwner,
      isStaff,
      newCumulativeStreak: result.cumulativeStreak,
      newConsecutiveDays: result.consecutiveDays,
      bonusApplied: result.bonusApplied,
      isGiftDay: result.isGiftDay,
      crossedMilestone: result.crossedMilestone,
    });

    const giftInfo = result.isGiftDay && associatedCampaignId ? {
      campaignId: associatedCampaignId,
      campaignName,
      message: `Congratulations! You've reached ${result.crossedMilestone} check-ins. It's gift day!`,
    } : undefined;

    return {
      success: true,
      message: result.wasAutoFollowed ?
        "User was added as follower and checked in successfully" :
        result.isGiftDay ? "Check-in successful! It's gift day!" : "Check-in successful",
      data: {
        cumulativeStreak: result.cumulativeStreak,
        consecutiveDays: result.consecutiveDays,
        bonusApplied: result.bonusApplied,
        isGiftDay: result.isGiftDay,
        isNewUser: result.wasAutoFollowed,
        wasAutoFollowed: result.wasAutoFollowed,
        giftInfo,
      },
    };
  } catch (error: unknown) {
    if (error instanceof HttpsError) {
      throw error;
    }

    logger.error("Error in checkInUser:", error);
    const errorMessage = error instanceof Error ? error.message : String(error);
    await createActivityLog(`shops/${shopId}/activityLogs`, {
      action: "check_in_failed",
      success: false,
      actorId: scannerId,
      actorRole: "system",
      functionName: "checkInUser",
      customerId: userId,
      shopId,
      failureReason: "unknown",
      errorCode: "unknown",
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

/**
 * Check In User
 * Vendor or staff scans user QR code for daily check-in
 * Handles cumulative streak, consecutive days, multiplier bonus, and gift day detection
 */
export const checkInUser = onCall<CheckInUserRequest, Promise<CheckInResponse>>(handleCheckInUser);

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
