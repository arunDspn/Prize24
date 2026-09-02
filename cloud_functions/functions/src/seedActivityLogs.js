/**
 * Seed Script — Activity Logs
 *
 * Generates 20-30 random activity log records across:
 *   campaigns/dZJ7TMG3twP7kGkh7xc4/activityLogs
 *   shops/BtVgAuMyLGzwxmhbUNPU/activityLogs
 *
 * Usage:
 *   node src/seedActivityLogs.js
 */

const admin = require("firebase-admin");
const path = require("path");

const serviceAccountPath = path.join(__dirname, "../serviceAccountKey.json");

try {
    const serviceAccount = require(serviceAccountPath);
    admin.initializeApp({
        credential: admin.credential.cert(serviceAccount),
    });
    console.log("✅ Firebase Admin initialized");
} catch (error) {
    console.error("❌ Error loading service account key:", error.message);
    process.exit(1);
}

const db = admin.firestore();
const FieldValue = admin.firestore.FieldValue;

// ---------------------------------------------------------------------------
// Target IDs
// ---------------------------------------------------------------------------
const CAMPAIGN_ID = "dZJ7TMG3twP7kGkh7xc4";
const SHOP_ID = "BtVgAuMyLGzwxmhbUNPU";

// ---------------------------------------------------------------------------
// Helpers
// ---------------------------------------------------------------------------
const pick = (arr) => arr[Math.floor(Math.random() * arr.length)];
const rand = (min, max) => Math.floor(Math.random() * (max - min + 1)) + min;
const randDouble = () => parseFloat(Math.random().toFixed(4));
const randId = () => `seed_${Date.now()}_${Math.random().toString(36).substr(2, 8)}`;

const ACTOR_ROLES = ["owner", "staff", "shared_vendor", "customer"];
const CUSTOMER_IDS = [
    "cust_aaa111", "cust_bbb222", "cust_ccc333",
    "cust_ddd444", "cust_eee555", "cust_fff666",
];
const ACTOR_IDS = [
    "owner_abc123", "staff_xyz789", "vendor_pqr456",
];
const GIFT_IDS = ["gift_001", "gift_002", "gift_003"];
const GIFT_NAMES = ["Free Coffee", "10% Discount Voucher", "Free Dessert", "Buy 1 Get 1"];
const FAILURE_REASONS = ["not_lucky", "campaign_expired", "gifts_exhausted", "not-found"];

// ---------------------------------------------------------------------------
// Campaign log builders
// ---------------------------------------------------------------------------

function makeGiftAvailSuccess() {
    const luckFactor = randDouble();
    const randomNumber = parseFloat((Math.random() * luckFactor).toFixed(4));
    const giftId = pick(GIFT_IDS);
    const giftName = pick(GIFT_NAMES);
    const isViaStreak = Math.random() > 0.5;
    return {
        action: "gift_avail_success",
        success: true,
        actorId: pick(CUSTOMER_IDS),
        actorRole: "customer",
        functionName: pick([
            "scanAvailPublicPrivateAutoCampaign",
            "scanToAvailPublicPrivateAutoCampaignBySharedVendor",
            "scanToAvailPublicPrivateAutoCampaignByStaff",
        ]),
        customerId: pick(CUSTOMER_IDS),
        giftId,
        giftName,
        redemptionId: randId(),
        isRedeemable: Math.random() > 0.4,
        payloadId: Math.random() > 0.5 ? randId() : null,
        luckFactor,
        randomNumber,
        remainingGifts: rand(1, 50),
        remainingParticipants: rand(10, 200),
        availedViaStreak: isViaStreak,
        streakShopId: isViaStreak ? SHOP_ID : null,
        timestamp: FieldValue.serverTimestamp(),
    };
}

