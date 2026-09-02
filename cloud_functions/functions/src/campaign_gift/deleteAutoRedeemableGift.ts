import {onCall, HttpsError} from "firebase-functions/v2/https";
import {getFirestore, FieldValue} from "firebase-admin/firestore";
import * as admin from "firebase-admin";
import * as logger from "firebase-functions/logger";

if (!admin.apps.length) {
  admin.initializeApp();
}

const db = getFirestore();

interface DeleteAutoRedeemableGiftRequest {
    campaignId?: string;
    giftId?: string;
}

/**
 * Deletes an auto redeemable gift from campaigns/{campaignId}/gifts/{giftId},
 * subtracts gift.remainingQuantity from campaigns/{campaignId}.totalGiftsAdded,
 * and adds gift.remainingQuantity to campaigns/{campaignId}.remainingGifts.
 */
export const deleteAutoRedeemableGift = onCall<DeleteAutoRedeemableGiftRequest>(
  async (request) => {
    if (!request.auth?.uid) {
      throw new HttpsError("unauthenticated", "Authentication required");
    }

    const {campaignId, giftId} = request.data || {};

    if (!campaignId || !giftId) {
      throw new HttpsError("invalid-argument", "campaignId and giftId are required");
    }

    const campaignRef = db.collection("campaigns").doc(campaignId);
    const giftRef = campaignRef.collection("gifts").doc(giftId);

    try {
      const result = await db.runTransaction(async (transaction) => {
        const [campaignDoc, giftDoc] = await Promise.all([
          transaction.get(campaignRef),
          transaction.get(giftRef),
        ]);

        if (!campaignDoc.exists) {
          throw new HttpsError("not-found", "Campaign not found");
        }

        if (!giftDoc.exists) {
          throw new HttpsError("not-found", "Gift not found");
        }

        const giftData = giftDoc.data();
        const remainingQuantity = giftData?.remainingQuantity;

        if (typeof remainingQuantity !== "number" || !Number.isFinite(remainingQuantity)) {
          throw new HttpsError("failed-precondition", "Gift remainingQuantity is invalid");
        }

        transaction.update(campaignRef, {
          totalGiftsAdded: FieldValue.increment(-remainingQuantity),
          remainingGifts: FieldValue.increment(remainingQuantity),
        });

        transaction.delete(giftRef);

        return {remainingQuantity};
      });

      logger.info("Auto redeemable gift deleted", {
        campaignId,
        giftId,
        subtractedFromTotalGiftsAdded: result.remainingQuantity,
        addedToRemainingGifts: result.remainingQuantity,
        deletedBy: request.auth.uid,
        timestamp: new Date().toISOString(),
      });

      return {
        success: true,
        data: {
          campaignId,
          giftId,
          subtractedFromTotalGiftsAdded: result.remainingQuantity,
          addedToRemainingGifts: result.remainingQuantity,
          addedToTotalGiftsAdded: -result.remainingQuantity,
        },
      };
    } catch (error) {
      if (error instanceof HttpsError) {
        throw error;
      }

      logger.error("Failed to delete auto redeemable gift", {
        campaignId,
        giftId,
        error,
      });

      throw new HttpsError("internal", "Failed to delete auto redeemable gift");
    }
  }
);
