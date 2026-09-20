import {onCall, HttpsError} from "firebase-functions/v2/https";
import {FieldValue, getFirestore, Timestamp} from "firebase-admin/firestore";
import {getMessaging} from "firebase-admin/messaging";
import * as logger from "firebase-functions/logger";
import {createActivityLog} from "../activityLog";

const db = getFirestore();
const messaging = getMessaging();

type RewardSource = "campaign" | "gift_library";

interface ShopAccess {
  isOwner: boolean;
  isStaff: boolean;
  shop: FirebaseFirestore.DocumentData;
}

interface ResolveShopRewardRequest {
  shopId: string;
  userId: string;
  opportunityId: string;
  source: RewardSource;
  giftId?: string;
}

interface ManualGiftRequest {
  shopId: string;
  userId: string;
  giftId: string;
  requestId: string;
}

interface ShopGiftRequest {
  shopId: string;
  userGiftId: string;
}

/**
 * Validates a required callable string field.
 * @param {unknown} value Raw field value
 * @param {string} field Field name for errors
 * @return {string} Trimmed field value
 */
function requiredString(value: unknown, field: string): string {
  if (typeof value !== "string" || value.trim().length === 0) {
    throw new HttpsError("invalid-argument", `${field} is required`);
  }
  return value.trim();
}

/**
 * Resolves and validates owner or staff access for a shop.
 * @param {string} authUserId Authenticated user ID
 * @param {string} shopId Shop ID
 * @return {Promise<ShopAccess>} Resolved access and shop data
 */
async function validateShopAccess(authUserId: string, shopId: string): Promise<ShopAccess> {
  const shopRef = db.collection("shops").doc(shopId);
  const [shopDoc, staffDoc] = await Promise.all([
    shopRef.get(),
    shopRef.collection("staffs").doc(authUserId).get(),
  ]);
  if (!shopDoc.exists) {
    throw new HttpsError("not-found", "Shop not found");
  }
  const shop = shopDoc.data() ?? {};
  const isOwner = shop.shopOwnerId === authUserId;
  const isStaff = staffDoc.exists;
  if (!isOwner && !isStaff) {
    throw new HttpsError("permission-denied", "You are not authorized for this shop");
  }
  return {isOwner, isStaff, shop};
}

/**
 * Converts resolved access into the audit actor role.
 * @param {ShopAccess} access Resolved shop access
 * @return {"owner" | "staff"} Audit actor role
 */
function roleFor(access: ShopAccess): "owner" | "staff" {
  return access.isOwner ? "owner" : "staff";
}

/**
 * Creates the supported-shop snapshot stored with a wallet gift.
 * @param {string} shopId Shop ID
 * @param {FirebaseFirestore.DocumentData} shop Shop document data
 * @return {object} Supported shop snapshot
 */
function shopSnapshot(shopId: string, shop: FirebaseFirestore.DocumentData) {
  return {
    id: shopId,
    name: shop.shopName ?? "Shop",
    shopAddress: shop.shopAddress ?? "",
    shopPhone: shop.shopPhone ?? "",
    shopEmail: shop.shopEmail ?? null,
  };
}

/**
 * Selects the stable milestone fields copied into reward audit events.
 * @param {FirebaseFirestore.DocumentData} opportunity Opportunity snapshot
 * @return {object} Common reward audit fields
 */
function rewardAuditFields(opportunity: FirebaseFirestore.DocumentData) {
  return {
    crossedMilestone: opportunity.milestone ?? null,
    cumulativeBillSum: opportunity.cumulativeBillSum ?? null,
    milestoneCycleBillSum: opportunity.milestoneCycleBillSum ?? null,
    campaignId: opportunity.campaignId ?? null,
    giftLibraryId: opportunity.giftLibraryId ?? null,
    availableSources: opportunity.availableSources ?? [],
  };
}

/**
 * Sends a best-effort data notification to a customer.
 * @param {string} userId Customer ID
 * @param {Record<string, string>} data Notification data
 * @return {Promise<void>} Completion promise
 */
async function notifyUser(userId: string, data: Record<string, string>): Promise<void> {
  try {
    const userDoc = await db.collection("users").doc(userId).get();
    const token = userDoc.data()?.fcmToken;
    if (typeof token === "string" && token.trim().length > 0) {
      await messaging.send({token, data});
    }
  } catch (error) {
    logger.error("Gift Library notification failed", {
      userId,
      error: error instanceof Error ? error.message : String(error),
    });
  }
}

