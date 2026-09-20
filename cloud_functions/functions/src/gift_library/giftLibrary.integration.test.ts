import assert from "node:assert/strict";
import {randomUUID} from "node:crypto";
import {before, describe, it} from "node:test";
import {getApps, initializeApp} from "firebase-admin/app";
import {getFirestore, Timestamp} from "firebase-admin/firestore";
import firebaseFunctionsTest from "firebase-functions-test";
import {CallableRequest} from "firebase-functions/v2/https";

let subject: typeof import("./giftLibrary.js");
const emulatorEnabled = typeof process.env.FIRESTORE_EMULATOR_HOST === "string";

/**
 * Builds the minimum authenticated v2 callable request used by wrapped tests.
 * @param {T} data Callable request data
 * @param {string} uid Authenticated user ID
 * @return {CallableRequest<T>} Wrapped callable request
 */
function callableRequest<T>(data: T, uid: string): CallableRequest<T> {
  return {data, auth: {uid, token: {}}} as CallableRequest<T>;
}

before(async () => {
  if (getApps().length === 0) initializeApp({projectId: "demo-prize24"});
  subject = await import("./giftLibrary.js");
});

describe("Gift Library bucket transactions", {skip: !emulatorEnabled}, () => {
  it("allows only one of two concurrent creates for the twentieth slot", async () => {
    const db = getFirestore();
    const suffix = randomUUID();
    const ownerId = `owner-${suffix}`;
    const libraryRef = db.collection("giftLibraries").doc(`library-${suffix}`);
    await libraryRef.set({
      ownerVendorId: ownerId,
      name: "Vegetables",
      description: "Vegetable rewards",
      status: "active",
      activeBucketCount: 19,
      createdAt: Timestamp.now(),
      updatedAt: Timestamp.now(),
    });

    const wrapped = firebaseFunctionsTest().wrap(subject.createGiftLibraryBucket);
    const attempts = await Promise.allSettled([
      wrapped(callableRequest({
        giftLibraryId: libraryRef.id,
        name: "Carrot",
        description: "One carrot bundle",
        remainingCount: 10,
      }, ownerId)),
      wrapped(callableRequest({
        giftLibraryId: libraryRef.id,
        name: "Potato",
        description: "One potato bundle",
        remainingCount: 10,
      }, ownerId)),
    ]);

    assert.equal(attempts.filter((attempt) => attempt.status === "fulfilled").length, 1);
    assert.equal(attempts.filter((attempt) => attempt.status === "rejected").length, 1);
    assert.equal((await libraryRef.get()).data()?.activeBucketCount, 20);
    const createdBuckets = await libraryRef.collection("buckets").get();
    assert.equal(createdBuckets.size, 1);

    const archive = firebaseFunctionsTest().wrap(subject.archiveGiftLibraryBucket);
    await archive(callableRequest({
      giftLibraryId: libraryRef.id,
      bucketId: createdBuckets.docs[0].id,
    }, ownerId));
    assert.equal((await libraryRef.get()).data()?.activeBucketCount, 19);

    await wrapped(callableRequest({
      giftLibraryId: libraryRef.id,
      name: "Replacement",
      description: "Replacement bucket",
      remainingCount: 4,
    }, ownerId));
    assert.equal((await libraryRef.get()).data()?.activeBucketCount, 20);
    await db.recursiveDelete(libraryRef);
  });

  it("consumes the final unit only once across concurrent manual assignments", async () => {
    const db = getFirestore();
    const suffix = randomUUID();
    const ownerId = `owner-${suffix}`;
    const userId = `customer-${suffix}`;
    const libraryRef = db.collection("giftLibraries").doc(`library-${suffix}`);
    const bucketRef = libraryRef.collection("buckets").doc(`bucket-${suffix}`);
    const shopRef = db.collection("shops").doc(`shop-${suffix}`);
    await Promise.all([
      libraryRef.set({
        ownerVendorId: ownerId,
        name: "Vegetables",
        description: "Vegetable rewards",
        status: "active",
        activeBucketCount: 1,
        createdAt: Timestamp.now(),
        updatedAt: Timestamp.now(),
      }),
      bucketRef.set({
        name: "Carrot",
        description: "One carrot bundle",
        remainingCount: 1,
        status: "active",
        createdAt: Timestamp.now(),
        updatedAt: Timestamp.now(),
      }),
      shopRef.set({
        shopOwnerId: ownerId,
        shopName: "Test Shop",
        associatedGiftLibraryId: libraryRef.id,
      }),
      shopRef.collection("followers").doc(userId).set({userId}),
      db.collection("users").doc(userId).set({name: "Test Customer"}),
    ]);

    const wrapped = firebaseFunctionsTest().wrap(subject.assignManualLibraryGift);
    const attempts = await Promise.allSettled([
      wrapped(callableRequest({
        shopId: shopRef.id,
        userId,
        bucketId: bucketRef.id,
        requestId: `request-a-${suffix}`,
      }, ownerId)),
      wrapped(callableRequest({
        shopId: shopRef.id,
        userId,
        bucketId: bucketRef.id,
        requestId: `request-b-${suffix}`,
      }, ownerId)),
    ]);

    assert.equal(attempts.filter((attempt) => attempt.status === "fulfilled").length, 1);
    assert.equal(attempts.filter((attempt) => attempt.status === "rejected").length, 1);
    assert.equal((await bucketRef.get()).data()?.remainingCount, 0);
    const gifts = await db.collection("user_gifts").where("userId", "==", userId).get();
    assert.equal(gifts.size, 1);
    assert.equal(gifts.docs[0].data().bucketId, bucketRef.id);

    await Promise.all(gifts.docs.map((gift) => gift.ref.delete()));
    await Promise.all([
      db.recursiveDelete(libraryRef),
      db.recursiveDelete(shopRef),
      db.collection("users").doc(userId).delete(),
    ]);
  });

  it("decrements bucket inventory for a milestone assignment and audits the change", async () => {
    const db = getFirestore();
    const suffix = randomUUID();
    const ownerId = `owner-${suffix}`;
    const userId = `customer-${suffix}`;
    const libraryRef = db.collection("giftLibraries").doc(`library-${suffix}`);
    const bucketRef = libraryRef.collection("buckets").doc(`bucket-${suffix}`);
    const shopRef = db.collection("shops").doc(`shop-${suffix}`);
    const opportunityRef = shopRef.collection("rewardOpportunities").doc(`opportunity-${suffix}`);
    await Promise.all([
      libraryRef.set({
        ownerVendorId: ownerId,
        name: "Vegetables",
        description: "Vegetable rewards",
        status: "active",
        activeBucketCount: 1,
        createdAt: Timestamp.now(),
        updatedAt: Timestamp.now(),
      }),
      bucketRef.set({
        name: "Carrot",
        description: "One carrot bundle",
        remainingCount: 2,
        status: "active",
        createdAt: Timestamp.now(),
        updatedAt: Timestamp.now(),
      }),
      shopRef.set({
        shopOwnerId: ownerId,
        shopName: "Test Shop",
        associatedGiftLibraryId: libraryRef.id,
      }),
      opportunityRef.set({
        userId,
        shopId: shopRef.id,
        status: "pending",
        selectedSource: null,
        eligibleSources: ["gift_library"],
        giftLibraryId: libraryRef.id,
        milestone: 5,
        cumulativeBillSum: 40,
        milestoneCycleBillSum: 20,
        createdAt: Timestamp.now(),
        updatedAt: Timestamp.now(),
      }),
      db.collection("users").doc(userId).set({name: "Test Customer"}),
    ]);

    const wrapped = firebaseFunctionsTest().wrap(subject.resolveShopReward);
    await wrapped(callableRequest({
      shopId: shopRef.id,
      userId,
      opportunityId: opportunityRef.id,
      source: "gift_library",
      bucketId: bucketRef.id,
    }, ownerId));

    assert.equal((await bucketRef.get()).data()?.remainingCount, 1);
    assert.equal((await opportunityRef.get()).data()?.status, "completed");
    const gifts = await db.collection("user_gifts").where("userId", "==", userId).get();
    assert.equal(gifts.size, 1);
    const audit = await shopRef.collection("activityLogs")
      .where("action", "==", "library_gift_assignment_success").get();
    assert.equal(audit.size, 1);
    assert.equal(audit.docs[0].data().remainingCountBefore, 2);
    assert.equal(audit.docs[0].data().remainingCountAfter, 1);

    await Promise.all(gifts.docs.map((gift) => gift.ref.delete()));
    await Promise.all([
      db.recursiveDelete(libraryRef),
      db.recursiveDelete(shopRef),
      db.collection("users").doc(userId).delete(),
    ]);
  });
});
