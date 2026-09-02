# Audit Log Feature - Unified Activity Tracking

## Overview
Comprehensive audit logging system to track all vendor, staff, and user activities across campaigns and shop check-ins. Provides accountability, debugging capability, and business analytics.

## Collection Structure

### For Campaign Activities (Avail & Redeem)
```
campaigns/{campaignId}/activityLogs/{logId}
```

### For Shop Activities (Check-in & Follow)
```
shops/{shopId}/activityLogs/{logId}
```

**Rationale for Separate Collections:**
- Campaign logs are associated with campaign lifecycle (avail, redeem)
- Shop logs are associated with customer relationship (check-in, follow)
- Easier querying and data organization
- Better scalability and security rules
- **Dual Logging:** Gift avails triggered by check-ins are logged in BOTH collections for vendor visibility

---

## Common Fields (All Actions)

| Field | Type | Required | Description |
|-------|------|----------|-------------|
| `action` | string | ✓ | Action type identifier (see Action Types below) |
| `timestamp` | Timestamp | ✓ | Server timestamp when action occurred |
| `success` | boolean | ✓ | Whether the action completed successfully |
| `actorId` | string | ✓ | User ID who performed the action |
| `actorRole` | string | ✓ | Role: `owner`, `staff`, `shared_vendor`, `system`, `customer` |
| `functionName` | string | ✓ | Cloud function that generated the log |
| `errorCode` | string | ✗ | Error code if `success: false` |
| `errorMessage` | string | ✗ | Human-readable error message if `success: false` |
| `metadata` | object | ✗ | Additional context-specific data |

---

## Action Types & Specific Fields

### 1. Gift Avail Actions

#### `gift_avail_success`
**Collection:** `campaigns/{campaignId}/activityLogs`

| Field | Type | Required | Description |
|-------|------|----------|-------------|
| Common fields | - | ✓ | All common fields above |
| `customerId` | string | ✓ | User who received the gift |
| `giftId` | string | ✓ | Gift document ID |
| `giftName` | string | ✓ | Display name of the gift |
| `redemptionId` | string | ✓ | Unique redemption identifier |
| `isRedeemable` | boolean | ✓ | Whether gift needs redemption |
| `payloadId` | string | ✗ | Payload ID if non-redeemable gift |
| `shopId` | string | ✗ | Shop ID if scanned by staff |
| `luckFactor` | number | ✓ | Calculated luck percentage (0-1) |
| `randomNumber` | number | ✓ | Random number generated (0-1) |
| `remainingGifts` | number | ✓ | Remaining gifts after avail |
| `remainingParticipants` | number | ✓ | Remaining participants after avail |
| `availedViaStreak` | boolean | ✗ | If availed through streak bonus |
| `streakShopId` | string | ✗ | Shop ID for streak-based avail |

**Example:**
```json
{
  "action": "gift_avail_success",
  "timestamp": "2026-03-05T10:30:00Z",
  "success": true,
  "actorId": "vendor_123",
  "actorRole": "staff",
  "functionName": "scanToAvailPublicPrivateAutoCampaignByStaff",
  "customerId": "user_456",
  "giftId": "gift_789",
  "giftName": "Free Coffee",
  "redemptionId": "redemption_1234567890_abc123",
  "isRedeemable": true,
  "shopId": "shop_999",
  "luckFactor": 0.75,
  "randomNumber": 0.42,
  "remainingGifts": 24,
  "remainingParticipants": 50,
  "availedViaStreak": true,
  "streakShopId": "shop_999"
}
```

#### `gift_avail_failed`
**Collection:** `campaigns/{campaignId}/activityLogs`