/**
 * Locks an opportunity to its first selected reward source.
 * @param {string} shopId Shop ID
 * @param {string} opportunityId Reward opportunity ID
 * @param {string} userId Customer ID
 * @param {RewardSource} source Selected reward source
 * @return {Promise<object>} Existing result and source-selection state
 */
async function lockRewardSource(
  shopId: string,
  opportunityId: string,
  userId: string,
  source: RewardSource
): Promise<{
  completedResult: FirebaseFirestore.DocumentData | null;
  didSelect: boolean;
  opportunity: FirebaseFirestore.DocumentData;
}> {
  const opportunityRef = db.collection("shops").doc(shopId)
    .collection("rewardOpportunities").doc(opportunityId);
  return db.runTransaction(async (transaction) => {
    const opportunityDoc = await transaction.get(opportunityRef);
    if (!opportunityDoc.exists) {
      throw new HttpsError("not-found", "Reward opportunity not found");
    }
    const opportunity = opportunityDoc.data() ?? {};
    if (opportunity.userId !== userId) {
      throw new HttpsError("failed-precondition", "Reward opportunity customer does not match");
    }
    if (opportunity.status === "completed") {
      return {
        completedResult: opportunity.result ?? {outcome: opportunity.outcome},
        didSelect: false,
        opportunity,
      };
    }
    const sources = Array.isArray(opportunity.availableSources) ? opportunity.availableSources : [];
    if (!sources.includes(source)) {
      throw new HttpsError("failed-precondition", "Reward source is not available for this milestone");
    }
    if (opportunity.selectedSource && opportunity.selectedSource !== source) {
      throw new HttpsError("failed-precondition", "A different reward source was already selected");
    }
    const didSelect = opportunity.selectedSource == null;
    if (didSelect) {
      transaction.update(opportunityRef, {selectedSource: source, updatedAt: Timestamp.now()});
    }
    return {completedResult: null, didSelect, opportunity};
  });
}

export const getAttachedGiftLibrary = onCall<{
  shopId: string;
  opportunityId?: string;
  followerUserId?: string;
}>(async (request) => {
  if (!request.auth) throw new HttpsError("unauthenticated", "Authentication required");
  const shopId = requiredString(request.data.shopId, "shopId");
  const access = await validateShopAccess(request.auth.uid, shopId);
  if (typeof request.data.followerUserId === "string" && request.data.followerUserId.length > 0) {
    const followerDoc = await db.collection("shops").doc(shopId)
      .collection("followers").doc(request.data.followerUserId).get();
    if (!followerDoc.exists) {
      await createActivityLog(`shops/${shopId}/activityLogs`, {
        action: "manual_library_gift_assignment_failed",
        success: false,
        actorId: request.auth.uid,
        actorRole: roleFor(access),
        functionName: "getAttachedGiftLibrary",
        customerId: request.data.followerUserId,
        shopId,
        giftLibraryId: access.shop.associatedGiftLibraryId ?? null,
        assignmentMode: "manual",
        errorCode: "failed-precondition",
        errorMessage: "Customer is not a shop follower",
      });
      throw new HttpsError("failed-precondition", "Customer is not a shop follower");
    }
  }
  let libraryId = access.shop.associatedGiftLibraryId;
  if (typeof request.data.opportunityId === "string" && request.data.opportunityId.length > 0) {
    const opportunityDoc = await db.collection("shops").doc(shopId)
      .collection("rewardOpportunities").doc(request.data.opportunityId).get();
    if (!opportunityDoc.exists) {
      throw new HttpsError("not-found", "Reward opportunity not found");
    }
    libraryId = opportunityDoc.data()?.giftLibraryId;
  }
  if (typeof libraryId !== "string" || libraryId.length === 0) {
    return {library: null, gifts: []};
  }
  const libraryRef = db.collection("giftLibraries").doc(libraryId);
  const [libraryDoc, giftsSnapshot] = await Promise.all([
    libraryRef.get(),
    libraryRef.collection("gifts").where("status", "==", "active").get(),
  ]);
  const library = libraryDoc.data();
  if (!libraryDoc.exists || library?.status !== "active" ||
    library.ownerVendorId !== access.shop.shopOwnerId) {
    return {library: null, gifts: []};
  }
  return {
    library: {id: libraryDoc.id, ...libraryDoc.data()},
    gifts: giftsSnapshot.docs.map((doc) => ({id: doc.id, ...doc.data()})),
  };
});

