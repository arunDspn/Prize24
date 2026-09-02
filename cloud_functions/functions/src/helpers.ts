import {HttpsError} from "firebase-functions/v2/https";
import {getFirestore} from "firebase-admin/firestore";
import {SHOP_FOLLOW_ERROR_CODES} from "./types";

const db = getFirestore();

/**
 * Helper function to validate staff authorization for a shop
 * Validates before starting transaction to avoid transaction overhead
 * @param {string} authUserId - The authenticated user's ID
 * @param {string} shopId - The shop ID to validate access for
 * @throws {HttpsError} If user is not authorized
 */
export async function validateStaffAuthorization(
  authUserId: string,
  shopId: string
): Promise<void> {
  const requesterDoc = await db.collection("users").doc(authUserId).get();

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
      "You are not authorized to scan for this shop",
      SHOP_FOLLOW_ERROR_CODES.UNAUTHORIZED
    );
  }
}