| Field | Type | Required | Description |
|-------|------|----------|-------------|
| Common fields | - | ✓ | All common fields above |
| `customerId` | string | ✓ | User who attempted to avail |
| `giftId` | string | ✗ | Gift ID if identified before failure |
| `shopId` | string | ✗ | Shop ID if scanned by staff |
| `failureReason` | string | ✓ | Specific reason: `not_lucky`, `no_gifts_remaining`, `campaign_expired`, `already_participated`, etc. |
| `luckFactor` | number | ✗ | Calculated luck if failure was due to luck |
| `randomNumber` | number | ✗ | Random number if failure was due to luck |
| `remainingGifts` | number | ✗ | Remaining gifts at time of attempt |
| `remainingParticipants` | number | ✗ | Remaining participants at time of attempt |

**Example:**
```json
{
  "action": "gift_avail_failed",
  "timestamp": "2026-03-05T10:35:00Z",
  "success": false,
  "actorId": "user_456",
  "actorRole": "customer",
  "functionName": "scanAvailPublicPrivateAutoCampaign",
  "customerId": "user_456",
  "shopId": null,
  "failureReason": "not_lucky",
  "errorCode": "failed-precondition",
  "errorMessage": "Better luck next time!",
  "luckFactor": 0.25,
  "randomNumber": 0.78,
  "remainingGifts": 10,
  "remainingParticipants": 40
}
```

---

### 2. Gift Redemption Actions

#### `gift_redemption_success`
**Collection:** `campaigns/{campaignId}/activityLogs`

| Field | Type | Required | Description |
|-------|------|----------|-------------|
| Common fields | - | ✓ | All common fields above |
| `customerId` | string | ✓ | User who owns the gift |
| `userGiftId` | string | ✓ | User gift document ID |
| `giftId` | string | ✗ | Original gift template ID |
| `giftName` | string | ✗ | Display name of gift |
| `shopId` | string | ✗ | Shop where redemption occurred (if staff) |
| `redemptionMethod` | string | ✓ | `owner_scan`, `shared_vendor_scan`, `staff_scan` |

**Example:**
```json
{
  "action": "gift_redemption_success",
  "timestamp": "2026-03-05T14:20:00Z",
  "success": true,
  "actorId": "staff_789",
  "actorRole": "staff",
  "functionName": "scanToRedeemByStaff",
  "customerId": "user_456",
  "userGiftId": "user_gift_abc123",
  "giftId": "gift_789",
  "giftName": "Free Coffee",
  "shopId": "shop_999",
  "redemptionMethod": "staff_scan"
}
```

#### `gift_redemption_failed`
**Collection:** `campaigns/{campaignId}/activityLogs`

| Field | Type | Required | Description |
|-------|------|----------|-------------|
| Common fields | - | ✓ | All common fields above |
| `customerId` | string | ✗ | User who owns the gift (if identified) |
| `userGiftId` | string | ✓ | User gift document ID |
| `shopId` | string | ✗ | Shop where redemption was attempted |
| `failureReason` | string | ✓ | `already_redeemed`, `not_found`, `unauthorized`, `shop_not_supported`, etc. |

**Example:**
```json
{
  "action": "gift_redemption_failed",
  "timestamp": "2026-03-05T14:25:00Z",
  "success": false,
  "actorId": "staff_789",
  "actorRole": "staff",
  "functionName": "scanToRedeemByStaff",
  "customerId": "user_456",
  "userGiftId": "user_gift_abc123",
  "shopId": "shop_999",
  "failureReason": "already_redeemed",
  "errorCode": "already-exists",
  "errorMessage": "Gift has already been redeemed"
}
```

---

### 3. Check-in Actions

#### `check_in_success`
**Collection:** `shops/{shopId}/activityLogs`

| Field | Type | Required | Description |
|-------|------|----------|-------------|
| Common fields | - | ✓ | All common fields above |
| `customerId` | string | ✓ | User who checked in |
| `customerName` | string | ✗ | Display name of customer |
| `cumulativeStreak` | number | ✓ | Total check-ins after this action |
| `consecutiveDays` | number | ✓ | Consecutive days after this action |
| `bonusApplied` | boolean | ✓ | Whether streak bonus was applied |
| `bonusValue` | number | ✗ | Bonus increment value if applied |
| `isGiftDay` | boolean | ✓ | Whether this check-in triggers a gift |
| `campaignId` | string | ✗ | Associated campaign ID if gift day |
| `campaignName` | string | ✗ | Campaign name if gift day |
| `wasAutoFollowed` | boolean | ✓ | If user was auto-followed during check-in |
| `previousStreak` | number | ✗ | Streak before this check-in |

