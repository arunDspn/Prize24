# Shop Follow & Loyalty System - Cloud Functions Implementation

## Summary

Successfully implemented a comprehensive shop follow and loyalty system with 6 cloud functions that enable:
- Vendor and staff-initiated follower management
- Daily check-in system with cumulative and consecutive streak tracking
- Multiplier bonus rewards for consecutive check-ins
- Automatic gift day detection
- Promotional offer management with FCM push notifications

## Implemented Cloud Functions

### 1. `followShopByVendor`
**Purpose**: Vendor scans user QR code to add them as a follower

**Input**:
```typescript
{
  userId: string;      // User to add as follower
  shopId: string;      // Shop ID
  fcmToken: string;    // User's FCM token for notifications
}
```

**Process**:
- Validates vendor owns the shop
- Creates bidirectional relationship (vendor & user sides)
- Initializes streak data (cumulativeStreak: 0, consecutiveDays: 0)
- Subscribes user to shop's FCM topic
- Increments follower/following counters

**Response**:
```typescript
{
  success: true,
  message: "User successfully added as follower",
  data: {
    shopId: string,
    followedAt: Timestamp,
    notificationEnabled: boolean
  }
}
```

---

### 2. `followShopByStaff`
**Purpose**: Active staff member scans user QR code to add them as a follower

**Input**: Same as `followShopByVendor`

**Additional Validations**:
- Staff must exist in `shopStaff` collection with status "active"
- Staff must belong to the specific shop

**Process**: Identical to vendor follow after staff validation

---

### 3. `unfollowShop`
**Purpose**: User unfollows a shop from their following list

**Input**:
```typescript
{
  shopId: string;
  fcmToken: string;
}
```

**Process**:
- Deletes both follower documents (vendor & user sides)
- Unsubscribes from FCM topic
- Decrements follower/following counters

**Response**:
```typescript
{
  success: true,
  message: "Successfully unfollowed shop",
  data: { shopId: string }
}
```

---

### 4. `removeFollower`
**Purpose**: Vendor removes a follower (spam/abuse cases)

**Input**:
```typescript
{
  shopId: string;
  userId: string;
  reason?: string;    // Optional removal reason
}
```

**Validations**:
- Vendor must own the shop
- User must be a follower

**Process**: Same as unfollow but vendor-initiated with audit logging

---

### 5. `checkInUser`
**Purpose**: Daily check-in with streak tracking, bonus rewards, and gift day detection

**Input**:
```typescript
{
  userId: string;     // From scanned QR code
  shopId: string;     // Scanner's shop
}
```

**Scanner Authorization**:
- Scanner must be shop owner OR active staff member
- Authorization validated via `shopStaff` collection

**Streak Logic**:
1. **Cumulative Streak**: Total check-ins (never decreases)
2. **Consecutive Days**: Current streak (resets if day missed)
3. **Multiplier Bonus**: 
   - If user checks in for consecutive `bonusIncrementDaysRequired` days
   - Increment by `bonusIncrementValue` instead of 1
4. **Gift Day Detection**:
   - If `associatedCampaignId` is not null
   - If `cumulativeStreak % giftDayCycle === 0`
   - If this is a new gift day (not already claimed)

**Business Rules**:
- Only one check-in per day (calendar day comparison)
- Consecutive streak continues only if checked in yesterday
- Gift day flagged but gift distribution handled separately

**Response**:
```typescript
{
  success: true,
  message: "Check-in successful! It's gift day!" | "Check-in successful",
  data: {
    cumulativeStreak: number,
    consecutiveDays: number,
    bonusApplied: boolean,
    isGiftDay: boolean,
    giftInfo?: {
      campaignId: string,
      campaignName: string,
      message: string
    }
  }
}
```

---

### 6. `addOfferToShop`
**Purpose**: Vendor adds promotional offer and notifies all followers

**Input**:
```typescript
{
  shopId: string;
  name: string;
  description: string;
  startDate: string;    // ISO date string
  endDate: string;      // ISO date string
}
```

**Validations**:
- Vendor must own the shop
- Shop must be active
- End date must be after start date

