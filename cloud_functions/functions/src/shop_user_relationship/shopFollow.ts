import {onCall, HttpsError} from "firebase-functions/v2/https";
import {getFirestore, FieldValue, Timestamp} from "firebase-admin/firestore";
import {getMessaging} from "firebase-admin/messaging";
import * as logger from "firebase-functions/logger";
import {
  FollowShopByVendorRequest,
  FollowShopByStaffRequest,
  UnfollowShopRequest,
  RemoveFollowerRequest,
  ShopFollowApiResponse,
  UserFollowingShop,
  ShopFollower,
  SHOP_FOLLOW_ERROR_CODES,
} from "../types";

const db = getFirestore();
const messaging = getMessaging();

/**
 * Helper function to follow a user to a shop
 * Can be used by vendor, staff, or during check-in process
 * @param {string} userId - The ID of the user to follow
 * @param {string} shopId - The ID of the shop
 * @param {number} initialCumulativeStreak - Initial cumulative streak value (default 0)
 * @param {number} initialConsecutiveDays - Initial consecutive days value (default 0)
 * @return {Promise<Object>} Result of the follow operation
 */
export async function followUserToShop(
  userId: string,
  shopId: string,
  initialCumulativeStreak: number = 0,
  initialConsecutiveDays: number = 0
): Promise<{
  success: boolean;
  message: string;
  data: any;
}> {
  // Get user document to retrieve user details and FCM token
  const userDoc = await db.collection("users").doc(userId).get();
  if (!userDoc.exists) {
    throw new HttpsError(
      "not-found",
      "User not found",
      SHOP_FOLLOW_ERROR_CODES.USER_NOT_FOUND
    );
  }

  const userData = userDoc.data();
  const userName = userData?.name || userData?.userName || "Anonymous User";
  const userPhoneNumber = typeof userData?.userPhoneNumber === "string" &&
    userData.userPhoneNumber.trim().length > 0 ? userData.userPhoneNumber : null;
  const userProfilePic = userData?.userAvatar || userData?.photoURL || null;
  const fcmToken = userData?.fcmToken;

  // Validate FCM token exists
  if (!fcmToken || typeof fcmToken !== "string" || fcmToken.trim().length === 0) {
    throw new HttpsError(
      "failed-precondition",
      "User FCM token not found or invalid",
      SHOP_FOLLOW_ERROR_CODES.FCM_TOKEN_NOT_FOUND
    );
  }

  // Check if shop exists
  const shopDoc = await db.collection("shops").doc(shopId).get();
  if (!shopDoc.exists) {
    throw new HttpsError(
      "not-found",
      "Shop not found",
      SHOP_FOLLOW_ERROR_CODES.SHOP_NOT_FOUND
    );
  }

  const shopData = shopDoc.data();
  const shopName = shopData?.name || shopData?.shopName || "Unknown Shop";
  const shopDescription = shopData?.description || shopData?.shopDescription || "";
  const shopAddress = shopData?.address || shopData?.shopAddress || "";
  const shopPhone = shopData?.phone || shopData?.shopPhone || "";

  if (shopData?.status === "inactive" || shopData?.status === "deleted") {
    throw new HttpsError(
      "failed-precondition",
      "Shop is not available",
      SHOP_FOLLOW_ERROR_CODES.SHOP_INACTIVE
    );
  }

  // Check if already following
  const followingDoc = await db
    .collection("users")
    .doc(userId)
    .collection("followedShops")
    .doc(shopId)
    .get();

  if (followingDoc.exists) {
    throw new HttpsError(
      "already-exists",
      "User is already following this shop",
      SHOP_FOLLOW_ERROR_CODES.ALREADY_FOLLOWING
    );
  }

  const now = Timestamp.now();

  // Run transaction to ensure data consistency
  await db.runTransaction(async (transaction) => {
    // Create user's following document with streak data
    const userFollowingData: UserFollowingShop = {
      shopId,
      shopName,
      shopDescription,
      shopAddress,
      shopPhone,
      notificationEnabled: true,
      cumulativeStreak: initialCumulativeStreak,
      consecutiveDays: initialConsecutiveDays,
      lastCheckInDate: initialCumulativeStreak > 0 ? now : null,
      cycleBillSum: 0,
      previousCycleBillSum: 0,
      cumulativeBillSum: 0,
      followedAt: now,
      updatedAt: now,
    };

    transaction.set(
      db.collection("users").doc(userId).collection("followedShops").doc(shopId),
      userFollowingData
    );

    // Create shop's follower document with streak data
    const shopFollowerData: ShopFollower = {
      userId,
      userName,
      userPhoneNumber,
      userProfilePic,
      notificationEnabled: true,
      cumulativeStreak: initialCumulativeStreak,
      consecutiveDays: initialConsecutiveDays,
      lastCheckInDate: initialCumulativeStreak > 0 ? now : null,
      lastGiftDayStreak: null,
      lastBonusDate: null,
      cycleBillSum: 0,
      previousCycleBillSum: 0,
      cumulativeBillSum: 0,
      followedAt: now,
      createdAt: now,
      updatedAt: now,
    };

    transaction.set(
      db.collection("shops").doc(shopId).collection("followers").doc(userId),
      shopFollowerData
    );

    // Increment totalFollowing for user and add to subscribedShopTopics
    transaction.set(
      db.collection("users").doc(userId),
      {
        totalFollowing: FieldValue.increment(1),
        subscribedShopTopics: FieldValue.arrayUnion(shopId),
      },
      {merge: true}
    );

    // Increment totalFollowers for shop
    transaction.set(
      db.collection("shops").doc(shopId),
      {totalFollowers: FieldValue.increment(1)},
      {merge: true}
    );
  });

  // Subscribe to FCM topic
  try {
    await messaging.subscribeToTopic([fcmToken], shopId);
  } catch (fcmError) {
    logger.error("FCM subscription failed:", fcmError);
    return {
      success: true,
      message: "Successfully added follower, but notification subscription failed",
      data: {
        shopId,
        followedAt: now,
        notificationEnabled: true,
        fcmWarning: "Notification subscription failed",
      },
    };
  }

  return {
    success: true,
    message: "User successfully added as follower",
    data: {
      shopId,
      followedAt: now,
      notificationEnabled: true,
    },
  };
}

