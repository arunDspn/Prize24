# 1. Public Code Gift - (`textAvail-Public-FullText-CodeCampaign`)
Can only be availed via TEXT method

#### Request Data
1. User ID (required)
2. Campaign Slug (required)
3. Gift Slug (required) 
4. Code (required)

#### Pre-Validations
1. Validate User ID exists and is active
2. Validate all required fields are present
3. Check rate limiting (if applicable)

#### Procedure (All operations in single transaction)

1. **Get Campaign via slug**
    - Collection: `campaigns`        
    - Field: `publicSlug`
    - Validate: Campaign exists and status is 'active'

2. **Get Gift via slug**
    - Field: `publicSlug` (consistent naming)
    - Validate: Gift exists and belongs to campaign

3. **Get and Validate Code**
    - Sub-collection: `codeGiftCodes` inside Gift record
    - Validate: 
        - Code exists
        - `isRedeemed` is false
        - Code is not expired (if expiration field exists)

4. **Reserve Gift** (Prevent race conditions)
    - Check `remainingQuantity > 0` in gift record
    - Temporarily reserve the gift

5. **Mark Code as Redeemed**
    - Set `isRedeemed = true`
    - Set `redeemedByUserId = request user ID`
    - Set `redeemedAt = current timestamp`

6. **Update Quantities**
    - Decrement `remainingQuantity` in gift record
    - Decrement `totalGifts` in campaign record
    - Increment `totalParticipants` in campaign record

7. **Create User Gift Record**
    - Collection: `user_gifts`
    - Fields:
        - `userId` - from request
        - `giftId` - from gift record
        - `campaignId` - from campaign record
        - `campaignName` - from campaign record
        - `giftName` - copy `name` from gift
        - `giftDescription` - copy `description` from gift
        - `isRedeemable` - copy from gift
        - `isRedeemed` - NULL
        - `redeemedAt` - if non-redeemable: current time, if redeemable: NULL
        - `availedAt` - current time
        - `payload` - if non-redeemable: copy `payload` from selected code record, else NULL
        - `supportedShops` - if redeemable: copy from gift, else NULL
        - `redemptionId` - generate unique ID

8. **Audit Logging**
    - Log successful redemption with user ID, campaign ID, gift ID, code, timestamp

9. **Return Success Response**
    - Gift details (name, description, isRedeemable)
    - Redemption ID
    - Payload (if applicable)
    - Supported shops (if applicable)

#### Error Handling
- `CAMPAIGN_NOT_FOUND` - Campaign with slug not found
- `CAMPAIGN_INACTIVE` - Campaign status is not active
- `GIFT_NOT_FOUND` - Gift with slug not found
- `CODE_NOT_FOUND` - Code not found in gift
- `CODE_ALREADY_REDEEMED` - Code has already been used
- `CODE_EXPIRED` - Code has expired
- `GIFT_UNAVAILABLE` - No remaining quantity
- `USER_NOT_FOUND` - Invalid user ID
- `TRANSACTION_FAILED` - Database transaction failed


# 2. Public Auto Gift - `textAvail-Public-SemiText-AutoCampaign`
(with public campaign slug)

#### Request Data
1. User ID (required)
2. Campaign Slug (required)

#### Pre-Validations
1. Validate User ID exists and is active
2. Validate all required fields are present

#### Procedure (All operations in single transaction)

1. **Get Campaign via slug**
    - Field: `publicSlug` (consistent naming)
    - Validate: Campaign exists and status is 'active'

2. **Get Campaign Statistics**
    - `totalGifts` and `totalParticipants` from campaign record
    - Calculate available gifts count from gifts sub-collection

3. **Calculate Luck Factor**
    - Base luck percentage: Calculate as `(totalGifts / Math.max(totalParticipants, 1))`
    - If luck factor > 1, set to 1 (100% chance)
    - Generate random number between 0-1
    - If random number <= luck factor, user is lucky

4. **If Not Lucky**
    - Log failed attempt for audit
    - Return failure response with message

5. **If Lucky - Gift Selection Process**
    - Get all gifts from campaign's `gifts` sub-collection where `remainingQuantity > 0`
    - If no gifts available, return `GIFTS_EXHAUSTED` error
    - Randomly select one gift (truly random)
    - Reserve the selected gift

6. **Update Quantities**
    - Decrement `remainingQuantity` in selected gift record
    - Decrement `totalGifts` in campaign record
    - Increment `totalParticipants` in campaign record

7. **Determine Payload**
    - If gift is non-redeemable and has `autoGiftPayload` array:
        - Randomly select one payload from the array
    - Else set payload to NULL

8. **Create User Gift Record**
    - Collection: `user_gifts`
    - Fields:
        - `userId` - from request
        - `giftId` - from selected gift record
        - `campaignId` - from campaign record
        - `campaignName` - from campaign record
        - `giftName` - copy `name` from gift
        - `giftDescription` - copy `description` from gift
        - `isRedeemable` - copy from gift
        - `isRedeemed` - NULL
        - `redeemedAt` - if non-redeemable: current time, if redeemable: NULL
        - `availedAt` - current time
        - `payload` - from step 7
        - `supportedShops` - if redeemable: copy from gift, else NULL
        - `redemptionId` - generate unique ID

9. **Audit Logging**
    - Log successful redemption with user ID, campaign ID, gift ID, luck factor, timestamp

