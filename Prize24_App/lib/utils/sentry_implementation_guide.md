# Sentry Error Tracking Implementation Guide

This guide shows how to implement Sentry error tracking in critical areas of the app, **production-only**.

## ✅ What's Already Implemented

In `bootstrap.dart`:
```dart
FlutterError.onError = (details) {
  logger.e('Flutter Error: ${details.exceptionAsString()}');
  if (enableSentry) {
    Sentry.captureException(details.exception, stackTrace: details.stack);
  }
};
```

This catches **framework-level errors** (widget errors, rendering issues).

---

## 🎯 Critical Areas to Add Sentry Tracking

### 1. **Authentication Operations** (CRITICAL)
- User login/signup failures
- Token refresh errors
- Profile update errors

### 2. **Payment/Subscription Operations** (CRITICAL)
- RevenueCat purchase failures
- Subscription state errors
- Entitlement sync issues

### 3. **Data Write Operations** (HIGH PRIORITY)
- Campaign creation failures
- Shop creation failures
- Gift creation failures
- Profile updates

### 4. **Data Read Operations** (MEDIUM PRIORITY)
- Critical data fetching failures
- User data loading errors

---

## 📝 Implementation Examples

### Example 1: Authentication - Sign In with Google

**File**: `lib/features/authentication/data/repository/auth_repository_firebase_impl.dart`

**Current Code**:
```dart
@override
Future<AppUser?> signInWithGoogle() async {
  final googleSignIn = GoogleSignIn();
  final googleUser = await googleSignIn.signIn();
  // ... rest of implementation
}
```

**Enhanced with Sentry** (Production Only):
```dart
import 'package:prize24_app/utils/sentry_helper.dart';

@override
Future<AppUser?> signInWithGoogle() async {
  return await SentryHelper.executeWithErrorHandling<AppUser?>(
    operationName: 'signInWithGoogle',
    operation: () async {
      SentryHelper.addBreadcrumb(
        message: 'Starting Google Sign In',
        category: 'auth',
      );

      final googleSignIn = GoogleSignIn();
      final googleUser = await googleSignIn.signIn();

      if (googleUser == null) {
        throw Exception('Google sign-in was cancelled by user');
      }

      final googleAuth = await googleUser.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final userCredential = await _firebaseAuth.signInWithCredential(credential);

      SentryHelper.addBreadcrumb(
        message: 'Google Sign In successful',
        category: 'auth',
        data: {'userId': userCredential.user?.uid},
      );

      // ... rest of your implementation
      final appUser = await _processUserSignIn(userCredential);

      // Set user context in Sentry for future errors
      if (appUser != null) {
        SentryHelper.setUser(
          userId: appUser.userId,
          email: appUser.userEmail,
          username: appUser.userName,
        );
      }

      return appUser;
    },
    additionalContext: {
      'auth_method': 'google',
    },
  );
}
```

---

### Example 2: RevenueCat - Purchase Flow

**File**: `lib/features/vendor/presentation/become_a_vendor_paywall/view_model/register_user_as_vendor_controller.dart`

**Current Code**:
```dart
Future<void> registerAsVendor() async {
  state = const AsyncValue.loading();
  state = await AsyncValue.guard(() async {
    final userId = ref.read(authControllerProvider).requireValue?.userId;
    if (userId == null) {
      throw Exception('User not authenticated');
    }
    await ref.read(vendorRepositoryProvider).registerAsVendor(userId: userId);
    return userId;
  });
}
```

**Enhanced with Sentry**:
```dart
import 'package:prize24_app/utils/sentry_helper.dart';

Future<void> registerAsVendor() async {
  state = const AsyncValue.loading();

  state = await AsyncValue.guard(() async {
    return await SentryHelper.executeWithErrorHandling<String>(
      operationName: 'registerAsVendor',
      operation: () async {
        final userId = ref.read(authControllerProvider).requireValue?.userId;
        
        if (userId == null) {
          // Track authentication failure
          await SentryHelper.captureMessage(
            'Registration attempted without authenticated user',
            level: SentryLevel.warning,
          );
          throw Exception('User not authenticated');
        }

        SentryHelper.addBreadcrumb(
          message: 'Starting vendor registration',
          category: 'subscription',
          data: {'userId': userId},
        );

        await ref.read(vendorRepositoryProvider).registerAsVendor(userId: userId);

        SentryHelper.addBreadcrumb(
          message: 'Vendor registration successful',
          category: 'subscription',
        );

        return userId;
      },
      additionalContext: {
        'feature': 'vendor_registration',
      },
    ) ?? '';
  });
}
```