**Example (Gift Day):**
```json
{
  "action": "check_in_success",
  "timestamp": "2026-03-05T09:15:00Z",
  "success": true,
  "actorId": "vendor_123",
  "actorRole": "owner",
  "functionName": "checkInUser",
  "customerId": "user_456",
  "customerName": "John Doe",
  "cumulativeStreak": 15,
  "consecutiveDays": 5,
  "bonusApplied": true,
  "bonusValue": 2,
  "isGiftDay": true,
  "campaignId": "campaign_xyz",
  "campaignName": "Loyalty Rewards",
  "wasAutoFollowed": false,
  "previousStreak": 13
}
```

**Note:** When `isGiftDay: true`, a separate `gift_avail_triggered` log entry is also created to track the gift avail attempt outcome.

#### `check_in_failed`
**Collection:** `shops/{shopId}/activityLogs`

| Field | Type | Required | Description |
|-------|------|----------|-------------|
| Common fields | - | ✓ | All common fields above |
| `customerId` | string | ✓ | User who attempted check-in |
| `failureReason` | string | ✓ | `already_checked_in_today`, `unauthorized`, `user_not_found`, `shop_inactive`, etc. |
| `currentStreak` | number | ✗ | Current streak at time of failure |

**Example:**
```json
{
  "action": "check_in_failed",
  "timestamp": "2026-03-05T20:45:00Z",
  "success": false,
  "actorId": "vendor_123",
  "actorRole": "owner",
  "functionName": "checkInUser",
  "customerId": "user_456",
  "failureReason": "already_checked_in_today",
  "errorCode": "already-exists",
  "errorMessage": "User has already checked in today",
  "currentStreak": 15
}
```

---

### 4. Gift Avail Triggered by Check-in

#### `gift_avail_triggered`
**Collection:** `shops/{shopId}/activityLogs`

**Purpose:** Logged in shop collection when a check-in triggers a gift avail on a gift day. This provides vendors visibility into gift avail outcomes without querying campaign logs.

| Field | Type | Required | Description |
|-------|------|----------|-------------|
| Common fields | - | ✓ | All common fields above |
| `customerId` | string | ✓ | User who received/attempted the gift |
| `customerName` | string | ✗ | Display name of customer |
| `campaignId` | string | ✓ | Associated campaign ID |
| `campaignName` | string | ✓ | Campaign display name |
| `giftId` | string | ✗ | Gift ID (if successful) |
| `giftName` | string | ✗ | Gift display name (if successful) |
| `redemptionId` | string | ✗ | Redemption ID (if successful) |
| `availStatus` | string | ✓ | `success` or `failed` |
| `triggeredByStreak` | boolean | ✓ | Always true for streak-based avails |
| `streakValue` | number | ✓ | Cumulative streak that triggered the gift |
| `giftCycleDay` | number | ✓ | The cycle day requirement |
| `failureReason` | string | ✗ | If failed: `no_gifts_remaining`, `campaign_expired`, etc. |
| `relatedCampaignLogId` | string | ✗ | Optional reference to campaign log entry |

**Success Example:**
```json
{
  "action": "gift_avail_triggered",
  "timestamp": "2026-03-05T09:15:00Z",
  "success": true,
  "actorId": "vendor_123",
  "actorRole": "owner",
  "functionName": "checkInUser",
  "customerId": "user_456",
  "customerName": "John Doe",
  "campaignId": "campaign_xyz",
  "campaignName": "Loyalty Rewards",
  "giftId": "gift_789",
  "giftName": "Free Coffee",
  "redemptionId": "redemption_1234567890_abc123",
  "availStatus": "success",
  "triggeredByStreak": true,
  "streakValue": 15,
  "giftCycleDay": 5
}
```

