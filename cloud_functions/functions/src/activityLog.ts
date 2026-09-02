import {getFirestore, FieldValue} from "firebase-admin/firestore";
import * as logger from "firebase-functions/logger";

const db = getFirestore();

/**
 * Resolves the phone number to record on an activity log from a user document.
 * Prefers `userPhoneNumber`; falls back to `vendorPhoneNumber` (vendor-type accounts
 * store their phone under that field); otherwise null.
 * @param {Record<string, any> | null | undefined} userData - User document data
 * @return {string | null} The resolved phone number, or null if none found
 */
export function resolvePhoneNumber(
  userData: Record<string, any> | null | undefined
): string | null {
  return userData?.userPhoneNumber || userData?.vendorPhoneNumber || null;
}

/**
 * Base interface for all activity log entries.
 * Shared across campaign and shop activity logs.
 */
export interface ActivityLogEntry {
    action: string;
    timestamp?: any; // FieldValue.serverTimestamp() — set automatically
    success: boolean;
    actorId: string;
    actorRole: "owner" | "staff" | "shared_vendor" | "system" | "customer";
    functionName: string;
    errorCode?: string;
    errorMessage?: string;
    [key: string]: any; // allow action-specific fields
}

/**
 * Creates an activity log entry in the specified Firestore collection path.
 *
 * Collection path conventions:
 *   - Campaign activities: `campaigns/{campaignId}/activityLogs`
 *   - Shop activities:     `shops/{shopId}/activityLogs`
 *
 * This function never throws — logging failures are silently swallowed
 * so they never interrupt the main business operation.
 *
 * @param {string} collectionPath - Full Firestore collection path
 * @param {ActivityLogEntry} logData - Log payload (timestamp is added automatically)
 */
export async function createActivityLog(
  collectionPath: string,
  logData: ActivityLogEntry
): Promise<void> {
  try {
    const logRef = db.collection(collectionPath).doc();
    await logRef.set({
      ...logData,
      logId: logRef.id,
      timestamp: FieldValue.serverTimestamp(),
    });
    logger.info(`[activityLog] ${logData.action} logged`, {
      logId: logRef.id,
      collectionPath,
      action: logData.action,
      success: logData.success,
      actorId: logData.actorId,
    });
  } catch (error) {
    // Never throw — logging must not break the main operation
    logger.error("[activityLog] Failed to write activity log", {
      error: error instanceof Error ? error.message : String(error),
      collectionPath,
      action: logData.action,
    });
  }
}
