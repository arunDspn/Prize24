# Shop Follow System - Quick API Reference

## Authentication
All functions require Firebase Authentication. Pass the auth token in the request header.

## Base URL
```
https://<region>-<project-id>.cloudfunctions.net/
```

---

## 1. Follow Shop (Vendor)
**Function**: `followShopByVendor`  
**Caller**: Vendor (Shop Owner)

```typescript
// Request
{
  userId: "user123",           // User to add as follower
  shopId: "shop456",          // Your shop ID
  fcmToken: "fcm_token_xyz"   // User's FCM token
}

// Success Response
{
  success: true,
  message: "User successfully added as follower",
  data: {
    shopId: "shop456",
    followedAt: "2025-11-13T10:30:00Z",
    notificationEnabled: true
  }
}

// Error Response
{
  success: false,
  error: "ALREADY_FOLLOWING",
  message: "User is already following this shop"
}
```

---

## 2. Follow Shop (Staff)
**Function**: `followShopByStaff`  
**Caller**: Active Staff Member

```typescript
// Request (same as vendor)
{
  userId: "user123",
  shopId: "shop456",
  fcmToken: "fcm_token_xyz"
}

// Response: Same as followShopByVendor
```

---

## 3. Unfollow Shop
**Function**: `unfollowShop`  
**Caller**: User

```typescript
// Request
{
  shopId: "shop456",
  fcmToken: "fcm_token_xyz"
}

// Success Response
{
  success: true,
  message: "Successfully unfollowed shop",
  data: {
    shopId: "shop456"
  }
}
```

---

## 4. Remove Follower
**Function**: `removeFollower`  
**Caller**: Vendor (Shop Owner)

```typescript
// Request
{
  shopId: "shop456",
  userId: "user123",
  reason: "Spam behavior"  // Optional
}

// Success Response
{
  success: true,
  message: "Follower removed successfully",
  data: {
    shopId: "shop456",
    userId: "user123",
    removedAt: "2025-11-13T10:30:00Z"
  }
}
```

---

## 5. Check In User
**Function**: `checkInUser`  
**Caller**: Vendor or Active Staff

```typescript
// Request
{
  userId: "user123",     // From scanned QR code
  shopId: "shop456"      // Your shop ID
}

// Success Response (Regular Check-in)
{
  success: true,
  message: "Check-in successful",
  data: {
    cumulativeStreak: 15,      // Total check-ins
    consecutiveDays: 7,        // Current consecutive days
    bonusApplied: false,
    isGiftDay: false
  }
}

// Success Response (Gift Day)
{
  success: true,
  message: "Check-in successful! It's gift day!",
  data: {
    cumulativeStreak: 21,
    consecutiveDays: 21,
    bonusApplied: false,
    isGiftDay: true,
    giftInfo: {
      campaignId: "campaign789",
      campaignName: "Birthday Special",
      message: "Congratulations! You've reached 21 check-ins. It's gift day!"
    }
  }
}

// Success Response (Bonus Applied)
{
  success: true,
  message: "Check-in successful",
  data: {
    cumulativeStreak: 16,      // Increased by 2 instead of 1
    consecutiveDays: 7,
    bonusApplied: true,        // Multiplier bonus triggered
    isGiftDay: false
  }
}

// Error Response
{
  success: false,
  error: "ALREADY_CHECKED_IN_TODAY",
  message: "User has already checked in today"
}
```

---

## 6. Add Offer
**Function**: `addOfferToShop`  
**Caller**: Vendor (Shop Owner)

```typescript
// Request
{
  shopId: "shop456",
  name: "Buy 1 Get 1 Free",
  description: "All coffee drinks - valid until end of month",
  startDate: "2025-11-13T00:00:00Z",  // ISO 8601 format
  endDate: "2025-11-30T23:59:59Z"
}

// Success Response
{
  success: true,
  message: "Offer added successfully",
  data: {
    offerId: "offer123",
    name: "Buy 1 Get 1 Free",
    description: "All coffee drinks - valid until end of month",
    startDate: "2025-11-13T00:00:00Z",
    endDate: "2025-11-30T23:59:59Z",
    status: "active",
    notificationsSent: 45,    // Number of followers notified
    createdAt: "2025-11-13T10:30:00Z"
  }
}
```

