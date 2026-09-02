import {onCall, HttpsError} from "firebase-functions/v2/https";
import {getFirestore, Timestamp, FieldValue} from "firebase-admin/firestore";
import {getMessaging} from "firebase-admin/messaging";
import * as admin from "firebase-admin";
import * as logger from "firebase-functions/logger";
import {validateStaffAuthorization} from "../helpers";
import {createActivityLog, resolvePhoneNumber} from "../activityLog";

// Initialize Firebase Admin if not already initialized
if (!admin.apps.length) {
  admin.initializeApp();
}

const db = getFirestore();
const messaging = getMessaging();

// Request interfaces
interface ScanToRedeemOwnerRequest {
  userGiftId: string;
  campaignId: string;
}

interface ScanToRedeemSharedVendorRequest {
  userGiftId: string;
  campaignId: string;
}

interface ScanToRedeemStaffRequest {
  userGiftId: string;
  campaignId: string;
  shopId: string;
}

// Response interfaces
interface SuccessResponse {
  success: true;
}

interface ErrorResponse {
  error: {
    code: string;
    message: string;
  };
}

type RedeemResponse = SuccessResponse | ErrorResponse;

/**
 * Helper function to validate and update gift redemption.
 * Returns customer ID, gift ID and gift name for activity logging.
 * @param {string} userGiftId - The ID of the user gift to redeem
 * @param {string} campaignId - The ID of the campaign to increment totalRedeemed
 * @return {Promise<{customerId: string, giftId: string, giftName: string}>}
 */
async function validateAndRedeemGift(
  userGiftId: string,
  campaignId: string
): Promise<{ customerId: string; giftId: string; giftName: string }> {
  const giftRef = db.collection("user_gifts").doc(userGiftId);
  const campaignRef = db.collection("campaigns").doc(campaignId);
  let customerId = "";
  let giftId = "";
  let giftName = "";

  await db.runTransaction(async (transaction) => {
    const giftDoc = await transaction.get(giftRef);

    if (!giftDoc.exists) {
      throw new HttpsError("not-found", "Gift not found");
    }

    const giftData = giftDoc.data();

    if (giftData?.isRedeemed === true) {
      throw new HttpsError("already-exists", "Gift has already been redeemed");
    }

    customerId = giftData?.userId ?? "";
    giftId = giftData?.giftId ?? "";
    giftName = giftData?.giftName ?? "";

    // Update gift as redeemed
    transaction.update(giftRef, {
      isRedeemed: true,
      redeemedAt: Timestamp.now(),
    });

    // Increment campaign totalRedeemed counter
    transaction.update(campaignRef, {
      totalRedeemed: FieldValue.increment(1),
    });
  });

  return {customerId, giftId, giftName};
}

/**
 * Scan to Redeem by Owner Vendor
 * Allows campaign owner to redeem user gifts
 */