**Failure Example:**
```json
{
  "action": "gift_avail_triggered",
  "timestamp": "2026-03-05T09:15:00Z",
  "success": false,
  "actorId": "vendor_123",
  "actorRole": "owner",
  "functionName": "checkInUser",
  "customerId": "user_456",
  "customerName": "John Doe",
  "campaignId": "campaign_xyz",
  "campaignName": "Loyalty Rewards",
  "availStatus": "failed",
  "triggeredByStreak": true,
  "streakValue": 15,
  "giftCycleDay": 5,
  "failureReason": "no_gifts_remaining",
  "errorCode": "resource-exhausted",
  "errorMessage": "No more gifts available in this campaign"
}
```

---

### 5. Follower Management Actions

#### `follower_added`
**Collection:** `shops/{shopId}/activityLogs`

| Field | Type | Required | Description |
|-------|------|----------|-------------|
| Common fields | - | ✓ | All common fields above |
| `customerId` | string | ✓ | User who was added as follower |
| `customerName` | string | ✗ | Display name of customer |
| `addedMethod` | string | ✓ | `auto_check_in`, `manual_follow`, `staff_add`, `qr_scan` |
| `initialStreak` | number | ✓ | Initial cumulative streak value |
| `initialConsecutiveDays` | number | ✓ | Initial consecutive days value |
| `notificationEnabled` | boolean | ✓ | Whether notifications are enabled |

**Example:**
```json
{
  "action": "follower_added",
  "timestamp": "2026-03-05T09:15:00Z",
  "success": true,
  "actorId": "system",
  "actorRole": "system",
  "functionName": "checkInUser",
  "customerId": "user_456",
  "customerName": "John Doe",
  "addedMethod": "auto_check_in",
  "initialStreak": 1,
  "initialConsecutiveDays": 1,
  "notificationEnabled": true
}
```

#### `follower_removed`
**Collection:** `shops/{shopId}/activityLogs`

| Field | Type | Required | Description |
|-------|------|----------|-------------|
| Common fields | - | ✓ | All common fields above |
| `customerId` | string | ✓ | User who was removed |
| `removedMethod` | string | ✓ | `user_unfollow`, `vendor_remove`, `account_deletion` |
| `finalStreak` | number | ✗ | Final streak before removal |

---

## Implementation Guidelines

### 1. Helper Function: Create Audit Log

```typescript
interface BaseAuditLog {
  action: string;
  timestamp: FieldValue.serverTimestamp();
  success: boolean;
  actorId: string;
  actorRole: 'owner' | 'staff' | 'shared_vendor' | 'system' | 'customer';
  functionName: string;
  errorCode?: string;
  errorMessage?: string;
  metadata?: Record<string, any>;
}

async function createActivityLog(
  collectionPath: string, // 'campaigns/{id}/activityLogs' or 'shops/{id}/activityLogs'
  logData: BaseAuditLog & Record<string, any>
): Promise<void> {
  try {
    const logRef = db.collection(collectionPath).doc();
    await logRef.set({
      ...logData,
      timestamp: FieldValue.serverTimestamp(),
      logId: logRef.id,
    });
    logger.info(`Activity log created: ${logData.action}`, { logId: logRef.id });
  } catch (error) {
    logger.error('Failed to create activity log', { error, logData });
    // Don't throw - logging failure shouldn't break main operation
  }
}
```

### 2. Usage in Functions

