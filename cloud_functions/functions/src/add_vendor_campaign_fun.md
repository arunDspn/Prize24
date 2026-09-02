
# Campaign Share Request Functions

## Collections
- `campaignShareRequest`

## Data Model

### CampaignShareRequest Document Structure
```typescript
{
  id: string;                    // Auto-generated document ID
  ownerVendorId: string;         // Campaign owner's vendor ID
  ownerVendorName: string;       // Campaign owner's name
  ownerVendorPhone: string;      // Campaign owner's phone
  campaignId: string;            // Campaign being shared
  campaignName: string;          // Campaign name for UI display
  recipientId: string;           // Vendor receiving the request
  requestedAt: Timestamp;        // When request was sent
  status: "pending" | "accepted" | "declined";
  createdAt: Timestamp;          // Document creation time
  updatedAt: Timestamp;          // Last modification time
  respondedAt?: Timestamp;       // When recipient responded (if applicable)
  expiresAt: Timestamp;          // Request expiration date (30 days from creation)
}
```

## UI Side Data Requirements

### Request List (For Recipients)
- Owner Vendor Name
- Owner Vendor ID  
- Owner Vendor Phone Number
- Campaign Name
- Requested Date
- Status {Pending | Accepted | Declined}
- Expires At

### Sent Requests List (For Campaign Owners)
- Recipient Vendor Name
- Recipient Vendor ID
- Campaign Name
- Requested Date  
- Status {Pending | Accepted | Declined}
- Expires At

### Friends List Integration
- Handle locally in UI by filtering and transforming friends data
- Show status tags: "Can Send Request" | "Request Sent" | "Request Declined" | "Sharing Active"

## Cloud Function Operations

### 1. Send Campaign Share Request
**Function Name:** `sendCampaignShareRequest`
**Trigger:** HTTPS Callable
**Authentication:** Required (JWT)

#### Request Data
```typescript
{
  recipientId: string;
  campaignId: string;
}
```

#### Validations
1. **Requester Authentication:** Extract requester ID from JWT
2. **Campaign Ownership:** Check if requester owns the campaign
   - Query `campaigns` collection where `vendorID === requesterId`
3. **Recipient Validation:**
   - Check if recipient exists in `users` collection
   - Verify `user.isVendor === true`
4. **Friendship Check:** Verify requester and recipient are friends
   - Query `friendships` collection for accepted friendship
5. **Duplicate Prevention:** Check for existing request
   - Query `campaignShareRequest` where `ownerVendorId === requesterId` AND `campaignId === campaignId` AND `recipientId === recipientId` AND `status === 'pending'`

#### Operation
1. Create new document in `campaignShareRequest` collection:
   - Generate unique document ID
   - Set `ownerVendorId` from JWT
   - Get `ownerVendorName` and `ownerVendorPhone` from `users` collection
   - Get `campaignName` from `campaigns` collection
   - Set `status = "pending"`
   - Set timestamps: `requestedAt`, `createdAt`, `updatedAt`
   - Set `expiresAt = requestedAt + 30 days`

#### Error Responses
- `UNAUTHORIZED`: Invalid or missing JWT
- `CAMPAIGN_NOT_FOUND`: Campaign doesn't exist
- `CAMPAIGN_NOT_OWNED`: Requester is not campaign owner
- `RECIPIENT_NOT_FOUND`: Recipient user doesn't exist
- `RECIPIENT_NOT_VENDOR`: Recipient is not a vendor
- `NOT_FRIENDS`: Requester and recipient are not friends
- `REQUEST_ALREADY_EXISTS`: Pending request already exists

### 2. Respond to Campaign Share Request
**Function Name:** `respondToCampaignShareRequest`
**Trigger:** HTTPS Callable
**Authentication:** Required (JWT)

#### Request Data
```typescript
{
  requestId: string;
  action: "accept" | "decline";
}
```

#### Validations
1. **Requester Authentication:** Extract requester ID from JWT
2. **Request Validation:**
   - Check if request exists in `campaignShareRequest` collection
   - Verify `recipientId === requesterId` (only recipient can respond)
   - Verify `status === "pending"`
   - Check if request hasn't expired (`expiresAt > now`)

#### Operation
1. Update document in `campaignShareRequest` collection:
   - Set `status = action` ("accepted" or "declined")
   - Set `respondedAt = now`
   - Set `updatedAt = now`

#### Error Responses
- `UNAUTHORIZED`: Invalid or missing JWT
- `REQUEST_NOT_FOUND`: Request doesn't exist
- `REQUEST_EXPIRED`: Request has expired
- `INVALID_STATUS`: Request is not in pending state

## Querying Patterns

### For Campaign Owners
```typescript
// Get all requests for a specific campaign
campaignShareRequest
  .where('ownerVendorId', '==', vendorId)
  .where('campaignId', '==', campaignId)
  .orderBy('createdAt', 'desc')
```

### For Recipients  
```typescript
// Get all requests received
campaignShareRequest
  .where('recipientId', '==', vendorId)
  .orderBy('createdAt', 'desc')

// Get only pending requests
campaignShareRequest
  .where('recipientId', '==', vendorId)
  .where('status', '==', 'pending')
  .where('expiresAt', '>', now)
  .orderBy('createdAt', 'desc')
```

## Security Rules Considerations
- Users can only read their own requests (as owner or recipient)
- Users can only create requests where they are the owner
- Users can only update status of requests where they are the recipient
- Implement proper authentication checks

## Request Expiration Cleanup
Consider implementing a scheduled function to clean up expired pending requests or mark them as expired.