export const resolveShopReward = onCall<ResolveShopRewardRequest>(async (request) => {
  if (!request.auth) throw new HttpsError("unauthenticated", "Authentication required");
  const shopId = requiredString(request.data.shopId, "shopId");
  const userId = requiredString(request.data.userId, "userId");
  const opportunityId = requiredString(request.data.opportunityId, "opportunityId");
  const source = request.data.source;
  if (source !== "campaign" && source !== "gift_library") {
    throw new HttpsError("invalid-argument", "Invalid reward source");
  }
  const access = await validateShopAccess(request.auth.uid, shopId);
  const actorRole = roleFor(access);
  const sourceLock = await lockRewardSource(shopId, opportunityId, userId, source);
  if (sourceLock.completedResult) return {success: true, ...sourceLock.completedResult};

  if (sourceLock.didSelect) {
    await createActivityLog(`shops/${shopId}/activityLogs`, {
      action: "reward_source_selected",
      success: true,
      actorId: request.auth.uid,
      actorRole,
      functionName: "resolveShopReward",
      customerId: userId,
      shopId,
      rewardOpportunityId: opportunityId,
      selectedSource: source,
      ...rewardAuditFields(sourceLock.opportunity),
    });
  }

  if (source === "gift_library") {
    const giftId = requiredString(request.data.giftId, "giftId");
    const opportunityRef = db.collection("shops").doc(shopId)
      .collection("rewardOpportunities").doc(opportunityId);
    const userGiftRef = db.collection("user_gifts").doc();
    let result: FirebaseFirestore.DocumentData;
    try {
      result = await db.runTransaction(async (transaction) => {
        const opportunityDoc = await transaction.get(opportunityRef);
        const opportunity = opportunityDoc.data() ?? {};
        if (opportunity.status === "completed") return opportunity.result;
        const libraryId = requiredString(opportunity.giftLibraryId, "giftLibraryId");
        const libraryRef = db.collection("giftLibraries").doc(libraryId);
        const giftRef = libraryRef.collection("gifts").doc(giftId);
        const userRef = db.collection("users").doc(userId);
        const [libraryDoc, giftDoc, userDoc] = await transaction.getAll(libraryRef, giftRef, userRef);
        if (!libraryDoc.exists || libraryDoc.data()?.status !== "active" ||
          libraryDoc.data()?.ownerVendorId !== access.shop.shopOwnerId) {
          throw new HttpsError("failed-precondition", "Gift Library is unavailable");
        }
        if (!giftDoc.exists || giftDoc.data()?.status !== "active") {
          throw new HttpsError("failed-precondition", "Gift is unavailable");
        }
        if (!userDoc.exists) throw new HttpsError("not-found", "Customer not found");
        const gift = giftDoc.data() ?? {};
        const now = Timestamp.now();
        transaction.set(userGiftRef, {
          userId,
          giftId,
          giftName: gift.name,
          giftDescription: gift.description,
          isRedeemable: true,
          isRedeemed: false,
          redeemedAt: null,
          availedAt: now,
          supportedShops: [shopSnapshot(shopId, access.shop)],
          sourceType: "gift_library",
          giftLibraryId: libraryId,
          shopId,
          assignedBy: request.auth!.uid,
          assignmentMode: "milestone",
          rewardOpportunityId: opportunityId,
          redemptionId: userGiftRef.id,
          availedViaStreak: true,
          streakShopID: shopId,
          availedViaClub: false,
        });
        const storedResult = {
          outcome: "awarded",
          source,
          userGiftId: userGiftRef.id,
          giftId,
          giftName: gift.name,
          giftDescription: gift.description,
        };
        transaction.update(opportunityRef, {
          status: "completed",
          outcome: "awarded",
          userGiftId: userGiftRef.id,
          giftId,
          completedAt: now,
          updatedAt: now,
          result: storedResult,
        });
        return storedResult;
      });
    } catch (error) {
      await createActivityLog(`shops/${shopId}/activityLogs`, {
        action: "library_gift_assignment_failed",
        success: false,
        actorId: request.auth.uid,
        actorRole,
        functionName: "resolveShopReward",
        customerId: userId,
        shopId,
        rewardOpportunityId: opportunityId,
        giftId,
        assignmentMode: "milestone",
        selectedSource: source,
        ...rewardAuditFields(sourceLock.opportunity),
        errorCode: error instanceof HttpsError ? error.code : "internal",
        errorMessage: error instanceof Error ? error.message : String(error),
      });
      if (error instanceof HttpsError) throw error;
      throw new HttpsError("internal", "Failed to assign gift");
    }
    await createActivityLog(`shops/${shopId}/activityLogs`, {
      action: "library_gift_assignment_success",
      success: true,
      actorId: request.auth.uid,
      actorRole,
      functionName: "resolveShopReward",
      customerId: userId,
      shopId,
      rewardOpportunityId: opportunityId,
      assignmentMode: "milestone",
      selectedSource: source,
      ...rewardAuditFields(sourceLock.opportunity),
      ...result,
    });
    await notifyUser(userId, {
      type: "gift_library_assignment",
      shopId,
      userGiftId: String(result.userGiftId),
      giftName: String(result.giftName),
    });
    return {success: true, ...result};
  }

  const opportunityRef = db.collection("shops").doc(shopId)
    .collection("rewardOpportunities").doc(opportunityId);
  const userGiftRef = db.collection("user_gifts").doc();
  const result = await db.runTransaction(async (transaction) => {
    const opportunityDoc = await transaction.get(opportunityRef);
    const opportunity = opportunityDoc.data() ?? {};
    if (opportunity.status === "completed") return opportunity.result;
    const campaignId = requiredString(opportunity.campaignId, "campaignId");
    const campaignRef = db.collection("campaigns").doc(campaignId);
    const campaignDoc = await transaction.get(campaignRef);
    if (!campaignDoc.exists) {
      const unavailable = {outcome: "unavailable", source, campaignId};
      transaction.update(opportunityRef, {
        status: "completed", outcome: "unavailable", result: unavailable,
        completedAt: Timestamp.now(), updatedAt: Timestamp.now(),
      });
      return unavailable;
    }
    const campaign = campaignDoc.data() ?? {};
    const expired = campaign.endDate?.toDate?.() < new Date();
    if (campaign.status !== "active" || expired || Number(campaign.remainingParticipants) <= 0 ||
      Number(campaign.remainingGifts) <= 0) {
      const unavailable = {outcome: "unavailable", source, campaignId};
      transaction.update(opportunityRef, {
        status: "completed", outcome: "unavailable", result: unavailable,
        completedAt: Timestamp.now(), updatedAt: Timestamp.now(),
      });
      return unavailable;
    }
    const giftsSnapshot = await transaction.get(
      campaignRef.collection("gifts").where("remainingQuantity", ">", 0)
    );
    const gifts = giftsSnapshot.docs.filter((doc) => Number(doc.data().remainingQuantity) > 0);
    if (gifts.length === 0) {
      const unavailable = {outcome: "unavailable", source, campaignId};
      transaction.update(opportunityRef, {
        status: "completed", outcome: "unavailable", result: unavailable,
        completedAt: Timestamp.now(), updatedAt: Timestamp.now(),
      });
      return unavailable;
    }
    const luckFactor = Math.min(Number(campaign.remainingGifts) / Number(campaign.remainingParticipants), 1);
    const randomNumber = Math.random();
    if (randomNumber > luckFactor) {
      const noPrize = {outcome: "no_prize", source, campaignId, luckFactor, randomNumber};
      transaction.update(campaignRef, {remainingParticipants: FieldValue.increment(-1)});
      transaction.update(opportunityRef, {
        status: "completed", outcome: "no_prize", result: noPrize,
        completedAt: Timestamp.now(), updatedAt: Timestamp.now(),
      });
      return noPrize;
    }
    const giftDoc = gifts[Math.floor(Math.random() * gifts.length)];
    const gift = giftDoc.data();
    let payload: string | null = null;
    let payloadDoc: FirebaseFirestore.QueryDocumentSnapshot | null = null;
    if (gift.isRedeemable === false) {
      const payloadSnapshot = await transaction.get(
        giftDoc.ref.collection("autoGiftPayloads").where("redeemedByUserId", "==", null)
      );
      payloadDoc = payloadSnapshot.docs.find((doc) => typeof doc.data().content === "string") ?? null;
      if (!payloadDoc) {
        const unavailable = {outcome: "unavailable", source, campaignId};
        transaction.update(opportunityRef, {
          status: "completed", outcome: "unavailable", result: unavailable,
          completedAt: Timestamp.now(), updatedAt: Timestamp.now(),
        });
        return unavailable;
      }
      payload = payloadDoc.data().content;
    }
    const now = Timestamp.now();
    transaction.update(giftDoc.ref, {remainingQuantity: FieldValue.increment(-1)});
    transaction.update(campaignRef, {
      remainingParticipants: FieldValue.increment(-1),
      remainingGifts: FieldValue.increment(-1),
      totalGiftsAdded: FieldValue.increment(-1),
      totalAvailed: FieldValue.increment(1),
    });
    if (payloadDoc) transaction.update(payloadDoc.ref, {redeemedByUserId: userId, redeemedAt: now});
    transaction.set(userGiftRef, {
      userId,
      giftId: giftDoc.id,
      campaignId,
      campaignName: campaign.name,
      giftName: gift.name,
      giftDescription: gift.description,
      isRedeemable: gift.isRedeemable,
      isRedeemed: gift.isRedeemable ? false : null,
      redeemedAt: gift.isRedeemable ? null : now,
      availedAt: now,
      payload,
      supportedShops: gift.isRedeemable ? gift.supportedShops ?? null : null,
      sourceType: "campaign",
      redemptionId: userGiftRef.id,
      availedViaStreak: true,
      streakShopID: shopId,
      availedViaClub: false,
    });
    const awarded = {
      outcome: "awarded", source, campaignId, userGiftId: userGiftRef.id,
      giftId: giftDoc.id, giftName: gift.name, giftDescription: gift.description,
      isRedeemable: gift.isRedeemable, payload, luckFactor, randomNumber,
    };
    transaction.update(opportunityRef, {
      status: "completed", outcome: "awarded", userGiftId: userGiftRef.id,
      giftId: giftDoc.id, result: awarded, completedAt: now, updatedAt: now,
    });
    return awarded;
  });
  await createActivityLog(`shops/${shopId}/activityLogs`, {
    action: "campaign_reward_completed",
    // A no-prize or unavailable result is still a successfully resolved
    // opportunity. The outcome field carries the business result, while
    // technical failures leave the opportunity pending and are not logged as
    // completed.
    success: true,
    actorId: request.auth.uid,
    actorRole,
    functionName: "resolveShopReward",
    customerId: userId,
    shopId,
    rewardOpportunityId: opportunityId,
    selectedSource: source,
    ...rewardAuditFields(sourceLock.opportunity),
    ...result,
  });
  if (result.campaignId) {
    await createActivityLog(`campaigns/${result.campaignId}/activityLogs`, {
      action: result.outcome === "awarded" ? "gift_avail_success" : "gift_avail_failed",
      success: result.outcome === "awarded",
      actorId: request.auth.uid,
      actorRole,
      functionName: "resolveShopReward",
      customerId: userId,
      shopId,
      rewardOpportunityId: opportunityId,
      availedViaStreak: true,
      ...result,
    });
  }
  if (result.outcome === "awarded") {
    await notifyUser(userId, {
      type: "offer_avail_success",
      shopId,
      campaignId: String(result.campaignId),
      userGiftId: String(result.userGiftId),
      giftName: String(result.giftName),
    });
  }
  return {success: true, ...result};
});