#### In Avail Function (scanCampaign.ts)
```typescript
// On Success
await createActivityLog(`campaigns/${campaignId}/activityLogs`, {
  action: 'gift_avail_success',
  success: true,
  actorId: userId,
  actorRole: 'customer', // or 'staff' if scanned by staff
  functionName: 'scanAvailPublicPrivateAutoCampaign',
  customerId: userId,
  giftId: gift.id,
  giftName: gift.name,
  redemptionId,
  isRedeemable: gift.isRedeemable,
  payloadId,
  shopId: shopId || null,
  luckFactor,
  randomNumber,
  remainingGifts: campaign.remainingGifts - 1,
  remainingParticipants: campaign.remainingParticipants - 1,
  availedViaStreak,
  streakShopId,
});

// On Failure (Not Lucky)
await createActivityLog(`campaigns/${campaignId}/activityLogs`, {
  action: 'gift_avail_failed',
  success: false,
  actorId: userId,
  actorRole: 'customer',
  functionName: 'scanAvailPublicPrivateAutoCampaign',
  customerId: userId,
  failureReason: 'not_lucky',
  errorCode: 'failed-precondition',
  errorMessage: 'Better luck next time!',
  luckFactor,
  randomNumber,
  remainingGifts: campaign.remainingGifts,
  remainingParticipants: campaign.remainingParticipants,
});
```

#### In Redeem Function (scanToRedeem.ts)
```typescript
// Replace existing createAuditLog calls
await createActivityLog(`campaigns/${campaignId}/activityLogs`, {
  action: 'gift_redemption_success',
  success: true,
  actorId: userId,
  actorRole: 'staff',
  functionName: 'scanToRedeemByStaff',
  customerId: customerId,
  userGiftId: userGiftId,
  giftId: giftData?.giftId,
  giftName: giftData?.giftName,
  shopId: shopId,
  redemptionMethod: 'staff_scan',
});
```

#### In Check-in Function (shopCheckIn.ts)
```typescript
// 1. Log Check-in Success
await createActivityLog(`shops/${shopId}/activityLogs`, {
  action: 'check_in_success',
  success: true,
  actorId: scannerId,
  actorRole: scannerType,
  functionName: 'checkInUser',
  customerId: userId,
  customerName: userData?.userName,
  cumulativeStreak: newCumulativeStreak,
  consecutiveDays: newConsecutiveDays,
  bonusApplied,
  bonusValue: bonusApplied ? bonusIncrementValue : null,
  isGiftDay,
  campaignId: isGiftDay ? associatedCampaignId : null,
  campaignName: isGiftDay ? campaignName : null,
  wasAutoFollowed,
  previousStreak: currentCumulativeStreak,
});

// 2. If Gift Day - Attempt Gift Avail and Log in BOTH Collections
if (isGiftDay && associatedCampaignId) {
  try {
    // Call the gift avail function
    const availResult = await scanAvailPublicPrivateAutoCampaign({
      userId,
      campaignId: associatedCampaignId,
      availedViaStreak: true,
      streakShopID: shopId,
    });

    // Log in Campaign Collection (detailed)
    await createActivityLog(`campaigns/${associatedCampaignId}/activityLogs`, {
      action: 'gift_avail_success',
      success: true,
      actorId: userId,
      actorRole: 'customer',
      functionName: 'scanAvailPublicPrivateAutoCampaign',
      customerId: userId,
      giftId: availResult.data.giftId,
      giftName: availResult.data.giftName,
      redemptionId: availResult.data.redemptionId,
      isRedeemable: availResult.data.isRedeemable,
      shopId: shopId,
      availedViaStreak: true,
      streakShopId: shopId,
      // ... other avail-specific fields
    });

    // Log in Shop Collection (summary for vendor)
    await createActivityLog(`shops/${shopId}/activityLogs`, {
      action: 'gift_avail_triggered',
      success: true,
      actorId: scannerId,
      actorRole: scannerType,
      functionName: 'checkInUser',
      customerId: userId,
      customerName: userData?.userName,
      campaignId: associatedCampaignId,
      campaignName: campaignName,
      giftId: availResult.data.giftId,
      giftName: availResult.data.giftName,
      redemptionId: availResult.data.redemptionId,
      availStatus: 'success',
      triggeredByStreak: true,
      streakValue: newCumulativeStreak,
      giftCycleDay: giftCycleDay,
    });
  } catch (error) {
    // Log failure in both collections
    const errorCode = error instanceof HttpsError ? error.code : 'unknown';
    const errorMessage = error instanceof Error ? error.message : String(error);

    // Log in Campaign Collection
    await createActivityLog(`campaigns/${associatedCampaignId}/activityLogs`, {
      action: 'gift_avail_failed',
      success: false,
      actorId: userId,
      actorRole: 'customer',
      functionName: 'scanAvailPublicPrivateAutoCampaign',
      customerId: userId,
      shopId: shopId,
      failureReason: errorCode,
      errorCode,
      errorMessage,
      availedViaStreak: true,
      streakShopId: shopId,
    });

    // Log in Shop Collection (vendor needs to see this)
    await createActivityLog(`shops/${shopId}/activityLogs`, {
      action: 'gift_avail_triggered',
      success: false,
      actorId: scannerId,
      actorRole: scannerType,
      functionName: 'checkInUser',
      customerId: userId,
      customerName: userData?.userName,
      campaignId: associatedCampaignId,
      campaignName: campaignName,
      availStatus: 'failed',
      triggeredByStreak: true,
      streakValue: newCumulativeStreak,
      giftCycleDay: giftCycleDay,
      failureReason: errorCode,
      errorCode,
      errorMessage,
    });
  }
}

// 3. When Auto-Follow Occurs
await createActivityLog(`shops/${shopId}/activityLogs`, {
  action: 'follower_added',
  success: true,
  actorId: 'system',
  actorRole: 'system',
  functionName: 'checkInUser',
  customerId: userId,
  customerName: userData?.userName,
  addedMethod: 'auto_check_in',
  initialStreak: 1,
  initialConsecutiveDays: 1,
  notificationEnabled: true,
});
```

