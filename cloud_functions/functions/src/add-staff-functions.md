
# Staff Management System
## Database Design - Shop Staff Request & Management

### Collection: `staffRequests`
**Document ID:** Auto-generated unique ID

**Document Fields:**
```typescript
{
  id: string;                     // Auto-generated document ID
  vendorId: string;               // Shop owner's vendor ID (who sent the request)
  vendorName: string;             // Shop owner's name for display
  vendorPhone?: string;           // Shop owner's phone number
  staffUserId: string;            // User ID of potential staff member
  staffName: string;              // Display name of staff member
  staffEmail: string;             // Email of staff member
  staffPhone?: string;            // Phone number of staff member
  shopId: string;                 // Shop ID where staff will work
  shopName: string;               // Shop name for display
  status: 'pending' | 'accepted' | 'declined' | 'expired';
  requestDate: Timestamp;         // When request was sent
  respondedAt?: Timestamp;        // When staff member responded
  joinedAt?: Timestamp;           // When staff member joined (if accepted)
  expiresAt: Timestamp;           // Request expiration (30 days from creation)
  role: string;                   // Staff role (e.g., 'cashier', 'manager', 'sales')
  permissions: string[];          // Array of permissions granted
  createdAt: Timestamp;           // Document creation time
  updatedAt: Timestamp;           // Last modification time
}
```

### Collection: `shopStaff` (Active Staff Members)
**Document ID:** `{shopId}_{userId}` (for uniqueness across shop-staff relationships)

**Document Fields:**
```typescript
{
  shopId: string;                 // Shop ID
  shopName: string;               // Shop name for display
  userId: string;                 // Staff member's user ID
  userName: string;               // Staff member's name
  userEmail: string;              // Staff member's email
  userPhone?: string;             // Staff member's phone
  vendorId: string;               // Shop owner's vendor ID (for reference only)
  vendorName: string;             // Shop owner's name (for reference only)
  role: string;                   // Staff role at this specific shop
  permissions: string[];          // Permissions at this specific shop
  joinedAt: Timestamp;            // When staff member joined this shop
  status: 'active' | 'inactive' | 'suspended' | 'revoked';
  revokedAt?: Timestamp;          // When access was revoked (if applicable)
  revokedBy?: string;             // Who revoked access (user ID)
  revokedReason?: string;         // Reason for revocation
  createdAt: Timestamp;           // Document creation time
  updatedAt: Timestamp;           // Last modification time
}
```

### Required Firestore Indexes:
1. `staffRequests` collection: `staffUserId` + `status`
2. `staffRequests` collection: `vendorId` + `status`
3. `staffRequests` collection: `shopId` + `status`
4. `staffRequests` collection: `expiresAt` + `status` (for cleanup)
5. `shopStaff` collection: `shopId` + `status`
6. `shopStaff` collection: `userId` + `status`
7. `shopStaff` collection: `vendorId` + `status` (for vendor queries)

## API Endpoints

### 1. Send Staff Request
**Function Name:** `sendStaffRequest`
**Trigger:** HTTPS Callable
**Authentication:** Required (JWT)

#### Request Data
```typescript
{
  staffUserId: string;            // Required: Target user ID to invite as staff
  shopId: string;                 // Required: Shop ID where staff will work
  role: string;                   // Required: Staff role (e.g., 'cashier', 'manager')
  permissions: string[];          // Required: Array of permissions to grant
}
```

#### Response
```typescript
{
  success: boolean;
  message: string;
  data?: {
    requestId: string;
    status: 'pending';
    expiresAt: string;
    createdAt: string;
  };
  error?: string;
}
```

#### Pre-Validations
1. **Authentication Required:** Extract vendor ID from JWT
2. **Input Validation:** Validate all required fields are present
3. **Shop Ownership:** Verify vendor is the shop owner
4. **Target User Validation:** 
   - Check if target user exists in `users` collection
   - Verify user is not already active staff at this specific shop
5. **Duplicate Prevention:** Check for existing pending request for same user and shop
6. **Role Validation:** Verify role is valid for the shop type
7. **Permission Validation:** Verify permissions are valid and allowed
8. **Multi-shop Support:** Allow user to be staff at multiple different shops