export const assignManualLibraryGift = onCall<ManualGiftRequest>(async (request) => {
  if (!request.auth) throw new HttpsError("unauthenticated", "Authentication required");
  const shopId = requiredString(request.data.shopId, "shopId");
  const userId = requiredString(request.data.userId, "userId");
  const giftId = requiredString(request.data.giftId, "giftId");
  const requestId = requiredString(request.data.requestId, "requestId");
  if (requestId.includes("/")) throw new HttpsError("invalid-argument", "Invalid requestId");
  const access = await validateShopAccess(request.auth.uid, shopId);
  const actorRole = roleFor(access);
  const libraryId = requiredString(access.shop.associatedGiftLibraryId, "associatedGiftLibraryId");
  const assignmentRef = db.collection("shops").doc(shopId)
    .collection("manualGiftAssignments").doc(requestId);
  const userGiftRef = db.collection("user_gifts").doc();
  try {
    const result = await db.runTransaction(async (transaction) => {
      const followerRef = db.collection("shops").doc(shopId).collection("followers").doc(userId);
      const libraryRef = db.collection("giftLibraries").doc(libraryId);
      const giftRef = libraryRef.collection("gifts").doc(giftId);
      const userRef = db.collection("users").doc(userId);
      const [assignmentDoc, followerDoc, libraryDoc, giftDoc, userDoc] = await transaction.getAll(
        assignmentRef, followerRef, libraryRef, giftRef, userRef
      );
      if (assignmentDoc.exists) {
        const assignment = assignmentDoc.data() ?? {};
        if (assignment.userId !== userId || assignment.giftId !== giftId ||
          assignment.assignedBy !== request.auth!.uid) {
          throw new HttpsError("already-exists", "requestId was already used for another assignment");
        }
        return assignment.result;
      }
      if (!followerDoc.exists) throw new HttpsError("failed-precondition", "Customer is not a shop follower");
      if (!libraryDoc.exists || libraryDoc.data()?.status !== "active" ||
        libraryDoc.data()?.ownerVendorId !== access.shop.shopOwnerId) {
        throw new HttpsError("failed-precondition", "Gift Library is unavailable");
      }
      if (!giftDoc.exists || giftDoc.data()?.status !== "active") {
        throw new HttpsError("failed-precondition", "Gift is unavailable");
      }
      if (!userDoc.exists) throw new HttpsError("not-found", "Customer not found");
      const gift = giftDoc.data() ?? {};
      const now = Timestamp.now();
      const storedResult = {outcome: "awarded", userGiftId: userGiftRef.id, giftId, giftName: gift.name};
      transaction.set(userGiftRef, {
        userId, giftId, giftName: gift.name, giftDescription: gift.description,
        isRedeemable: true, isRedeemed: false, redeemedAt: null, availedAt: now,
        supportedShops: [shopSnapshot(shopId, access.shop)], sourceType: "gift_library",
        giftLibraryId: libraryId, shopId, assignedBy: request.auth!.uid,
        assignmentMode: "manual", requestId, redemptionId: userGiftRef.id,
        availedViaStreak: false, streakShopID: shopId, availedViaClub: false,
      });
      transaction.set(assignmentRef, {
        requestId, userId, shopId, giftLibraryId: libraryId, giftId,
        assignedBy: request.auth!.uid, createdAt: now, result: storedResult,
      });
      return storedResult;
    });
    await createActivityLog(`shops/${shopId}/activityLogs`, {
      action: "manual_library_gift_assignment_success", success: true,
      actorId: request.auth.uid, actorRole, functionName: "assignManualLibraryGift",
      customerId: userId, shopId, giftLibraryId: libraryId, requestId,
      assignmentMode: "manual", ...result,
    });
    await notifyUser(userId, {
      type: "gift_library_assignment", shopId,
      userGiftId: String(result.userGiftId), giftName: String(result.giftName),
    });
    return {success: true, ...result};
  } catch (error) {
    await createActivityLog(`shops/${shopId}/activityLogs`, {
      action: "manual_library_gift_assignment_failed", success: false,
      actorId: request.auth.uid, actorRole, functionName: "assignManualLibraryGift",
      customerId: userId, shopId, giftLibraryId: libraryId, giftId, requestId,
      errorCode: error instanceof HttpsError ? error.code : "internal",
      errorMessage: error instanceof Error ? error.message : String(error),
    });
    if (error instanceof HttpsError) throw error;
    throw new HttpsError("internal", "Failed to assign gift");
  }
});

