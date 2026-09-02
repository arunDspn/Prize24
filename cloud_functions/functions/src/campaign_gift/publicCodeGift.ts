import {onCall, HttpsError} from "firebase-functions/v2/https";
import {getFirestore, FieldValue} from "firebase-admin/firestore";
import * as admin from "firebase-admin";
import * as logger from "firebase-functions/logger";
import {
  Campaign,
  Gift,
  CodeGiftCode,
  UserGift,
  FunctionResponse,
  ERROR_CODES,
} from "../types";

// Initialize Firebase Admin if not already initialized
if (!admin.apps.length) {
  admin.initializeApp();
}

const db = getFirestore();

interface PublicCodeGiftRequest {
  userId: string;
  campaignSlug: string;
  giftSlug: string;
  code: string;
}

/**
 * Public Code Gift Function
 * Can only be availed via TEXT method
 */
export const textAvailPublicFullTextCodeCampaign = onCall<PublicCodeGiftRequest>(
  async (request): Promise<FunctionResponse> => {
    const {userId, campaignSlug, giftSlug, code} = request.data;

    try {
      // Pre-validations
      if (!userId || !campaignSlug || !giftSlug || !code) {
        throw new HttpsError("invalid-argument", "Missing required fields");
      }

      // Start transaction
      return await db.runTransaction(async (transaction) => {
        // STEP 1: ALL READS FIRST (to avoid Firestore transaction error)

        // 1. Validate User ID exists and is active
        const userDoc = await transaction.get(db.collection("users").doc(userId));
        if (!userDoc.exists) {
          throw new HttpsError("not-found", ERROR_CODES.USER_NOT_FOUND);
        }
        // const userData = userDoc.data();
        // if (userData?.status !== "active") {
        //   throw new HttpsError("failed-precondition", "User is not active");
        // }

        // 2. Get Campaign via slug
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

        // 3. Get Gift via slug
        const giftsSnapshot = await transaction.get(
          db.collection("campaigns").doc(campaign.id)
            .collection("gifts").where("publicSlug", "==", giftSlug).limit(1)
        );

        if (giftsSnapshot.empty) {
          throw new HttpsError("not-found", ERROR_CODES.GIFT_NOT_FOUND);
        }

        const giftDoc = giftsSnapshot.docs[0];
        const gift = {id: giftDoc.id, ...giftDoc.data()} as Gift;

        // 4. Get and Validate Code
        const codeSnapshot = await transaction.get(
          db.collection("campaigns").doc(campaign.id)
            .collection("gifts").doc(gift.id)
            .collection("codeGiftCodes").where("code", "==", code).limit(1)
        );

        if (codeSnapshot.empty) {
          throw new HttpsError("not-found", ERROR_CODES.CODE_NOT_FOUND);
        }

        const codeDoc = codeSnapshot.docs[0];
        const codeData = {id: codeDoc.id, ...codeDoc.data()} as CodeGiftCode;

        // STEP 2: VALIDATIONS (after all reads)

        // Validate code is not already redeemed
        if (codeData.isRedeemed) {
          throw new HttpsError("already-exists", ERROR_CODES.CODE_ALREADY_REDEEMED);
        }

        // Check if code is expired (if expiration field exists)
        if (codeData.expirationDate) {
          let expirationDate: Date;

          if (typeof codeData.expirationDate === "object" && "toDate" in codeData.expirationDate) {
            // Firestore Timestamp
            expirationDate = codeData.expirationDate.toDate();
          } else {
            // Handle other date formats
            expirationDate = new Date(codeData.expirationDate as any);
          }

          if (new Date() > expirationDate) {
            throw new HttpsError("failed-precondition", ERROR_CODES.CODE_EXPIRED);
          }
        }

        // Reserve Gift (check remaining quantity)
        if (gift.remainingQuantity <= 0) {
          throw new HttpsError("resource-exhausted", ERROR_CODES.GIFT_UNAVAILABLE);
        }

        // STEP 3: ALL WRITES (after all reads and validations)

        const redemptionTimestamp = FieldValue.serverTimestamp();

        // 5. Mark Code as Redeemed
        transaction.update(codeDoc.ref, {
          isRedeemed: true,
          redeemedByUserId: userId,
          redeemedAt: redemptionTimestamp,
        });

        // 6. Update Gift Quantities
        transaction.update(giftDoc.ref, {
          remainingQuantity: FieldValue.increment(-1),
        });

        // 7. Create User Gift Record
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
          payload: gift.isRedeemable ? null : codeData.payload,
          supportedShops: gift.isRedeemable ? gift.supportedShops : null,
          redemptionId,
        };

        const userGiftRef = db.collection("user_gifts").doc();
        transaction.set(userGiftRef, userGiftData);

        // 8. Audit Logging (outside transaction to avoid blocking)
        logger.info("Code gift redeemed successfully", {
          userId,
          campaignId: campaign.id,
          giftId: gift.id,
          code,
          redemptionId,
          timestamp: new Date().toISOString(),
        });

        // 9. Return Success Response
        return {
          success: true,
          data: {
            giftName: gift.name,
            giftDescription: gift.description,
            isRedeemable: gift.isRedeemable,
            redemptionId,
            ...(userGiftData.payload && {payload: userGiftData.payload}),
            ...(userGiftData.supportedShops && {supportedShops: userGiftData.supportedShops}),
          },
        } as FunctionResponse;
      });
    } catch (error) {
      // Error logging and handling
      logger.error("Error in textAvailPublicFullTextCodeCampaign", {
        userId,
        campaignSlug,
        giftSlug,
        code,
        error: error instanceof Error ? error.message : String(error),
      });

      if (error instanceof HttpsError) {
        throw error;
      }

      throw new HttpsError("internal", ERROR_CODES.TRANSACTION_FAILED);
    }
  }
);
