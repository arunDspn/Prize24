import {onCall, HttpsError} from "firebase-functions/v2/https";
import {getFirestore, Timestamp} from "firebase-admin/firestore";
import * as admin from "firebase-admin";
import * as logger from "firebase-functions/logger";
import {
  Club,
  CreateClubData,
  ClubApiResponse,
  CLUB_ERROR_CODES,
} from "../types";

// Initialize Firebase Admin if not already initialized
if (!admin.apps.length) {
  admin.initializeApp();
}

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
 * Helper function to validate campaign ownership
 * @param {string} campaignId - The campaign ID to validate
 * @param {string} vendorId - The vendor ID to check ownership
 * @return {Promise<any>} Campaign data if owned by vendor
 */
async function validateCampaignOwnership(campaignId: string, vendorId: string) {
  const campaignDoc = await db.collection("campaigns").doc(campaignId).get();

  if (!campaignDoc.exists) {
    throw new HttpsError("not-found", CLUB_ERROR_CODES.CAMPAIGN_NOT_FOUND);
  }

  const campaignData = campaignDoc.data();

  // Check if campaign is active
  if (campaignData?.status !== "active") {
    throw new HttpsError("failed-precondition", CLUB_ERROR_CODES.CAMPAIGN_INACTIVE);
  }

  // Validate ownership
  if (campaignData?.vendorId !== vendorId) {
    throw new HttpsError("permission-denied", CLUB_ERROR_CODES.NOT_CAMPAIGN_OWNER);
  }

  return {
    name: campaignData?.name || "Unknown Campaign",
    description: campaignData?.description || "",
    data: campaignData,
  };
}

/**
 * Helper function to get all shops owned by vendor
 * @param {string} vendorId - The vendor ID
 * @return {Promise<string[]>} Array of shop IDs
 */
async function getVendorShops(vendorId: string): Promise<string[]> {
  try {
    const shopsSnapshot = await db.collection("shops")
      .where("shopOwnerId", "==", vendorId)
      .get();

    if (shopsSnapshot.empty) {
      return [];
    }

    return shopsSnapshot.docs.map((doc) => doc.id);
  } catch (error) {
    logger.error("Error fetching vendor shops:", error);
    throw new HttpsError("internal", "Failed to fetch vendor shops");
  }
}

/**
 * Helper function to associate shops with club using batch write
 * @param {string[]} shopIds - Array of shop IDs to update
 * @param {string} clubId - The club ID to associate
 * @return {Promise<void>}
 */
async function associateShopsWithClub(shopIds: string[], clubId: string): Promise<void> {
  try {
    const batch = db.batch();

    shopIds.forEach((shopId) => {
      const shopRef = db.collection("shops").doc(shopId);
      batch.update(shopRef, {
        associatedClub: clubId,
        updatedAt: Timestamp.now(),
      });
    });

    await batch.commit();
    logger.info(`Successfully associated ${shopIds.length} shops with club ${clubId}`);
  } catch (error) {
    // Log error but don't throw - ignore individual shop update failures
    logger.error("Error associating shops with club:", error);
    logger.warn("Some shops may not have been associated with the club");
  }
}

/**
 * Create Club
 * Allows vendors to create a club attached to their campaign
 */