/**
 * Follow Shop By Vendor
 * Vendor scans user QR code from shop detail page to add follower
 */
export const followShopByVendor = onCall<FollowShopByVendorRequest, Promise<ShopFollowApiResponse>>(
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
    const {userId, shopId} = request.data;

    // Validate input
    if (!userId || !shopId) {
      throw new HttpsError(
        "invalid-argument",
        "userId and shopId are required"
      );
    }

    try {
      // Check if shop exists and vendor owns it
      const shopDoc = await db.collection("shops").doc(shopId).get();
      if (!shopDoc.exists) {
        throw new HttpsError(
          "not-found",
          "Shop not found",
          SHOP_FOLLOW_ERROR_CODES.SHOP_NOT_FOUND
        );
      }

      const shopData = shopDoc.data();

      // Validate vendor owns the shop
      if (shopData?.shopOwnerId !== vendorId) {
        throw new HttpsError(
          "permission-denied",
          "You do not own this shop",
          SHOP_FOLLOW_ERROR_CODES.NOT_SHOP_OWNER
        );
      }

      if (shopData?.status === "inactive" || shopData?.status === "deleted") {
        throw new HttpsError(
          "failed-precondition",
          "Shop is not available",
          SHOP_FOLLOW_ERROR_CODES.SHOP_INACTIVE
        );
      }

      // Use helper function to handle follow logic
      const result = await followUserToShop(userId, shopId);

      logger.info("User followed shop by vendor", {vendorId, userId, shopId});

      return result;
    } catch (error: any) {
      if (error instanceof HttpsError) {
        throw error;
      }

      logger.error("Error in followShopByVendor:", error);
      throw new HttpsError(
        "internal",
        "Failed to add follower",
        SHOP_FOLLOW_ERROR_CODES.TRANSACTION_FAILED
      );
    }
  }
);

/**
 * Follow Shop By Staff
 * Staff member scans user QR code to add follower
 */