---

### Example 3: RevenueCat - Purchase Subscription

**File**: `lib/features/subscriptions/presentation/manage_subscriptions/ui/manage_subscriptions_page.dart`

**In the `_launchPaywall` method**:
```dart
Future<void> _launchPaywall(BuildContext context, SubscriptionTier tier) async {
  return await SentryHelper.executeWithErrorHandling(
    operationName: 'launchPaywall',
    operation: () async {
      final placement = tierToPlacementMap[tier];
      if (placement == null) {
        throw Exception('No placement found for tier: ${tier.name}');
      }

      SentryHelper.addBreadcrumb(
        message: 'Launching paywall',
        category: 'subscription',
        data: {
          'tier': tier.name,
          'placement': placement,
        },
      );

      final offering = await Purchases.getCurrentOfferingForPlacement(placement);
      
      if (offering == null) {
        await SentryHelper.captureMessage(
          'No offering found for placement: $placement',
          level: SentryLevel.warning,
          extra: {'tier': tier.name, 'placement': placement},
        );
        
        if (context.mounted) {
          _showToast('No offering found for ${tier.name} tier', false);
        }
        return;
      }

      final result = await RevenueCatUI.presentPaywall(offering: offering);

      if (result == PaywallResult.purchased) {
        SentryHelper.addBreadcrumb(
          message: 'Purchase successful',
          category: 'subscription',
          data: {'tier': tier.name},
        );

        await Purchases.getCustomerInfo();
        await ref.read(subscriptionControllerProvider.notifier).recheckEntitlements();
        await _loadCustomerInfo();
        
        if (context.mounted) {
          _showToast('Successfully upgraded to ${tier.name} tier!', true);
        }
      } else if (result == PaywallResult.error) {
        await SentryHelper.captureMessage(
          'Paywall purchase error',
          level: SentryLevel.error,
          extra: {'tier': tier.name},
        );
      }
    },
    additionalContext: {
      'tier': tier.name,
      'feature': 'subscription_purchase',
    },
  );
}
```

---

### Example 4: Campaign Creation

**File**: `lib/features/campaign/domain/use_cases/create_campaign/create_campaign_usecase.dart`

**Current Code**:
```dart
Future<CampaignModel> call({required CampaignModel campaign}) async {
  try {
    _validateCampaign(campaign);
    final createdCampaign = await _campaignRepository.addCampaign(campaign: campaign);
    return createdCampaign;
  } catch (e) {
    throw Exception('Failed to create campaign: $e');
  }
}
```

**Enhanced with Sentry**:
```dart
import 'package:prize24_app/utils/sentry_helper.dart';

Future<CampaignModel> call({required CampaignModel campaign}) async {
  return await SentryHelper.executeWithErrorHandling<CampaignModel>(
    operationName: 'createCampaign',
    operation: () async {
      SentryHelper.addBreadcrumb(
        message: 'Creating campaign',
        category: 'campaign',
        data: {
          'campaignName': campaign.name,
          'vendorId': campaign.vendorId,
          'totalParticipants': campaign.totalParticipants.toString(),
        },
      );

      _validateCampaign(campaign);
      
      final createdCampaign = await _campaignRepository.addCampaign(campaign: campaign);

      SentryHelper.addBreadcrumb(
        message: 'Campaign created successfully',
        category: 'campaign',
        data: {'campaignId': createdCampaign.id ?? 'unknown'},
      );

      return createdCampaign;
    },
    additionalContext: {
      'campaignName': campaign.name,
      'vendorId': campaign.vendorId,
      'totalParticipants': campaign.totalParticipants,
    },
  ) ?? campaign; // Fallback to original campaign on error
}
```

---

### Example 5: Shop Creation

**File**: `lib/features/shop/domain/use_cases/add_shop/add_shop_usecase.dart`