#### Procedure (All operations in single transaction)

1. **Get Shop Details**
   - Query `shops` collection with `shopId`
   - Validate shop exists and is active
   - Verify requester has permission to add staff (owner or manager)

4. **Get Vendor and Target User Details**
   - Query `users` collection to get vendor profile information
   - Query `users` collection with `staffUserId` to get target user details
   - Validate target user exists and account is active
   - Extract user profile information for both vendor and staff

3. **Check Existing Staff Relationship**
   - Query `shopStaff` collection for existing active relationship at this specific shop
   - If exists and status is 'active', return error
   - Allow if user is staff at other shops (multi-shop support)

4. **Check Pending Requests**
   - Query `staffRequests` for pending requests to same user for same shop
   - If pending request exists, return error

5. **Create Staff Request**
   - Generate unique request ID
   - Set expiration date (30 days from now)
   - Create document in `staffRequests` collection
   - Include vendor details (from JWT and user profile)
   - Include target user details and shop information

#### Error Handling
- `UNAUTHORIZED` - Invalid or missing JWT
- `SHOP_NOT_FOUND` - Shop doesn't exist
- `SHOP_NOT_OWNED` - Requester is not the shop owner (only owners can add staff)
- `USER_NOT_FOUND` - Target user doesn't exist
- `USER_ALREADY_STAFF` - User is already active staff at this specific shop
- `PENDING_REQUEST_EXISTS` - Pending request already exists for this user and shop
- `INVALID_ROLE` - Invalid role specified
- `INVALID_PERMISSIONS` - Invalid permissions specified
- `SHOP_INACTIVE` - Shop is not active

---

### 2. Respond to Staff Request
**Function Name:** `respondToStaffRequest`
**Trigger:** HTTPS Callable
**Authentication:** Required (JWT)

#### Request Data
```typescript
{
  requestId: string;              // Required: Staff request ID
  action: 'accept' | 'decline';   // Required: Response action
}
```

#### Response
```typescript
{
  success: boolean;
  message: string;
  data?: {
    requestId: string;
    status: 'accepted' | 'declined';
    respondedAt: string;
    joinedAt?: string;            // Only if accepted
  };
  error?: string;
}
```

#### Pre-Validations
1. **Authentication Required:** Extract responder ID from JWT
2. **Request Validation:**
   - Check if request exists in `staffRequests` collection
   - Verify `staffUserId === responderId` (only target user can respond)
   - Verify `status === "pending"`
   - Check if request hasn't expired

#### Procedure (All operations in single transaction)

1. **Get Request Details**
   - Query `staffRequests` collection with `requestId`
   - Validate request exists and is pending
   - Check expiration date

2. **Update Request Status**
   - Set `status = action` ("accepted" or "declined")
   - Set `respondedAt = current timestamp`
   - Set `updatedAt = current timestamp`

3. **If Accepted - Create Active Staff Record**
   - Create document in `shopStaff` collection
   - Copy relevant details from request
   - Set `joinedAt = current timestamp`
   - Set `status = "active"`

#### Error Handling
- `UNAUTHORIZED` - Invalid or missing JWT
- `REQUEST_NOT_FOUND` - Request doesn't exist
- `REQUEST_EXPIRED` - Request has expired
- `INVALID_STATUS` - Request is not pending
- `NOT_AUTHORIZED` - User is not the target of this request

---

### 3. Revoke Staff Access
**Function Name:** `revokeStaffAccess`
**Trigger:** HTTPS Callable
**Authentication:** Required (JWT)

#### Request Data
```typescript
{
  shopId: string;                 // Required: Shop ID
  staffUserId: string;            // Required: Staff member's user ID
  reason?: string;                // Optional: Reason for revocation
}
```

#### Response
```typescript
{
  success: boolean;
  message: string;
  data?: {
    staffId: string;
    revokedAt: string;
    reason?: string;
  };
}
```

#### Pre-Validations
1. **Authentication Required:** Extract requester ID from JWT
2. **Shop Ownership:** Verify requester is the shop owner
3. **Staff Validation:** 
   - Check if staff member exists at this shop
   - Verify staff member is currently active
