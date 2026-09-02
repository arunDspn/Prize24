
# Purpose: Shop Follow & Loyalty System

> **Note**: This system replaces the previous Club feature. Shops now directly manage follower streaks, gift distribution, and loyalty rewards.

## Overview
Users can follow shops to participate in a loyalty/streak system. When users follow a shop, they gain access to:
- **Cumulative check-in streak system** (with optional gift rewards)
- **Shop offers** (time-limited promotions)
- **FCM notifications** for new offers

## Core Features

### 1. Follow Shop (Vendor Scans User)
- **Who**: Vendor scans user QR code from shop detail page
- **Requirements**: userId, shopId, fcmToken
- **Process**:
  - Creates bidirectional relationship:
    - `/shops/{shopId}/followers/{userId}` - Vendor side with streak data
    - `/users/{userId}/followedShops/{shopId}` - User side with shop info
  - Subscribes user's FCM token to shop's FCM topic (topicId = shopId)
  - Initializes streak data with default values

### 2. Follow Shop (Staff Scans User)
- **Who**: Staff member scans user QR code
- **Requirements**: userId, shopId, fcmToken, staffId
- **Validations**:
  - Staff must be active (not revoked)
  - Staff must belong to the specific shop
  - User cannot already be following the shop
- **Process**: Same as vendor follow

### 3. Unfollow Shop (User)
- **Who**: User unfollows from their following list
- **Requirements**: userId, shopId, fcmToken
- **Process**:
  - Deletes both documents (vendor & user collections)
  - Unsubscribes from FCM topic
  - Decrements totalFollowers/totalFollowing counters

### 4. Remove Follower (Vendor)
- **Who**: Vendor removes a user (spam/abuse cases)
- **Requirements**: vendorId, shopId, userId, reason (optional)
- **Validations**: Vendor must own the shop
- **Process**: Same as unfollow but initiated by vendor

### 5. Check-in User (Vendor or Staff)
- **Who**: Vendor or Staff scans user QR code for check-in
- **Requirements**: userId (from QR code), shopId (scanner has this)
- **Frequency**: Once per day per shop (based on shop timezone)
- **Validations**:
  - Scanner must be authenticated (vendor or staff)
  - If scanner is vendor: must own the shop
  - If scanner is staff: must be active and belong to shop
  - User must be a follower of the shop
  - Only one check-in per day allowed
- **Streak Logic**:
  - **Cumulative System**: Total check-ins increment (never breaks)
  - **Consecutive Days Tracking**: Tracks current consecutive streak
  - **Multiplier Bonus**: If user checks in for consecutive `daysRequired` days, increment by `bonusIncrement` instead of 1
  - **Gift Day**: If `campaignId` is not null and current cumulative streak matches gift day cycle, flag as gift day
- **Response**: Returns updated streak info and gift day status

### 6. Add Offer to Shop
- **Who**: Vendor adds promotional offer
- **Requirements**: shopId, offer details (name, description, startDate, endDate)
- **Process**:
  - Creates document in `/shops/{shopId}/offers/{offerId}`
  - Sends FCM notification to all followers subscribed to shop topic
- **Notification**: Automatic FCM push to topic `shopId`

# Database Structure

## 1. Shop Document (Vendor Side)
**Path**: `/shops/{shopId}`

### Fields
```typescript
{
  shopId: string;                    // Document ID
  shopOwnerId: string;               // Vendor/owner user ID
  shopName: string;                      // Shop name
  shopDescription: string;               // Shop description
  shopAddress: string;                   // Physical address
  shopPhone: string;                     // Contact number
  shopStatus: "active" | "inactive" | "deleted";
  
  // Streak & Gift Configuration
  associatedCampaignId: string | null;         // Attached campaign (null = no gifts)
  campaignName?: string;             // Campaign name (if campaignId not null)
  giftDayCycle: number | null;       // Every N check-ins = gift day (e.g., 7)
  
  // Multiplier Bonus Rule (Consecutive streak reward)
  bonusIncrementDaysRequired: number | null;       // Consecutive days required for bonus (e.g., 7)
  bonusIncrementValue: number | null;     // Bonus increment instead of 1 (e.g., 2)
  
  // Counters
  totalFollowers: number;            // Total current followers
  
  // Metadata
  createdAt: Timestamp;
  updatedAt: Timestamp;
}
```

