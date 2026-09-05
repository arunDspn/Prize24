import assert from "node:assert/strict";
import {after, before, describe, it} from "node:test";
import {deleteApp, getApps, initializeApp} from "firebase-admin/app";

let subject: typeof import("./shopCheckIn.js");

before(async () => {
  if (getApps().length === 0) {
    initializeApp({projectId: "demo-prize24"});
  }
  subject = await import("./shopCheckIn.js");
});

after(async () => {
  await Promise.all(getApps().map((app) => deleteApp(app)));
});

describe("bill validation", () => {
  it("normalizes bill numbers without changing the display value", () => {
    assert.deepEqual(subject.validateBillNumber("  ab-123  "), {
      billNumber: "ab-123",
      normalizedBillNumber: "AB-123",
    });
  });

  it("accepts positive values with at most two decimal places", () => {
    assert.deepEqual(subject.validateBillAmount(123.45), {
      amount: 123.45,
      minorUnits: 12345,
    });
  });

  it("rejects zero, non-finite, and overly precise values", () => {
    assert.throws(() => subject.validateBillAmount(0));
    assert.throws(() => subject.validateBillAmount(Number.POSITIVE_INFINITY));
    assert.throws(() => subject.validateBillAmount(1.001));
  });
});

describe("bill totals", () => {
  it("adds a bill to the open and cumulative totals", () => {
    assert.deepEqual(subject.calculateBillTotals(10.1, 25, 100.2, 1234, false), {
      cycleBillSum: 22.44,
      previousCycleBillSum: 25,
      cumulativeBillSum: 112.54,
    });
  });

  it("moves the closing bill into the completed cycle", () => {
    assert.deepEqual(subject.calculateBillTotals(10.1, 25, 100.2, 1234, true), {
      cycleBillSum: 0,
      previousCycleBillSum: 22.44,
      cumulativeBillSum: 112.54,
    });
  });
});

describe("gift milestone crossing", () => {
  it("detects exact, skipped, and multiple milestone crossings", () => {
    assert.equal(subject.crossedGiftMilestone(14, 15, 15, null), 15);
    assert.equal(subject.crossedGiftMilestone(14, 16, 15, null), 15);
    assert.equal(subject.crossedGiftMilestone(14, 31, 15, null), 30);
  });

  it("does not repeat an awarded milestone", () => {
    assert.equal(subject.crossedGiftMilestone(14, 16, 15, 15), null);
    assert.equal(subject.crossedGiftMilestone(16, 17, 15, 15), null);
  });

  it("supports a first check-in milestone", () => {
    assert.equal(subject.crossedGiftMilestone(0, 1, 1, null), 1);
  });
});