export const createClub = onCall<CreateClubData>(async (request): Promise<ClubApiResponse> => {
  try {
    // 1. Validate authentication
    if (!request.auth?.uid) {
      throw new HttpsError("unauthenticated", CLUB_ERROR_CODES.UNAUTHORIZED);
    }

    const vendorId = request.auth.uid;
    const {
      name,
      description,
      giftDay,
      attachedCampaignId,
      multiplierStreakDaysRequired,
      bonusIncrement,
    } = request.data;

    // 2. Validate input
    if (!name || !description || !giftDay || !attachedCampaignId) {
      throw new HttpsError(
        "invalid-argument",
        "Name, description, gift day, and campaign ID are required"
      );
    }

    // Validate gift day is between 1-31
    if (giftDay < 1 || giftDay > 31) {
      throw new HttpsError("invalid-argument", CLUB_ERROR_CODES.INVALID_GIFT_DAY);
    }

    // Validate multiplier rule if provided
    if (multiplierStreakDaysRequired !== undefined && multiplierStreakDaysRequired <= 0) {
      throw new HttpsError(
        "invalid-argument",
        "Multiplier streak days must be a positive number"
      );
    }

    if (bonusIncrement !== undefined && bonusIncrement <= 0) {
      throw new HttpsError(
        "invalid-argument",
        "Bonus increment must be a positive number"
      );
    }

    // 3. Validate user is a vendor
    const isVendor = await validateVendor(vendorId);
    if (!isVendor) {
      throw new HttpsError("permission-denied", CLUB_ERROR_CODES.NOT_A_VENDOR);
    }

    // 4. Validate campaign ownership and status
    const campaignDetails = await validateCampaignOwnership(attachedCampaignId, vendorId);

    // 5. Get all vendor's shops and validate at least one exists
    const vendorShopIds = await getVendorShops(vendorId);
    if (vendorShopIds.length === 0) {
      throw new HttpsError(
        "failed-precondition",
        CLUB_ERROR_CODES.NO_SHOPS_AVAILABLE
      );
    }

    logger.info(`Found ${vendorShopIds.length} shops for vendor ${vendorId}`);

    // 6. Create club document in transaction
    const clubData = await db.runTransaction(async (transaction) => {
      const currentTime = Timestamp.now();

      // Create club reference with auto-generated ID at top-level collection
      const clubRef = db.collection("clubs").doc();

      // Build multiplier rule if provided
      const multiplierRule =
        multiplierStreakDaysRequired && bonusIncrement ?
          {
            daysRequired: multiplierStreakDaysRequired,
            bonusIncrement: bonusIncrement,
          } :
          null;

      // Build club document (no clubId field needed)
      const club: Club = {
        vendorId: vendorId,
        name: name,
        description: description,
        giftDay: giftDay,
        campaignId: attachedCampaignId,
        campaignName: campaignDetails.name,
        campaignDescription: campaignDetails.description,
        multiplierRule: multiplierRule,
        totalMembers: 0,
        totalActiveMembers: 0,
        status: "active",
        createdAt: currentTime,
        updatedAt: currentTime,
        lastGiftDistributedAt: null,
      };

      // Create club document
      transaction.set(clubRef, club);

      // Optional: Create audit log
      const auditRef = db.collection("audit_logs").doc();
      transaction.set(auditRef, {
        action: "club_created",
        clubId: clubRef.id,
        vendorId: vendorId,
        campaignId: attachedCampaignId,
        timestamp: currentTime,
        metadata: {
          clubName: name,
          campaignName: campaignDetails.name,
          shopCount: vendorShopIds.length,
        },
      });

      return {
        clubId: clubRef.id,
        ...club,
      };
    });

    // 7. Associate all vendor's shops with this club (batch write)
    await associateShopsWithClub(vendorShopIds, clubData.clubId);

    // 8. Return success response
    return {
      success: true,
      message: "Club created successfully",
      data: {
        clubId: clubData.clubId,
        name: clubData.name,
        description: clubData.description,
        giftDay: clubData.giftDay,
        campaignId: clubData.campaignId,
        campaignName: clubData.campaignName,
        vendorId: clubData.vendorId,
        multiplierRule: clubData.multiplierRule,
        totalMembers: clubData.totalMembers,
        associatedShopsCount: vendorShopIds.length,
        status: clubData.status,
        createdAt: clubData.createdAt.toDate().toISOString(),
      },
    } as ClubApiResponse;
  } catch (error) {
    logger.error("Error creating club:", error);

    if (error instanceof HttpsError) {
      throw error;
    }

    throw new HttpsError("internal", CLUB_ERROR_CODES.INTERNAL_ERROR);
  }
});