```dart
import 'package:prize24_app/utils/sentry_helper.dart';

Future<ShopModel> call(ShopModel shop) async {
  return await SentryHelper.executeWithErrorHandling<ShopModel>(
    operationName: 'addShop',
    operation: () async {
      SentryHelper.addBreadcrumb(
        message: 'Creating shop',
        category: 'shop',
        data: {
          'shopName': shop.shopName,
          'vendorId': shop.vendorId,
        },
      );

      final createdShop = await _shopRepository.addNewShop(shop: shop);

      SentryHelper.addBreadcrumb(
        message: 'Shop created successfully',
        category: 'shop',
        data: {'shopId': createdShop.shopId},
      );

      return createdShop;
    },
    additionalContext: {
      'shopName': shop.shopName,
      'vendorId': shop.vendorId,
    },
  ) ?? shop;
}
```

---

### Example 6: Firestore Write Errors

**File**: `lib/repository/user/user_repository_firebase_impl.dart`

**Current Code**:
```dart
@override
Future<void> updateUserName({
  required String userId,
  required String newUserName,
}) async {
  final userRef = _firestore.collection('users').doc(userId);
  await userRef.update({'userName': newUserName});
}
```

**Enhanced**:
```dart
import 'package:prize24_app/utils/sentry_helper.dart';

@override
Future<void> updateUserName({
  required String userId,
  required String newUserName,
}) async {
  await SentryHelper.executeWithErrorHandling(
    operationName: 'updateUserName',
    operation: () async {
      final userRef = _firestore.collection('users').doc(userId);
      await userRef.update({'userName': newUserName});

      SentryHelper.addBreadcrumb(
        message: 'Username updated',
        category: 'user',
        data: {'userId': userId},
      );
    },
    additionalContext: {
      'userId': userId,
      'operation': 'profile_update',
    },
  );
}
```

---

## 🔄 Update Bootstrap.dart for User Context

Add this to your auth check in auth controller:

**File**: `lib/features/global_controller/auth/auth_controller.dart`

```dart
import 'package:prize24_app/utils/sentry_helper.dart';

@override
FutureOr<AppUser?> build() async {
  final user = await ref.read(authRepositoryProvider).checkAuth();
  
  // Set Sentry user context (production only)
  if (user != null) {
    SentryHelper.setUser(
      userId: user.userId,
      email: user.userEmail,
      username: user.userName,
    );
  }
  
  return user;
}

Future<void> signOut() async {
  state = const AsyncLoading();

  state = await AsyncValue.guard(() async {
    await ref.read(authRepositoryProvider).signOut();
    
    // Clear Sentry user context
    SentryHelper.clearUser();
    
    return null;
  });
}
```

---

## 📊 Priority Ranking for Implementation

### Must Have (Critical - Implement First)
1. ✅ `signInWithGoogle()` - auth_repository_firebase_impl.dart
2. ✅ `signInWithApple()` - auth_repository_firebase_impl.dart  
3. ✅ `registerAsVendor()` - register_user_as_vendor_controller.dart
4. ✅ `_launchPaywall()` - manage_subscriptions_page.dart and become_a_vendor_paywall_page.dart
5. ✅ `recheckEntitlements()` - subscription_controller.dart

### Should Have (High Priority)
6. ✅ `createCampaign()` - create_campaign_usecase.dart
7. ✅ `addShop()` - add_shop_usecase.dart
8. ✅ `createGift()` - create_gift_usecase.dart (if exists)
9. ✅ `updateUserName()` - user_repository_firebase_impl.dart

### Nice to Have (Medium Priority)
10. ✅ Critical data fetches that impact UX
11. ✅ Payment transaction flows
12. ✅ FCM token update errors

---

## 🎛️ Testing Strategy

### Development/Staging
- Errors are **logged only** (not sent to Sentry)
- Use logger to see what would be captured

### Production
- Errors are **logged AND sent to Sentry**
- Full context and breadcrumbs included

---

## 🔍 Sentry Dashboard Filters

Once implemented, filter errors in Sentry by:
- **Tag**: `flavor: production`
- **Category**: `auth`, `subscription`, `campaign`, `shop`, etc.
- **User ID**: Track issues per user
- **Operation Name**: Group by operation type

---

## ⚠️ Important Notes

1. **FlavorConfig.isProduction** gates all Sentry captures
2. **Always log locally** with logger regardless of environment
3. **Add breadcrumbs** for tracking user journey before errors
4. **Set user context** after authentication
5. **Clear user context** on sign out
6. **Include relevant context** in extra data for debugging

---

## 🚀 Quick Start

1. Import SentryHelper in your file
2. Wrap critical operations with `executeWithErrorHandling`
3. Add breadcrumbs for user flow tracking
4. Set user context after authentication
5. Deploy to production and monitor Sentry dashboard