export const followShopByStaff = onCall<FollowShopByStaffRequest, Promise<ShopFollowApiResponse>>(
  async (request) => {
    // Verify authentication
    if (!request.auth) {
      throw new HttpsError(
        "unauthenticated",
        "User must be authenticated",
        SHOP_FOLLOW_ERROR_CODES.UNAUTHORIZED
      );
    }

    const staffId = request.auth.uid;
    const {userId, shopId} = request.data;

    // Validate input
    if (!userId || !shopId) {
      throw new HttpsError(
        "invalid-argument",
        "userId and shopId are required"
      );
    }

    try {
      // Validate staff is active and belongs to this shop
      // Check if requester is staff for this shop
      const requesterDoc = await db.collection("users").doc(staffId).get();
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

      // Check if shop exists
      const shopDoc = await db.collection("shops").doc(shopId).get();
      if (!shopDoc.exists) {
        throw new HttpsError(
          "not-found",
          "Shop not found",
          SHOP_FOLLOW_ERROR_CODES.SHOP_NOT_FOUND
        );
      }

      const shopData = shopDoc.data();

      if (shopData?.status === "inactive" || shopData?.status === "deleted") {
        throw new HttpsError(
          "failed-precondition",
          "Shop is not available",
          SHOP_FOLLOW_ERROR_CODES.SHOP_INACTIVE
        );
      }

      // Use helper function to handle follow logic
      const result = await followUserToShop(userId, shopId);

      logger.info("User followed shop by staff", {staffId, userId, shopId});

      return result;
    } catch (error: any) {
      if (error instanceof HttpsError) {
        throw error;
      }

      logger.error("Error in followShopByStaff:", error);
      throw new HttpsError(
        "internal",
        "Failed to add follower",
        SHOP_FOLLOW_ERROR_CODES.TRANSACTION_FAILED
      );
    }
  }
);

/**
 * Unfollow Shop
 * User unfollows a shop from their following list
 */
export const unfollowShop = onCall<UnfollowShopRequest, Promise<ShopFollowApiResponse>>(
  async (request) => {
    // Verify authentication
    if (!request.auth) {
      throw new HttpsError(
        "unauthenticated",
        "User must be authenticated",
        SHOP_FOLLOW_ERROR_CODES.UNAUTHORIZED
      );
    }

    const userId = request.auth.uid;
    const {shopId} = request.data;

    // Validate input
    if (!shopId) {
      throw new HttpsError(
        "invalid-argument",
        "shopId is required"
      );
    }

    try {
      // Get user document to retrieve FCM token
      const userDoc = await db.collection("users").doc(userId).get();
      if (!userDoc.exists) {
        throw new HttpsError(
          "not-found",
          "User not found",
          SHOP_FOLLOW_ERROR_CODES.USER_NOT_FOUND
        );
      }

      const userData = userDoc.data();
      const fcmToken = userData?.fcmToken;

      // Validate FCM token exists
      if (!fcmToken || typeof fcmToken !== "string" || fcmToken.trim().length === 0) {
        throw new HttpsError(
          "failed-precondition",
          "User FCM token not found or invalid",
          SHOP_FOLLOW_ERROR_CODES.FCM_TOKEN_NOT_FOUND
        );
      }

      // Check if following relationship exists
      const followingDoc = await db
        .collection("users")
        .doc(userId)
        .collection("followedShops")
        .doc(shopId)
        .get();

      if (!followingDoc.exists) {
        throw new HttpsError(
          "not-found",
          "Not currently following this shop",
          SHOP_FOLLOW_ERROR_CODES.NOT_FOLLOWING
        );
      }

      // Run transaction to ensure data consistency
      await db.runTransaction(async (transaction) => {
        // Delete user's following document
        transaction.delete(
          db.collection("users").doc(userId).collection("followedShops").doc(shopId)
        );

        // Delete shop's follower document
        transaction.delete(
          db.collection("shops").doc(shopId).collection("followers").doc(userId)
        );

        // Decrement totalFollowing for user and remove from subscribedShopTopics
        transaction.set(
          db.collection("users").doc(userId),
          {
            totalFollowing: FieldValue.increment(-1),
            subscribedShopTopics: FieldValue.arrayRemove(shopId),
          },
          {merge: true}
        );

        // Decrement totalFollowers for shop
        transaction.set(
          db.collection("shops").doc(shopId),
          {totalFollowers: FieldValue.increment(-1)},
          {merge: true}
        );
      });

      // Unsubscribe from FCM topic
      try {
        await messaging.unsubscribeFromTopic([fcmToken], shopId);
      } catch (fcmError) {
        logger.error("FCM unsubscription failed:", fcmError);
        return {
          success: true,
          message: "Successfully unfollowed shop, but notification unsubscription failed",
          data: {
            shopId,
            fcmWarning: "Notification unsubscription failed",
          },
        };
      }

      logger.info("User unfollowed shop", {userId, shopId});

      return {
        success: true,
        message: "Successfully unfollowed shop",
        data: {
          shopId,
        },
      };
    } catch (error: any) {
      if (error instanceof HttpsError) {
        throw error;
      }

      logger.error("Error in unfollowShop:", error);
      throw new HttpsError(
        "internal",
        "Failed to unfollow shop",
        SHOP_FOLLOW_ERROR_CODES.TRANSACTION_FAILED
      );
    }
  }
);