export const scanToRedeemByOwner = onCall<ScanToRedeemOwnerRequest>(
  async (request): Promise<RedeemResponse> => {
    const {userGiftId, campaignId} = request.data;

    try {
      // Authentication check
      if (!request.auth) {
        throw new HttpsError("unauthenticated", "User must be authenticated");
      }

      const userId = request.auth.uid;

      // Validation
      if (!userGiftId || !campaignId) {
        throw new HttpsError("invalid-argument", "Missing required parameters");
      }

      // Get campaign document
      const campaignDoc = await db.collection("campaigns").doc(campaignId).get();

      if (!campaignDoc.exists) {
        throw new HttpsError("not-found", "Campaign not found");
      }

      const campaignData = campaignDoc.data();

      // Verify user is the campaign owner
      if (campaignData?.vendorId !== userId) {
        throw new HttpsError("permission-denied", "You are not authorized to redeem this gift");
      }

      // Validate and redeem gift
      const {customerId, giftId, giftName} = await validateAndRedeemGift(userGiftId, campaignId);

      // Fetch customer profile once for phone number (audit log) and FCM token
      const customerDoc = await db.collection("users").doc(customerId).get();
      const customerData = customerDoc.data();
      const customerPhoneNumber = resolvePhoneNumber(customerData);

      // Send FCM notification to the gift owner
      try {
        const fcmToken = customerData?.fcmToken;

        if (fcmToken) {
          const message = {
            data: {
              type: "offer_redeem_success",
              campaignId: campaignId,
              userGiftId: userGiftId,
            },
            token: fcmToken,
          };

          await messaging.send(message);
          logger.info("FCM notification sent successfully", {customerId, campaignId});
        } else {
          logger.warn("User does not have FCM token, skipping notification", {customerId});
        }
      } catch (fcmError) {
        logger.error("FCM notification failed, continuing with redemption success:", fcmError);
      }

      // Activity log - success
      await createActivityLog(`campaigns/${campaignId}/activityLogs`, {
        action: "gift_redemption_success",
        success: true,
        actorId: userId,
        actorRole: "owner",
        functionName: "scanToRedeemByOwner",
        customerId,
        userGiftId,
        giftId,
        giftName,
        redemptionMethod: "owner_scan",
        phoneNumber: customerPhoneNumber,
      });

      logger.info("Gift redeemed by owner", {
        userGiftId,
        campaignId,
        redeemedBy: userId,
      });

      return {success: true};
    } catch (error) {
      const errorCode = error instanceof HttpsError ? error.code : "unknown";
      const errorMessage = error instanceof Error ? error.message : String(error);

      // Activity log - failure
      await createActivityLog(`campaigns/${campaignId}/activityLogs`, {
        action: "gift_redemption_failed",
        success: false,
        actorId: request.auth?.uid || "unknown",
        actorRole: "owner",
        functionName: "scanToRedeemByOwner",
        userGiftId,
        failureReason: errorCode,
        errorCode,
        errorMessage,
        phoneNumber: null,
      });

      logger.error("Error in scanToRedeemByOwner", error);

      if (error instanceof HttpsError) {
        throw error;
      }

      throw new HttpsError("internal", "Internal server error");
    }
  }
);

/**
 * Scan to Redeem by Shared Vendor
 * Allows shared vendors to redeem user gifts
 */
export const scanToRedeemBySharedVendor = onCall<ScanToRedeemSharedVendorRequest>(
  async (request): Promise<RedeemResponse> => {
    const {userGiftId, campaignId} = request.data;

    try {
      // Authentication check
      if (!request.auth) {
        throw new HttpsError("unauthenticated", "User must be authenticated");
      }

      const userId = request.auth.uid;

      // Validation
      if (!userGiftId || !campaignId) {
        throw new HttpsError("invalid-argument", "Missing required parameters");
      }

      // Get campaign document
      const campaignDoc = await db.collection("campaigns").doc(campaignId).get();

      if (!campaignDoc.exists) {
        throw new HttpsError("not-found", "Campaign not found");
      }

      // const campaignData = campaignDoc.data();

      // Verify user is in sharedVendors array
      // const sharedVendors = campaignData?.sharedVendors || [];
      // if (!sharedVendors.includes(userId)) {
      //   throw new HttpsError("permission-denied", "You are not authorized to redeem this gift");
      // }

      // Validate and redeem gift
      const {customerId, giftId, giftName} = await validateAndRedeemGift(userGiftId, campaignId);

      // Fetch customer profile once for phone number (audit log) and FCM token
      const customerDoc = await db.collection("users").doc(customerId).get();
      const customerData = customerDoc.data();
      const customerPhoneNumber = resolvePhoneNumber(customerData);

      // Send FCM notification to the gift owner
      try {
        const fcmToken = customerData?.fcmToken;

        if (fcmToken) {
          const message = {
            data: {
              type: "offer_redeem_success",
              campaignId: campaignId,
              userGiftId: userGiftId,
            },
            token: fcmToken,
          };

          await messaging.send(message);
          logger.info("FCM notification sent successfully", {customerId, campaignId});
        } else {
          logger.warn("User does not have FCM token, skipping notification", {customerId});
        }
      } catch (fcmError) {
        logger.error("FCM notification failed, continuing with redemption success:", fcmError);
      }

      // Activity log - success
      await createActivityLog(`campaigns/${campaignId}/activityLogs`, {
        action: "gift_redemption_success",
        success: true,
        actorId: userId,
        actorRole: "shared_vendor",
        functionName: "scanToRedeemBySharedVendor",
        customerId,
        userGiftId,
        giftId,
        giftName,
        redemptionMethod: "shared_vendor_scan",
        phoneNumber: customerPhoneNumber,
      });

      logger.info("Gift redeemed by shared vendor", {
        userGiftId,
        campaignId,
        redeemedBy: userId,
      });

      return {success: true};
    } catch (error) {
      const errorCode = error instanceof HttpsError ? error.code : "unknown";
      const errorMessage = error instanceof Error ? error.message : String(error);

      // Activity log - failure
      await createActivityLog(`campaigns/${campaignId}/activityLogs`, {
        action: "gift_redemption_failed",
        success: false,
        actorId: request.auth?.uid || "unknown",
        actorRole: "shared_vendor",
        functionName: "scanToRedeemBySharedVendor",
        userGiftId,
        failureReason: errorCode,
        errorCode,
        errorMessage,
        phoneNumber: null,
      });

      logger.error("Error in scanToRedeemBySharedVendor", error);

      if (error instanceof HttpsError) {
        throw error;
      }

      throw new HttpsError("internal", "Internal server error");
    }
  }
);

