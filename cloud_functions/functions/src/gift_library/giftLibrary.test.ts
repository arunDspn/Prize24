import assert from "node:assert/strict";
import {before, describe, it} from "node:test";
import {getApps, initializeApp} from "firebase-admin/app";

let subject: typeof import("./giftLibrary.js");

before(async () => {
  if (getApps().length === 0) initializeApp({projectId: "demo-prize24"});
  subject = await import("./giftLibrary.js");
});

describe("Gift Library bucket inventory", () => {
  it("accepts safe whole-number inventory values", () => {
    assert.equal(subject.requiredInventoryCount(1, "remainingCount", 1), 1);
    assert.equal(subject.requiredInventoryCount(0, "remainingCount"), 0);
    assert.equal(subject.requiredInventoryCount(1000000, "remainingCount"), 1000000);
  });

  it("rejects negative, fractional, and unsafe inventory values", () => {
    for (const value of [-1, 1.5, Number.MAX_SAFE_INTEGER + 1, "4", null]) {
      assert.throws(() => subject.requiredInventoryCount(value, "remainingCount"));
    }
    assert.throws(() => subject.requiredInventoryCount(0, "remainingCount", 1));
  });

  it("rejects assignment from an empty bucket", () => {
    assert.equal(subject.requireAvailableBucketCount(2), 2);
    assert.throws(() => subject.requireAvailableBucketCount(0), (error: unknown) => {
      return typeof error === "object" && error !== null &&
        "code" in error && error.code === "resource-exhausted";
    });
  });

  it("enforces the twenty-active-bucket limit", () => {
    assert.equal(subject.requireBucketSlot(undefined), 0);
    assert.equal(subject.requireBucketSlot(19), 19);
    assert.throws(() => subject.requireBucketSlot(subject.MAX_ACTIVE_BUCKETS));
  });
});