function makeGiftAvailFailed() {
    const luckFactor = randDouble();
    const isViaStreak = Math.random() > 0.6;
    const failureReason = pick(FAILURE_REASONS);
    return {
        action: "gift_avail_failed",
        success: false,
        actorId: pick(CUSTOMER_IDS),
        actorRole: "customer",
        functionName: pick([
            "scanAvailPublicPrivateAutoCampaign",
            "scanToAvailPublicPrivateAutoCampaignBySharedVendor",
            "scanToAvailPublicPrivateAutoCampaignByStaff",
        ]),
        customerId: pick(CUSTOMER_IDS),
        failureReason,
        luckFactor,
        randomNumber: parseFloat((luckFactor + 0.1 + Math.random() * 0.3).toFixed(4)),
        remainingGifts: rand(0, 30),
        remainingParticipants: rand(5, 100),
        availedViaStreak: isViaStreak,
        streakShopId: isViaStreak ? SHOP_ID : null,
        errorCode: failureReason,
        errorMessage: `Campaign avail failed: ${failureReason}`,
        timestamp: FieldValue.serverTimestamp(),
    };
}

function makeGiftRedemptionSuccess() {
    const giftId = pick(GIFT_IDS);
    const giftName = pick(GIFT_NAMES);
    const actorRole = pick(["owner", "staff", "shared_vendor"]);
    const methodMap = { owner: "owner_scan", staff: "staff_scan", shared_vendor: "shared_vendor_scan" };
    return {
        action: "gift_redemption_success",
        success: true,
        actorId: pick(ACTOR_IDS),
        actorRole,
        functionName: pick(["scanToRedeemByOwner", "scanToRedeemByStaff", "scanToRedeemBySharedVendor"]),
        customerId: pick(CUSTOMER_IDS),
        userGiftId: randId(),
        giftId,
        giftName,
        redemptionId: randId(),
        redemptionMethod: methodMap[actorRole],
        shopId: Math.random() > 0.5 ? SHOP_ID : null,
        timestamp: FieldValue.serverTimestamp(),
    };
}

function makeGiftRedemptionFailed() {
    const actorRole = pick(["owner", "staff", "shared_vendor"]);
    const methodMap = { owner: "owner_scan", staff: "staff_scan", shared_vendor: "shared_vendor_scan" };
    const failureReason = pick(["not-found", "already-redeemed", "permission-denied", "gift_expired"]);
    return {
        action: "gift_redemption_failed",
        success: false,
        actorId: pick(ACTOR_IDS),
        actorRole,
        functionName: pick(["scanToRedeemByOwner", "scanToRedeemByStaff", "scanToRedeemBySharedVendor"]),
        customerId: pick(CUSTOMER_IDS),
        userGiftId: randId(),
        giftId: pick(GIFT_IDS),
        giftName: pick(GIFT_NAMES),
        redemptionId: randId(),
        failureReason,
        redemptionMethod: methodMap[actorRole],
        shopId: Math.random() > 0.5 ? SHOP_ID : null,
        errorCode: failureReason,
        errorMessage: `Redemption failed: ${failureReason}`,
        timestamp: FieldValue.serverTimestamp(),
    };
}

// ---------------------------------------------------------------------------
// Shop log builders
// ---------------------------------------------------------------------------

function makeCheckInSuccess() {
    const cumulativeStreak = rand(1, 120);
    const giftCycleDay = 10;
    const isGiftDay = cumulativeStreak % giftCycleDay === 0;
    const bonusApplied = Math.random() > 0.7;
    const wasAutoFollowed = Math.random() > 0.85;
    return {
        action: "check_in_success",
        success: true,
        actorId: pick(ACTOR_IDS),
        actorRole: pick(["owner", "staff"]),
        functionName: "checkInUser",
        customerId: pick(CUSTOMER_IDS),
        shopId: SHOP_ID,
        cumulativeStreak,
        consecutiveDays: rand(1, cumulativeStreak),
        bonusApplied,
        bonusValue: bonusApplied ? rand(2, 3) : null,
        isGiftDay,
        campaignId: isGiftDay ? CAMPAIGN_ID : null,
        wasAutoFollowed,
        previousStreak: cumulativeStreak - (bonusApplied ? rand(2, 3) : 1),
        timestamp: FieldValue.serverTimestamp(),
    };
}