10. **Return Success Response**
    - Gift details (name, description, isRedeemable)
    - Redemption ID
    - Payload (if applicable)
    - Supported shops (if applicable)

#### Error Handling
- `CAMPAIGN_NOT_FOUND` - Campaign with slug not found
- `CAMPAIGN_INACTIVE` - Campaign status is not active
- `USER_NOT_FOUND` - Invalid user ID
- `GIFTS_EXHAUSTED` - No gifts with remaining quantity
- `LUCK_FAILED` - User was not lucky this time
- `TRANSACTION_FAILED` - Database transaction failed


# 3. Scan Campaign (`scanAvail-PublicPrivate-AutoCampaign`)
- Allowed gift type: Auto
- Allowed campaign visibility: Public (can also be redeemed by Text, has publicSlug), Private

#### Request Data
1. User ID (required)
2. Campaign ID (required)

#### Pre-Validations
1. Validate User ID exists and is active
2. Validate all required fields are present

#### Procedure (All operations in single transaction)

1. **Get Campaign via ID**
    - Collection: `campaigns`
    - Field: `campaignId`
    - Validate: Campaign exists and status is 'active'

2. **Get Campaign Statistics**
    - `totalGifts` and `totalParticipants` from campaign record
    - Calculate available gifts count from gifts sub-collection

3. **Calculate Luck Factor**
    - Base luck percentage: Calculate as `(totalGifts / Math.max(totalParticipants, 1))`
    - If luck factor > 1, set to 1 (100% chance)
    - Generate random number between 0-1
    - If random number <= luck factor, user is lucky

4. **If Not Lucky**
    - Log failed attempt for audit
    - Return failure response with message

5. **If Lucky - Gift Selection Process**
    - Get all gifts from campaign's `gifts` sub-collection where `remainingQuantity > 0`
    - If no gifts available, return `GIFTS_EXHAUSTED` error
    - Randomly select one gift (truly random)
    - Reserve the selected gift

6. **Update Quantities**
    - Decrement `remainingQuantity` in selected gift record
    - Decrement `totalGifts` in campaign record
    - Increment `totalParticipants` in campaign record

7. **Determine Payload**
    - If gift is non-redeemable and has `autoGiftPayload` array:
        - Randomly select one payload from the array
    - Else set payload to NULL

8. **Create User Gift Record**
    - Collection: `user_gifts`
    - Fields:
        - `userId` - from request
        - `giftId` - from selected gift record
        - `campaignId` - from campaign record
        - `campaignName` - from campaign record
        - `giftName` - copy `name` from gift
        - `giftDescription` - copy `description` from gift
        - `isRedeemable` - copy from gift
        - `isRedeemed` - NULL
        - `redeemedAt` - if non-redeemable: current time, if redeemable: NULL
        - `availedAt` - current time
        - `payload` - from step 7
        - `supportedShops` - if redeemable: copy from gift, else NULL
        - `redemptionId` - generate unique ID

9. **Audit Logging**
    - Log successful redemption with user ID, campaign ID, gift ID, luck factor, timestamp

10. **Return Success Response**
    - Gift details (name, description, isRedeemable)
    - Redemption ID
    - Payload (if applicable)
    - Supported shops (if applicable)

#### Error Handling
- `CAMPAIGN_NOT_FOUND` - Campaign with ID not found
- `CAMPAIGN_INACTIVE` - Campaign status is not active
- `USER_NOT_FOUND` - Invalid user ID
- `GIFTS_EXHAUSTED` - No gifts with remaining quantity
- `LUCK_FAILED` - User was not lucky this time
- `TRANSACTION_FAILED` - Database transaction failed

---

## Common Data Structures

### Campaign Record
```
{
  id: string,
  publicSlug: string,
  name: string,
  status: 'active' | 'inactive' | 'expired',
  totalGifts: number,
  totalParticipants: number,
  // ... other fields
}
```

### Gift Record
```
{
  id: string,
  publicSlug: string,
  name: string,
  description: string,
  remainingQuantity: number,
  isRedeemable: boolean,
  supportedShops: string[] | null,
  autoGiftPayload: any[] | null, // For auto campaigns
  // ... other fields
}
```

### Code Gift Record (sub-collection of Gift)
```
{
  code: string,
  isRedeemed: boolean,
  redeemedByUserId: string | null,
  redeemedAt: timestamp | null,
  payload: any | null,
  // ... other fields
}
```

### User Gift Record
```
{
  userId: string,
  giftId: string,
  campaignId: string,
  campaignName: string,
  giftName: string,
  giftDescription: string,
  isRedeemable: boolean,
  isRedeemed: boolean | null,
  redeemedAt: timestamp | null,
  availedAt: timestamp,
  payload: any | null,
  supportedShops: string[] | null,
  redemptionId: string
}
```

## Security Measures
1. **Input Validation**: Validate all inputs for type, format, and required fields
2. **Authentication**: Verify user session/token before processing
3. **Transaction Safety**: Use database transactions for atomic operations
4. **Race Condition Prevention**: Implement proper locking mechanisms
5. **Audit Trail**: Log all attempts (success and failures) with timestamps

## Performance Considerations
1. **Indexing**: Ensure proper indexes on frequently queried fields (publicSlug, campaignId, userId)
2. **Caching**: Cache frequently accessed campaign and gift data
3. **Connection Pooling**: Use database connection pooling for better performance
4. **Batch Operations**: Consider batch updates for analytics data