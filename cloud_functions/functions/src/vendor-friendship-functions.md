# Vendor Friendship System
## Database Design - Enhanced Single Document Approach

### Collection: `vendorFriendships`
**Document ID:** `{requesterId}_{receiverId}` (lexicographically sorted to ensure consistency)

**Document Fields:**
```typescript
{
  requesterId: string;        // User ID who sent the request
  requesterName: string;      // Display name of requester
  requesterProfilePic?: string; // Profile picture URL
  receiverId: string;         // User ID who received the request
  receiverName: string;       // Display name of receiver
  receiverProfilePic?: string; // Profile picture URL
  status: 'pending' | 'accepted' | 'declined' | 'blocked';
  createdAt: Timestamp;       // When request was sent
  updatedAt: Timestamp;       // Last status change
  acceptedAt?: Timestamp;     // When friendship was accepted
  participants: string[];     // [requesterId, receiverId] for efficient querying
}
```

### Composite Indexes Required:
1. `participants` + `status`
2. `requesterId` + `status` 
3. `receiverId` + `status`

## API Endpoints

### 1. Send Friend Request
**Endpoint:** `POST /sendFriendRequest`

**Request Body:**
```typescript
{
  receiverId: string;     // Required: Target user ID
}
```

**Response:**
```typescript
{
  success: boolean;
  message: string;
  data?: {
    friendshipId: string;
    status: 'pending';
    createdAt: string;
  };
  error?: string;
}
```

**Validations:**
- Requester must be authenticated
- Both requester and receiver must be vendors (`user.isVendor = true`)
- Cannot send request to self
- Friendship document must not already exist
- Receiver user must exist

---

### 2. Respond to Friend Request
**Endpoint:** `POST /respondToFriendRequest`

**Request Body:**
```typescript
{
  friendshipId: string;           // Required: Friendship document ID
  action: 'accept' | 'decline';   // Required: Response action
}
```

**Response:**
```typescript
{
  success: boolean;
  message: string;
  data?: {
    friendshipId: string;
    status: 'accepted' | 'declined';
    updatedAt: string;
    acceptedAt?: string;
  };
  error?: string;
}
```

**Validations:**
- User must be authenticated
- User must be the receiver of the request
- Friendship document must exist
- Current status must be 'pending'

---

### 3. Block User
**Endpoint:** `POST /blockUser`

**Request Body:**
```typescript
{
  userId: string;  // Required: User ID to block
}
```

**Response:**
```typescript
{
  success: boolean;
  message: string;
  data?: {
    friendshipId: string;
    status: 'blocked';
    updatedAt: string;
  };
  error?: string;
}
```

**Validations:**
- User must be authenticated
- Cannot block self
- Target user must exist and be a vendor

## Client-Side Queries (Direct Firestore Access)

### Get Friend Requests (Received)
```javascript
// Real-time listener for received requests
const receivedRequestsQuery = db.collection('vendorFriendships')
  .where('receiverId', '==', currentUserId)
  .where('status', '==', 'pending')
  .orderBy('createdAt', 'desc');

// One-time fetch with pagination
const receivedRequestsQuery = db.collection('vendorFriendships')
  .where('receiverId', '==', currentUserId)
  .where('status', '==', 'pending')
  .orderBy('createdAt', 'desc')
  .limit(20);
```

### Get Friend Requests (Sent)
```javascript
// Real-time listener for sent requests
const sentRequestsQuery = db.collection('vendorFriendships')
  .where('requesterId', '==', currentUserId)
  .where('status', '==', 'pending')
  .orderBy('createdAt', 'desc');
```

### Get Friends List
```javascript
// Real-time listener for friends
const friendsQuery = db.collection('vendorFriendships')
  .where('participants', 'array-contains', currentUserId)
  .where('status', '==', 'accepted')
  .orderBy('acceptedAt', 'desc');

// With pagination
const friendsQuery = db.collection('vendorFriendships')
  .where('participants', 'array-contains', currentUserId)
  .where('status', '==', 'accepted')
  .orderBy('acceptedAt', 'desc')
  .limit(20)
  .startAfter(lastDocSnapshot); // For pagination
```

