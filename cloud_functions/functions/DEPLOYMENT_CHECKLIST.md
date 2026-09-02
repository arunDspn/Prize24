# Deployment Checklist - Shop Follow & Loyalty System

## ✅ Pre-Deployment Verification

### Code Quality
- [x] All TypeScript files compile without errors
- [x] All functions exported in `index.ts`
- [x] Type definitions added to `types.ts`
- [x] Error codes defined and used consistently
- [x] Logging added for audit trails
- [x] Input validation implemented
- [x] Authentication checks in place

### Functions Implemented
- [x] `followShopByVendor` - Vendor adds follower
- [x] `followShopByStaff` - Staff adds follower
- [x] `unfollowShop` - User unfollows shop
- [x] `removeFollower` - Vendor removes follower
- [x] `checkInUser` - Daily check-in with streak tracking
- [x] `addOfferToShop` - Add offer with FCM notifications

### Documentation
- [x] System requirements documented (`shop_user_relation.md`)
- [x] Implementation summary created (`IMPLEMENTATION_COMPLETE.md`)
- [x] API reference guide created (`API_REFERENCE.md`)
- [x] Error codes documented
- [x] Database structure documented

---

## 🚀 Deployment Steps

### 1. Build Functions
```bash
cd functions
npm run build
```

**Expected Output**: TypeScript compilation completes without errors

### 2. Test Build Artifacts
```bash
# Verify all JavaScript files exist
ls -la lib/shop_user_relationship/

# Check exports in compiled index.js
grep "followShopByVendor\|checkInUser\|addOfferToShop" lib/index.js
```

### 3. Deploy to Firebase
```bash
# Deploy all functions
firebase deploy --only functions

# OR deploy shop functions only
firebase deploy --only functions:followShopByVendor,functions:followShopByStaff,functions:unfollowShop,functions:removeFollower,functions:checkInUser,functions:addOfferToShop
```

### 4. Verify Deployment
```bash
# List deployed functions
firebase functions:list | grep -E "followShop|checkIn|addOffer"

# Check function logs
firebase functions:log --only followShopByVendor
```

---

## 📋 Post-Deployment Testing

### Test 1: Follow Shop (Vendor)
```bash
# Use Firebase Console or client app
# Expected: User added as follower with initialized streak data
```

**Verify**:
- [ ] Document created at `/shops/{shopId}/followers/{userId}`
- [ ] Document created at `/users/{userId}/followedShops/{shopId}`
- [ ] Both documents have `cumulativeStreak: 0`, `consecutiveDays: 0`
- [ ] FCM subscription successful
- [ ] `totalFollowers` and `totalFollowing` incremented

### Test 2: Check-In User
```bash
# Vendor or staff scans user QR code
# Expected: Streak incremented, response shows current stats
```

**Verify**:
- [ ] `cumulativeStreak` incremented by 1 (or bonus value)
- [ ] `consecutiveDays` calculated correctly
- [ ] `lastCheckInDate` updated
- [ ] User's copy in `followedShops` updated
- [ ] Second check-in same day fails with `ALREADY_CHECKED_IN_TODAY`

### Test 3: Consecutive Days & Bonus
```bash
# Check in for multiple consecutive days
# Expected: Consecutive streak increases, bonus applied when threshold met
```

**Verify**:
- [ ] Consecutive days increment when checked in yesterday
- [ ] Consecutive days reset to 1 when day missed
- [ ] Bonus applied at correct intervals (e.g., every 7 consecutive days)
- [ ] `bonusApplied: true` in response when bonus triggered

### Test 4: Gift Day Detection
```bash
# Configure shop with giftDayCycle (e.g., 7)
# Check in until cumulative reaches cycle
# Expected: Gift day flagged in response
```

**Verify**:
- [ ] `isGiftDay: true` when cumulative matches cycle
- [ ] `giftInfo` included in response
- [ ] `lastGiftDayStreak` updated
- [ ] Gift day not triggered again until next cycle

### Test 5: Add Offer
```bash
# Vendor adds promotional offer
# Expected: Offer created, FCM notification sent
```

**Verify**:
- [ ] Offer document created at `/shops/{shopId}/offers/{offerId}`
- [ ] FCM notification sent to topic
- [ ] Followers receive push notification
- [ ] `notificationsSent` count accurate

### Test 6: Unfollow & Remove
```bash
# User unfollows or vendor removes
# Expected: Relationship deleted, counters decremented
```

**Verify**:
- [ ] Documents deleted from both sides
- [ ] Counters decremented
- [ ] FCM unsubscription attempted

---

## 🔍 Monitoring & Logs

