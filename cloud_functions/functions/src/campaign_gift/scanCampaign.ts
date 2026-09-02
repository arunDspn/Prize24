import {onCall, HttpsError} from "firebase-functions/v2/https";
import {getFirestore, FieldValue} from "firebase-admin/firestore";
import {getMessaging} from "firebase-admin/messaging";
import * as admin from "firebase-admin";
import * as logger from "firebase-functions/logger";
import {
  Campaign,
  Gift,
  UserGift,
  FunctionResponse,
  ERROR_CODES,
} from "../types";
import {validateStaffAuthorization} from "../helpers";
import {createActivityLog, resolvePhoneNumber} from "../activityLog";

// Initialize Firebase Admin if not already initialized
if (!admin.apps.length) {
  admin.initializeApp();
}

const db = getFirestore();
const messaging = getMessaging();

interface ScanCampaignRequest {
  userId: string;
  campaignId: string;
  availedViaStreak?: boolean;
  streakShopID?: string;
}

interface ScanCampaignByStaffRequest {
  userId: string;
  campaignId: string;
  shopId: string;
  availedViaStreak?: boolean;
  streakShopID?: string;
}

/**
 * Scan Campaign Function - scanAvail-PublicPrivate-AutoCampaign
 * Supports both Public and Private campaigns
 * Luck-based gift distribution with automatic payload selection
 *
 * Key Features:
 * - Edge case handling for campaign expiration, data consistency, and race conditions
 * - Uses remainingParticipants and remainingGifts for real-time luck calculation
 * - Updated to use autoGiftPayloads collection path
 * - Comprehensive payload validation
 * - Vendor-controlled scanning with attempt-based participant tracking
 *
 * Draw Logic:
 * - Every scan attempt decrements remainingParticipants (success or failure)
 * - Only successful scans decrement remainingGifts and gift remainingQuantity
 * - Luck factor = remainingGifts / remainingParticipants (real-time probability)
 */