### Remove Friend (Client-side)
```javascript
// Direct delete operation - secured by Firestore rules
const removeFriend = async (friendshipId) => {
  try {
    await db.collection('vendorFriendships').doc(friendshipId).delete();
    console.log('Friend removed successfully');
  } catch (error) {
    console.error('Error removing friend:', error);
    // Handle permission denied or other errors
  }
};
```

## Query Patterns

### Cloud Functions (Server-side operations):
- ✅ **Send Friend Request** - `sendFriendRequest()`
- ✅ **Respond to Request** - `respondToFriendRequest()`
- ✅ **Block User** - `blockUser()`

### Direct Firestore Operations (Client-side):
- 🔥 **Friend Requests for Me** - Direct query for better performance
- 🔥 **Friends List** - Real-time updates with Firestore listeners
- 🔥 **Remove Friend** - Direct delete operation (secured by rules)
- 🔥 **Search Friends** - Client-side filtering and search

## Security Rules (Firestore)

```javascript
rules_version = '2';
service cloud.firestore {
  match /databases/{database}/documents {
    
    // Helper function to check if user is a vendor
    function isVendor(userId) {
      return get(/databases/$(database)/documents/users/$(userId)).data.isVendor == true;
    }
    
    // Helper function to check if user is authenticated
    function isAuthenticated() {
      return request.auth != null;
    }
    
    // Helper function to check if user is participant in friendship
    function isParticipant(userId) {
      return userId in resource.data.participants;
    }
    
    // Friendship collection rules
    match /vendorFriendships/{friendshipId} {
      
      // Read rules: Users can read friendships they participate in
      allow read: if isAuthenticated()
        && isParticipant(request.auth.uid)
        && isVendor(request.auth.uid);
      
      // Create rules: Only Cloud Functions can create (no direct client creation)
      allow create: if false; // Prevent direct client creation - use Cloud Functions
      
      // Update rules: Only Cloud Functions can update (no direct client updates)
      allow update: if false; // Prevent direct client updates - use Cloud Functions
      
      // Delete rules: Users can delete accepted friendships they participate in
      allow delete: if isAuthenticated()
        && isParticipant(request.auth.uid)
        && isVendor(request.auth.uid)
        && resource.data.status == 'accepted'; // Only allow deleting accepted friendships
    }
    
    // Users collection rules (for vendor validation)
    match /users/{userId} {
      allow read: if isAuthenticated(); // Allow reading user data for validation
      // Add other user rules as needed for your app
    }
  }
}
```

### Security Rules Explanation:

**Read Access:**
- ✅ Users can read friendships they participate in
- ✅ Must be authenticated and a vendor
- ✅ Supports queries for friend lists and requests

**Write Access:**
- ❌ **Create/Update blocked** - Only Cloud Functions can create/update friendships
- ✅ **Delete allowed** - Users can remove accepted friendships directly
- ✅ Vendor validation enforced on all operations

**Key Security Features:**
- 🛡️ **Vendor-only access** - Non-vendors cannot access friendship data
- 🛡️ **Participant validation** - Users can only access their own friendships
- 🛡️ **Status protection** - Can only delete accepted friendships
- 🛡️ **Cloud Function enforcement** - Critical operations go through validated functions

## Common Validations

### Global Validations:
1. **Authentication Required:** All endpoints require valid Firebase Auth token
2. **Vendor Check:** User must have `isVendor: true` in users collection
3. **Rate Limiting:** Max 10 requests per minute per user
4. **Input Sanitization:** All string inputs trimmed and validated

### Business Logic Validations:
1. **No Self-Friendship:** Cannot send friend request to self
2. **No Duplicate Requests:** Cannot send request if friendship document already exists
3. **Status Transitions:** 
   - `pending` → `accepted` ✅
   - `pending` → `declined` ✅
   - `pending` → `blocked` ✅
   - `accepted` → `blocked` ✅
   - Other transitions ❌

## Error Codes

| Code | Message | Description |
|------|---------|-------------|
| `UNAUTHORIZED` | Authentication required | No valid auth token |
| `FORBIDDEN` | Not a vendor | User is not a vendor |
| `NOT_FOUND` | User not found | Target user doesn't exist |
| `ALREADY_EXISTS` | Friendship already exists | Duplicate request |
| `INVALID_STATUS` | Invalid status transition | Cannot change from current status |
| `SELF_REQUEST` | Cannot send request to self | Self-friendship attempt |
| `RATE_LIMITED` | Too many requests | Rate limit exceeded |