export const redeemShopGift = onCall<ShopGiftRequest>(async (request) => {
  if (!request.auth) throw new HttpsError("unauthenticated", "Authentication required");
  const shopId = requiredString(request.data.shopId, "shopId");
  const userGiftId = requiredString(request.data.userGiftId, "userGiftId");
  const access = await validateShopAccess(request.auth.uid, shopId);
  const actorRole = roleFor(access);
  const giftRef = db.collection("user_gifts").doc(userGiftId);
  try {
    const result = await db.runTransaction(async (transaction) => {
      const giftDoc = await transaction.get(giftRef);
      if (!giftDoc.exists) throw new HttpsError("not-found", "Gift not found");
      const gift = giftDoc.data() ?? {};
      if (gift.sourceType !== "gift_library" || gift.shopId !== shopId) {
        throw new HttpsError("permission-denied", "Gift cannot be redeemed at this shop");
      }
      if (gift.isRedeemed === true) throw new HttpsError("already-exists", "Gift has already been redeemed");
      const now = Timestamp.now();
      transaction.update(giftRef, {isRedeemed: true, redeemedAt: now, redeemedBy: request.auth!.uid});
      return {
        userId: gift.userId as string,
        giftId: gift.giftId as string,
        giftName: gift.giftName as string,
        giftLibraryId: gift.giftLibraryId as string,
        assignmentMode: gift.assignmentMode as string,
      };
    });
    await createActivityLog(`shops/${shopId}/activityLogs`, {
      action: "library_gift_redemption_success", success: true,
      actorId: request.auth.uid, actorRole, functionName: "redeemShopGift",
      customerId: result.userId, shopId, userGiftId, giftId: result.giftId,
      giftName: result.giftName, giftLibraryId: result.giftLibraryId,
      assignmentMode: result.assignmentMode,
    });
    await notifyUser(result.userId, {type: "gift_redeem_success", shopId, userGiftId});
    return {success: true};
  } catch (error) {
    await createActivityLog(`shops/${shopId}/activityLogs`, {
      action: "library_gift_redemption_failed", success: false,
      actorId: request.auth.uid, actorRole, functionName: "redeemShopGift",
      shopId, userGiftId, errorCode: error instanceof HttpsError ? error.code : "internal",
      errorMessage: error instanceof Error ? error.message : String(error),
    });
    if (error instanceof HttpsError) throw error;
    throw new HttpsError("internal", "Failed to redeem gift");
  }
});