export const scanAvailPublicPrivateAutoCampaign = onCall<ScanCampaignRequest>(
  async (request): Promise<FunctionResponse> => {
    const {userId, campaignId, availedViaStreak, streakShopID} = request.data;
    // Closure variable to capture transaction log data for post-transaction activity logging
    let availActivityData: any = null;
    // Pre-transaction activity log (used to log failures discovered during reads)
    let preTxnActivityLog: any = null;
    // Customer phone number, resolved from the user doc once it's read (used in audit logs)
    let customerPhoneNumber: string | null = null;

    try {
      // Pre-validations
      if (!userId || !campaignId) {
        throw new HttpsError("invalid-argument", "Missing required fields");
      }

      // Edge Case: Validate Campaign ID format (basic validation)
      if (typeof campaignId !== "string" || campaignId.trim().length === 0) {
        throw new HttpsError("invalid-argument", "Invalid Campaign ID format");
      }

      // Edge Case: Validate User ID format (basic validation)
      if (typeof userId !== "string" || userId.trim().length === 0) {
        throw new HttpsError("invalid-argument", "Invalid User ID format");
      }

      // Validate streakShopID when availedViaStreak is true
      if (availedViaStreak === true) {
        if (!streakShopID || typeof streakShopID !== "string" || streakShopID.trim().length === 0) {
          throw new HttpsError("invalid-argument", "streakShopID is required when availedViaStreak is true");
        }
      }

      // Start transaction
      const result = await db.runTransaction(async (transaction) => {
        // ===== ALL READS FIRST =====

        // 1. Validate User exists
        const userDoc = await transaction.get(
          db.collection("users").doc(userId)
        );

        if (!userDoc.exists) {
          throw new HttpsError("not-found", "User not found");
        }

        customerPhoneNumber = resolvePhoneNumber(userDoc.data());

        // 2. Get Campaign via ID
        const campaignDoc = await transaction.get(
          db.collection("campaigns").doc(campaignId)
        );

        if (!campaignDoc.exists) {
          throw new HttpsError("not-found", ERROR_CODES.CAMPAIGN_NOT_FOUND);
        }

        const campaign = {id: campaignDoc.id, ...campaignDoc.data()} as Campaign;

        // Validate campaign status
        if (campaign.status !== "active") {
          throw new HttpsError("failed-precondition", ERROR_CODES.CAMPAIGN_INACTIVE);
        }

        // Edge Case: Verify campaign has not expired based on end date (if applicable)
        if (campaign.endDate && new Date() > campaign.endDate.toDate()) {
          throw new HttpsError("failed-precondition", ERROR_CODES.CAMPAIGN_EXPIRED);
        }

        // Check remaining participants - campaign capacity
        if (campaign.remainingParticipants <= 0) {
          throw new HttpsError("resource-exhausted", ERROR_CODES.CAMPAIGN_PARTICIPATION_EXHAUSTED);
        }

        // Check remaining gifts at campaign level
        if (campaign.remainingGifts <= 0) {
          throw new HttpsError("resource-exhausted", ERROR_CODES.GIFTS_EXHAUSTED);
        }

        // 3. Get available gifts count from gifts sub-collection
        const availableGiftsSnapshot = await transaction.get(
          db.collection("campaigns").doc(campaign.id)
            .collection("gifts").where("remainingQuantity", ">", 0)
        );

        if (availableGiftsSnapshot.empty) {
          preTxnActivityLog = {
            action: "gift_avail_failed",
            success: false,
            actorId: userId,
            actorRole: "customer",
            functionName: "scanAvailPublicPrivateAutoCampaign",
            customerId: userId,
            failureReason: ERROR_CODES.GIFTS_EXHAUSTED,
            errorCode: ERROR_CODES.GIFTS_EXHAUSTED,
            errorMessage: "No gifts available",
            availedViaStreak: availedViaStreak === true,
            streakShopId: streakShopID ?? null,
            phoneNumber: customerPhoneNumber,
          };
          throw new HttpsError("resource-exhausted", ERROR_CODES.GIFTS_EXHAUSTED);
        }

        // Edge Case: Validate that at least one gift has remainingQuantity > 0 after fetching
        const validGifts = availableGiftsSnapshot.docs.filter((doc) => {
          const giftData = doc.data();
          return giftData.remainingQuantity > 0;
        });

        if (validGifts.length === 0) {
          preTxnActivityLog = {
            action: "gift_avail_failed",
            success: false,
            actorId: userId,
            actorRole: "customer",
            functionName: "scanAvailPublicPrivateAutoCampaign",
            customerId: userId,
            failureReason: ERROR_CODES.GIFTS_EXHAUSTED,
            errorCode: ERROR_CODES.GIFTS_EXHAUSTED,
            errorMessage: "No valid gifts with remainingQuantity > 0",
            availedViaStreak: availedViaStreak === true,
            streakShopId: streakShopID ?? null,
            phoneNumber: customerPhoneNumber,
          };
          throw new HttpsError("resource-exhausted", ERROR_CODES.GIFTS_EXHAUSTED);
        }

        // 3. Calculate Luck Factor using remaining counts
        const {remainingGifts, remainingParticipants} = campaign;

        // Edge Case: Handle division by zero - should not happen due to earlier checks
        if (remainingGifts === 0 || remainingParticipants === 0) {
          throw new HttpsError("failed-precondition", ERROR_CODES.CAMPAIGN_DATA_INCONSISTENT);
        }

        // Real-time luck calculation based on remaining counts
        const baseLuckPercentage = remainingGifts / remainingParticipants;
        const luckFactor = Math.min(baseLuckPercentage, 1); // Cap at 100%
        const randomNumber = Math.random();

        const isLucky = randomNumber <= luckFactor;

        // 4. If Not Lucky
        if (!isLucky) {
          // ===== WRITES FOR UNLUCKY ATTEMPT =====

          // Decrement remaining participants (every attempt counts)
          transaction.update(campaignDoc.ref, {
            remainingParticipants: FieldValue.increment(-1),
          });

          // Log failed attempt for audit
          logger.info("User was not lucky in scan campaign", {
            userId,
            campaignId: campaign.id,
            luckFactor,
            randomNumber,
            remainingParticipants: campaign.remainingParticipants - 1,
            remainingGifts: campaign.remainingGifts,
            timestamp: new Date().toISOString(),
          });

          availActivityData = {
            success: false,
            customerId: userId,
            failureReason: "not_lucky",
            luckFactor,
            randomNumber,
            remainingGifts: campaign.remainingGifts,
            remainingParticipants: campaign.remainingParticipants - 1,
            phoneNumber: customerPhoneNumber,
          };

          return {
            success: false,
            error: {
              code: ERROR_CODES.LUCK_FAILED,
              message: "Better luck next time!",
            },
          } as FunctionResponse;
        }

        // 5. If Lucky - Gift Selection Process
        const availableGifts = validGifts.map((doc) => ({
          id: doc.id,
          ref: doc.ref,
          data: {id: doc.id, ...doc.data()} as Gift,
        }));

        const randomGiftIndex = Math.floor(Math.random() * availableGifts.length);
        const selectedGift = availableGifts[randomGiftIndex];
        const gift = selectedGift.data;

        if (gift.remainingQuantity <= 0) {
          throw new HttpsError("resource-exhausted", ERROR_CODES.GIFT_QUANTITY_INVALID);
        }

        // 6. Handle payload reading for non-redeemable gifts
        let payloadData: string | null = null;
        let payloadId: string | null = null;
        let selectedPayloadDoc: any = null;

        if (!gift.isRedeemable) {
          const unredeemedPayloadsSnapshot = await transaction.get(
            db.collection("campaigns").doc(campaign.id)
              .collection("gifts").doc(gift.id)
              .collection("autoGiftPayloads").where("redeemedByUserId", "==", null)
          );

          if (unredeemedPayloadsSnapshot.empty) {
            throw new HttpsError("resource-exhausted", ERROR_CODES.PAYLOADS_EXHAUSTED);
          }

          const availablePayloads = unredeemedPayloadsSnapshot.docs.filter((doc) => {
            const pd = doc.data();
            return pd && pd.content && typeof pd.content === "string" && pd.redeemedByUserId === null;
          });

          if (availablePayloads.length === 0) {
            throw new HttpsError("failed-precondition", ERROR_CODES.PAYLOAD_STRUCTURE_INVALID);
          }

          const randomPayloadIndex = Math.floor(Math.random() * availablePayloads.length);
          selectedPayloadDoc = availablePayloads[randomPayloadIndex];
          const selectedPayload = {id: selectedPayloadDoc.id, ...selectedPayloadDoc.data()};

          if (selectedPayload.redeemedByUserId !== null) {
            throw new HttpsError("resource-exhausted", ERROR_CODES.PAYLOADS_EXHAUSTED);
          }

          payloadData = selectedPayload.content;
          payloadId = selectedPayload.id;
        }

        // ===== ALL WRITES AFTER ALL READS =====

        const redemptionTimestamp = FieldValue.serverTimestamp();

        transaction.update(selectedGift.ref, {remainingQuantity: FieldValue.increment(-1)});
        transaction.update(campaignDoc.ref, {
          remainingParticipants: FieldValue.increment(-1),
          remainingGifts: FieldValue.increment(-1),
          totalGiftsAdded: FieldValue.increment(-1),
          totalAvailed: FieldValue.increment(1),
        });

        if (!gift.isRedeemable && selectedPayloadDoc) {
          transaction.update(selectedPayloadDoc.ref, {
            redeemedByUserId: userId,
            redeemedAt: redemptionTimestamp,
          });
        }

        const redemptionId = `redemption_${Date.now()}_${Math.random().toString(36).substr(2, 9)}`;
        const userGiftData: UserGift = {
          userId,
          giftId: gift.id,
          campaignId: campaign.id,
          campaignName: campaign.name,
          giftName: gift.name,
          giftDescription: gift.description,
          isRedeemable: gift.isRedeemable,
          isRedeemed: null,
          redeemedAt: gift.isRedeemable ? null : redemptionTimestamp,
          availedAt: redemptionTimestamp,
          payload: payloadData,
          payloadId,
          supportedShops: gift.isRedeemable ? gift.supportedShops : null,
          redemptionId,
          availedViaStreak: availedViaStreak === true ? true : false,
          streakShopID: availedViaStreak === true ? streakShopID : null,
        };

        const userGiftRef = db.collection("user_gifts").doc();
        transaction.set(userGiftRef, userGiftData);

        logger.info("Scan campaign gift availed successfully", {
          userId, campaignId: campaign.id, giftId: gift.id, luckFactor, randomNumber, redemptionId,
          remainingParticipants: campaign.remainingParticipants - 1,
          remainingGifts: campaign.remainingGifts - 1,
        });

        availActivityData = {
          success: true,
          customerId: userId,
          giftId: gift.id,
          giftName: gift.name,
          redemptionId,
          isRedeemable: gift.isRedeemable,
          payloadId,
          luckFactor,
          randomNumber,
          remainingGifts: campaign.remainingGifts - 1,
          remainingParticipants: campaign.remainingParticipants - 1,
          phoneNumber: customerPhoneNumber,
        };

        return {
          success: true,
          data: {
            giftName: gift.name,
            giftDescription: gift.description,
            isRedeemable: gift.isRedeemable,
            redemptionId,
            ...(payloadData && {payload: payloadData}),
            ...(userGiftData.supportedShops && {supportedShops: userGiftData.supportedShops}),
          },
        } as FunctionResponse;
      });

      // Activity log — written outside transaction so it does not affect atomicity
      if (availActivityData) {
        if (availActivityData.success) {
          await createActivityLog(`campaigns/${campaignId}/activityLogs`, {
            action: "gift_avail_success",
            actorId: userId,
            actorRole: "customer",
            functionName: "scanAvailPublicPrivateAutoCampaign",
            availedViaStreak: availedViaStreak === true,
            streakShopId: streakShopID ?? null,
            ...availActivityData,
          });
          // Dual log: streak-triggered avails also appear in shop logs
          if (availedViaStreak === true && streakShopID) {
            await createActivityLog(`shops/${streakShopID}/activityLogs`, {
              action: "gift_avail_triggered",
              actorId: userId,
              actorRole: "customer",
              functionName: "scanAvailPublicPrivateAutoCampaign",
              campaignId,
              availStatus: "success",
              triggeredByStreak: true,
              streakValue: null,
              giftCycleDay: null,
              ...availActivityData,
            });
          }
        } else {
          await createActivityLog(`campaigns/${campaignId}/activityLogs`, {
            action: "gift_avail_failed",
            actorId: userId,
            actorRole: "customer",
            functionName: "scanAvailPublicPrivateAutoCampaign",
            errorCode: ERROR_CODES.LUCK_FAILED,
            errorMessage: "Better luck next time!",
            availedViaStreak: availedViaStreak === true,
            streakShopId: streakShopID ?? null,
            ...availActivityData,
          });
          if (availedViaStreak === true && streakShopID) {
            await createActivityLog(`shops/${streakShopID}/activityLogs`, {
              action: "gift_avail_triggered",
              actorId: userId,
              actorRole: "customer",
              functionName: "scanAvailPublicPrivateAutoCampaign",
              campaignId,
              availStatus: "failed",
              triggeredByStreak: true,
              streakValue: null,
              giftCycleDay: null,
              failureReason: "not_lucky",
              errorCode: ERROR_CODES.LUCK_FAILED,
              errorMessage: "Better luck next time!",
              success: false,
              customerId: userId,
              luckFactor: availActivityData.luckFactor,
              randomNumber: availActivityData.randomNumber,
              phoneNumber: customerPhoneNumber,
            });
          }
        }
      }

      // Send FCM notification on successful avail
      if (result.success) {
        try {
          const userFcmDoc = await db.collection("users").doc(userId).get();
          const fcmToken = userFcmDoc.data()?.fcmToken;
          if (fcmToken) {
            await messaging.send({
              data: {
                type: "offer_avail_success",
                campaignId,
                giftName: result.data.giftName,
                redemptionId: result.data.redemptionId,
                isRedeemable: String(result.data.isRedeemable),
              },
              token: fcmToken,
            });
            logger.info("FCM data message sent successfully", {userId, campaignId});
          } else {
            logger.warn("User does not have FCM token, skipping notification", {userId});
          }
        } catch (fcmError) {
          logger.error("FCM notification failed, continuing with avail success:", fcmError);
        }
      }

      return result;
    } catch (error) {
      logger.error("Error in scanAvailPublicPrivateAutoCampaign", {
        userId, campaignId, error: error instanceof Error ? error.message : String(error),
      });

      // If a pre-transaction activity log was prepared, write it now to ensure the
      // GIFTS_EXHAUSTED (or similar) condition is recorded.
      if (preTxnActivityLog) {
        await createActivityLog(`campaigns/${campaignId}/activityLogs`, preTxnActivityLog);
      }

      if (!preTxnActivityLog && (!(error instanceof HttpsError) || !availActivityData)) {
        const errorCode = error instanceof HttpsError ? error.code : "unknown";
        const errorMessage = error instanceof Error ? error.message : String(error);
        await createActivityLog(`campaigns/${campaignId}/activityLogs`, {
          action: "gift_avail_failed",
          success: false,
          actorId: userId,
          actorRole: "customer",
          functionName: "scanAvailPublicPrivateAutoCampaign",
          customerId: userId,
          failureReason: errorCode,
          errorCode,
          errorMessage,
          phoneNumber: customerPhoneNumber,
          availedViaStreak: availedViaStreak === true,
          streakShopId: streakShopID ?? null,
        });
      }

      if (error instanceof HttpsError) throw error;
      throw new HttpsError("internal", ERROR_CODES.TRANSACTION_FAILED);
    }
  }
);


