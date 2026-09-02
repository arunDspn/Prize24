/**
 * Seed Script for UserGift Records
 *
 * This script generates 140 mock UserGift records for testing load and pagination.
 * All gifts belong to user: 6gL3Vht5myV4JoKC6dLy9DGfSYm2
 *
 * Prerequisites:
 * 1. Download your Firebase service account key JSON file from Firebase Console:
 *    Project Settings > Service Accounts > Generate New Private Key
 * 2. Save it as 'serviceAccountKey.json' in the functions directory
 * 3. Install dependencies: npm install firebase-admin
 *
 * Usage:
 *   node src/seedUserGifts.js
 */

const admin = require("firebase-admin");
const path = require("path");

// Initialize Firebase Admin SDK
// Update the path to your service account key
const serviceAccountPath = path.join(__dirname, "../serviceAccountKey.json");

try {
  const serviceAccount = require(serviceAccountPath);
  admin.initializeApp({
    credential: admin.credential.cert(serviceAccount),
  });
  console.log("✅ Firebase Admin initialized successfully");
} catch (error) {
  console.error("❌ Error loading service account key:", error.message);
  console.log("\n📝 Please download your service account key from Firebase Console:");
  console.log("   Project Settings > Service Accounts > Generate New Private Key");
  console.log("   Save it as \"serviceAccountKey.json\" in the functions directory\n");
  process.exit(1);
}

const db = admin.firestore();

// Configuration
const USER_ID = "6gL3Vht5myV4JoKC6dLy9DGfSYm2";
const CAMPAIGN_ID = "dZJ7TMG3twP7kGkh7xc4";
const CAMPAIGN_NAME = "Spring Festival Campaign 2026";
const TOTAL_RECORDS = 140;
const REDEEMED_RATIO = 0.5; // 50% redeemed, 50% unredeemed

// Gift name prefixes to create variety
const GIFT_NAME_PREFIXES = [
  "Premium Gift",
  "Discount Voucher",
  "Special Offer",
  "Bonus Reward",
  "Lucky Prize",
  "Exclusive Deal",
  "Super Coupon",
  "Flash Sale",
  "VIP Offer",
  "Mega Deal",
];

// Gift descriptions
const GIFT_DESCRIPTIONS = [
  "Get 20% off on your next purchase",
  "Free item with minimum purchase",
  "Buy one get one free offer",
  "Special discount on selected items",
  "Complimentary upgrade available",
  "Extra loyalty points bonus",
  "Limited time exclusive offer",
  "Premium member special benefit",
  "Seasonal promotional gift",
  "Anniversary celebration reward",
];

// Sample shop IDs
const SHOP_IDS = [
  "shop_abc123",
  "shop_def456",
  "shop_ghi789",
  "shop_jkl012",
  "shop_mno345",
  "shop_pqr678",
  "shop_stu901",
  "shop_vwx234",
];

// Payload examples (for code-based or auto gifts)
const PAYLOAD_EXAMPLES = [
  {type: "discount_code", code: "SAVE20", value: 20, description: "20% discount code"},
  {type: "voucher", code: "FREESHIP", value: 0, description: "Free shipping voucher"},
  {type: "cashback", code: "CB50", value: 50, currency: "USD", description: "$50 cashback"},
  {type: "coupon", code: "BONUS10", percent: 10, description: "10% off coupon"},
  {type: "gift_card", code: "GC100", amount: 100, currency: "USD", description: "$100 gift card"},
];

/**
 * Generate a random gift ID
 */
function generateGiftId() {
  const prefix = "gift_";
  const randomId = Math.random().toString(36).substring(2, 15);
  return prefix + randomId;
}

/**
 * Generate a random redemption ID
 */
function generateRedemptionId() {
  const prefix = "redemption_";
  const randomId = Math.random().toString(36).substring(2, 15) +
        Math.random().toString(36).substring(2, 15);
  return prefix + randomId;
}

/**
 * Generate a random payload ID
 */
function generatePayloadId() {
  const prefix = "payload_";
  const randomId = Math.random().toString(36).substring(2, 15);
  return prefix + randomId;
}

/**
 * Get a random element from an array
 */
function getRandomElement(array) {
  return array[Math.floor(Math.random() * array.length)];
}

/**
 * Get random shop IDs (1 to 3 shops)
 */
function getRandomShops() {
  const count = Math.floor(Math.random() * 3) + 1; // 1-3 shops
  const shuffled = [...SHOP_IDS].sort(() => 0.5 - Math.random());
  return shuffled.slice(0, count);
}

/**
 * Generate timestamps spread over the last 60 days
 */
function generateAvailedTimestamp(index) {
  const now = Date.now();
  const sixtyDaysAgo = now - (60 * 24 * 60 * 60 * 1000);
  const timeRange = now - sixtyDaysAgo;
  const timeOffset = (timeRange / TOTAL_RECORDS) * index;
  const timestamp = new Date(sixtyDaysAgo + timeOffset);
  return admin.firestore.Timestamp.fromDate(timestamp);
}

