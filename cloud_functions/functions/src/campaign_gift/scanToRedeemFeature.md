# Scan to Redeem Feature - Cloud Functions

This feature allows redemption of user gifts through three different Firebase HTTP Callable functions based on user roles.

## Authentication
All functions require Google Sign-in authentication. The authenticated user's UID is retrieved from `context.auth.uid`.

## Function Overview
1. **scanToRedeemByOwner** - For campaign owner vendors
2. **scanToRedeemBySharedVendor** - For shared vendors of campaigns  
3. **scanToRedeemByStaff** - For shop staff members

---

## 1. scanToRedeemByOwner

**Function Type**: Firebase HTTP Callable Function

### Request Parameters
```json
{
  "userGiftId": "string",
  "campaignId": "string"
}
```

### Authentication & Validation
- User must be authenticated via Google Sign-in
- Verify that `context.auth.uid` matches the `vendorId` field in the campaign document
- Check if gift with `userGiftId` exists in `user_gifts` collection
- Verify that `isRedeemed` is `false` (prevent double redemption)

**Validation Process:**
1. Get campaign document from `campaigns` collection using `campaignId`
2. Check if `campaigns.vendorId` equals `context.auth.uid`
3. Get gift document from `user_gifts` collection using `userGiftId`
4. Ensure `user_gifts.isRedeemed` is `false`

### Procedure
1. Update gift document in `user_gifts` collection:
   - Set `isRedeemed` to `true`
   - Set `redeemedAt` to current timestamp
2. Create audit log entry
3. Return success response

---

## 2. scanToRedeemBySharedVendor

**Function Type**: Firebase HTTP Callable Function

### Request Parameters
```json
{
  "userGiftId": "string",
  "campaignId": "string"
}
```

### Authentication & Validation
- User must be authenticated via Google Sign-in
- Verify that `context.auth.uid` exists in the `sharedVendors` array of the campaign
- Check if gift with `userGiftId` exists in `user_gifts` collection
- Verify that `isRedeemed` is `false` (prevent double redemption)

**Validation Process:**
1. Get campaign document from `campaigns` collection using `campaignId`
2. Check if `context.auth.uid` exists in `campaigns.sharedVendors` array
3. Get gift document from `user_gifts` collection using `userGiftId`
4. Ensure `user_gifts.isRedeemed` is `false`

### Procedure
1. Update gift document in `user_gifts` collection:
   - Set `isRedeemed` to `true`
   - Set `redeemedAt` to current timestamp
2. Create audit log entry
3. Return success response

---

## 3. scanToRedeemByStaff

**Function Type**: Firebase HTTP Callable Function

### Request Parameters
```json
{
  "userGiftId": "string",
  "campaignId": "string",
  "shopId": "string"
}
```

### Authentication & Validation
- User must be authenticated via Google Sign-in
- Verify that staff member belongs to the specified shop
- Verify that shop is supported by the campaign
- Check if gift with `userGiftId` exists in `user_gifts` collection
- Verify that `isRedeemed` is `false` (prevent double redemption)

**Validation Process:**
1. Query `shopStaff` collection where `userId` equals `context.auth.uid` AND `shopId` equals request `shopId`
2. Ensure staff record exists (user is staff of the specified shop)
3. Get campaign document from `campaigns` collection using `campaignId`
4. Check if request `shopId` exists in `campaigns.supportedShops` array
5. Get gift document from `user_gifts` collection using `userGiftId`
6. Ensure `user_gifts.isRedeemed` is `false`

### Procedure
1. Update gift document in `user_gifts` collection:
   - Set `isRedeemed` to `true`
   - Set `redeemedAt` to current timestamp
2. Create audit log entry
3. Return success response

---

## Response Formats

### Success Response
```json
{
  "success": true
}
```

### Error Response
```json
{
  "error": {
    "code": "ERROR_CODE",
    "message": "Error description"
  }
}
```

### Common Error Codes
- `UNAUTHENTICATED`: User not authenticated
- `PERMISSION_DENIED`: User not authorized for this operation
- `NOT_FOUND`: Gift, campaign, or related document not found
- `ALREADY_REDEEMED`: Gift has already been redeemed
- `INVALID_ARGUMENT`: Invalid request parameters

---

## Audit Trail

### Collection: `audit_logs`
Each redemption creates an audit log entry with the following fields:

```json
{
  "action": "gift_redeemed",
  "giftId": "string",
  "campaignId": "string", 
  "redeemedBy": "string", // context.auth.uid
  "redeemerRole": "string", // "owner", "shared_vendor", or "staff"
  "shopId": "string", // only for staff redemptions
  "timestamp": "timestamp",
  "functionName": "string" // function that processed the redemption
}
```

---

## Future Features

### Notifications (To be implemented)
```javascript
// TODO: Add notification functionality after successful redemption
// - Send notification to gift owner
// - Send notification to campaign owner
// - Update notification preferences
```

---

## Database Collections Referenced

### Collections Used:
- `campaigns` - Campaign documents with vendorId, sharedVendors, supportedShops
- `user_gifts` - User gift documents with isRedeemed, redeemedAt fields
- `shopStaff` - Staff-shop relationships with userId, shopId fields  
- `audit_logs` - Redemption audit trail

### Collection Structures:
```javascript
// campaigns
{
  vendorId: "string",
  sharedVendors: ["string"], // array of vendor IDs
  supportedShops: ["string"] // array of shop IDs
}

// user_gifts  
{
  isRedeemed: boolean,
  redeemedAt: timestamp // set when redeemed
}

// shopStaff
{
  userId: "string", // staff member UID
  shopId: "string"  // shop identifier
}
```