## 2. Shop Followers Subcollection (Vendor Side - Streak Data)
**Path**: `/shops/{shopId}/followers/{userId}`

### Fields
```typescript
{
  userId: string;                    // Document ID
  userName: string;                  // User display name
  userProfilePic: string | null;     // User avatar URL
  notificationEnabled: boolean;      // FCM subscription status
  
  // Streak Data
  cumulativeStreak: number;          // Total check-ins (never decreases)
  consecutiveDays: number;           // Current consecutive check-in streak
  lastCheckInDate: Timestamp | null; // Last check-in timestamp
  lastGiftDayStreak: number | null;  // Cumulative streak at last gift
  lastBonusDate: Timestamp | null;   // Last time bonus was applied
  
  // Timestamps
  followedAt: Timestamp;             // When user followed shop
  createdAt: Timestamp;
  updatedAt: Timestamp;
}
```

## 3. User Following Shops Subcollection (User Side)
**Path**: `/users/{userId}/followedShops/{shopId}`

### Fields
```typescript
{
  shopId: string;                    // Document ID
  shopName: string;                  // Shop name
  shopDescription: string;           // Shop description
  shopAddress: string;               // Shop address
  shopPhone: string;                 // Shop phone
  notificationEnabled: boolean;      // User preference for notifications
  
  // User's streak info (read-only copy for quick access)
  cumulativeStreak: number;
  consecutiveDays: number;
  lastCheckInDate: Timestamp | null;
  
  // Timestamps
  followedAt: Timestamp;
  updatedAt: Timestamp;
}
```

## 4. Shop Offers Subcollection
**Path**: `/shops/{shopId}/offers/{offerId}`

### Fields
```typescript
{
  offerId: string;                   // Document ID (auto-generated)
  name: string;                      // Offer title
  description: string;               // Offer details
  startDate: Timestamp;              // Offer start date
  endDate: Timestamp;                // Offer expiration date
  status: "active" | "expired" | "inactive";
  
  // Metadata
  createdBy: string;                 // Vendor userId
  createdAt: Timestamp;
  updatedAt: Timestamp;
}
```

## 5. User Document (Counters)
**Path**: `/users/{userId}`

### Relevant Fields
```typescript
{
  userId: string;
  userName: string;
  userAvatar?: string;
  totalFollowing: number;            // Total shops following
  // ... other user fields
}
```


# Cloud Functions Required

## Phase 1: Core Functions (Implement Now)

### 1. `followShopByVendor`
**Trigger**: Callable HTTPS function  
**Auth**: Required (Vendor)  
**Input**:
```typescript
{
  userId: string;        // User to follow
  shopId: string;        // Shop to follow
  fcmToken: string;      // User's FCM token
}
```
**Validations**:
- Vendor must own the shop
- Shop must be active
- User must exist and not already following
**Process**:
- Create follower documents (both sides)
- Subscribe FCM token to shop topic
- Initialize streak data
- Increment counters
**Response**:
```typescript
{
  success: boolean;
  message: string;
  data: {
    shopId: string;
    followedAt: Timestamp;
    notificationEnabled: boolean;
  }
}
```

### 2. `unfollowShop`
**Trigger**: Callable HTTPS function  
**Auth**: Required (User)  
**Input**:
```typescript
{
  shopId: string;
  fcmToken: string;
}
```
**Process**:
- Delete follower documents (both sides)
- Unsubscribe from FCM topic
- Decrement counters
**Response**: Success/error message

### 3. `removeFollower`
**Trigger**: Callable HTTPS function  
**Auth**: Required (Vendor)  
**Input**:
```typescript
{
  shopId: string;
  userId: string;
  reason?: string;        // Optional reason for removal
}
```
**Validations**:
- Vendor must own the shop
- User must be a follower
**Process**: Same as unfollow but vendor-initiated
**Audit**: Log removal with reason