### 3. Error Handling Best Practices

1. **Always log in try-catch blocks**
2. **Log before throwing errors** (so we capture the failure)
3. **Don't let logging failures break main operations**
4. **Include enough context for debugging**

```typescript
try {
  // Main operation
  await someOperation();
  
  // Log success
  await createActivityLog(...);
} catch (error) {
  // Log failure BEFORE re-throwing
  await createActivityLog(`collection/path/activityLogs`, {
    action: 'operation_failed',
    success: false,
    actorId: userId,
    actorRole: role,
    functionName: 'functionName',
    errorCode: error instanceof HttpsError ? error.code : 'unknown',
    errorMessage: error instanceof Error ? error.message : String(error),
    // ... other relevant fields
  });
  
  // Then re-throw
  throw error;
}
```

---

## Query Examples

### Get all successful gift avails for a campaign
```typescript
const logs = await db
  .collection('campaigns').doc(campaignId)
  .collection('activityLogs')
  .where('action', '==', 'gift_avail_success')
  .where('success', '==', true)
  .orderBy('timestamp', 'desc')
  .limit(100)
  .get();
```

### Get all failed check-ins for a shop
```typescript
const logs = await db
  .collection('shops').doc(shopId)
  .collection('activityLogs')
  .where('action', '==', 'check_in_failed')
  .where('success', '==', false)
  .orderBy('timestamp', 'desc')
  .get();
```

### Get all actions by a specific staff member
```typescript
const logs = await db
  .collection('shops').doc(shopId)
  .collection('activityLogs')
  .where('actorId', '==', staffId)
  .where('actorRole', '==', 'staff')
  .orderBy('timestamp', 'desc')
  .get();
```

### Get customer's interaction history with a shop
```typescript
const logs = await db
  .collection('shops').doc(shopId)
  .collection('activityLogs')
  .where('customerId', '==', userId)
  .orderBy('timestamp', 'desc')
  .get();

// This returns check_in_success, gift_avail_triggered, follower_added, etc.
// Complete customer journey at this shop!
```

### Get all gift avails triggered by check-ins at a shop
```typescript
const giftAvails = await db
  .collection('shops').doc(shopId)
  .collection('activityLogs')
  .where('action', '==', 'gift_avail_triggered')
  .where('availStatus', '==', 'success')
  .orderBy('timestamp', 'desc')
  .get();
```

