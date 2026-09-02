import {onCall, HttpsError} from "firebase-functions/v2/https";
import {getFirestore, FieldValue} from "firebase-admin/firestore";
import * as logger from "firebase-functions/logger";
import {
  AccountDeletionRequest,
  RequestAccountDeletionResponse,
  CancelAccountDeletionResponse,
  ACCOUNT_ERROR_CODES,
} from "../types";

const db = getFirestore();

/**
 * Cloud Function: Request Account Deletion
 * Marks the user's account for deletion (soft delete). Denormalizes the
 * request onto users/{userId}.deletionRequestedAt so the client can route
 * the user to a "deletion pending" screen on login. The actual permanent
 * purge is performed later by a separate scheduled job (not implemented here).
 *
 * @param {object} data - Empty object (userId comes from auth context)
 * @param {object} context - Function context with auth information
 * @returns {Promise<RequestAccountDeletionResponse>} Success response
 */
export const requestAccountDeletion = onCall<object, Promise<RequestAccountDeletionResponse>>(
  async (request) => {
    if (!request.auth) {
      throw new HttpsError(
        "unauthenticated",
        "User must be authenticated to request account deletion",
        ACCOUNT_ERROR_CODES.UNAUTHORIZED
      );
    }

    const userId = request.auth.uid;
    logger.info(`Starting account deletion request for user: ${userId}`);

    const userRef = db.collection("users").doc(userId);
    const requestRef = db.collection("accountDeletionRequests").doc(userId);

    try {
      await db.runTransaction(async (transaction) => {
        const [userDoc, requestDoc] = await Promise.all([
          transaction.get(userRef),
          transaction.get(requestRef),
        ]);

        if (!userDoc.exists) {
          throw new HttpsError(
            "not-found",
            "User document not found",
            ACCOUNT_ERROR_CODES.USER_NOT_FOUND
          );
        }

        // Idempotent: a pending request already exists, nothing to do.
        if (requestDoc.exists && requestDoc.data()?.status === "pending") {
          logger.info(`Deletion request already pending for user: ${userId}`);
          return;
        }

        const deletionRequest: AccountDeletionRequest = {
          userId,
          requestedAt: FieldValue.serverTimestamp(),
          status: "pending",
          processedAt: null,
          processedBy: null,
          reason: null,
        };

        transaction.set(requestRef, deletionRequest);
        transaction.update(userRef, {
          deletionRequestedAt: FieldValue.serverTimestamp(),
        });
      });

      logger.info(`Successfully requested account deletion for user: ${userId}`);

      return {success: true};
    } catch (error: any) {
      logger.error("Account deletion request failed:", error);

      if (error instanceof HttpsError) {
        throw error;
      }

      throw new HttpsError(
        "internal",
        `Account deletion request failed: ${error.message}`,
        ACCOUNT_ERROR_CODES.REQUEST_FAILED
      );
    }
  }
);

/**
 * Cloud Function: Cancel Account Deletion
 * Cancels a pending account deletion request and clears the denormalized
 * flag on the user document. Cannot cancel once backend processing has
 * already started (status is no longer 'pending').
 *
 * @param {object} data - Empty object (userId comes from auth context)
 * @param {object} context - Function context with auth information
 * @returns {Promise<CancelAccountDeletionResponse>} Success response
 */
export const cancelAccountDeletion = onCall<object, Promise<CancelAccountDeletionResponse>>(
  async (request) => {
    if (!request.auth) {
      throw new HttpsError(
        "unauthenticated",
        "User must be authenticated to cancel account deletion",
        ACCOUNT_ERROR_CODES.UNAUTHORIZED
      );
    }

    const userId = request.auth.uid;
    logger.info(`Starting account deletion cancellation for user: ${userId}`);

    const userRef = db.collection("users").doc(userId);
    const requestRef = db.collection("accountDeletionRequests").doc(userId);

    try {
      const cancelled = await db.runTransaction(async (transaction) => {
        const requestDoc = await transaction.get(requestRef);

        if (!requestDoc.exists || requestDoc.data()?.status !== "pending") {
          return false;
        }

        transaction.update(requestRef, {
          status: "cancelled",
          processedAt: FieldValue.serverTimestamp(),
          processedBy: "user",
        });
        transaction.update(userRef, {
          deletionRequestedAt: null,
        });

        return true;
      });

      if (!cancelled) {
        logger.info(`No cancellable deletion request found for user: ${userId}`);
        return {success: false};
      }

      logger.info(`Successfully cancelled account deletion for user: ${userId}`);

      return {success: true};
    } catch (error: any) {
      logger.error("Account deletion cancellation failed:", error);

      if (error instanceof HttpsError) {
        throw error;
      }

      throw new HttpsError(
        "internal",
        `Account deletion cancellation failed: ${error.message}`,
        ACCOUNT_ERROR_CODES.CANCEL_FAILED
      );
    }
  }
);