export const archiveGiftLibrary = onCall<{giftLibraryId: string}>(async (request) => {
  if (!request.auth) throw new HttpsError("unauthenticated", "Authentication required");
  const giftLibraryId = requiredString(request.data.giftLibraryId, "giftLibraryId");
  const libraryRef = db.collection("giftLibraries").doc(giftLibraryId);
  const libraryDoc = await libraryRef.get();
  if (!libraryDoc.exists) throw new HttpsError("not-found", "Gift Library not found");
  if (libraryDoc.data()?.ownerVendorId !== request.auth.uid) {
    throw new HttpsError("permission-denied", "Only the library owner can archive it");
  }
  const [shops, pending] = await Promise.all([
    db.collection("shops").where("associatedGiftLibraryId", "==", giftLibraryId).limit(1).get(),
    db.collectionGroup("rewardOpportunities")
      .where("giftLibraryId", "==", giftLibraryId).where("status", "==", "pending").limit(1).get(),
  ]);
  if (!shops.empty || !pending.empty) {
    throw new HttpsError("failed-precondition", "Detach this library and resolve pending rewards first");
  }
  await libraryRef.update({status: "archived", updatedAt: Timestamp.now()});
  return {success: true};
});

export const getGiftLibraryUsage = onCall<{giftLibraryId: string}>(async (request) => {
  if (!request.auth) throw new HttpsError("unauthenticated", "Authentication required");
  const giftLibraryId = requiredString(request.data.giftLibraryId, "giftLibraryId");
  const libraryDoc = await db.collection("giftLibraries").doc(giftLibraryId).get();
  if (!libraryDoc.exists) throw new HttpsError("not-found", "Gift Library not found");
  if (libraryDoc.data()?.ownerVendorId !== request.auth.uid) {
    throw new HttpsError("permission-denied", "Only the library owner can view usage");
  }
  const [shops, pending] = await Promise.all([
    db.collection("shops").where("associatedGiftLibraryId", "==", giftLibraryId).get(),
    db.collectionGroup("rewardOpportunities")
      .where("giftLibraryId", "==", giftLibraryId).where("status", "==", "pending").get(),
  ]);
  return {
    attachedShopCount: shops.size,
    pendingRewardCount: pending.size,
    canArchive: shops.empty && pending.empty,
  };
});
