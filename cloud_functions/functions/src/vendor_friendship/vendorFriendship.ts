import {onCall, HttpsError} from "firebase-functions/v2/https";
import {getFirestore, Timestamp} from "firebase-admin/firestore";
import {
  Friendship,
  FriendshipRequest,
  FriendshipResponse,
  BlockUserRequest,
  FriendshipApiResponse,
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
 * @return {Promise<Object>} User profile data with name and optional profilePic
 */
async function getUserProfile(userId: string) {
  const userDoc = await db.collection("users").doc(userId).get();
  if (!userDoc.exists) {
    throw new HttpsError("not-found", "User not found");
  }
  const userData = userDoc.data();
  return {
    name: userData?.userName || "Unknown User",
    profilePic: userData?.profilePic || userData?.photoURL,
  };
}

/**
 * Helper function to create friendship document ID
 * @param {string} userId1 - First user ID
 * @param {string} userId2 - Second user ID
 * @return {string} Lexicographically sorted friendship document ID
 */
function createFriendshipId(userId1: string, userId2: string): string {
  return userId1 < userId2 ? `${userId1}_${userId2}` : `${userId2}_${userId1}`;
}

/**
 * Send Friend Request
 */
export const sendFriendRequest = onCall<FriendshipRequest>(async (request) => {
  try {
    // Validate authentication
    if (!request.auth?.uid) {
      throw new HttpsError("unauthenticated", "Authentication required");
    }

    const senderId = request.auth.uid;
    const {receiverId} = request.data;

    // Validate input
    if (!receiverId) {
      throw new HttpsError("invalid-argument", "Receiver ID is required");
    }

    // Prevent self-friendship
    if (senderId === receiverId) {
      throw new HttpsError("invalid-argument", "Cannot send friend request to yourself");
    }

    // Validate both users are vendors
    const [senderIsVendor, receiverIsVendor] = await Promise.all([
      validateVendor(senderId),
      validateVendor(receiverId),
    ]);

    if (!senderIsVendor) {
      throw new HttpsError("permission-denied", "Sender must be a vendor");
    }

    if (!receiverIsVendor) {
      throw new HttpsError("permission-denied", "Receiver must be a vendor");
    }

    // Get user profiles
    const [senderProfile, receiverProfile] = await Promise.all([
      getUserProfile(senderId),
      getUserProfile(receiverId),
    ]);

    // Create friendship document ID
    const friendshipId = createFriendshipId(senderId, receiverId);

    // Check if friendship already exists
    const existingFriendship = await db.collection("vendorFriendships").doc(friendshipId).get();
    if (existingFriendship.exists) {
      throw new HttpsError("already-exists", "Friendship request already exists");
    }

    // Create friendship document
    const friendshipData: Friendship = {
      requesterId: senderId,
      requesterName: senderProfile.name,
      requesterProfilePic: senderProfile.profilePic || null,
      receiverId: receiverId,
      receiverName: receiverProfile.name,
      receiverProfilePic: receiverProfile.profilePic || null,
      status: "pending",
      createdAt: Timestamp.now(),
      updatedAt: Timestamp.now(),
      participants: [senderId, receiverId],
    };

    await db.collection("vendorFriendships").doc(friendshipId).set(friendshipData);

    const response: FriendshipApiResponse = {
      success: true,
      message: "Friend request sent successfully",
      data: {
        friendshipId,
        status: "pending",
        createdAt: friendshipData.createdAt.toDate().toISOString(),
      },
    };

    return response;
  } catch (error) {
    console.error("Error sending friend request:", error);
    if (error instanceof HttpsError) {
      throw error;
    }
    throw new HttpsError("internal", "Failed to send friend request");
  }
});

/**
 * Respond to Friend Request (Accept/Decline)
 */
export const respondToFriendRequest = onCall<FriendshipResponse>(async (request) => {
  try {
    // Validate authentication
    if (!request.auth?.uid) {
      throw new HttpsError("unauthenticated", "Authentication required");
    }

    const userId = request.auth.uid;
    const {friendshipId, action} = request.data;

    // Validate input
    if (!friendshipId || !action) {
      throw new HttpsError("invalid-argument", "Friendship ID and action are required");
    }

    if (!["accept", "decline"].includes(action)) {
      throw new HttpsError("invalid-argument", "Action must be accept or decline");
    }

    // Validate user is vendor
    if (!(await validateVendor(userId))) {
      throw new HttpsError("permission-denied", "User must be a vendor");
    }

    // Get friendship document
    const friendshipRef = db.collection("vendorFriendships").doc(friendshipId);
    const friendshipDoc = await friendshipRef.get();

    if (!friendshipDoc.exists) {
      throw new HttpsError("not-found", "Friendship request not found");
    }

    const friendshipData = friendshipDoc.data() as Friendship;

    // Validate user is the receiver
    if (friendshipData.receiverId !== userId) {
      throw new HttpsError("permission-denied", "Only the receiver can respond to this request");
    }

    // Validate current status
    if (friendshipData.status !== "pending") {
      throw new HttpsError("failed-precondition", "Request has already been responded to");
    }

    // Update friendship status
    const updateData: Partial<Friendship> = {
      status: action === "accept" ? "accepted" : "declined",
      updatedAt: Timestamp.now(),
    };

    if (action === "accept") {
      updateData.acceptedAt = Timestamp.now();
    }

    await friendshipRef.update(updateData);

    const response: FriendshipApiResponse = {
      success: true,
      message: `Friend request ${action}ed successfully`,
      data: {
        friendshipId,
        status: updateData.status,
        updatedAt: updateData.updatedAt!.toDate().toISOString(),
        ...(updateData.acceptedAt && {acceptedAt: updateData.acceptedAt.toDate().toISOString()}),
      },
    };

    return response;
  } catch (error) {
    console.error("Error responding to friend request:", error);
    if (error instanceof HttpsError) {
      throw error;
    }
    throw new HttpsError("internal", "Failed to respond to friend request");
  }
});


/**
 * Block User
 */
export const blockUser = onCall<BlockUserRequest>(async (request) => {
  try {
    // Validate authentication
    if (!request.auth?.uid) {
      throw new HttpsError("unauthenticated", "Authentication required");
    }

    const blockerId = request.auth.uid;
    const {userId: blockedUserId} = request.data;

    // Validate input
    if (!blockedUserId) {
      throw new HttpsError("invalid-argument", "User ID to block is required");
    }

    // Prevent self-blocking
    if (blockerId === blockedUserId) {
      throw new HttpsError("invalid-argument", "Cannot block yourself");
    }

    // Validate both users are vendors
    const [blockerIsVendor, blockedIsVendor] = await Promise.all([
      validateVendor(blockerId),
      validateVendor(blockedUserId),
    ]);

    if (!blockerIsVendor) {
      throw new HttpsError("permission-denied", "Blocker must be a vendor");
    }

    if (!blockedIsVendor) {
      throw new HttpsError("permission-denied", "Blocked user must be a vendor");
    }

    // Get user profiles
    const [blockerProfile, blockedProfile] = await Promise.all([
      getUserProfile(blockerId),
      getUserProfile(blockedUserId),
    ]);

    // Create friendship document ID
    const friendshipId = createFriendshipId(blockerId, blockedUserId);

    // Check if friendship exists
    const friendshipRef = db.collection("vendorFriendships").doc(friendshipId);
    const friendshipDoc = await friendshipRef.get();

    const friendshipData: Friendship = {
      requesterId: blockerId,
      requesterName: blockerProfile.name,
      requesterProfilePic: blockerProfile.profilePic || null,
      receiverId: blockedUserId,
      receiverName: blockedProfile.name,
      receiverProfilePic: blockedProfile.profilePic || null,
      status: "blocked",
      createdAt: friendshipDoc.exists ? (friendshipDoc.data() as Friendship).createdAt : Timestamp.now(),
      updatedAt: Timestamp.now(),
      participants: [blockerId, blockedUserId],
    };

    // Create or update friendship document with blocked status
    await friendshipRef.set(friendshipData);

    const response: FriendshipApiResponse = {
      success: true,
      message: "User blocked successfully",
      data: {
        friendshipId,
        status: "blocked",
        updatedAt: friendshipData.updatedAt.toDate().toISOString(),
      },
    };

    return response;
  } catch (error) {
    console.error("Error blocking user:", error);
    if (error instanceof HttpsError) {
      throw error;
    }
    throw new HttpsError("internal", "Failed to block user");
  }
});