### Key Metrics to Watch
- [ ] Function execution time (should be < 5 seconds)
- [ ] Error rate (should be < 1%)
- [ ] FCM delivery success rate
- [ ] Transaction success rate

### Log Queries
```bash
# Check for errors
firebase functions:log --only followShopByVendor | grep ERROR

# Monitor check-in activity
firebase functions:log --only checkInUser | grep "checked in successfully"

# Track gift days
firebase functions:log --only checkInUser | grep "isGiftDay: true"
```

---

## 🛡️ Security Checklist

### Firestore Security Rules
```javascript
service cloud.firestore {
  match /databases/{database}/documents {
    // Shop followers - vendor and user can read their own
    match /shops/{shopId}/followers/{userId} {
      allow read: if request.auth != null && 
        (request.auth.uid == userId || 
         request.auth.uid == get(/databases/$(database)/documents/shops/$(shopId)).data.shopOwnerId);
      allow write: if false; // Only via cloud functions
    }
    
    // User following shops - user can read their own
    match /users/{userId}/followedShops/{shopId} {
      allow read: if request.auth != null && request.auth.uid == userId;
      allow write: if false; // Only via cloud functions
    }
    
    // Shop offers - public read, vendor write
    match /shops/{shopId}/offers/{offerId} {
      allow read: if true; // Public
      allow write: if false; // Only via cloud functions
    }
  }
}
```

### Function Security
- [x] All functions require authentication
- [x] Vendor ownership validated
- [x] Staff authorization checked
- [x] Input sanitization implemented
- [x] SQL injection not applicable (Firestore)
- [x] Rate limiting (Firebase default)

---

## 🔧 Configuration Required

### Shop Document Setup
Before using the system, each shop needs:

```javascript
// Set in shop document
{
  shopOwnerId: "vendor_user_id",
  shopName: "My Coffee Shop",
  shopDescription: "Best coffee in town",
  shopAddress: "123 Main St",
  shopPhone: "+1234567890",
  status: "active",
  
  // Loyalty configuration
  associatedCampaignId: "campaign_123" | null,  // Required for gift days
  campaignName: "Coffee Rewards",
  giftDayCycle: 7,                              // Gift every 7 check-ins
  
  // Bonus configuration (optional)
  bonusIncrementDaysRequired: 7,                // Bonus after 7 consecutive days
  bonusIncrementValue: 2,                       // Add 2 instead of 1
  
  totalFollowers: 0,
  createdAt: serverTimestamp(),
  updatedAt: serverTimestamp()
}
```

### FCM Setup
- [ ] Firebase Cloud Messaging enabled
- [ ] FCM server key configured
- [ ] Client apps can receive FCM notifications
- [ ] Topics use shop IDs

---

## 🐛 Common Issues & Solutions

### Issue: FCM subscription fails
**Solution**: Ensure FCM token is valid and not expired. Client should refresh token periodically.

### Issue: Check-in allowed twice same day
**Solution**: Verify timezone handling. Consider adding shop timezone field for accurate day boundaries.

### Issue: Consecutive days not resetting
**Solution**: Check `wasCheckedInYesterday()` logic. Ensure date comparison accounts for timezone.

### Issue: Gift day not detected
**Solution**: Verify `associatedCampaignId` is not null and `giftDayCycle` is set in shop document.

### Issue: Staff cannot add followers
**Solution**: Check staff status is "active" in `shopStaff` collection with document ID format `{shopId}_{staffId}`.

---

## 📊 Success Criteria

- [ ] All 6 functions deploy successfully
- [ ] Functions appear in Firebase Console
- [ ] Test follow/unfollow works end-to-end
- [ ] Check-in increments streaks correctly
- [ ] Bonus logic applies when configured
- [ ] Gift day detection works
- [ ] FCM notifications received by followers
- [ ] No critical errors in logs after 24 hours
- [ ] Response times < 5 seconds
- [ ] Client apps integrate successfully

---

## 📞 Support

### Documentation
- System Design: `shop_user_relation.md`
- Implementation: `IMPLEMENTATION_COMPLETE.md`
- API Guide: `API_REFERENCE.md`

### Log Locations
- Firebase Console: Functions > Logs
- Cloud Logging: GCP Console
- Client logs: App-specific

### Rollback Plan
```bash
# List previous versions
firebase functions:list

# Rollback to previous version
firebase deploy --only functions --version <previous-version>
```

---

## ✅ Final Sign-Off

- [ ] All functions deployed
- [ ] All tests passed
- [ ] Documentation complete
- [ ] Client team notified
- [ ] Monitoring configured
- [ ] Security rules deployed

**Deployment Date**: _________________  
**Deployed By**: _________________  
**Version**: 1.0.0  
**Status**: ⏳ Pending / ✅ Complete