export const scanToAvailPublicPrivateAutoCampaignBySharedVendor = onCall<ScanCampaignRequest>(
  async (request): Promise<FunctionResponse> => {
    const {userId, campaignId, availedViaStreak, streakShopID} = request.data;
    // Closure variable to capture transaction log data for post-transaction activity logging
    let availActivityData: any = null;
    // Pre-transaction activity log (used to log failures discovered during reads)
    let preTxnActivityLog: any = null;
    // Customer phone number, resolved from the user doc once it's read (used in audit logs)
    let customerPhoneNumber: string | null = null;

    try {
      // Pre-validations
      if (!userId || !campaignId) {
        throw new HttpsError("invalid-argument", "Missing required fields");
      }

      // Edge Case: Validate Campaign ID format (basic validation)
      if (typeof campaignId !== "string" || campaignId.trim().length === 0) {
        throw new HttpsError("invalid-argument", "Invalid Campaign ID format");
      }

      // Edge Case: Validate User ID format (basic validation)
      if (typeof userId !== "string" || userId.trim().length === 0) {
        throw new HttpsError("invalid-argument", "Invalid User ID format");
      }

      // Validate streakShopID when availedViaStreak is true
      if (availedViaStreak === true) {
        if (!streakShopID || typeof streakShopID !== "string" || streakShopID.trim().length === 0) {
          throw new HttpsError("invalid-argument", "streakShopID is required when availedViaStreak is true");
        }
      }

      // Start transaction
      const result = await db.runTransaction(async (transaction) => {
        // ===== ALL READS FIRST =====

        // 1. Validate User exists
        const userDoc = await transaction.get(
          db.collection("users").doc(userId)
        );

        if (!userDoc.exists) {
          throw new HttpsError("not-found", "User not found");
        }

        customerPhoneNumber = resolvePhoneNumber(userDoc.data());

        // 2. Get Campaign via ID
        const campaignDoc = await transaction.get(
          db.collection("campaigns").doc(campaignId)
        );

        if (!campaignDoc.exists) {
          throw new HttpsError("not-found", ERROR_CODES.CAMPAIGN_NOT_FOUND);
        }

        const campaign = {id: campaignDoc.id, ...campaignDoc.data()} as Campaign;

        // Validate campaign status
        if (campaign.status !== "active") {
          throw new HttpsError("failed-precondition", ERROR_CODES.CAMPAIGN_INACTIVE);
        }

        // Edge Case: Verify campaign has not expired based on end date (if applicable)
        if (campaign.endDate && new Date() > campaign.endDate.toDate()) {
          throw new HttpsError("failed-precondition", ERROR_CODES.CAMPAIGN_EXPIRED);
        }

        // Check remaining participants - campaign capacity
        if (campaign.remainingParticipants <= 0) {
          throw new HttpsError("resource-exhausted", ERROR_CODES.CAMPAIGN_PARTICIPATION_EXHAUSTED);
        }

        // Check remaining gifts at campaign level
        if (campaign.remainingGifts <= 0) {
          throw new HttpsError("resource-exhausted", ERROR_CODES.GIFTS_EXHAUSTED);
        }

        // 2. Get available gifts count from gifts sub-collection
        const availableGiftsSnapshot = await transaction.get(
          db.collection("campaigns").doc(campaign.id)
            .collection("gifts").where("remainingQuantity", ">", 0)
        );

        if (availableGiftsSnapshot.empty) {
          preTxnActivityLog = {
            action: "gift_avail_failed",
            success: false,
            actorId: userId,
            actorRole: "customer",
            functionName: "scanToAvailPublicPrivateAutoCampaignBySharedVendor",
            customerId: userId,
            failureReason: ERROR_CODES.GIFTS_EXHAUSTED,
            errorCode: ERROR_CODES.GIFTS_EXHAUSTED,
            errorMessage: "No gifts available",
            availedViaStreak: availedViaStreak === true,
            streakShopId: streakShopID ?? null,
            phoneNumber: customerPhoneNumber,
          };
          throw new HttpsError("resource-exhausted", ERROR_CODES.GIFTS_EXHAUSTED);
        }

        // Edge Case: Validate that at least one gift has remainingQuantity > 0 after fetching
        const validGifts = availableGiftsSnapshot.docs.filter((doc) => {
          const giftData = doc.data();
          return giftData.remainingQuantity > 0;
        });

        if (validGifts.length === 0) {
          preTxnActivityLog = {
            action: "gift_avail_failed",
            success: false,
            actorId: userId,
            actorRole: "customer",
            functionName: "scanToAvailPublicPrivateAutoCampaignBySharedVendor",
            customerId: userId,
            failureReason: ERROR_CODES.GIFTS_EXHAUSTED,
            errorCode: ERROR_CODES.GIFTS_EXHAUSTED,
            errorMessage: "No valid gifts with remainingQuantity > 0",
            availedViaStreak: availedViaStreak === true,
            streakShopId: streakShopID ?? null,
            phoneNumber: customerPhoneNumber,
          };
          throw new HttpsError("resource-exhausted", ERROR_CODES.GIFTS_EXHAUSTED);
        }

        // 3. Calculate Luck Factor using remaining counts
        const {remainingGifts, remainingParticipants} = campaign;

        // Edge Case: Handle division by zero - should not happen due to earlier checks
        if (remainingGifts === 0 || remainingParticipants === 0) {
          throw new HttpsError("failed-precondition", ERROR_CODES.CAMPAIGN_DATA_INCONSISTENT);
        }

        // Real-time luck calculation based on remaining counts
        const baseLuckPercentage = remainingGifts / remainingParticipants;
        const luckFactor = Math.min(baseLuckPercentage, 1); // Cap at 100%
        const randomNumber = Math.random();

        const isLucky = randomNumber <= luckFactor;

        // 4. If Not Lucky
        if (!isLucky) {
          // ===== WRITES FOR UNLUCKY ATTEMPT =====

          // Decrement remaining participants (every attempt counts)
          transaction.update(campaignDoc.ref, {
            remainingParticipants: FieldValue.increment(-1),
          });

          // Log failed attempt for audit
          logger.info("User was not lucky in scan campaign", {
            userId,
            campaignId: campaign.id,
            luckFactor,
            randomNumber,
            remainingParticipants: campaign.remainingParticipants - 1,
            remainingGifts: campaign.remainingGifts,
            timestamp: new Date().toISOString(),
          });

          availActivityData = {
            success: false,
            customerId: userId,
            failureReason: "not_lucky",
            luckFactor,
            randomNumber,
            remainingGifts: campaign.remainingGifts,
            remainingParticipants: campaign.remainingParticipants - 1,
            phoneNumber: customerPhoneNumber,
          };

          return {
            success: false,
            error: {
              code: ERROR_CODES.LUCK_FAILED,
              message: "Better luck next time!",
            },
          } as FunctionResponse;
        }

        // 5. If Lucky - Gift Selection Process
        const availableGifts = validGifts.map((doc) => ({
          id: doc.id,
          ref: doc.ref,
          data: {id: doc.id, ...doc.data()} as Gift,
        }));

        // Randomly select one gift (truly random)
        const randomGiftIndex = Math.floor(Math.random() * availableGifts.length);
        const selectedGift = availableGifts[randomGiftIndex];
        const gift = selectedGift.data;

        // Edge Case: Double-check selected gift's remainingQuantity > 0 before proceeding
        if (gift.remainingQuantity <= 0) {
          throw new HttpsError("resource-exhausted", ERROR_CODES.GIFT_QUANTITY_INVALID);
        }

        // 6. Handle payload reading for non-redeemable gifts
        let payloadData: string | null = null;
        let payloadId: string | null = null;
        let selectedPayloadDoc: any = null;

        if (!gift.isRedeemable) {
          const unredeemedPayloadsSnapshot = await transaction.get(
            db.collection("campaigns").doc(campaign.id)
              .collection("gifts").doc(gift.id)
              .collection("autoGiftPayloads").where("redeemedByUserId", "==", null)
          );

          if (unredeemedPayloadsSnapshot.empty) {
            throw new HttpsError("resource-exhausted", ERROR_CODES.PAYLOADS_EXHAUSTED);
          }

          const availablePayloads = unredeemedPayloadsSnapshot.docs.filter((doc) => {
            const payloadData = doc.data();
            return payloadData &&
              payloadData.content &&
              typeof payloadData.content === "string" &&
              payloadData.redeemedByUserId === null;
          });

          if (availablePayloads.length === 0) {
            throw new HttpsError("failed-precondition", ERROR_CODES.PAYLOAD_STRUCTURE_INVALID);
          }

          const randomPayloadIndex = Math.floor(Math.random() * availablePayloads.length);
          selectedPayloadDoc = availablePayloads[randomPayloadIndex];

          const selectedPayload = {
            id: selectedPayloadDoc.id,
            ...selectedPayloadDoc.data(),
          };

          if (selectedPayload.redeemedByUserId !== null) {
            throw new HttpsError("resource-exhausted", ERROR_CODES.PAYLOADS_EXHAUSTED);
          }

          payloadData = selectedPayload.content;
          payloadId = selectedPayload.id;
        }

        // ===== ALL WRITES AFTER ALL READS =====

        const redemptionTimestamp = FieldValue.serverTimestamp();

        // 7. Update gift quantities
        transaction.update(selectedGift.ref, {
          remainingQuantity: FieldValue.increment(-1),
        });

        // 8. Update campaign quantities
        const campaignUpdate: any = {
          remainingParticipants: FieldValue.increment(-1),
          remainingGifts: FieldValue.increment(-1),
          totalGiftsAdded: FieldValue.increment(-1),
          totalAvailed: FieldValue.increment(1),
        };

        transaction.update(campaignDoc.ref, campaignUpdate);

        // 9. Update payload if needed
        if (!gift.isRedeemable && selectedPayloadDoc) {
          transaction.update(selectedPayloadDoc.ref, {
            redeemedByUserId: userId,
            redeemedAt: redemptionTimestamp,
          });
        }

        // 10. Create User Gift Record
        const redemptionId = `redemption_${Date.now()}_${Math.random().toString(36).substr(2, 9)}`;
        const userGiftData: UserGift = {
          userId,
          giftId: gift.id,
          campaignId: campaign.id,
          campaignName: campaign.name,
          giftName: gift.name,
          giftDescription: gift.description,
          isRedeemable: gift.isRedeemable,
          isRedeemed: null,
          redeemedAt: gift.isRedeemable ? null : redemptionTimestamp,
          availedAt: redemptionTimestamp,
          payload: payloadData,
          payloadId,
          supportedShops: gift.isRedeemable ? gift.supportedShops : null,
          redemptionId,
          availedViaStreak: availedViaStreak === true ? true : false,
          streakShopID: availedViaStreak === true ? streakShopID : null,
        };

        const userGiftRef = db.collection("user_gifts").doc();
        transaction.set(userGiftRef, userGiftData);

        logger.info("Scan campaign gift availed successfully", {
          userId,
          campaignId: campaign.id,
          giftId: gift.id,
          luckFactor,
          randomNumber,
          redemptionId,
          payloadId,
          remainingParticipants: campaign.remainingParticipants - 1,
          remainingGifts: campaign.remainingGifts - 1,
          timestamp: new Date().toISOString(),
        });

        availActivityData = {
          success: true,
          customerId: userId,
          giftId: gift.id,
          giftName: gift.name,
          redemptionId,
          isRedeemable: gift.isRedeemable,
          payloadId,
          luckFactor,
          randomNumber,
          remainingGifts: campaign.remainingGifts - 1,
          remainingParticipants: campaign.remainingParticipants - 1,
          phoneNumber: customerPhoneNumber,
        };

        // Return Success Response
        return {
          success: true,
          data: {
            giftName: gift.name,
            giftDescription: gift.description,
            isRedeemable: gift.isRedeemable,
            redemptionId,
            ...(payloadData && {payload: payloadData}),
            ...(userGiftData.supportedShops && {supportedShops: userGiftData.supportedShops}),
          },
        } as FunctionResponse;
      });

      // Activity log — written outside transaction
      if (availActivityData) {
        if (availActivityData.success) {
          await createActivityLog(`campaigns/${campaignId}/activityLogs`, {
            action: "gift_avail_success",
            actorId: userId,
            actorRole: "customer",
            functionName: "scanToAvailPublicPrivateAutoCampaignBySharedVendor",
            availedViaStreak: availedViaStreak === true,
            streakShopId: streakShopID ?? null,
            ...availActivityData,
          });
          if (availedViaStreak === true && streakShopID) {
            await createActivityLog(`shops/${streakShopID}/activityLogs`, {
              action: "gift_avail_triggered",
              actorId: userId,
              actorRole: "customer",
              functionName: "scanToAvailPublicPrivateAutoCampaignBySharedVendor",
              campaignId,
              availStatus: "success",
              triggeredByStreak: true,
              streakValue: null,
              giftCycleDay: null,
              ...availActivityData,
            });
          }
        } else {
          await createActivityLog(`campaigns/${campaignId}/activityLogs`, {
            action: "gift_avail_failed",
            actorId: userId,
            actorRole: "customer",
            functionName: "scanToAvailPublicPrivateAutoCampaignBySharedVendor",
            errorCode: ERROR_CODES.LUCK_FAILED,
            errorMessage: "Better luck next time!",
            availedViaStreak: availedViaStreak === true,
            streakShopId: streakShopID ?? null,
            ...availActivityData,
          });
          if (availedViaStreak === true && streakShopID) {
            await createActivityLog(`shops/${streakShopID}/activityLogs`, {
              action: "gift_avail_triggered",
              actorId: userId,
              actorRole: "customer",
              functionName: "scanToAvailPublicPrivateAutoCampaignBySharedVendor",
              campaignId,
              availStatus: "failed",
              triggeredByStreak: true,
              streakValue: null,
              giftCycleDay: null,
              failureReason: "not_lucky",
              errorCode: ERROR_CODES.LUCK_FAILED,
              errorMessage: "Better luck next time!",
              success: false,
              customerId: userId,
              luckFactor: availActivityData.luckFactor,
              randomNumber: availActivityData.randomNumber,
              phoneNumber: customerPhoneNumber,
            });
          }
        }
      }

      // Send FCM notification on successful avail
      if (result.success) {
        try {
          const userFcmDoc = await db.collection("users").doc(userId).get();
          const userFcmData = userFcmDoc.data();
          const fcmToken = userFcmData?.fcmToken;

          if (fcmToken) {
            const fcmMessage = {
              data: {
                type: "offer_avail_success",
                campaignId,
                giftName: result.data.giftName,
                redemptionId: result.data.redemptionId,
                isRedeemable: String(result.data.isRedeemable),
              },
              token: fcmToken,
            };

            await messaging.send(fcmMessage);
            logger.info("FCM data message sent successfully", {userId, campaignId});
          } else {
            logger.warn("User does not have FCM token, skipping notification", {userId});
          }
        } catch (fcmError) {
          logger.error("FCM notification failed, continuing with avail success:", fcmError);
        }
      }

      return result;
    } catch (error) {
      logger.error("Error in scanToAvailPublicPrivateAutoCampaignBySharedVendor", {
        userId,
        campaignId,
        error: error instanceof Error ? error.message : String(error),
      });

      if (preTxnActivityLog) {
        await createActivityLog(`campaigns/${campaignId}/activityLogs`, preTxnActivityLog);
      }

      if (!preTxnActivityLog && (!(error instanceof HttpsError) || !availActivityData)) {
        const errorCode = error instanceof HttpsError ? error.code : "unknown";
        const errorMessage = error instanceof Error ? error.message : String(error);
        await createActivityLog(`campaigns/${campaignId}/activityLogs`, {
          action: "gift_avail_failed",
          success: false,
          actorId: userId,
          actorRole: "customer",
          functionName: "scanToAvailPublicPrivateAutoCampaignBySharedVendor",
          customerId: userId,
          failureReason: errorCode,
          errorCode,
          errorMessage,
          phoneNumber: customerPhoneNumber,
          availedViaStreak: availedViaStreak === true,
          streakShopId: streakShopID ?? null,
        });
      }

      if (error instanceof HttpsError) {
        throw error;
      }

      throw new HttpsError("internal", ERROR_CODES.TRANSACTION_FAILED);
    }
  }
);