### 4. `checkInUser`
**Trigger**: Callable HTTPS function  
**Auth**: Required (Vendor or Staff)  
**Input**:
```typescript
{
  userId: string;        // From scanned QR code
  shopId: string;        // Scanner knows their shop
}
```
**Validations**:
1. Get scanner ID from `request.auth.uid`
2. Verify scanner authorization:
   - Check if scanner owns the shop (`shops/{shopId}.shopOwnerId === scannerId`)
   - OR check if scanner is active staff (`shops/{shopId}/staff/{scannerId}.status === "active"`)
3. User must be follower of the shop
4. Only one check-in per day (check `lastCheckInDate` based on shop timezone)
**Process**:
1. Get current streak data
2. Calculate if eligible for check-in (not already checked in today)
3. Determine if consecutive streak continues (checked in yesterday)
4. Check if eligible for multiplier bonus
5. Update streak data:
   - Increment `cumulativeStreak` by 1 or `bonusIncrement`
   - Update `consecutiveDays`
   - Update `lastCheckInDate`
6. Check if it's a gift day:
   - If `campaignId` not null AND `cumulativeStreak % giftDayCycle === 0`
7. Update user's copy in `/users/{userId}/followedShops/{shopId}`
**Response**:
```typescript
{
  success: boolean;
  message: string;
  data: {
    cumulativeStreak: number;
    consecutiveDays: number;
    bonusApplied: boolean;
    isGiftDay: boolean;              // Flag if gift should be distributed
    giftInfo?: {                     // Only if isGiftDay = true
      campaignId: string;
      campaignName: string;
      message: string;               // e.g., "Congratulations! Gift day!"
    };
  }
}
```

### 5. `addOfferToShop`
**Trigger**: Callable HTTPS function  
**Auth**: Required (Vendor)  
**Input**:
```typescript
{
  shopId: string;
  name: string;
  description: string;
  startDate: string;     // ISO date string
  endDate: string;       // ISO date string
}
```
**Validations**:
- Vendor must own the shop
- Shop must be active
- End date must be after start date
**Process**:
1. Create offer document in `/shops/{shopId}/offers/{offerId}`
2. Send FCM notification to topic `shopId`:
   ```json
   {
     "notification": {
       "title": "New Offer at {shopName}!",
       "body": "{offerName} - {offerDescription}"
     },
     "data": {
       "type": "new_offer",
       "shopId": "{shopId}",
       "offerId": "{offerId}"
     }
   }
   ```
**Response**:
```typescript
{
  success: boolean;
  message: string;
  data: {
    offerId: string;
    notificationsSent: number;  // Count of subscribed users
  }
}
```

## Phase 2: Staff Functions (Implement Later)

### 6. `followShopByStaff`
Same as `followShopByVendor` but with staff validation:
- Verify staff is active in `/shops/{shopId}/staff/{staffId}`
- Verify staff status is "active"

## Additional Client-Side Operations (No Cloud Function Needed)

- **Toggle Notifications**: Update `notificationEnabled` field and subscribe/unsubscribe FCM
- **View Followers**: Query `/shops/{shopId}/followers` collection
- **View Offers**: Query `/shops/{shopId}/offers` collection
- **Configure Shop Settings**: Update shop document (streak rules, gift day cycle, etc.)
- **View Following Shops**: Query `/users/{userId}/followedShops` collection

## Edge Cases & Business Rules

1. **Check-in Once Per Day**: Use shop timezone to determine "day" boundaries
2. **Consecutive Streak**: Resets if user misses a day (but cumulative never decreases)
3. **Multiplier Bonus**: Only applies when user checks in on consecutive `daysRequired` day
4. **Gift Day with Null Campaign**: Return `isGiftDay: false` always
5. **FCM Failures**: Log error but don't fail the operation (notification is non-critical)
6. **Timezone Handling**: Store shop timezone in shop document for accurate "day" calculation



