/**
 * Delete Script for UserGift Records
 *
 * This script deletes all UserGift records created by seedUserGifts.js
 * for user: 6gL3Vht5myV4JoKC6dLy9DGfSYm2
 *
 * Prerequisites:
 * 1. Download your Firebase service account key JSON file from Firebase Console:
 *    Project Settings > Service Accounts > Generate New Private Key
 * 2. Save it as 'serviceAccountKey.json' in the functions directory
 * 3. Install dependencies: npm install firebase-admin
 *
 * Usage:
 *   node src/deleteUserGifts.js
 *
 * WARNING: This will permanently delete all user_gifts records for the specified user.
 */

const admin = require("firebase-admin");
const path = require("path");
const readline = require("readline");

// Initialize Firebase Admin SDK
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
const BATCH_SIZE = 500; // Firestore batch write limit

/**
 * Prompt user for confirmation
 */
function askConfirmation(question) {
  const rl = readline.createInterface({
    input: process.stdin,
    output: process.stdout,
  });

  return new Promise((resolve) => {
    rl.question(question, (answer) => {
      rl.close();
      resolve(answer.toLowerCase() === "yes" || answer.toLowerCase() === "y");
    });
  });
}

/**
 * Delete documents in batches
 */
async function deleteInBatches(querySnapshot) {
  const docs = querySnapshot.docs;

  if (docs.length === 0) {
    return 0;
  }

  let deletedCount = 0;
  let batch = db.batch();
  let batchCount = 0;

  for (let i = 0; i < docs.length; i++) {
    batch.delete(docs[i].ref);
    batchCount++;
    deletedCount++;

    // Commit batch when limit reached or at the end
    if (batchCount === BATCH_SIZE || i === docs.length - 1) {
      await batch.commit();
      console.log(`✓ Deleted ${deletedCount}/${docs.length} documents...`);
      batch = db.batch();
      batchCount = 0;
    }
  }

  return deletedCount;
}

/**
 * Delete all UserGift records for the specified user
 */
async function deleteUserGifts() {
  console.log("\n🔍 Searching for UserGift records...");
  console.log(`👤 User ID: ${USER_ID}`);
  console.log("📍 Collection: user_gifts\n");

  // Query all user_gifts for this user
  const query = db.collection("user_gifts").where("userId", "==", USER_ID);
  const snapshot = await query.get();

  const totalDocs = snapshot.size;

  if (totalDocs === 0) {
    console.log("ℹ️  No documents found to delete.");
    return;
  }

  console.log(`📊 Found ${totalDocs} documents to delete.\n`);

  // Ask for confirmation
  const confirmed = await askConfirmation(
    "⚠️  WARNING: This will permanently delete all these records. Continue? (yes/no): "
  );

  if (!confirmed) {
    console.log("\n❌ Deletion cancelled by user.");
    return;
  }

  console.log("\n🗑️  Starting deletion...\n");

  const startTime = Date.now();
  const deletedCount = await deleteInBatches(snapshot);
  const endTime = Date.now();
  const duration = ((endTime - startTime) / 1000).toFixed(2);

  console.log("\n✅ Deletion completed successfully!");
  console.log(`📊 Total deleted: ${deletedCount} documents`);
  console.log(`⏱️  Time taken: ${duration} seconds\n`);
}

/**
 * Main execution
 */
async function main() {
  try {
    await deleteUserGifts();
    console.log("🏁 Script finished.");
    process.exit(0);
  } catch (error) {
    console.error("❌ Error deleting user gifts:", error);
    process.exit(1);
  }
}

// Run the script
main();