### Get gift day check-ins with their avail outcomes
```typescript
// First get gift day check-ins
const checkIns = await db
  .collection('shops').doc(shopId)
  .collection('activityLogs')
  .where('action', '==', 'check_in_success')
  .where('isGiftDay', '==', true)
  .orderBy('timestamp', 'desc')
  .get();

// Then get corresponding avail attempts (same timestamp range)
const avails = await db
  .collection('shops').doc(shopId)
  .collection('activityLogs')
  .where('action', '==', 'gift_avail_triggered')
  .orderBy('timestamp', 'desc')
  .get();

// Match by customerId and timestamp proximity
```

---

## Dual Logging Strategy for Gift Day Check-ins

### The Challenge
When a customer checks in on a gift day (e.g., 5th, 10th, 15th visit), the system:
1. Records the check-in
2. Triggers an automatic gift avail from the associated campaign

Without dual logging, vendors would need to query both shop AND campaign collections to see the complete story.

### The Solution
We log gift avail attempts in **BOTH** collections:

#### Campaign Collection: Detailed Analytics
```
campaigns/{campaignId}/activityLogs/{logId}
```
- Full gift avail details (luck factor, payload, etc.)
- Used for campaign performance analytics
- Includes ALL avails (direct scans + streak-triggered)

#### Shop Collection: Vendor Dashboard
```
shops/{shopId}/activityLogs/{logId}
```
- Summary of gift avail triggered by check-in
- Customer-centric view for vendors
- Shows: Was it successful? What gift? Any errors?

### Benefits
✅ **Single Query for Vendors:** Shop owners see everything in one place  
✅ **Complete Customer Timeline:** Check-in → Gift avail → Gift redeem  
✅ **No Cross-Collection Joins:** Each collection is self-sufficient  
✅ **Debugging Made Easy:** Vendors can troubleshoot gift issues  
✅ **Minimal Overhead:** Only summary data is duplicated  

### Example Timeline in Shop Logs
```
09:00 - follower_added (auto via check-in)
09:00 - check_in_success (streak: 1, isGiftDay: false)
09:01 - check_in_success (streak: 2, isGiftDay: false)
09:02 - check_in_success (streak: 3, isGiftDay: false)
09:03 - check_in_success (streak: 4, isGiftDay: false)
09:04 - check_in_success (streak: 5, isGiftDay: true)
09:04 - gift_avail_triggered (success, giftName: "Free Coffee")
14:30 - (corresponding redemption logged when customer redeems)
```

### Vendor Dashboard Use Cases

**"Did this customer get their gift today?"**
```typescript
const todayLogs = await db
  .collection('shops').doc(shopId)
  .collection('activityLogs')
  .where('customerId', '==', userId)
  .where('timestamp', '>=', startOfDay)
  .orderBy('timestamp', 'desc')
  .get();

// Shows: check_in_success + gift_avail_triggered
```

**"How many gifts were successfully triggered this week?"**
```typescript
const weeklyGifts = await db
  .collection('shops').doc(shopId)
  .collection('activityLogs')
  .where('action', '==', 'gift_avail_triggered')
  .where('availStatus', '==', 'success')
  .where('timestamp', '>=', startOfWeek)
  .get();

console.log(`${weeklyGifts.size} gifts availed this week!`);
```

**"Show me all failed gift attempts (for support)"**
```typescript
const failedGifts = await db
  .collection('shops').doc(shopId)
  .collection('activityLogs')
  .where('action', '==', 'gift_avail_triggered')
  .where('availStatus', '==', 'failed')
  .orderBy('timestamp', 'desc')
  .limit(50)
  .get();

// Shows: errorCode, errorMessage, failure reasons
```

---

## Security Rules