4. **Self-Revocation Prevention:** Shop owner cannot revoke their own access (if they're also staff)

#### Procedure (All operations in single transaction)

1. **Get Shop and Staff Details**
   - Query `shops` collection to verify ownership
   - Query `shopStaff` collection for staff member record
   - Validate staff member is active at this shop

2. **Update Staff Status**
   - Set `status = "revoked"`
   - Set `revokedAt = current timestamp`
   - Set `revokedBy = requester ID`
   - Set `revokedReason = reason` (if provided)
   - Set `updatedAt = current timestamp`

#### Error Handling
- `UNAUTHORIZED` - Invalid or missing JWT
- `SHOP_NOT_FOUND` - Shop doesn't exist
- `SHOP_NOT_OWNED` - Requester is not the shop owner
- `STAFF_NOT_FOUND` - Staff member not found at this shop
- `STAFF_NOT_ACTIVE` - Staff member is not currently active
- `CANNOT_REVOKE_SELF` - Cannot revoke own access

---

### 4. Get Staff Member Details
**Function Name:** `getStaffMemberDetails`
**Trigger:** HTTPS Callable
**Authentication:** Required (JWT)

#### Request Data
```typescript
{
  staffUserId: string;            // Required: Staff member's user ID
  shopId?: string;                // Optional: Specific shop (if not provided, returns all shops)
}
```

#### Response
```typescript
{
  success: boolean;
  data: {
    staffMember: StaffMemberDetails;
    shops: ShopStaffDetails[];    // All shops where user is staff
  };
}

interface StaffMemberDetails {
  userId: string;
  userName: string;
  userEmail: string;
  userPhone?: string;
  totalShops: number;             // Number of shops where user is active staff
}

interface ShopStaffDetails {
  shopId: string;
  shopName: string;
  vendorName: string;
  role: string;
  permissions: string[];
  joinedAt: string;
  status: string;
}
```

---

### 6. Remove Staff Member
**Function Name:** `removeStaffMember`
**Trigger:** HTTPS Callable
**Authentication:** Required (JWT)

---

### 5. Remove Staff Member (Permanent)
**Function Name:** `removeStaffMember`
**Trigger:** HTTPS Callable
**Authentication:** Required (JWT)

#### Request Data
```typescript
{
  shopId: string;                 // Required: Shop ID
  staffUserId: string;            // Required: Staff member's user ID
  reason?: string;                // Optional: Reason for removal
}
```

#### Response
```typescript
{
  success: boolean;
  message: string;
  data?: {
    staffId: string;
    removedAt: string;
  };
}
```

#### Pre-Validations
1. **Authentication Required:** Extract requester ID from JWT
2. **Shop Ownership:** Verify requester is the shop owner
3. **Staff Validation:** Check if staff member exists at this shop
4. **Self-Removal Prevention:** Shop owner cannot remove their own record

#### Procedure (All operations in single transaction)

1. **Get Shop and Staff Details**
   - Query `shops` collection to verify ownership
   - Query `shopStaff` collection for staff member record

2. **Delete Staff Record**
   - Permanently delete document from `shopStaff` collection
   - This removes all association between user and shop

#### Error Handling
- `UNAUTHORIZED` - Invalid or missing JWT
- `SHOP_NOT_FOUND` - Shop doesn't exist
- `SHOP_NOT_OWNED` - Requester is not the shop owner
- `STAFF_NOT_FOUND` - Staff member not found at this shop
- `CANNOT_REMOVE_SELF` - Cannot remove own record

#### Note
**Difference between Revoke and Remove:**
- **Revoke**: Sets status to 'revoked', keeps record for audit trail
- **Remove**: Permanently deletes the staff relationship record

## Query Patterns (Direct Firestore Access)

> **Why Direct Queries Instead of Cloud Functions?**
> 
> For read operations (listing staff, requests, etc.), direct Firestore queries are much better than Cloud Functions because:
> - ✅ **Real-time updates** with Firestore listeners
> - ✅ **Better performance** - no function cold starts
> - ✅ **Lower costs** - no function execution fees
> - ✅ **Offline support** - client-side caching
> - ✅ **Easier pagination** with Firestore cursors
> - ✅ **Better UX** - instant updates and filtering
>
> Cloud Functions should only be used for operations requiring server-side business logic, validation, or data consistency (like creating, updating, deleting).

### Get Staff Requests (Sent by Shop Owner)
```javascript
// Real-time listener for requests sent by current vendor
const sentRequestsQuery = db.collection('staffRequests')
  .where('vendorId', '==', currentVendorId)
  .orderBy('requestDate', 'desc');

// With status filter
const pendingSentRequestsQuery = db.collection('staffRequests')
  .where('vendorId', '==', currentVendorId)
  .where('status', '==', 'pending')
  .orderBy('requestDate', 'desc');

// With shop filter
const shopRequestsQuery = db.collection('staffRequests')
  .where('vendorId', '==', currentVendorId)
  .where('shopId', '==', shopId)
  .orderBy('requestDate', 'desc');

// With pagination
const paginatedRequestsQuery = db.collection('staffRequests')
  .where('vendorId', '==', currentVendorId)
  .orderBy('requestDate', 'desc')
  .limit(20)
  .startAfter(lastDocSnapshot);
```

### Get Staff Requests (Received by User)
```javascript
// Real-time listener for requests received by current user
const receivedRequestsQuery = db.collection('staffRequests')
  .where('staffUserId', '==', currentUserId)
  .orderBy('requestDate', 'desc');

// Only pending requests
const pendingReceivedRequestsQuery = db.collection('staffRequests')
  .where('staffUserId', '==', currentUserId)
  .where('status', '==', 'pending')
  .where('expiresAt', '>', new Date()) // Filter out expired
  .orderBy('requestDate', 'desc');

// All active (non-expired) requests
const activeReceivedRequestsQuery = db.collection('staffRequests')
  .where('staffUserId', '==', currentUserId)
  .where('status', 'in', ['pending', 'accepted', 'declined'])
  .orderBy('requestDate', 'desc');
```

### Get Shop Staff Members (Multi-shop aware)
```javascript
// Real-time listener for shop staff
const shopStaffQuery = db.collection('shopStaff')
  .where('shopId', '==', shopId)
  .where('status', '==', 'active')
  .orderBy('joinedAt', 'desc');

// With status filter
const allShopStaffQuery = db.collection('shopStaff')
  .where('shopId', '==', shopId)
  .where('status', 'in', ['active', 'inactive', 'suspended'])
  .orderBy('joinedAt', 'desc');

// With pagination for large shops
const paginatedStaffQuery = db.collection('shopStaff')
  .where('shopId', '==', shopId)
  .where('status', '==', 'active')
  .orderBy('joinedAt', 'desc')
  .limit(20)
  .startAfter(lastDocSnapshot);
```

### Get All Shops Where User is Staff
```javascript
// Real-time listener for user's staff positions
const userStaffQuery = db.collection('shopStaff')
  .where('userId', '==', currentUserId)
  .where('status', '==', 'active')
  .orderBy('joinedAt', 'desc');

// Include inactive/suspended positions
const allUserStaffQuery = db.collection('shopStaff')
  .where('userId', '==', currentUserId)
  .where('status', 'in', ['active', 'inactive', 'suspended'])
  .orderBy('joinedAt', 'desc');
```

### Get Staff Members Across All Vendor's Shops
```javascript
// Real-time listener for all staff across vendor's shops
const vendorStaffQuery = db.collection('shopStaff')
  .where('vendorId', '==', currentVendorId)
  .where('status', '==', 'active')
  .orderBy('joinedAt', 'desc');

// Get staff count per shop for vendor dashboard
const vendorStaffByShopQuery = db.collection('shopStaff')
  .where('vendorId', '==', currentVendorId)
  .where('status', '==', 'active');

// Usage: Group by shopId on client side for dashboard stats
```

### Advanced Query Examples
```javascript
// Get expired requests for cleanup (admin use)
const expiredRequestsQuery = db.collection('staffRequests')
  .where('status', '==', 'pending')
  .where('expiresAt', '<', new Date())
  .orderBy('expiresAt', 'asc');

// Get recently joined staff (last 30 days)
const recentStaffQuery = db.collection('shopStaff')
  .where('shopId', '==', shopId)
  .where('status', '==', 'active')
  .where('joinedAt', '>', new Date(Date.now() - 30 * 24 * 60 * 60 * 1000))
  .orderBy('joinedAt', 'desc');

// Get revoked staff for audit
const revokedStaffQuery = db.collection('shopStaff')
  .where('shopId', '==', shopId)
  .where('status', '==', 'revoked')
  .orderBy('revokedAt', 'desc');
```

### Client-Side Data Transformation Examples
```javascript
// Transform staff requests for UI display
const transformStaffRequest = (doc) => ({
  id: doc.id,
  staffName: doc.data().staffName,
  staffEmail: doc.data().staffEmail,
  shopName: doc.data().shopName,
  role: doc.data().role,
  status: doc.data().status,
  requestDate: doc.data().requestDate.toDate().toLocaleDateString(),
  expiresAt: doc.data().expiresAt.toDate().toLocaleDateString(),
  isExpired: doc.data().expiresAt.toDate() < new Date(),
  daysUntilExpiry: Math.ceil((doc.data().expiresAt.toDate() - new Date()) / (1000 * 60 * 60 * 24))
});

// Group staff by shop for vendor dashboard
const groupStaffByShop = (staffDocs) => {
  return staffDocs.reduce((acc, doc) => {
    const shopId = doc.data().shopId;
    if (!acc[shopId]) {
      acc[shopId] = {
        shopName: doc.data().shopName,
        staff: []
      };
    }
    acc[shopId].staff.push(transformStaffMember(doc));
    return acc;
  }, {});
};
```

## Security Rules (Firestore)

```javascript
rules_version = '2';
service cloud.firestore {
  match /databases/{database}/documents {
    
    // Helper function to check if user is authenticated
    function isAuthenticated() {
      return request.auth != null;
    }
    
    // Helper function to check if user owns a shop
    function ownsShop(shopId) {
      return exists(/databases/$(database)/documents/shops/$(shopId)) &&
        get(/databases/$(database)/documents/shops/$(shopId)).data.vendorId == request.auth.uid;
    }
    
    // Helper function to check if user is staff at a shop
    function isStaffAtShop(shopId, userId) {
      return exists(/databases/$(database)/documents/shopStaff/$(shopId + '_' + userId)) &&
        get(/databases/$(database)/documents/shopStaff/$(shopId + '_' + userId)).data.status == 'active';
    }
    
    // Staff Requests collection rules
    match /staffRequests/{requestId} {
      
      // Read rules: Users can read requests they sent or received
      allow read: if isAuthenticated() && (
        resource.data.vendorId == request.auth.uid ||
        resource.data.staffUserId == request.auth.uid
      );
      
      // Create rules: Only shop owners (vendors) can create staff requests
      allow create: if isAuthenticated() &&
        request.data.vendorId == request.auth.uid &&
        ownsShop(request.data.shopId);
      
      // Update rules: Only target staff can update (respond to requests)
      allow update: if isAuthenticated() &&
        resource.data.staffUserId == request.auth.uid &&
        resource.data.status == 'pending';
      
      // Delete rules: Only shop owners can delete their requests
      allow delete: if isAuthenticated() &&
        resource.data.vendorId == request.auth.uid;
    }
    
    // Shop Staff collection rules
    match /shopStaff/{staffId} {
      
      // Read rules: Shop owners and staff members can read
      allow read: if isAuthenticated() && (
        ownsShop(resource.data.shopId) ||
        resource.data.userId == request.auth.uid ||
        isStaffAtShop(resource.data.shopId, request.auth.uid)
      );
      
      // Create/Update/Delete rules: Only through Cloud Functions for data integrity
      allow create, update, delete: if false;
    }
  }
}
```

## Common Validations

### Global Validations:
1. **Authentication Required:** All endpoints require valid Firebase Auth token
2. **Shop Ownership:** Verify user is the shop owner (not manager/staff) for management operations
3. **User Existence:** Validate target users exist and are active
4. **Multi-shop Support:** Allow users to be staff at multiple different shops
5. **Rate Limiting:** Max 20 requests per minute per user
6. **Input Sanitization:** All string inputs trimmed and validated

### Business Logic Validations:
1. **No Self-Invitation:** Shop owners cannot send staff requests to themselves
2. **No Duplicate Active Staff:** User cannot be active staff at same shop multiple times
3. **No Duplicate Requests:** Cannot send multiple pending requests to same user for same shop
4. **Request Expiration:** Requests expire after 30 days
5. **Role Validation:** Role must be valid for shop type
6. **Permission Validation:** Permissions must be valid and specific to scan offers
7. **Revocation Support:** Staff access can be revoked while maintaining audit trail

## Error Codes

| Code | Message | Description |
|------|---------|-------------|
| `UNAUTHORIZED` | Authentication required | No valid auth token |
| `SHOP_NOT_FOUND` | Shop not found | Shop doesn't exist |
| `SHOP_NOT_OWNED` | Not shop owner | User doesn't own shop |
| `USER_NOT_FOUND` | User not found | Target user doesn't exist |
| `USER_ALREADY_STAFF` | User already staff | User is already active staff at this specific shop |
| `PENDING_REQUEST_EXISTS` | Request already exists | Pending request exists for this user and shop |
| `REQUEST_NOT_FOUND` | Request not found | Staff request doesn't exist |
| `REQUEST_EXPIRED` | Request expired | Request has expired |
| `INVALID_STATUS` | Invalid status | Invalid status transition |
| `INVALID_ROLE` | Invalid role | Role not valid for shop |
| `INVALID_PERMISSIONS` | Invalid permissions | Permissions not allowed |
| `STAFF_NOT_FOUND` | Staff not found | Staff member not found at shop |
| `STAFF_NOT_ACTIVE` | Staff not active | Staff member is not currently active |
| `CANNOT_REVOKE_SELF` | Cannot revoke self | Cannot revoke own access |
| `CANNOT_REMOVE_SELF` | Cannot remove self | Cannot remove own record |
| `RATE_LIMITED` | Too many requests | Rate limit exceeded |

## Summary - Optimized Architecture

### ✅ **Cloud Functions (5 functions) - For Critical Operations Only**
1. **`sendStaffRequest`** - Server-side validation, business logic, and data consistency
2. **`respondToStaffRequest`** - Secure status updates with audit trail
3. **`revokeStaffAccess`** - Permission validation and audit logging
4. **`getStaffMemberDetails`** - Cross-collection aggregation (if needed)
5. **`removeStaffMember`** - Permanent deletion with ownership validation

### ✅ **Direct Firestore Queries - For All Read Operations**
- **Staff Requests (Sent/Received)** - Real-time with filters and pagination
- **Shop Staff Lists** - Live updates with status filtering
- **User Staff Positions** - Multi-shop aware queries
- **Vendor Dashboard Data** - Aggregated views across shops
- **Analytics & Reports** - Advanced filtering and grouping

### ✅ **Why This Architecture is Optimal**

**Performance Benefits:**
- ⚡ **Instant UI updates** with real-time listeners
- ⚡ **No function cold starts** for read operations
- ⚡ **Client-side caching** for offline support
- ⚡ **Efficient pagination** with Firestore cursors

**Cost Benefits:**
- 💰 **Lower costs** - no function execution fees for reads
- 💰 **Reduced bandwidth** - only changed data transmitted
- 💰 **Better scaling** - reads don't consume function quotas

**Developer Benefits:**
- 🔧 **Simpler implementation** - standard Firestore patterns
- 🔧 **Better debugging** - direct query inspection
- 🔧 **Flexible filtering** - client-side query composition
- 🔧 **Easy maintenance** - fewer function deployments

**User Experience:**
- 🚀 **Real-time updates** - instant UI refreshes
- 🚀 **Offline capability** - cached data access
- 🚀 **Faster loading** - no network round trips to functions
- 🚀 **Better responsiveness** - immediate filtering and sorting