/**
 * Remove Follower
 * Vendor removes a follower from their shop (spam/abuse cases)
 */
export const removeFollower = onCall<RemoveFollowerRequest, Promise<ShopFollowApiResponse>>(
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
    const {shopId, userId, reason} = request.data;

    // Validate input
    if (!shopId || !userId) {
      throw new HttpsError(
        "invalid-argument",
        "shopId and userId are required"
      );
    }

    try {
      // Check if shop exists and vendor owns it
      const shopDoc = await db.collection("shops").doc(shopId).get();
      if (!shopDoc.exists) {
        throw new HttpsError(
          "not-found",
          "Shop not found",
          SHOP_FOLLOW_ERROR_CODES.SHOP_NOT_FOUND
        );
      }

      const shopData = shopDoc.data();

      // Validate vendor owns the shop
      if (shopData?.shopOwnerId !== vendorId) {
        throw new HttpsError(
          "permission-denied",
          "You do not own this shop",
          SHOP_FOLLOW_ERROR_CODES.NOT_SHOP_OWNER
        );
      }

      // Check if following relationship exists
      const followerDoc = await db
        .collection("shops")
        .doc(shopId)
        .collection("followers")
        .doc(userId)
        .get();

      if (!followerDoc.exists) {
        throw new HttpsError(
          "not-found",
          "User is not following this shop",
          SHOP_FOLLOW_ERROR_CODES.NOT_FOLLOWING
        );
      }

      // Run transaction to ensure data consistency
      await db.runTransaction(async (transaction) => {
        // Delete user's following document
        transaction.delete(
          db.collection("users").doc(userId).collection("followedShops").doc(shopId)
        );

        // Delete shop's follower document
        transaction.delete(
          db.collection("shops").doc(shopId).collection("followers").doc(userId)
        );

        // Decrement totalFollowing for user and remove from subscribedShopTopics
        transaction.set(
          db.collection("users").doc(userId),
          {
            totalFollowing: FieldValue.increment(-1),
            subscribedShopTopics: FieldValue.arrayRemove(shopId),
          },
          {merge: true}
        );

        // Decrement totalFollowers for shop
        transaction.set(
          db.collection("shops").doc(shopId),
          {totalFollowers: FieldValue.increment(-1)},
          {merge: true}
        );
      });

      // Try to unsubscribe from FCM topic (best effort)
      // Note: We don't have the user's FCM token here, so this may not work
      // The user will need to handle unsubscription on their end

      logger.info("Vendor removed follower", {
        vendorId,
        userId,
        shopId,
        reason: reason || "No reason provided",
      });

      return {
        success: true,
        message: "Follower removed successfully",
        data: {
          shopId,
          userId,
          removedAt: Timestamp.now(),
        },
      };
    } catch (error: any) {
      if (error instanceof HttpsError) {
        throw error;
      }

      logger.error("Error in removeFollower:", error);
      throw new HttpsError(
        "internal",
        "Failed to remove follower",
        SHOP_FOLLOW_ERROR_CODES.TRANSACTION_FAILED
      );
    }
  }
);
