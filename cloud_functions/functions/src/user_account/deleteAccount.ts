import {onCall, HttpsError} from "firebase-functions/v2/https";
import {getFirestore, WriteBatch} from "firebase-admin/firestore";
import {getAuth} from "firebase-admin/auth";
import * as logger from "firebase-functions/logger";
import {
  DeleteAccountResponse,
  ACCOUNT_ERROR_CODES,
} from "../types";

const db = getFirestore();
const auth = getAuth();

/**
 * Cloud Function: Delete User Account
 * Deletes all user data from Firestore and Firebase Auth
 *
 * @param {object} data - Empty object (userId comes from auth context)
 * @param {object} context - Function context with auth information
 * @returns {Promise<DeleteAccountResponse>} Success response
 */
export const deleteAccount = onCall<object, Promise<DeleteAccountResponse>>(
  async (request) => {
    // 1. Verify authentication
    if (!request.auth) {
      throw new HttpsError(
        "unauthenticated",
        "User must be authenticated to delete account",
        ACCOUNT_ERROR_CODES.UNAUTHORIZED
      );
    }

    const userId = request.auth.uid;
    logger.info(`Starting account deletion for user: ${userId}`);

    try {
      // 2. Get user document to extract followedShops and staffShopIds
      const userDoc = await db.collection("users").doc(userId).get();

      if (!userDoc.exists) {
        throw new HttpsError(
          "not-found",
          "User document not found",
          ACCOUNT_ERROR_CODES.USER_NOT_FOUND
        );
      }

      const userData = userDoc.data();
      const followedShops: string[] = userData?.followedShops || [];
      const staffShopIds: string[] = userData?.staffShopIds || [];

      logger.info(`User has ${followedShops.length} followed shops and ${staffShopIds.length} staff shops`);

      // 3. Collect all operations for batching
      const batches: WriteBatch[] = [];
      let currentBatch = db.batch();
      let operationCount = 0;
      const MAX_BATCH_SIZE = 500;

      /**
             * Helper to add operation to batch
             * @param {Function} operation - The operation to add to the current batch
             */
      const addToBatch = (operation: () => void) => {
        if (operationCount >= MAX_BATCH_SIZE) {
          batches.push(currentBatch);
          currentBatch = db.batch();
          operationCount = 0;
        }
        operation();
        operationCount++;
      };

      // 4. Delete campaigns where vendorId == userId (including activityLogs & gifts subcollections)
      logger.info("Querying campaigns...");
      const campaignsQuery = await db
        .collection("campaigns")
        .where("vendorId", "==", userId)
        .get();

      logger.info(`Found ${campaignsQuery.size} campaigns to delete`);
      for (const campaignDoc of campaignsQuery.docs) {
        const campaignId = campaignDoc.id;
        logger.info(`Deleting subcollections for campaign: ${campaignId}`);

        // Delete activityLogs subcollection
        const activityLogsQuery = await db
          .collection("campaigns")
          .doc(campaignId)
          .collection("activityLogs")
          .get();
        for (const logDoc of activityLogsQuery.docs) {
          addToBatch(() => currentBatch.delete(logDoc.ref));
        }

        // Delete gifts subcollection
        const giftsQuery = await db
          .collection("campaigns")
          .doc(campaignId)
          .collection("gifts")
          .get();
        for (const giftDoc of giftsQuery.docs) {
          addToBatch(() => currentBatch.delete(giftDoc.ref));
        }

        // Delete campaign document (sharedVendors array on owner doc is deleted with campaign doc)
        addToBatch(() => currentBatch.delete(campaignDoc.ref));
      }

      // 5. Delete shops owned by user (including subcollections & user-side followedShops references)
      logger.info("Querying shops...");
      const shopsQuery = await db
        .collection("shops")
        .where("shopOwnerId", "==", userId)
        .get();

      logger.info(`Found ${shopsQuery.size} shops to delete`);

      for (const shopDoc of shopsQuery.docs) {
        const shopId = shopDoc.id;
        logger.info(`Deleting subcollections and follower references for shop: ${shopId}`);

        // Delete followers subcollection (vendor side) and user-side followedShops references
        const followersQuery = await db
          .collection("shops")
          .doc(shopId)
          .collection("followers")
          .get();
        for (const followerDoc of followersQuery.docs) {
          const followerUserId = followerDoc.id;

          // Delete vendor-side follower doc (shops/{shopId}/followers/{followerUserId})
          addToBatch(() => currentBatch.delete(followerDoc.ref));

          // Delete user-side followedShops reference (users/{followerUserId}/followedShops/{shopId})
          const followerUserShopRef = db
            .collection("users")
            .doc(followerUserId)
            .collection("followedShops")
            .doc(shopId);
          addToBatch(() => currentBatch.delete(followerUserShopRef));
        }

        // Delete activityLogs subcollection
        const shopActivityLogsQuery = await db
          .collection("shops")
          .doc(shopId)
          .collection("activityLogs")
          .get();
        for (const logDoc of shopActivityLogsQuery.docs) {
          addToBatch(() => currentBatch.delete(logDoc.ref));
        }

        // Delete staffs subcollection
        const staffsQuery = await db
          .collection("shops")
          .doc(shopId)
          .collection("staffs")
          .get();
        for (const staffDoc of staffsQuery.docs) {
          addToBatch(() => currentBatch.delete(staffDoc.ref));
        }

        // Delete offers subcollection
        const offersQuery = await db
          .collection("shops")
          .doc(shopId)
          .collection("offers")
          .get();
        for (const offerDoc of offersQuery.docs) {
          addToBatch(() => currentBatch.delete(offerDoc.ref));
        }

        // Delete the shop document itself
        addToBatch(() => currentBatch.delete(shopDoc.ref));
      }

      // 6. Remove user from followers in followed shops
      logger.info("Removing user from followed shops...");
      for (const shopId of followedShops) {
        const followerRef = db
          .collection("shops")
          .doc(shopId)
          .collection("followers")
          .doc(userId);

        addToBatch(() => currentBatch.delete(followerRef));
      }

      // 7. Remove user from staffs in staff shops
      logger.info("Removing user from staff shops...");
      for (const shopId of staffShopIds) {
        const staffRef = db
          .collection("shops")
          .doc(shopId)
          .collection("staffs")
          .doc(userId);

        addToBatch(() => currentBatch.delete(staffRef));
      }

      // 8. Delete staffRequests where receiverId == userId
      logger.info("Querying staff requests...");
      const staffRequestsQuery = await db
        .collection("staffRequests")
        .where("receiverId", "==", userId)
        .get();

      logger.info(`Found ${staffRequestsQuery.size} staff requests to delete`);
      for (const doc of staffRequestsQuery.docs) {
        addToBatch(() => currentBatch.delete(doc.ref));
      }

      // 9. Delete user_gifts where userId == userId
      logger.info("Querying user gifts...");
      const userGiftsQuery = await db
        .collection("user_gifts")
        .where("userId", "==", userId)
        .get();

      logger.info(`Found ${userGiftsQuery.size} user gifts to delete`);
      for (const doc of userGiftsQuery.docs) {
        addToBatch(() => currentBatch.delete(doc.ref));
      }

      // 10. Delete user's followedShops subcollection
      logger.info("Deleting followedShops subcollection...");
      const followedShopsQuery = await db
        .collection("users")
        .doc(userId)
        .collection("followedShops")
        .get();

      for (const doc of followedShopsQuery.docs) {
        addToBatch(() => currentBatch.delete(doc.ref));
      }

      // 11. Delete user document
      logger.info("Adding user document deletion...");
      addToBatch(() => currentBatch.delete(db.collection("users").doc(userId)));

      // Add the last batch if it has operations
      if (operationCount > 0) {
        batches.push(currentBatch);
      }

      // 12. Commit all batches
      logger.info(`Committing ${batches.length} batches with total operations...`);
      for (let i = 0; i < batches.length; i++) {
        await batches[i].commit();
        logger.info(`Committed batch ${i + 1}/${batches.length}`);
      }

      // 13. Delete Firebase Auth account
      logger.info("Deleting Firebase Auth account...");
      await auth.deleteUser(userId);

      logger.info(`Successfully deleted account for user: ${userId}`);

      return {
        success: true,
        message: "Account deleted successfully",
      };
    } catch (error: any) {
      logger.error("Account deletion failed:", error);

      // If it's already an HttpsError, rethrow it
      if (error instanceof HttpsError) {
        throw error;
      }

      // Otherwise, wrap it in a generic error
      throw new HttpsError(
        "internal",
        `Account deletion failed: ${error.message}`,
        ACCOUNT_ERROR_CODES.DELETION_FAILED
      );
    }
  }
);
