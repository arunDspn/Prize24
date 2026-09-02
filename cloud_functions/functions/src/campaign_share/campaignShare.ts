import {onCall, HttpsError} from "firebase-functions/v2/https";
import {getFirestore, Timestamp, FieldValue} from "firebase-admin/firestore";
import {
  CampaignShareRequest,
  SendCampaignShareRequest,
  RespondToCampaignShareRequest,
  CampaignShareApiResponse,
  CAMPAIGN_SHARE_ERROR_CODES,
} from "../types";


const db = getFirestore();

/**
 * Helper function to validate if user is a vendor
 * @param {string} userId - The user ID to validate
 * @return {Promise<boolean>} True if user is a vendor, false otherwise
 */
async function validateVendor(userId: string): Promise<boolean> {
  try {
    const userDoc = await db.collection("users").doc(userId).get();
    return userDoc.exists && userDoc.data()?.isVendor === true;
  } catch {
    return false;
  }
}

/**
 * Helper function to get user profile data
 * @param {string} userId - The user ID to get profile data for
 * @return {Promise<Object>} User profile data with name and phone
 */
async function getUserProfile(userId: string) {
  const userDoc = await db.collection("users").doc(userId).get();
  if (!userDoc.exists) {
    throw new HttpsError("not-found", CAMPAIGN_SHARE_ERROR_CODES.RECIPIENT_NOT_FOUND);
  }
  const userData = userDoc.data();
  return {
    name: userData?.name || userData?.userName || "Unknown User",
    phone: userData?.phone || userData?.userPhoneNumber || "",
  };
}

/**
 * Helper function to validate campaign ownership
 * @param {string} campaignId - The campaign ID to validate
 * @param {string} vendorId - The vendor ID to check ownership
 * @return {Promise<Object>} Campaign data if owned by vendor
 */
async function validateCampaignOwnership(campaignId: string, vendorId: string) {
  const campaignDoc = await db.collection("campaigns").doc(campaignId).get();

  if (!campaignDoc.exists) {
    throw new HttpsError("not-found", CAMPAIGN_SHARE_ERROR_CODES.CAMPAIGN_NOT_FOUND);
  }

  const campaignData = campaignDoc.data();
  if (campaignData?.vendorId !== vendorId) {
    throw new HttpsError("permission-denied", CAMPAIGN_SHARE_ERROR_CODES.CAMPAIGN_NOT_OWNED);
  }

  return {
    name: campaignData?.name || "Unknown Campaign",
    data: campaignData,
  };
}

/**
 * Helper function to check if users are friends
 * @param {string} userId1 - First user ID
 * @param {string} userId2 - Second user ID
 * @return {Promise<boolean>} True if users are friends, false otherwise
 */
async function areUsersFriends(userId1: string, userId2: string): Promise<boolean> {
  try {
    const friendshipId1 = `${userId1}_${userId2}`;
    const friendshipId2 = `${userId2}_${userId1}`;

    const [friendship1, friendship2] = await Promise.all([
      db.collection("vendorFriendships").doc(friendshipId1).get(),
      db.collection("vendorFriendships").doc(friendshipId2).get(),
    ]);

    const friendship = friendship1.exists ? friendship1 : friendship2;
    return friendship.exists && friendship.data()?.status === "accepted";
  } catch {
    return false;
  }
}

/**
 * Helper function to check for existing pending request
 * @param {string} ownerVendorId - Campaign owner's vendor ID
 * @param {string} campaignId - Campaign ID
 * @param {string} recipientId - Recipient's vendor ID
 * @return {Promise<boolean>} True if pending request exists, false otherwise
 */
async function hasExistingPendingRequest(
  ownerVendorId: string,
  campaignId: string,
  recipientId: string
): Promise<boolean> {
  try {
    const querySnapshot = await db.collection("campaignShareRequest")
      .where("ownerVendorId", "==", ownerVendorId)
      .where("campaignId", "==", campaignId)
      .where("recipientId", "==", recipientId)
      .where("status", "==", "pending")
      .limit(1)
      .get();

    return !querySnapshot.empty;
  } catch {
    return false;
  }
}

/**
 * Send Campaign Share Request
 */