```javascript
// Firestore Security Rules
match /campaigns/{campaignId}/activityLogs/{logId} {
  // Only authenticated users can read
  allow read: if request.auth != null;
  
  // Only functions can write (via Admin SDK)
  allow write: if false;
}

match /shops/{shopId}/activityLogs/{logId} {
  // Shop owner and staff can read
  allow read: if request.auth != null && (
    get(/databases/$(database)/documents/shops/$(shopId)).data.shopOwnerId == request.auth.uid ||
    request.auth.uid in get(/databases/$(database)/documents/shops/$(shopId)).data.staffIds
  );
  
  // Only functions can write (via Admin SDK)
  allow write: if false;
}
```

---

## Analytics & Reporting

### Key Metrics to Track

1. **Campaign Performance** (from `campaigns/{id}/activityLogs`)
   - Total avail attempts vs successes
   - Average luck factor
   - Peak avail times
   - Gift distribution per actor role
   - Streak-triggered vs direct scan avails

2. **Shop Engagement** (from `shops/{id}/activityLogs`)
   - Daily check-in rate
   - Streak distribution
   - Auto-follow conversion rate
   - Staff activity levels
   - Gift day conversion rate (check-in → successful avail)
   - Gift avail failure patterns

3. **Error Patterns**
   - Most common failure reasons
   - Error rate by function
   - Time-based error patterns

### Dashboard Queries

Use Firebase Extensions or custom Cloud Functions to aggregate:
- Daily/weekly/monthly action counts
- Success rates by action type
- Actor performance metrics
- Customer engagement trends

---

## Migration Plan

### Phase 1: Add New Logging (Parallel)
1. Create helper function `createActivityLog()`
2. Add new logging calls alongside existing logs
3. Test in development environment

### Phase 2: Update Existing Functions
1. Update scanCampaign.ts functions
2. Update scanToRedeem.ts functions  
3. Update shopCheckIn.ts functions

### Phase 3: Deprecate Old Logs
1. Keep old `redemptionLogs` collection for 90 days
2. Add migration script to copy old logs to new format
3. Remove old logging code after verification

### Phase 4: Enable Analytics
1. Deploy dashboard queries
2. Set up monitoring alerts
3. Create vendor-facing analytics views

---

## Best Practices

1. ✅ **Always await log creation** even though it shouldn't block operations
2. ✅ **Log both success and failure** for complete audit trail
3. ✅ **Include customer ID** for all customer-facing actions
4. ✅ **Use consistent action names** (snake_case, descriptive)
5. ✅ **Add relevant metadata** but don't overload with unnecessary data
6. ✅ **Use server timestamps** for accurate timing
7. ✅ **Don't throw errors** in logging functions
8. ✅ **Test log queries** to ensure they're indexed properly
9. ✅ **Dual log gift avails on gift days** - summary in shop logs, details in campaign logs
10. ✅ **Keep shop logs vendor-focused** - everything a vendor needs in one place
11. ✅ **Log immediately after events** - don't batch gift day avail logs

---

## Future Enhancements

1. **Real-time Monitoring Dashboard**
   - Live activity feed for vendors
   - Alert system for unusual patterns

2. **Advanced Analytics**
   - Customer lifetime value tracking
   - Predictive gift inventory management
   - Staff performance leaderboards

3. **Audit Report Generation**
   - PDF export for compliance
   - Custom date range reports
   - Multi-shop aggregate reports

4. **Data Retention Policies**
   - Auto-archive logs older than 1 year
   - Comply with GDPR data deletion requests

---

## Open Questions / Discussion Points

1. **Collection Naming:** `activityLogs` vs `vendorLogs` vs `auditLogs`?
   - Recommendation: `activityLogs` (more descriptive of content)

2. **Data Retention:** How long should logs be kept?
   - Recommendation: 1 year active, then archive to Cloud Storage

3. **Access Control:** Who can view logs?
   - Owners: Full access to their shop/campaign logs
   - Staff: Read-only access to shop logs
   - Customers: Should they see their own activity history?

4. **Performance:** Should we implement batched writes for high-volume scenarios?
   - Recommendation: Monitor first, optimize if needed

5. **Notification on Errors:** Should vendors get notified of repeated failures?
   - Recommendation: Yes, implement alert thresholds
