import {onCall, HttpsError} from "firebase-functions/v2/https";
import {getFirestore, FieldValue} from "firebase-admin/firestore";
import * as admin from "firebase-admin";
import * as logger from "firebase-functions/logger";
import {
  Campaign,
  Gift,
  UserGift,
  FunctionResponse,
  ERROR_CODES,
} from "../types";

// Initialize Firebase Admin if not already initialized
if (!admin.apps.length) {
  admin.initializeApp();
}

const db = getFirestore();

interface PublicAutoGiftRequest {
  userId: string;
  campaignSlug: string;
}

/**
 * Public Auto Gift Function - textAvail-Public-SemiText-AutoCampaign
 * Supports Public campaigns via slug
 * Luck-based gift distribution with automatic payload selection
 *
 * Key Features:
 * - Edge case handling for campaign expiration, data consistency, and race conditions
 * - Uses remainingParticipants and remainingGifts for real-time luck calculation
 * - Updated to use autoGiftPayloads collection path
 * - Comprehensive payload validation
 * - Vendor-controlled text scanning with attempt-based participant tracking
 *
 * Draw Logic:
 * - Every text attempt decrements remainingParticipants (success or failure)
 * - Only successful attempts decrement remainingGifts and gift remainingQuantity
 * - Luck factor = remainingGifts / remainingParticipants (real-time probability)
 */
export const textAvailPublicSemiTextAutoCampaign = onCall<PublicAutoGiftRequest>(
  async (request): Promise<FunctionResponse> => {
    const {userId, campaignSlug} = request.data;

    try {
      // Pre-validations
      if (!userId || !campaignSlug) {
        throw new HttpsError("invalid-argument", "Missing required fields");
      }

      // Edge Case: Validate Campaign Slug format (basic validation)
      if (typeof campaignSlug !== "string" || campaignSlug.trim().length === 0) {
        throw new HttpsError("invalid-argument", "Invalid Campaign Slug format");
      }

      // Edge Case: Validate User ID format (basic validation)
      if (typeof userId !== "string" || userId.trim().length === 0) {
        throw new HttpsError("invalid-argument", "Invalid User ID format");
      }

      // Start transaction
      return await db.runTransaction(async (transaction) => {
        // ===== ALL READS FIRST =====

        // 1. Get Campaign via publicSlug
        const campaignsSnapshot = await transaction.get(
          db.collection("campaigns").where("publicSlug", "==", campaignSlug).limit(1)
        );

        if (campaignsSnapshot.empty) {
          throw new HttpsError("not-found", ERROR_CODES.CAMPAIGN_NOT_FOUND);
        }

        const campaignDoc = campaignsSnapshot.docs[0];
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
          throw new HttpsError("resource-exhausted", ERROR_CODES.GIFTS_EXHAUSTED);
        }

        // Edge Case: Validate that at least one gift has remainingQuantity > 0 after fetching
        const validGifts = availableGiftsSnapshot.docs.filter((doc) => {
          const giftData = doc.data();
          return giftData.remainingQuantity > 0;
        });

        if (validGifts.length === 0) {
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
          logger.info("User was not lucky in public campaign", {
            userId,
            campaignId: campaign.id,
            campaignSlug,
            luckFactor,
            randomNumber,
            remainingParticipants: campaign.remainingParticipants - 1,
            remainingGifts: campaign.remainingGifts,
            timestamp: new Date().toISOString(),
          });

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
        };

        const userGiftRef = db.collection("user_gifts").doc();
        transaction.set(userGiftRef, userGiftData);

        // 11. Audit Logging
        logger.info("Public campaign gift redeemed successfully", {
          userId,
          campaignId: campaign.id,
          campaignSlug,
          giftId: gift.id,
          luckFactor,
          randomNumber,
          redemptionId,
          payloadId,
          remainingParticipants: campaign.remainingParticipants - 1,
          remainingGifts: campaign.remainingGifts - 1,
          timestamp: new Date().toISOString(),
        });

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
    } catch (error) {
      // Error logging and handling
      logger.error("Error in textAvailPublicSemiTextAutoCampaign", {
        userId,
        campaignSlug,
        error: error instanceof Error ? error.message : String(error),
      });

      if (error instanceof HttpsError) {
        throw error;
      }

      throw new HttpsError("internal", ERROR_CODES.TRANSACTION_FAILED);
    }
  }
);
