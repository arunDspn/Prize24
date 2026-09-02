import {onRequest} from "firebase-functions/v2/https";
import {defineSecret} from "firebase-functions/params";
import * as logger from "firebase-functions/logger";
import {createHash} from "node:crypto";
import {FieldValue, Timestamp, getFirestore} from "firebase-admin/firestore";
import {
  RevenueCatWebhookBody,
  RevenueCatNormalizedPayment,
  REVENUECAT_EVENT_TYPES,
} from "../types";

const db = getFirestore();
const revenueCatWebhookSecret = defineSecret("REVENUECAT_WEBHOOK_SECRET");

/**
 * Normalizes Authorization header values and supports optional Bearer prefix.
 * @param {string | undefined} headerValue Raw Authorization header value.
 * @return {string} Parsed secret token.
 */
function parseAuthHeader(headerValue: string | undefined): string {
  if (!headerValue) {
    return "";
  }

  const trimmed = headerValue.trim();
  if (trimmed.toLowerCase().startsWith("bearer ")) {
    return trimmed.slice(7).trim();
  }

  return trimmed;
}

/**
 * Builds an idempotency-safe payment identifier from RevenueCat event data.
 * @param {object} event RevenueCat event payload.
 * @return {string} Stable payment ID.
 */
function getPaymentId(event: RevenueCatWebhookBody["event"]): string {
  const explicitId = event.id || event.transaction_id || event.original_transaction_id;
  if (explicitId && explicitId.trim().length > 0) {
    return explicitId;
  }

  const hashInput = [
    event.app_user_id || "",
    event.product_id || "",
    String(event.purchased_at_ms || ""),
    String(event.price || ""),
    event.currency || "",
    event.type || "",
  ].join("|");

  return createHash("sha256").update(hashInput).digest("hex");
}

/**
 * Maps RevenueCat event fields into normalized Firestore payment shape.
 * @param {object} event RevenueCat event payload.
 * @param {string} paymentId Idempotent payment ID.
 * @return {RevenueCatNormalizedPayment} Normalized payment record.
 */
function normalizePayment(event: RevenueCatWebhookBody["event"], paymentId: string): RevenueCatNormalizedPayment {
  const now = Timestamp.now();
  const eventDate = typeof event.purchased_at_ms === "number" ?
    Timestamp.fromMillis(event.purchased_at_ms) : now;

  return {
    paymentId,
    amount: event.price,
    currency: event.currency,
    productId: event.product_id,
    eventDate,
    createdAt: FieldValue.serverTimestamp(),
    provider: "revenuecat",
    eventType: event.type,
    transactionId: event.transaction_id || null,
    originalTransactionId: event.original_transaction_id || null,
  };
}

/**
 * RevenueCat webhook endpoint for paid subscription events.
 */
export const revenueCatWebhook = onRequest(
  {secrets: [revenueCatWebhookSecret]},
  async (req, res) => {
    if (req.method !== "POST") {
      res.status(405).json({success: false, message: "Method not allowed"});
      return;
    }

    const expectedSecret = revenueCatWebhookSecret.value();
    const providedSecret = parseAuthHeader(req.get("authorization") || undefined);

    if (!expectedSecret || providedSecret !== expectedSecret) {
      logger.warn("RevenueCat webhook unauthorized", {
        hasAuthHeader: Boolean(req.get("authorization")),
      });
      res.status(401).json({success: false, message: "Unauthorized"});
      return;
    }

    const body = req.body as RevenueCatWebhookBody | undefined;
    const event = body?.event;

    if (!event) {
      logger.warn("RevenueCat webhook missing event payload");
      res.status(400).json({success: false, message: "Invalid payload: missing event"});
      return;
    }

    if (!REVENUECAT_EVENT_TYPES.has(event.type)) {
      logger.info("RevenueCat webhook ignored event type", {
        eventType: event.type,
      });
      res.status(200).json({success: true, message: "Event ignored"});
      return;
    }

    if (!event.app_user_id || typeof event.app_user_id !== "string") {
      logger.warn("RevenueCat webhook missing app_user_id", {
        eventType: event.type,
      });
      res.status(400).json({success: false, message: "Invalid payload: missing app_user_id"});
      return;
    }

    if (typeof event.price !== "number" || event.price < 0) {
      logger.warn("RevenueCat webhook invalid price", {
        appUserId: event.app_user_id,
        eventType: event.type,
        price: event.price,
      });
      res.status(400).json({success: false, message: "Invalid payload: invalid price"});
      return;
    }

    if (!event.currency || !event.product_id) {
      logger.warn("RevenueCat webhook missing currency or product_id", {
        appUserId: event.app_user_id,
        eventType: event.type,
      });
      res.status(400).json({success: false, message: "Invalid payload: missing currency/product_id"});
      return;
    }

    const userId = event.app_user_id;
    const paymentId = getPaymentId(event);
    const payment = normalizePayment(event, paymentId);
    const commission = Number((payment.amount * 0.5).toFixed(2));

    const userRef = db.collection("users").doc(userId);
    const paymentRef = userRef.collection("subscriptionPayment").doc(paymentId);

    try {
      const result = await db.runTransaction(async (transaction) => {
        const paymentDoc = await transaction.get(paymentRef);
        if (paymentDoc.exists) {
          return {duplicate: true, referredBy: null as string | null};
        }

        const userDoc = await transaction.get(userRef);
        if (!userDoc.exists) {
          throw new Error("USER_NOT_FOUND");
        }

        const referredBy = userDoc.get("referredBy");
        const validReferredBy = typeof referredBy === "string" && referredBy.trim().length > 0 ? referredBy : null;

        transaction.set(paymentRef, payment);

        if (validReferredBy) {
          const commissionRef = db
            .collection("users")
            .doc(validReferredBy)
            .collection("commissions")
            .doc();

          const paymentType = payment.eventType === "INITIAL_PURCHASE" ? "initial" : "renew";

          transaction.set(commissionRef, {
            userId,
            paymentId,
            type: paymentType,
            date: payment.eventDate,
            totalAmount: payment.amount,
            commission,
            currency: payment.currency,
            createdAt: FieldValue.serverTimestamp(),
          });
        }

        return {duplicate: false, referredBy: validReferredBy};
      });

      if (result.duplicate) {
        logger.info("RevenueCat webhook duplicate ignored", {
          userId,
          paymentId,
          eventType: payment.eventType,
        });
        res.status(200).json({success: true, message: "Duplicate ignored", paymentId});
        return;
      }

      logger.info("RevenueCat webhook processed", {
        userId,
        paymentId,
        referredBy: result.referredBy,
        eventType: payment.eventType,
      });
      res.status(200).json({
        success: true,
        message: "Processed",
        paymentId,
        referredBy: result.referredBy,
      });
    } catch (error) {
      if ((error as Error).message === "USER_NOT_FOUND") {
        logger.error("RevenueCat webhook user not found", {
          userId,
          paymentId,
        });
        res.status(404).json({success: false, message: "User not found"});
        return;
      }

      logger.error("RevenueCat webhook processing failed", {
        userId,
        paymentId,
        error: (error as Error).message,
      });
      res.status(500).json({success: false, message: "Internal server error"});
    }
  }
);