---

## Error Codes Reference

| Code | Description |
|------|-------------|
| `UNAUTHORIZED` | User not authenticated |
| `SHOP_NOT_FOUND` | Shop doesn't exist |
| `SHOP_INACTIVE` | Shop is not active |
| `ALREADY_FOLLOWING` | User already follows this shop |
| `NOT_FOLLOWING` | User doesn't follow this shop |
| `USER_NOT_FOUND` | User doesn't exist |
| `STAFF_NOT_FOUND` | Staff member not found |
| `STAFF_NOT_ACTIVE` | Staff member is not active |
| `NOT_SHOP_OWNER` | Caller doesn't own this shop |
| `SCANNER_NOT_AUTHORIZED` | Not authorized to check in users |
| `ALREADY_CHECKED_IN_TODAY` | Already checked in today |
| `OFFER_INVALID_DATES` | End date must be after start date |
| `INVALID_FCM_TOKEN` | Invalid FCM token format |
| `TRANSACTION_FAILED` | Database operation failed |

---

## Firebase Client Example

```javascript
import { getFunctions, httpsCallable } from 'firebase/functions';

const functions = getFunctions();

// Follow shop as vendor
const followShopByVendor = httpsCallable(functions, 'followShopByVendor');
const result = await followShopByVendor({
  userId: scannedUserId,
  shopId: myShopId,
  fcmToken: userFcmToken
});

// Check in user
const checkInUser = httpsCallable(functions, 'checkInUser');
const checkInResult = await checkInUser({
  userId: scannedUserId,
  shopId: myShopId
});

if (checkInResult.data.isGiftDay) {
  // Show gift celebration UI
  console.log('Gift day!', checkInResult.data.giftInfo);
}

// Add offer
const addOfferToShop = httpsCallable(functions, 'addOfferToShop');
await addOfferToShop({
  shopId: myShopId,
  name: "Special Discount",
  description: "20% off all items",
  startDate: new Date().toISOString(),
  endDate: new Date(Date.now() + 7*24*60*60*1000).toISOString()
});
```

---

## Testing with cURL

```bash
# Get auth token first
TOKEN="your_firebase_auth_token"
PROJECT_ID="your_project_id"
REGION="us-central1"

# Check in user
curl -X POST \
  "https://${REGION}-${PROJECT_ID}.cloudfunctions.net/checkInUser" \
  -H "Authorization: Bearer ${TOKEN}" \
  -H "Content-Type: application/json" \
  -d '{
    "data": {
      "userId": "user123",
      "shopId": "shop456"
    }
  }'
```

---

## FCM Notification Format (Offers)

When a shop adds an offer, all followers receive:

```json
{
  "notification": {
    "title": "New Offer at Coffee Shop!",
    "body": "Buy 1 Get 1 Free - All coffee drinks"
  },
  "data": {
    "type": "new_offer",
    "shopId": "shop456",
    "offerId": "offer123",
    "offerName": "Buy 1 Get 1 Free",
    "offerDescription": "All coffee drinks"
  }
}
```

Client should handle the `new_offer` type to navigate user to offer details.

---

## Client-Side Operations (No Cloud Function)

These operations should be handled directly by the client:

1. **Toggle Notifications**: Update `notificationEnabled` field and subscribe/unsubscribe FCM
2. **View Followers**: Query `/shops/{shopId}/followers` collection
3. **View Following Shops**: Query `/users/{userId}/followedShops` collection
4. **View Offers**: Query `/shops/{shopId}/offers` collection
5. **View Streak**: Read from `/users/{userId}/followedShops/{shopId}`

---

## Firestore Security Rules (Recommended)

```javascript
match /shops/{shopId}/followers/{userId} {
  // Shop owner can read all followers
  allow read: if request.auth.uid == resource.data.shopOwnerId;
  // User can read their own follower document
  allow read: if request.auth.uid == userId;
}

match /users/{userId}/followedShops/{shopId} {
  // User can read their own following list
  allow read: if request.auth.uid == userId;
}

match /shops/{shopId}/offers/{offerId} {
  // Anyone can read offers (public)
  allow read: if true;
  // Only shop owner can write
  allow write: if request.auth.uid == get(/databases/$(database)/documents/shops/$(shopId)).data.shopOwnerId;
}
```