export const scanToAvailPublicPrivateAutoCampaignByStaff = onCall<ScanCampaignByStaffRequest>(
  async (request): Promise<FunctionResponse> => {
    const {userId, campaignId, shopId, availedViaStreak, streakShopID} = request.data;
    const authUserId = request.auth?.uid;
    // Closure variable to capture transaction log data for post-transaction activity logging
    let availActivityData: any = null;
    // Pre-transaction activity log (used to log failures discovered during reads)
    let preTxnActivityLog: any = null;
    // Customer phone number, resolved from the user doc once it's read (used in audit logs)
    let customerPhoneNumber: string | null = null;

    try {
      // Pre-validations
      if (!userId || !campaignId || !shopId) {
        throw new HttpsError("invalid-argument", "Missing required fields");
      }

      // Edge Case: Validate auth user exists
      if (!authUserId) {
        throw new HttpsError("unauthenticated", "User must be authenticated");
      }

      // Edge Case: Validate Campaign ID format (basic validation)
      if (typeof campaignId !== "string" || campaignId.trim().length === 0) {
        throw new HttpsError("invalid-argument", "Invalid Campaign ID format");
      }

      // Edge Case: Validate User ID format (basic validation)
      if (typeof userId !== "string" || userId.trim().length === 0) {
        throw new HttpsError("invalid-argument", "Invalid User ID format");
      }

      // Edge Case: Validate Shop ID format
      if (typeof shopId !== "string" || shopId.trim().length === 0) {
        throw new HttpsError("invalid-argument", "Invalid Shop ID format");
      }

      // Validate streakShopID when availedViaStreak is true
      if (availedViaStreak === true) {
        if (!streakShopID || typeof streakShopID !== "string" || streakShopID.trim().length === 0) {
          throw new HttpsError("invalid-argument", "streakShopID is required when availedViaStreak is true");
        }
      }

      // Validate staff authorization before starting transaction
      await validateStaffAuthorization(authUserId, shopId);

      // Start transaction
      const result = await db.runTransaction(async (transaction) => {
        // ===== ALL READS FIRST =====

        // 1. Validate User exists
        const userDoc = await transaction.get(
          db.collection("users").doc(userId)
        );

        if (!userDoc.exists) {
          throw new HttpsError("not-found", "User not found");
        }

        customerPhoneNumber = resolvePhoneNumber(userDoc.data());

        // 2. Get Campaign via ID
        const campaignDoc = await transaction.get(
          db.collection("campaigns").doc(campaignId)
        );

        if (!campaignDoc.exists) {
          throw new HttpsError("not-found", ERROR_CODES.CAMPAIGN_NOT_FOUND);
        }

        const campaign = {id: campaignDoc.id, ...campaignDoc.data()} as Campaign;

        // Validate campaign status
        if (campaign.status !== "active") {
          throw new HttpsError("failed-precondition", ERROR_CODES.CAMPAIGN_INACTIVE);
        }

        // Edge Case: Verify campaign has not expired based on end date (if applicable)
        if (campaign.endDate && new Date() > campaign.endDate.toDate()) {
          throw new HttpsError("failed-precondition", ERROR_CODES.CAMPAIGN_EXPIRED);
        }

        // Check remaining participants - campaign capacity
        if (campaign.remainingParticipants <= 0) {
          throw new HttpsError("resource-exhausted", ERROR_CODES.CAMPAIGN_PARTICIPATION_EXHAUSTED);
        }

        // Check remaining gifts at campaign level
        if (campaign.remainingGifts <= 0) {
          throw new HttpsError("resource-exhausted", ERROR_CODES.GIFTS_EXHAUSTED);
        }

        // 3. Get available gifts count from gifts sub-collection
        const availableGiftsSnapshot = await transaction.get(
          db.collection("campaigns").doc(campaign.id)
            .collection("gifts").where("remainingQuantity", ">", 0)
        );

        if (availableGiftsSnapshot.empty) {
          preTxnActivityLog = {
            action: "gift_avail_failed",
            success: false,
            actorId: authUserId ?? userId,
            actorRole: "staff",
            functionName: "scanToAvailPublicPrivateAutoCampaignByStaff",
            customerId: userId,
            shopId,
            failureReason: ERROR_CODES.GIFTS_EXHAUSTED,
            errorCode: ERROR_CODES.GIFTS_EXHAUSTED,
            errorMessage: "No gifts available",
            availedViaStreak: availedViaStreak === true,
            streakShopId: streakShopID ?? null,
            phoneNumber: customerPhoneNumber,
          };
          throw new HttpsError("resource-exhausted", ERROR_CODES.GIFTS_EXHAUSTED);
        }

        // Edge Case: Validate that at least one gift has remainingQuantity > 0 after fetching
        const validGifts = availableGiftsSnapshot.docs.filter((doc) => {
          const giftData = doc.data();
          return giftData.remainingQuantity > 0;
        });

        if (validGifts.length === 0) {
          preTxnActivityLog = {
            action: "gift_avail_failed",
            success: false,
            actorId: authUserId ?? userId,
            actorRole: "staff",
            functionName: "scanToAvailPublicPrivateAutoCampaignByStaff",
            customerId: userId,
            shopId,
            failureReason: ERROR_CODES.GIFTS_EXHAUSTED,
            errorCode: ERROR_CODES.GIFTS_EXHAUSTED,
            errorMessage: "No valid gifts with remainingQuantity > 0",
            availedViaStreak: availedViaStreak === true,
            streakShopId: streakShopID ?? null,
            phoneNumber: customerPhoneNumber,
          };
          throw new HttpsError("resource-exhausted", ERROR_CODES.GIFTS_EXHAUSTED);
        }

        // 3. Calculate Luck Factor using remaining counts
        const {remainingGifts, remainingParticipants} = campaign;

        // Edge Case: Handle division by zero - should not happen due to earlier checks
        if (remainingGifts === 0 || remainingParticipants === 0) {
          throw new HttpsError("failed-precondition", ERROR_CODES.CAMPAIGN_DATA_INCONSISTENT);
        }

        // Real-time luck calculation based on remaining counts
        const baseLuckPercentage = remainingGifts / remainingParticipants;
        const luckFactor = Math.min(baseLuckPercentage, 1); // Cap at 100%
        const randomNumber = Math.random();

        const isLucky = randomNumber <= luckFactor;

        // 4. If Not Lucky
        if (!isLucky) {
          // ===== WRITES FOR UNLUCKY ATTEMPT =====

          // Decrement remaining participants (every attempt counts)
          transaction.update(campaignDoc.ref, {
            remainingParticipants: FieldValue.increment(-1),
          });

          // Log failed attempt for audit
          logger.info("User was not lucky in scan campaign", {
            userId,
            campaignId: campaign.id,
            shopId,
            authUserId,
            luckFactor,
            randomNumber,
            remainingParticipants: campaign.remainingParticipants - 1,
            remainingGifts: campaign.remainingGifts,
            timestamp: new Date().toISOString(),
          });

          availActivityData = {
            success: false,
            customerId: userId,
            failureReason: "not_lucky",
            luckFactor,
            randomNumber,
            remainingGifts: campaign.remainingGifts,
            remainingParticipants: campaign.remainingParticipants - 1,
            phoneNumber: customerPhoneNumber,
          };

          return {
            success: false,
            error: {
              code: ERROR_CODES.LUCK_FAILED,
              message: "Better luck next time!",
            },
          } as FunctionResponse;
        }

        // 5. If Lucky - Gift Selection Process
        const availableGifts = validGifts.map((doc) => ({
          id: doc.id,
          ref: doc.ref,
          data: {id: doc.id, ...doc.data()} as Gift,
        }));

        // Randomly select one gift (truly random)
        const randomGiftIndex = Math.floor(Math.random() * availableGifts.length);
        const selectedGift = availableGifts[randomGiftIndex];
        const gift = selectedGift.data;

        // Edge Case: Double-check selected gift's remainingQuantity > 0 before proceeding
        if (gift.remainingQuantity <= 0) {
          throw new HttpsError("resource-exhausted", ERROR_CODES.GIFT_QUANTITY_INVALID);
        }

        // 6. Handle payload reading for non-redeemable gifts
        let payloadData: string | null = null;
        let payloadId: string | null = null;
        let selectedPayloadDoc: any = null;

        if (!gift.isRedeemable) {
          // Query unredeemed payloads - using redeemedByUserId as the redemption indicator
          const unredeemedPayloadsSnapshot = await transaction.get(
            db.collection("campaigns").doc(campaign.id)
              .collection("gifts").doc(gift.id)
              .collection("autoGiftPayloads").where("redeemedByUserId", "==", null)
          );

          if (unredeemedPayloadsSnapshot.empty) {
            throw new HttpsError("resource-exhausted", ERROR_CODES.PAYLOADS_EXHAUSTED);
          }

          // Edge Case: Validate payload document structure before selection
          const availablePayloads = unredeemedPayloadsSnapshot.docs.filter((doc) => {
            const payloadData = doc.data();
            // Basic structure validation for actual payload structure
            return payloadData &&
              payloadData.content &&
              typeof payloadData.content === "string" &&
              payloadData.redeemedByUserId === null; // Double-check it's not redeemed
          });

          if (availablePayloads.length === 0) {
            throw new HttpsError("failed-precondition", ERROR_CODES.PAYLOAD_STRUCTURE_INVALID);
          }

          // Randomly select one payload from unredeemed payloads
          const randomPayloadIndex = Math.floor(Math.random() * availablePayloads.length);
          selectedPayloadDoc = availablePayloads[randomPayloadIndex];

          const selectedPayload = {
            id: selectedPayloadDoc.id,
            ...selectedPayloadDoc.data(),
          };

          // Edge Case: Handle case where payload becomes redeemed between query and update
          if (selectedPayload.redeemedByUserId !== null) {
            throw new HttpsError("resource-exhausted", ERROR_CODES.PAYLOADS_EXHAUSTED);
          }

          // Store payload data for user_gifts record
          payloadData = selectedPayload.content;
          payloadId = selectedPayload.id;
        }

        // ===== ALL WRITES AFTER ALL READS =====

        const redemptionTimestamp = FieldValue.serverTimestamp();

        // 7. Update gift quantities
        transaction.update(selectedGift.ref, {
          remainingQuantity: FieldValue.increment(-1),
        });

        // 8. Update campaign quantities - New logic for remaining counts
        const campaignUpdate: any = {
          // Decrement remaining participants (every attempt counts)
          remainingParticipants: FieldValue.increment(-1),
          // Decrement remaining gifts (only on success)
          remainingGifts: FieldValue.increment(-1),
          totalGiftsAdded: FieldValue.increment(-1),
          totalAvailed: FieldValue.increment(1),
        };

        transaction.update(campaignDoc.ref, campaignUpdate);

        // 9. Update payload if needed
        if (!gift.isRedeemable && selectedPayloadDoc) {
          transaction.update(selectedPayloadDoc.ref, {
            redeemedByUserId: userId,
            redeemedAt: redemptionTimestamp,
          });
        }

        // 10. Create User Gift Record
        const redemptionId = `redemption_${Date.now()}_${Math.random().toString(36).substr(2, 9)}`;
        const userGiftData: UserGift = {
          userId,
          giftId: gift.id,
          campaignId: campaign.id,
          campaignName: campaign.name,
          giftName: gift.name,
          giftDescription: gift.description,
          isRedeemable: gift.isRedeemable,
          isRedeemed: null,
          redeemedAt: gift.isRedeemable ? null : redemptionTimestamp,
          availedAt: redemptionTimestamp,
          payload: payloadData,
          payloadId,
          supportedShops: gift.isRedeemable ? gift.supportedShops : null,
          redemptionId,
          availedViaStreak: availedViaStreak === true ? true : false,
          streakShopID: availedViaStreak === true ? streakShopID : null,
        };

        const userGiftRef = db.collection("user_gifts").doc();
        transaction.set(userGiftRef, userGiftData);

        // 11. Audit Logging
        logger.info("Scan campaign gift availed successfully by staff", {
          userId,
          campaignId: campaign.id,
          giftId: gift.id,
          shopId,
          authUserId,
          luckFactor,
          randomNumber,
          redemptionId,
          payloadId,
          remainingParticipants: campaign.remainingParticipants - 1,
          remainingGifts: campaign.remainingGifts - 1,
          timestamp: new Date().toISOString(),
        });

        availActivityData = {
          success: true,
          customerId: userId,
          giftId: gift.id,
          giftName: gift.name,
          redemptionId,
          isRedeemable: gift.isRedeemable,
          payloadId,
          luckFactor,
          randomNumber,
          remainingGifts: campaign.remainingGifts - 1,
          remainingParticipants: campaign.remainingParticipants - 1,
          phoneNumber: customerPhoneNumber,
        };

        // 12. Return Success Response
        return {
          success: true,
          data: {
            giftName: gift.name,
            giftDescription: gift.description,
            isRedeemable: gift.isRedeemable,
            redemptionId,
            ...(payloadData && {payload: payloadData}),
            ...(userGiftData.supportedShops && {supportedShops: userGiftData.supportedShops}),
          },
        } as FunctionResponse;
      });

      // Activity log — written outside transaction
      if (availActivityData) {
        if (availActivityData.success) {
          await createActivityLog(`campaigns/${campaignId}/activityLogs`, {
            action: "gift_avail_success",
            actorId: authUserId ?? userId,
            actorRole: "staff",
            functionName: "scanToAvailPublicPrivateAutoCampaignByStaff",
            shopId,
            availedViaStreak: availedViaStreak === true,
            streakShopId: streakShopID ?? null,
            ...availActivityData,
          });
          if (availedViaStreak === true && streakShopID) {
            await createActivityLog(`shops/${streakShopID}/activityLogs`, {
              action: "gift_avail_triggered",
              actorId: authUserId ?? userId,
              actorRole: "staff",
              functionName: "scanToAvailPublicPrivateAutoCampaignByStaff",
              campaignId,
              shopId,
              availStatus: "success",
              triggeredByStreak: true,
              streakValue: null,
              giftCycleDay: null,
              ...availActivityData,
            });
          }
        } else {
          await createActivityLog(`campaigns/${campaignId}/activityLogs`, {
            action: "gift_avail_failed",
            actorId: authUserId ?? userId,
            actorRole: "staff",
            functionName: "scanToAvailPublicPrivateAutoCampaignByStaff",
            shopId,
            errorCode: ERROR_CODES.LUCK_FAILED,
            errorMessage: "Better luck next time!",
            availedViaStreak: availedViaStreak === true,
            streakShopId: streakShopID ?? null,
            ...availActivityData,
          });
          if (availedViaStreak === true && streakShopID) {
            await createActivityLog(`shops/${streakShopID}/activityLogs`, {
              action: "gift_avail_triggered",
              actorId: authUserId ?? userId,
              actorRole: "staff",
              functionName: "scanToAvailPublicPrivateAutoCampaignByStaff",
              campaignId,
              shopId,
              availStatus: "failed",
              triggeredByStreak: true,
              streakValue: null,
              giftCycleDay: null,
              failureReason: "not_lucky",
              errorCode: ERROR_CODES.LUCK_FAILED,
              errorMessage: "Better luck next time!",
              success: false,
              customerId: userId,
              luckFactor: availActivityData.luckFactor,
              randomNumber: availActivityData.randomNumber,
              phoneNumber: customerPhoneNumber,
            });
          }
        }
      }

      // Send FCM notification on successful avail
      if (result.success) {
        try {
          const userFcmDoc = await db.collection("users").doc(userId).get();
          const userFcmData = userFcmDoc.data();
          const fcmToken = userFcmData?.fcmToken;

          if (fcmToken) {
            const fcmMessage = {
              data: {
                type: "offer_avail_success",
                campaignId,
                giftName: result.data.giftName,
                redemptionId: result.data.redemptionId,
                isRedeemable: String(result.data.isRedeemable),
              },
              token: fcmToken,
            };

            await messaging.send(fcmMessage);
            logger.info("FCM data message sent successfully", {userId, campaignId});
          } else {
            logger.warn("User does not have FCM token, skipping notification", {userId});
          }
        } catch (fcmError) {
          logger.error("FCM notification failed, continuing with avail success:", fcmError);
        }
      }

      return result;
    } catch (error) {
      // Error logging and handling
      logger.error("Error in scanToAvailPublicPrivateAutoCampaignByStaff", {
        userId,
        campaignId,
        shopId,
        authUserId,
        error: error instanceof Error ? error.message : String(error),
      });

      if (preTxnActivityLog) {
        await createActivityLog(`campaigns/${campaignId}/activityLogs`, preTxnActivityLog);
      }

      if (!preTxnActivityLog && (!(error instanceof HttpsError) || !availActivityData)) {
        const errorCode = error instanceof HttpsError ? error.code : "unknown";
        const errorMessage = error instanceof Error ? error.message : String(error);
        await createActivityLog(`campaigns/${campaignId}/activityLogs`, {
          action: "gift_avail_failed",
          success: false,
          actorId: authUserId ?? userId,
          actorRole: "staff",
          functionName: "scanToAvailPublicPrivateAutoCampaignByStaff",
          customerId: userId,
          shopId,
          failureReason: errorCode,
          errorCode,
          errorMessage,
          phoneNumber: customerPhoneNumber,
          availedViaStreak: availedViaStreak === true,
          streakShopId: streakShopID ?? null,
        });
      }

      if (error instanceof HttpsError) {
        throw error;
      }

      throw new HttpsError("internal", ERROR_CODES.TRANSACTION_FAILED);
    }
  }
);