function makeCheckInFailed() {
    const failureReason = pick(["already-checked-in", "shop-not-found", "internal", "permission-denied"]);
    return {
        action: "check_in_failed",
        success: false,
        actorId: pick(ACTOR_IDS),
        actorRole: "system",
        functionName: "checkInUser",
        customerId: pick(CUSTOMER_IDS),
        shopId: SHOP_ID,
        failureReason,
        errorCode: failureReason,
        errorMessage: `Check-in failed: ${failureReason}`,
        timestamp: FieldValue.serverTimestamp(),
    };
}

function makeFollowerAdded() {
    return {
        action: "follower_added",
        success: true,
        actorId: pick(ACTOR_IDS),
        actorRole: pick(["owner", "staff"]),
        functionName: "checkInUser",
        customerId: pick(CUSTOMER_IDS),
        shopId: SHOP_ID,
        addedMethod: "auto_check_in",
        initialStreak: 1,
        timestamp: FieldValue.serverTimestamp(),
    };
}

function makeGiftAvailTriggered() {
    const availStatus = pick(["success", "failed"]);
    const luckFactor = randDouble();
    return {
        action: "gift_avail_triggered",
        success: availStatus === "success",
        actorId: pick(CUSTOMER_IDS),
        actorRole: "customer",
        functionName: pick([
            "scanAvailPublicPrivateAutoCampaign",
            "scanToAvailPublicPrivateAutoCampaignBySharedVendor",
        ]),
        customerId: pick(CUSTOMER_IDS),
        campaignId: CAMPAIGN_ID,
        shopId: SHOP_ID,
        availStatus,
        triggeredByStreak: true,
        streakValue: null,
        giftCycleDay: null,
        giftId: availStatus === "success" ? pick(GIFT_IDS) : null,
        giftName: availStatus === "success" ? pick(GIFT_NAMES) : null,
        failureReason: availStatus === "failed" ? pick(FAILURE_REASONS) : null,
        luckFactor,
        randomNumber: availStatus === "success"
            ? parseFloat((Math.random() * luckFactor).toFixed(4))
            : parseFloat((luckFactor + 0.05 + Math.random() * 0.2).toFixed(4)),
        errorCode: availStatus === "failed" ? "luck_failed" : null,
        errorMessage: availStatus === "failed" ? "Better luck next time!" : null,
        timestamp: FieldValue.serverTimestamp(),
    };
}

// ---------------------------------------------------------------------------
// Seeder
// ---------------------------------------------------------------------------

async function seed() {
    const batch = db.batch();
    let total = 0;

    // ── Campaign logs (12-15 records) ────────────────────────────────────────
    const campaignCol = db.collection("campaigns").doc(CAMPAIGN_ID).collection("activityLogs");

    const campaignBuilders = [
        ...Array(5).fill(makeGiftAvailSuccess),
        ...Array(3).fill(makeGiftAvailFailed),
        ...Array(4).fill(makeGiftRedemptionSuccess),
        ...Array(3).fill(makeGiftRedemptionFailed),
    ];

    // Shuffle
    campaignBuilders.sort(() => Math.random() - 0.5);

    for (const builder of campaignBuilders) {
        const ref = campaignCol.doc();
        const data = builder();
        batch.set(ref, { ...data, logId: ref.id });
        total++;
    }

    // ── Shop logs (12-15 records) ─────────────────────────────────────────────
    const shopCol = db.collection("shops").doc(SHOP_ID).collection("activityLogs");

    const shopBuilders = [
        ...Array(6).fill(makeCheckInSuccess),
        ...Array(2).fill(makeCheckInFailed),
        ...Array(2).fill(makeFollowerAdded),
        ...Array(4).fill(makeGiftAvailTriggered),
    ];

    // Shuffle
    shopBuilders.sort(() => Math.random() - 0.5);

    for (const builder of shopBuilders) {
        const ref = shopCol.doc();
        const data = builder();
        batch.set(ref, { ...data, logId: ref.id });
        total++;
    }

    await batch.commit();
    console.log(`✅ Seeded ${total} activity log records`);
    console.log(`   📁 campaigns/${CAMPAIGN_ID}/activityLogs — ${campaignBuilders.length} records`);
    console.log(`   📁 shops/${SHOP_ID}/activityLogs — ${shopBuilders.length} records`);
}

seed().catch((err) => {
    console.error("❌ Seed failed:", err);
    process.exit(1);
});