export const sendCampaignShareRequest = onCall<SendCampaignShareRequest>(async (request) => {
  try {
    // Validate authentication
    if (!request.auth?.uid) {
      throw new HttpsError("unauthenticated", CAMPAIGN_SHARE_ERROR_CODES.UNAUTHORIZED);
    }

    const requesterId = request.auth.uid;
    const {recipientId, campaignId} = request.data;

    // Validate input
    if (!recipientId || !campaignId) {
      throw new HttpsError("invalid-argument", "Recipient ID and Campaign ID are required");
    }

    // Validate requester is a vendor
    if (!(await validateVendor(requesterId))) {
      throw new HttpsError("permission-denied", CAMPAIGN_SHARE_ERROR_CODES.UNAUTHORIZED);
    }

    // Validate campaign ownership
    const campaign = await validateCampaignOwnership(campaignId, requesterId);

    // Validate recipient exists and is a vendor
    if (!(await validateVendor(recipientId))) {
      throw new HttpsError("permission-denied", CAMPAIGN_SHARE_ERROR_CODES.RECIPIENT_NOT_VENDOR);
    }

    // Get user profiles
    const [ownerProfile] = await Promise.all([
      getUserProfile(requesterId),
      getUserProfile(recipientId),
    ]);

    // Check if users are friends
    if (!(await areUsersFriends(requesterId, recipientId))) {
      throw new HttpsError("permission-denied", CAMPAIGN_SHARE_ERROR_CODES.NOT_FRIENDS);
    }

    // Check for existing pending request
    if (await hasExistingPendingRequest(requesterId, campaignId, recipientId)) {
      throw new HttpsError("already-exists", CAMPAIGN_SHARE_ERROR_CODES.REQUEST_ALREADY_EXISTS);
    }

    // Create campaign share request document
    const now = Timestamp.now();
    const expiresAt = Timestamp.fromMillis(now.toMillis() + (30 * 24 * 60 * 60 * 1000)); // 30 days

    const shareRequestData: Omit<CampaignShareRequest, "id"> = {
      ownerVendorId: requesterId,
      ownerVendorName: ownerProfile.name,
      ownerVendorPhone: ownerProfile.phone,
      campaignId: campaignId,
      campaignName: campaign.name,
      recipientId: recipientId,
      requestedAt: now,
      status: "pending",
      createdAt: now,
      updatedAt: now,
      expiresAt: expiresAt,
    };

    // Add document to collection and get the auto-generated ID
    const docRef = await db.collection("campaignShareRequest").add(shareRequestData);

    const response: CampaignShareApiResponse = {
      success: true,
      message: "Campaign share request sent successfully",
      data: {
        requestId: docRef.id,
        ownerVendorName: ownerProfile.name,
        campaignName: campaign.name,
        recipientId: recipientId,
        status: "pending",
        expiresAt: expiresAt.toDate().toISOString(),
        createdAt: now.toDate().toISOString(),
      },
    };

    return response;
  } catch (error) {
    console.error("Error sending campaign share request:", error);
    if (error instanceof HttpsError) {
      throw error;
    }
    throw new HttpsError("internal", "Failed to send campaign share request");
  }
});

/**
 * Respond to Campaign Share Request
 */
export const respondToCampaignShareRequest = onCall<RespondToCampaignShareRequest>(async (request) => {
  try {
    // Validate authentication
    if (!request.auth?.uid) {
      throw new HttpsError("unauthenticated", CAMPAIGN_SHARE_ERROR_CODES.UNAUTHORIZED);
    }

    const userId = request.auth.uid;
    const {requestId, action} = request.data;

    // Validate input
    if (!requestId || !action) {
      throw new HttpsError("invalid-argument", "Request ID and action are required");
    }

    if (!["accept", "decline"].includes(action)) {
      throw new HttpsError("invalid-argument", "Action must be accept or decline");
    }

    // Validate user is vendor
    if (!(await validateVendor(userId))) {
      throw new HttpsError("permission-denied", CAMPAIGN_SHARE_ERROR_CODES.UNAUTHORIZED);
    }

    // Get campaign share request document
    const requestRef = db.collection("campaignShareRequest").doc(requestId);
    const requestDoc = await requestRef.get();

    if (!requestDoc.exists) {
      throw new HttpsError("not-found", CAMPAIGN_SHARE_ERROR_CODES.REQUEST_NOT_FOUND);
    }

    const requestData = requestDoc.data() as CampaignShareRequest;

    // Validate user is the recipient
    if (requestData.recipientId !== userId) {
      throw new HttpsError("permission-denied", "Only the recipient can respond to this request");
    }

    // Validate current status
    if (requestData.status !== "pending") {
      throw new HttpsError("failed-precondition", CAMPAIGN_SHARE_ERROR_CODES.INVALID_STATUS);
    }

    // Check if request has expired
    const now = Timestamp.now();
    if (requestData.expiresAt.toMillis() <= now.toMillis()) {
      throw new HttpsError("failed-precondition", CAMPAIGN_SHARE_ERROR_CODES.REQUEST_EXPIRED);
    }

    // Get recipient profile data if accepting (needed outside transaction)
    let recipientProfile = null;
    if (action === "accept") {
      recipientProfile = await getUserProfile(requestData.recipientId);
    }

    // Update request status and campaign sharedVendors in a transaction
    await db.runTransaction(async (transaction) => {
      // READS FIRST: Get campaign document if we need to update it
      let campaignDoc = null;
      const campaignRef = db.collection("campaigns").doc(requestData.campaignId);

      if (action === "accept") {
        campaignDoc = await transaction.get(campaignRef);
      }

      // WRITES SECOND: Update request status
      const updateData = {
        status: action === "accept" ? "accepted" : "declined",
        respondedAt: now,
        updatedAt: now,
      };

      transaction.update(requestRef, updateData);

      // If accepting, add recipient object to campaign's sharedVendors array
      if (action === "accept" && campaignDoc && campaignDoc.exists && recipientProfile) {
        const campaignData = campaignDoc.data();
        const currentSharedVendors = campaignData?.sharedVendors || [];

        // Check if recipientId is not already in the array (by comparing id field)
        const isAlreadyShared = currentSharedVendors.some((vendor: any) => vendor.id === requestData.recipientId);

        if (!isAlreadyShared) {
          const vendorToAdd = {
            id: requestData.recipientId,
            name: recipientProfile.name,
            phone: recipientProfile.phone,
          };

          transaction.update(campaignRef, {
            sharedVendors: FieldValue.arrayUnion(vendorToAdd),
          });
        }
      }
    });

    const response: CampaignShareApiResponse = {
      success: true,
      message: `Campaign share request ${action}ed successfully`,
      data: {
        requestId: requestId,
        ownerVendorName: requestData.ownerVendorName,
        campaignName: requestData.campaignName,
        action: action,
        status: action === "accept" ? "accepted" : "declined",
        respondedAt: now.toDate().toISOString(),
        updatedAt: now.toDate().toISOString(),
      },
    };

    return response;
  } catch (error) {
    console.error("Error responding to campaign share request:", error);
    if (error instanceof HttpsError) {
      throw error;
    }
    throw new HttpsError("internal", "Failed to respond to campaign share request");
  }
});
