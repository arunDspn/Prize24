
# Shop Follow Feature

## 1. Follow a Shop (Cloud Function)

### Requirements
- `shopId` (string)
- `userId` (from auth context)
- `fcmToken` (string) - Client must send FCM token for notifications

### Procedure
1. **Validate**
   - User authentication check
   - Shop existence validation (`/shops/{shopId}`)
   - Check if already following (query `/users/{userId}/shopsFollowing/{shopId}`)

2. **Transaction: Create Follow Relationship**
   - Create document in `/users/{userId}/shopsFollowing/{shopId}`
     ```typescript
     {
       shopId: string,
       notificationEnabled: boolean, // true by default
       followedAt: Timestamp,
       status: "active",
       unfollowedAt: null
     }
     ```
   
   - Create document in `/shops/{shopId}/followers/{userId}`
     ```typescript
     {
       userId: string,
       userName: string,
       followerProfilePic: string | null,
       notificationEnabled: boolean, // true by default
       followedAt: Timestamp,
       status: "active",
       unfollowedAt: null
     }
     ```
   
   - Increment `/shops/{shopId}.totalFollowers` by 1
   - Increment `/users/{userId}.totalFollowing` by 1

3. **FCM Pub/Sub Topic Subscription**
   - Topic name: `{shopId}` (exposed via QR anyway)
   - Subscribe user's FCM token to shop topic

### Response
```typescript
{
  success: true,
  message: "Successfully followed shop",
  data: {
    shopId: string,
    followedAt: Timestamp,
    notificationEnabled: true
  }
}
```

---

## 2. Unfollow a Shop (Cloud Function)

### Requirements
- `shopId` (string)
- `userId` (from auth context)
- `fcmToken` (string) - For topic unsubscription

### Procedure
1. **Validate**
   - User authentication check
   - Verify following relationship exists
   - Check status is "active"

2. **Transaction: Soft Delete Follow Relationship**
   - Update `/users/{userId}/shopsFollowing/{shopId}`
     ```typescript
     {
       status: "unfollowed",
       unfollowedAt: Timestamp,
       notificationEnabled: false
     }
     ```
   
   - Update `/shops/{shopId}/followers/{userId}`
     ```typescript
     {
       status: "unfollowed",
       unfollowedAt: Timestamp,
       notificationEnabled: false
     }
     ```
   
   - Decrement `/shops/{shopId}.totalFollowers` by 1
   - Decrement `/users/{userId}.totalFollowing` by 1

3. **FCM Topic Unsubscription**
   - Unsubscribe user's FCM token from shop topic `{shopId}`

### Response
```typescript
{
  success: true,
  message: "Successfully unfollowed shop"
}
```

---

## 3. Toggle Notification (Client Side ✅)

**Client can directly update:**
- `/users/{userId}/shopsFollowing/{shopId}.notificationEnabled`
- `/shops/{shopId}/followers/{userId}.notificationEnabled`

**With Security Rules:**
```javascript
// users/{userId}/shopsFollowing/{shopId}
allow update: if request.auth.uid == userId 
              && request.resource.data.diff(resource.data).affectedKeys().hasOnly(['notificationEnabled'])
              && resource.data.status == "active";

// shops/{shopId}/followers/{userId}
allow update: if request.auth.uid == userId 
              && request.resource.data.diff(resource.data).affectedKeys().hasOnly(['notificationEnabled'])
              && resource.data.status == "active";
```

**Note:** Toggling notification does NOT affect FCM topic subscription - user remains subscribed but can filter on client side, OR we create separate topics like `{shopId}_offers`, `{shopId}_updates`.

---

## 4. Shop Privacy & Follower Visibility

- **Shops can see followers:** Yes, via `/shops/{shopId}/followers/` collection (read with shop owner auth)
- **No privacy settings:** All shops are public and followable
- **No rate limiting:** Not implemented initially
- **No follower limits:** Unlimited followers per shop

---

## Data Structure Summary

### `/users/{userId}/shopsFollowing/{shopId}`
```typescript
{
  shopId: string,              // Reference only, fetch shop details dynamically
  notificationEnabled: boolean,
  followedAt: Timestamp,
  status: "active" | "unfollowed",
  unfollowedAt: Timestamp | null
}
```

### `/shops/{shopId}/followers/{userId}`
```typescript
{
  userId: string,
  userName: string,
  followerProfilePic: string | null,
  notificationEnabled: boolean,
  followedAt: Timestamp,
  status: "active" | "unfollowed",
  unfollowedAt: Timestamp | null
}
```

### `/users/{userId}` (add field)
```typescript
{
  // ... existing fields
  totalFollowing: number  // Count of active shop follows
}
```

### `/shops/{shopId}` (add field)
```typescript
{
  // ... existing fields
  totalFollowers: number  // Count of active followers
}
```

---

## Cloud Functions to Create

1. ✅ `followShop` - Follow a shop with FCM subscription
2. ✅ `unfollowShop` - Unfollow a shop with FCM unsubscription
3. ❌ Toggle notification - Client handles directly

---

## Questions Answered

**Q: Users can follow multiple shops, should it be an array?**
A: No. Use subcollection `/users/{userId}/shopsFollowing/` with one document per shop. Better for querying and pagination.

**Q: Unfollow - separate cloud function or client side?**
A: Needs Cloud Function because:
- Transaction safety for counter updates
- FCM topic unsubscription (requires admin SDK)

**Q: Disable notification - cloud function or client?**
A: Client side is fine! Just toggle `notificationEnabled` field with proper security rules.

**Q: Shop ID exposed in topic name?**
A: Acceptable since shop IDs are already in QR codes.

**Q: FCM token handling?**
A: Client MUST send FCM token in request body for both follow and unfollow operations.
