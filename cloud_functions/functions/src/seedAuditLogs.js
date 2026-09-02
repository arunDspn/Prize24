/**
 * Seed Script for Audit Log Entries
 *
 * This script generates 100 mock AuditLogEntry records for testing load and pagination.
 *
 * Prerequisites:
 * 1. Download your Firebase service account key JSON file from Firebase Console:
 *    Project Settings > Service Accounts > Generate New Private Key
 * 2. Save it as 'serviceAccountKey.json' in the functions directory
 * 3. Install dependencies: npm install firebase-admin
 *
 * Usage:
 *   node src/seedAuditLogs.js
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
const CAMPAIGN_ID = "dZJ7TMG3twP7kGkh7xc4";
const TOTAL_RECORDS = 100;
const SUCCESS_RATE = 0.7; // 70% success, 30% failure

// Mock data arrays
const REDEEMER_ROLES = ["owner", "shared_vendor", "staff"];
const FUNCTION_NAMES = [
  "scanToRedeemByOwner",
  "scanToRedeemBySharedVendor",
  "scanToRedeemByStaff",
];
const ERROR_CODES = [
  "not-found",
  "already-exists",
  "permission-denied",
  "invalid-argument",
  "unauthenticated",
];
const ERROR_MESSAGES = [
  "Gift not found",
  "Gift has already been redeemed",
  "You are not authorized to redeem this gift",
  "Missing required parameters",
  "User must be authenticated",
  "This shop is not supported by the campaign",
];

// Sample shop IDs for staff redemptions
const SHOP_IDS = [
  "shop_abc123",
  "shop_def456",
  "shop_ghi789",
  "shop_jkl012",
  "shop_mno345",
];

/**
 * Generate a random customer ID
 */
function generateCustomerId() {
  const prefix = "customer_";
  const randomId = Math.random().toString(36).substring(2, 15);
  return prefix + randomId;
}

/**
 * Generate a random redeemer ID
 */
function generateRedeemerId() {
  const prefix = "user_";
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
 * Generate timestamps spread over the last 30 days
 */
function generateTimestamp(index) {
  const now = Date.now();
  const thirtyDaysAgo = now - (30 * 24 * 60 * 60 * 1000);
  const timeRange = now - thirtyDaysAgo;
  const timeOffset = (timeRange / TOTAL_RECORDS) * index;
  const timestamp = new Date(thirtyDaysAgo + timeOffset);
  return admin.firestore.Timestamp.fromDate(timestamp);
}

/**
 * Create a success audit log entry
 */
function createSuccessEntry(giftId, index) {
  const redeemerRole = getRandomElement(REDEEMER_ROLES);
  const functionName = redeemerRole === "owner" ?
    "scanToRedeemByOwner" :
    redeemerRole === "shared_vendor" ?
      "scanToRedeemBySharedVendor" :
      "scanToRedeemByStaff";

  const entry = {
    action: "gift_redeemed",
    giftId: giftId,
    customerId: generateCustomerId(),
    redeemedBy: generateRedeemerId(),
    redeemerRole: redeemerRole,
    timestamp: generateTimestamp(index),
    functionName: functionName,
    success: true,
  };

  // Add shopId for staff redemptions
  if (redeemerRole === "staff") {
    entry.shopId = getRandomElement(SHOP_IDS);
  }

  return entry;
}

/**
 * Create a failure audit log entry
 */
function createFailureEntry(giftId, index) {
  const redeemerRole = getRandomElement(REDEEMER_ROLES);
  const functionName = redeemerRole === "owner" ?
    "scanToRedeemByOwner" :
    redeemerRole === "shared_vendor" ?
      "scanToRedeemBySharedVendor" :
      "scanToRedeemByStaff";

  const entry = {
    action: "gift_redemption_failed",
    giftId: giftId,
    redeemedBy: generateRedeemerId(),
    redeemerRole: redeemerRole,
    timestamp: generateTimestamp(index),
    functionName: functionName,
    errorCode: getRandomElement(ERROR_CODES),
    errorMessage: getRandomElement(ERROR_MESSAGES),
    success: false,
  };

  // Add shopId for staff redemptions
  if (redeemerRole === "staff") {
    entry.shopId = getRandomElement(SHOP_IDS);
  }

  // Add customerId for some failure cases (when gift was found but failed for other reasons)
  if (Math.random() > 0.5) {
    entry.customerId = generateCustomerId();
  }

  return entry;
}

/**
 * Generate all audit log entries
 */
function generateAuditLogs() {
  const entries = [];

  for (let i = 1; i <= TOTAL_RECORDS; i++) {
    const giftId = i.toString();
    const isSuccess = Math.random() < SUCCESS_RATE;

    const entry = isSuccess ?
      createSuccessEntry(giftId, i) :
      createFailureEntry(giftId, i);

    entries.push(entry);
  }

  return entries;
}

/**
 * Seed the audit logs to Firestore
 */
async function seedAuditLogs() {
  console.log("\n🌱 Starting audit log seeding...");
  console.log(`📊 Campaign ID: ${CAMPAIGN_ID}`);
  console.log(`📝 Total records: ${TOTAL_RECORDS}`);
  console.log(`✅ Success rate: ${SUCCESS_RATE * 100}%`);
  console.log(`❌ Failure rate: ${(1 - SUCCESS_RATE) * 100}%\n`);

  const entries = generateAuditLogs();
  const collectionRef = db.collection("campaigns").doc(CAMPAIGN_ID).collection("redemptionLogs");

  // Batch write for better performance
  const BATCH_SIZE = 500; // Firestore batch limit
  let batchCount = 0;
  let batch = db.batch();
  let successCount = 0;
  let failureCount = 0;

  for (let i = 0; i < entries.length; i++) {
    const entry = entries[i];
    const docRef = collectionRef.doc();
    batch.set(docRef, entry);
    batchCount++;

    if (entry.success) {
      successCount++;
    } else {
      failureCount++;
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
  console.log(`✅ Success entries: ${successCount}`);
  console.log(`❌ Failure entries: ${failureCount}`);
  console.log(`📍 Location: campaigns/${CAMPAIGN_ID}/redemptionLogs\n`);
}

/**
 * Main execution
 */
async function main() {
  try {
    await seedAuditLogs();
    console.log("🏁 Script finished. You can now test pagination and load.");
    process.exit(0);
  } catch (error) {
    console.error("❌ Error seeding audit logs:", error);
    process.exit(1);
  }
}

// Run the script
main();