/**
 * Scan to Redeem by Staff
 * Allows shop staff to redeem user gifts
 */
export const scanToRedeemByStaff = onCall<ScanToRedeemStaffRequest>(
  async (request): Promise<RedeemResponse> => {
    const {userGiftId, campaignId, shopId} = request.data;

    try {
      // Authentication check
      if (!request.auth) {
        throw new HttpsError("unauthenticated", "User must be authenticated");
      }

      const userId = request.auth.uid;

      // Validation
      if (!userGiftId || !campaignId || !shopId) {
        throw new HttpsError("invalid-argument", "Missing required parameters");
      }

      // Validate staff authorization before starting transaction
      await validateStaffAuthorization(userId, shopId);


      // Get campaign document
      const campaignDoc = await db.collection("campaigns").doc(campaignId).get();

      if (!campaignDoc.exists) {
        throw new HttpsError("not-found", "Campaign not found");
      }

      // const campaignData = campaignDoc.data();

      // Verify shop is in supportedShops array
      // const supportedShops = campaignData?.supportedShops || [];
      // if (!supportedShops.includes(shopId)) {
      //   throw new HttpsError("permission-denied", "This shop is not supported by the campaign");
      // }

      // Validate and redeem gift
      const {customerId, giftId, giftName} = await validateAndRedeemGift(userGiftId, campaignId);

      // Fetch customer profile once for phone number (audit log) and FCM token
      const customerDoc = await db.collection("users").doc(customerId).get();
      const customerData = customerDoc.data();
      const customerPhoneNumber = resolvePhoneNumber(customerData);

      // Send FCM notification to the gift owner
      try {
        const fcmToken = customerData?.fcmToken;

        if (fcmToken) {
          const message = {
            data: {
              type: "offer_redeem_success",
              campaignId: campaignId,
              userGiftId: userGiftId,
              shopId: shopId,
            },
            token: fcmToken,
          };

          await messaging.send(message);
          logger.info("FCM notification sent successfully", {customerId, campaignId, shopId});
        } else {
          logger.warn("User does not have FCM token, skipping notification", {customerId});
        }
      } catch (fcmError) {
        logger.error("FCM notification failed, continuing with redemption success:", fcmError);
      }

      // Activity log - success
      await createActivityLog(`campaigns/${campaignId}/activityLogs`, {
        action: "gift_redemption_success",
        success: true,
        actorId: userId,
        actorRole: "staff",
        functionName: "scanToRedeemByStaff",
        customerId,
        userGiftId,
        giftId,
        giftName,
        shopId,
        redemptionMethod: "staff_scan",
        phoneNumber: customerPhoneNumber,
      });

      logger.info("Gift redeemed by staff", {
        userGiftId,
        campaignId,
        shopId,
        redeemedBy: userId,
      });

      return {success: true};
    } catch (error) {
      const errorCode = error instanceof HttpsError ? error.code : "unknown";
      const errorMessage = error instanceof Error ? error.message : String(error);

      // Activity log - failure
      await createActivityLog(`campaigns/${campaignId}/activityLogs`, {
        action: "gift_redemption_failed",
        success: false,
        actorId: request.auth?.uid || "unknown",
        actorRole: "staff",
        functionName: "scanToRedeemByStaff",
        userGiftId,
        shopId,
        failureReason: errorCode,
        errorCode,
        errorMessage,
        phoneNumber: null,
      });

      logger.error("Error in scanToRedeemByStaff", error);

      if (error instanceof HttpsError) {
        throw error;
      }

      throw new HttpsError("internal", "Internal server error");
    }
  }
);
