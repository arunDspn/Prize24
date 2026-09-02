/**
 * Delete Script — Activity Logs
 *
 * Deletes ALL activity log documents from:
 *   campaigns/dZJ7TMG3twP7kGkh7xc4/activityLogs
 *   shops/BtVgAuMyLGzwxmhbUNPU/activityLogs
 *
 * Usage:
 *   node src/deleteActivityLogs.js
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

const CAMPAIGN_ID = "dZJ7TMG3twP7kGkh7xc4";
const SHOP_ID = "BtVgAuMyLGzwxmhbUNPU";

// ---------------------------------------------------------------------------
// Helper — delete all docs in a collection in batches of 400
// ---------------------------------------------------------------------------

async function deleteCollection(collectionPath) {
    const colRef = db.collection(collectionPath);
    let deleted = 0;

    while (true) {
        const snapshot = await colRef.limit(400).get();
        if (snapshot.empty) break;

        const batch = db.batch();
        snapshot.docs.forEach((doc) => batch.delete(doc.ref));
        await batch.commit();
        deleted += snapshot.size;
        console.log(`   ↳ Deleted ${deleted} so far from ${collectionPath}...`);
    }

    return deleted;
}

// ---------------------------------------------------------------------------
// Main
// ---------------------------------------------------------------------------

async function run() {
    console.log("\n🗑️  Deleting activity logs...\n");

    const campaignPath = `campaigns/${CAMPAIGN_ID}/activityLogs`;
    const shopPath = `shops/${SHOP_ID}/activityLogs`;

    const campaignCount = await deleteCollection(campaignPath);
    console.log(`✅ Deleted ${campaignCount} records from ${campaignPath}`);

    const shopCount = await deleteCollection(shopPath);
    console.log(`✅ Deleted ${shopCount} records from ${shopPath}`);

    console.log(`\n✅ Done. Total deleted: ${campaignCount + shopCount} records\n`);
}

run().catch((err) => {
    console.error("❌ Delete failed:", err);
    process.exit(1);
});