/**
 * Generate redeemed timestamp (some time after availed)
 */
function generateRedeemedTimestamp(availedTimestamp) {
  const availedDate = availedTimestamp.toDate();
  const maxDaysAfter = 14; // Redeemed within 14 days of receiving
  const daysAfter = Math.floor(Math.random() * maxDaysAfter);
  const redeemedDate = new Date(availedDate.getTime() + (daysAfter * 24 * 60 * 60 * 1000));
  return admin.firestore.Timestamp.fromDate(redeemedDate);
}

/**
 * Create a UserGift entry
 */
function createUserGiftEntry(number) {
  const isRedeemed = Math.random() < REDEEMED_RATIO;
  const availedTimestamp = generateAvailedTimestamp(number);

  // Get random prefix for gift name
  const namePrefix = getRandomElement(GIFT_NAME_PREFIXES);
  const giftName = `${namePrefix} ${number}`;

  // Determine if this is a redeemable gift (80% are redeemable)
  const isRedeemable = Math.random() < 0.8;

  // Determine if availed via streak (30% chance)
  const isStreakGift = Math.random() < 0.3;

  const entry = {
    userId: USER_ID,
    giftId: generateGiftId(),
    campaignId: CAMPAIGN_ID,
    campaignName: CAMPAIGN_NAME,
    giftName: giftName,
    giftDescription: getRandomElement(GIFT_DESCRIPTIONS),
    isRedeemable: isRedeemable,
    isRedeemed: isRedeemed,
    redeemedAt: isRedeemed ? generateRedeemedTimestamp(availedTimestamp) : null,
    availedAt: availedTimestamp,
    payload: null,
    payloadId: null,
    supportedShops: null,
    redemptionId: generateRedemptionId(),
    availedViaStreak: isStreakGift ? true : null,
    streakShopID: isStreakGift ? getRandomElement(SHOP_IDS) : null,
  };

  return entry;
}

/**
 * Generate all UserGift entries
 */
function generateUserGifts() {
  const entries = [];

  for (let i = 1; i <= TOTAL_RECORDS; i++) {
    const entry = createUserGiftEntry(i);
    entries.push(entry);
  }

  return entries;
}

/**
 * Seed the user gifts to Firestore
 */
async function seedUserGifts() {
  console.log("\n🌱 Starting UserGift seeding...");
  console.log(`👤 User ID: ${USER_ID}`);
  console.log(`🎁 Campaign ID: ${CAMPAIGN_ID}`);
  console.log(`📝 Total records: ${TOTAL_RECORDS}`);
  console.log(`✅ Redeemed: ${Math.floor(TOTAL_RECORDS * REDEEMED_RATIO)}`);
  console.log(`⏳ Unredeemed: ${Math.floor(TOTAL_RECORDS * (1 - REDEEMED_RATIO))}\n`);

  const entries = generateUserGifts();
  const collectionRef = db.collection("user_gifts");

  // Batch write for better performance
  const BATCH_SIZE = 500; // Firestore batch limit
  let batchCount = 0;
  let batch = db.batch();
  let redeemedCount = 0;
  let unredeemedCount = 0;
  let redeemableCount = 0;
  let nonRedeemableCount = 0;
  let streakGiftCount = 0;

  for (let i = 0; i < entries.length; i++) {
    const entry = entries[i];
    const docRef = collectionRef.doc();
    batch.set(docRef, entry);
    batchCount++;

    // Count statistics
    if (entry.isRedeemed) {
      redeemedCount++;
    } else {
      unredeemedCount++;
    }
    if (entry.isRedeemable) {
      redeemableCount++;
    } else {
      nonRedeemableCount++;
    }
    if (entry.availedViaStreak) {
      streakGiftCount++;
    }

    // Commit batch when limit reached or at the end
    if (batchCount === BATCH_SIZE || i === entries.length - 1) {
      await batch.commit();
      console.log(`✓ Written ${i + 1}/${TOTAL_RECORDS} records...`);
      batch = db.batch();
      batchCount = 0;
    }
  }

  console.log("\n🎉 Seeding completed successfully!");
  console.log("\n📊 Statistics:");
  console.log(`   ✅ Redeemed: ${redeemedCount}`);
  console.log(`   ⏳ Unredeemed: ${unredeemedCount}`);
  console.log(`   🎁 Redeemable: ${redeemableCount}`);
  console.log(`   🚫 Non-redeemable: ${nonRedeemableCount}`);
  console.log(`   🔥 Streak gifts: ${streakGiftCount}`);
  console.log("\n📍 Location: user_gifts collection (root level)\n");
}

/**
 * Main execution
 */
async function main() {
  try {
    await seedUserGifts();
    console.log("🏁 Script finished. You can now test pagination and load.");
    process.exit(0);
  } catch (error) {
    console.error("❌ Error seeding user gifts:", error);
    process.exit(1);
  }
}

// Run the script
main();