**Process**:
1. Creates offer document in `/shops/{shopId}/offers/{offerId}`
2. Sends FCM notification to topic `shopId`:
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
  success: true,
  message: "Offer added successfully",
  data: {
    offerId: string,
    name: string,
    description: string,
    startDate: string,
    endDate: string,
    status: "active" | "inactive",
    notificationsSent: number,
    createdAt: string
  }
}
```

---

## Database Structure

### Shop Document
**Path**: `/shops/{shopId}`

```typescript
{
  shopId: string;
  shopOwnerId: string;
  shopName: string;
  shopDescription: string;
  shopAddress: string;
  shopPhone: string;
  shopStatus: "active" | "inactive" | "deleted";
  
  // Streak & Gift Configuration
  associatedCampaignId: string | null;
  campaignName?: string;
  giftDayCycle: number | null;           // e.g., 7 = gift every 7 check-ins
  
  // Multiplier Bonus Rule
  bonusIncrementDaysRequired: number | null;  // e.g., 7 = bonus after 7 consecutive days
  bonusIncrementValue: number | null;         // e.g., 2 = add 2 instead of 1
  
  totalFollowers: number;
  createdAt: Timestamp;
  updatedAt: Timestamp;
}
```

### Shop Followers (Vendor Side)
**Path**: `/shops/{shopId}/followers/{userId}`

```typescript
{
  userId: string;
  userName: string;
  userProfilePic: string | null;
  notificationEnabled: boolean;
  
  // Streak Data
  cumulativeStreak: number;          // Total check-ins
  consecutiveDays: number;           // Current consecutive streak
  lastCheckInDate: Timestamp | null;
  lastGiftDayStreak: number | null;  // Last cumulative streak at gift
  lastBonusDate: Timestamp | null;   // Last bonus application
  
  followedAt: Timestamp;
  createdAt: Timestamp;
  updatedAt: Timestamp;
}
```

### User Following Shops (User Side)
**Path**: `/users/{userId}/followedShops/{shopId}`

```typescript
{
  shopId: string;
  shopName: string;
  shopDescription: string;
  shopAddress: string;
  shopPhone: string;
  notificationEnabled: boolean;
  
  // Read-only streak copy
  cumulativeStreak: number;
  consecutiveDays: number;
  lastCheckInDate: Timestamp | null;
  
  followedAt: Timestamp;
  updatedAt: Timestamp;
}
```

### Shop Offers
**Path**: `/shops/{shopId}/offers/{offerId}`

```typescript
{
  offerId: string;
  name: string;
  description: string;
  startDate: Timestamp;
  endDate: Timestamp;
  status: "active" | "expired" | "inactive";
  createdBy: string;
  createdAt: Timestamp;
  updatedAt: Timestamp;
}
```

---

## Error Codes

All functions use consistent error codes from `SHOP_FOLLOW_ERROR_CODES`:

- `UNAUTHORIZED` - User not authenticated
- `SHOP_NOT_FOUND` - Shop doesn't exist
- `SHOP_INACTIVE` - Shop is not active
- `ALREADY_FOLLOWING` - User already follows shop
- `NOT_FOLLOWING` - User doesn't follow shop
- `USER_NOT_FOUND` - User doesn't exist
- `STAFF_NOT_FOUND` - Staff member not found
- `STAFF_NOT_ACTIVE` - Staff member is not active
- `NOT_SHOP_OWNER` - User doesn't own shop
- `SCANNER_NOT_AUTHORIZED` - Scanner not authorized
- `ALREADY_CHECKED_IN_TODAY` - Already checked in today
- `OFFER_INVALID_DATES` - Invalid offer dates
- `INVALID_FCM_TOKEN` - Invalid FCM token format
- `TRANSACTION_FAILED` - Database transaction failed

---

## File Structure

```
functions/
├── src/
│   ├── types.ts                          # Updated with shop follow types
│   ├── index.ts                          # Exports all functions
│   └── shop_user_relationship/
│       ├── shopFollow.ts                 # Follow/unfollow functions
│       ├── shopCheckIn.ts                # Check-in and offer functions
│       ├── clubManagement.ts             # Existing club management
│       └── shop_user_relation.md         # System documentation
└── lib/                                  # Compiled JavaScript output
    └── shop_user_relationship/
        ├── shopFollow.js
        ├── shopCheckIn.js
        └── clubManagement.js
```

---

## Deployment

### Deploy All Functions
```bash
cd functions
npm run build
firebase deploy --only functions
```

### Deploy Specific Functions
```bash
firebase deploy --only functions:followShopByVendor
firebase deploy --only functions:followShopByStaff
firebase deploy --only functions:unfollowShop
firebase deploy --only functions:removeFollower
firebase deploy --only functions:checkInUser
firebase deploy --only functions:addOfferToShop
```

---

## Testing Checklist

### Follow Flow
- [ ] Vendor can add follower by scanning user QR
- [ ] Staff can add follower (only active staff)
- [ ] Follower documents created on both sides
- [ ] FCM topic subscription succeeds
- [ ] Counters increment correctly
- [ ] Cannot follow same shop twice

### Unfollow Flow
- [ ] User can unfollow shop
- [ ] Vendor can remove follower
- [ ] Documents deleted on both sides
- [ ] FCM topic unsubscription
- [ ] Counters decrement correctly

### Check-in Flow
- [ ] Only owner or active staff can check in users
- [ ] Only followers can be checked in
- [ ] Only one check-in per day
- [ ] Cumulative streak increments correctly
- [ ] Consecutive days tracks properly
- [ ] Consecutive resets when day missed
- [ ] Multiplier bonus applies correctly
- [ ] Gift day detected at correct intervals
- [ ] User copy updated in sync

### Offer Flow
- [ ] Only shop owner can add offers
- [ ] Date validation works
- [ ] FCM notification sent to all followers
- [ ] Offer document created correctly
- [ ] Notification count accurate

---

## Known Limitations

1. **Timezone Handling**: Currently uses system timezone for "day" calculation. Consider storing shop timezone in shop document for accurate day boundaries.

2. **FCM Token Management**: User's FCM token must be provided by client. If token expires, re-subscription needed.

3. **Gift Distribution**: `checkInUser` only flags gift day - actual gift distribution must be handled separately (e.g., trigger separate gift distribution function).

4. **Remove Follower FCM**: `removeFollower` cannot unsubscribe from FCM topic without user's token. Client-side cleanup recommended.

---

## Next Steps (Future Enhancements)

1. **Timezone Support**: Add `shopTimezone` field and use for accurate day boundaries
2. **Gift Auto-Distribution**: Trigger gift distribution when `isGiftDay: true`
3. **Offer Expiration**: Cloud scheduler to auto-expire offers
4. **Analytics**: Track check-in patterns, gift redemption rates
5. **Leaderboards**: Top followers by cumulative/consecutive streaks
6. **Notification Preferences**: Granular notification settings (offers, gifts, etc.)
7. **Batch Operations**: Bulk follower management for vendors

---

## Implementation Date
November 13, 2025

## Status
✅ All functions implemented and compiled successfully
✅ TypeScript types defined
✅ Error handling implemented
✅ Logging added for audit trails
✅ Ready for deployment and testing
