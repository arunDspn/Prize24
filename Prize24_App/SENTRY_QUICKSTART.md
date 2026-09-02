# Sentry Error Tracking - Quick Start Guide

## 📋 Summary

You now have a **production-only** Sentry error tracking system that will capture critical errors without affecting development/staging environments.

## 🎯 What You Have

### 1. **SentryHelper Utility** (`lib/utils/sentry_helper.dart`)
- Centralized error handling
- Production-only capture via `FlavorConfig.isProduction`
- User context management
- Breadcrumb tracking
- Custom tagging

### 2. **Implementation Guide** (`lib/utils/sentry_implementation_guide.md`)
- Complete examples for all critical areas
- Priority ranking
- Testing strategy
- Sentry dashboard filtering tips

### 3. **Reference Examples**
- `auth_repository_with_sentry_example.dart` - Authentication tracking
- `subscription_controller_with_sentry_example.dart` - Payment tracking

## 🚀 Quick Start (3 Steps)

### Step 1: Update Auth Repository
**File**: `lib/features/authentication/data/repository/auth_repository_firebase_impl.dart`

Add import:
```dart
import 'package:prize24_app/utils/sentry_helper.dart';
```

Wrap `signInWithGoogle()` and `signInWithApple()` with:
```dart
return await SentryHelper.executeWithErrorHandling<AppUser>(
  operationName: 'signInWithGoogle',
  operation: () async {
    // Your existing code here
    SentryHelper.addBreadcrumb(message: 'Starting Google Sign In', category: 'auth');
    
    // ... existing implementation ...
    
    // After successful sign in:
    SentryHelper.setUser(
      userId: appUser.userId,
      email: appUser.userEmail,
      username: appUser.userName,
    );
    
    return appUser;
  },
  additionalContext: {'auth_method': 'google'},
);
```

### Step 2: Update Auth Controller
**File**: `lib/features/global_controller/auth/auth_controller.dart`

Add import:
```dart
import 'package:prize24_app/utils/sentry_helper.dart';
```

Update `build()`:
```dart
@override
FutureOr<AppUser?> build() async {
  final user = await ref.read(authRepositoryProvider).checkAuth();
  
  if (user != null) {
    SentryHelper.setUser(
      userId: user.userId,
      email: user.userEmail,
      username: user.userName,
    );
  }
  
  return user;
}
```

Update `signOut()`:
```dart
Future<void> signOut() async {
  state = const AsyncLoading();

  state = await AsyncValue.guard(() async {
    await ref.read(authRepositoryProvider).signOut();
    SentryHelper.clearUser(); // Clear Sentry context
    return null;
  });
}
```

### Step 3: Update Subscription Controller
**File**: `lib/features/global_controller/subscription/subscription_controller.dart`

Add import:
```dart
import 'package:prize24_app/utils/sentry_helper.dart';
```

Wrap `recheckEntitlements()`:
```dart
Future<void> recheckEntitlements() async {
  state = const AsyncLoading();

  try {
    SentryHelper.addBreadcrumb(
      message: 'Rechecking entitlements',
      category: 'subscription',
    );

    final customerInfo = await Purchases.getCustomerInfo();
    
    // ... rest of your implementation ...
    
    if (customerInfo.entitlements.active.isNotEmpty) {
      final activeEntitlement = customerInfo.entitlements.active.keys.first;
      SentryHelper.setTag('subscription_tier', activeEntitlement);
    }
    
  } catch (e, stackTrace) {
    await SentryHelper.captureException(
      e,
      stackTrace: stackTrace,
      hint: 'Failed to recheck entitlements',
      extra: {'operation': 'recheckEntitlements'},
    );
    state = AsyncError(e, stackTrace);
  }
}
```

## ✅ Testing

### Development/Staging (Sentry OFF)
```bash
# Run development
flutter run --flavor development -t lib/main_development.dart

# Errors are logged but NOT sent to Sentry
# Check console for: "Error captured: ..."
```

### Production (Sentry ON)
```bash
# Build production
flutter build apk --flavor production -t lib/main_production.dart

# Errors are logged AND sent to Sentry
# Check Sentry dashboard for captured errors
```

## 📊 Verify It's Working

1. **In Development**: Trigger an error → Should see log only  
2. **In Production**: Trigger an error → Should see in Sentry dashboard

### Test Error:
```dart
// Add this temporarily to test
Future<void> testSentry() async {
  await SentryHelper.captureException(
    Exception('Test error from ${FlavorConfig.name}'),
    hint: 'Test error',
  );
}
```

## 🎯 Priority Areas (Implement in Order)

1. ✅ **Authentication** (Step 1) - DONE
   - signInWithGoogle()
   - signInWithApple()
   - Set/Clear user context

2. ✅ **Subscription Operations** (Step 2 & 3) - DONE
   - recheckEntitlements()
   - Purchase flows
   - Restore purchases

3. 🔄 **Data Operations** (Optional - Next Steps)
   - Campaign creation
   - Shop creation
   - Gift creation
   - Profile updates

See `sentry_implementation_guide.md` for detailed examples.

## 📈 Monitoring in Sentry Dashboard

Filter by:
- **Environment**: `production`
- **Tags**: 
  - `flavor: production`
  - `has_subscription: true/false`
  - `subscription_tier: standard`
- **User**: Filter errors by specific user ID
- **Operation**: Group by `operationName`

### Useful Queries:
```
# Authentication errors only
operation:signInWithGoogle OR operation:signInWithApple

# Subscription errors only
category:subscription OR category:purchase

# Errors from specific user
user.id:"<userId>"

# Critical errors only
level:error
```

## 🔐 Security Notes

1. **No PII in extra data** - User ID only, no email/phone in extra fields
2. **Production only** - Controlled by `FlavorConfig.isProduction`
3. **User context cleared on sign out** - Privacy compliant
4. **Breadcrumbs** - Max 100 per session (Sentry default)

## 📝 Next Steps

1. ✅ Complete Steps 1-3 above
2. Test in development (verify no Sentry sends)
3. Deploy to production
4. Monitor Sentry dashboard for 24 hours
5. Review captured errors
6. Add tracking to additional critical areas as needed

## 🆘 Troubleshooting

**Q: Errors not appearing in Sentry?**
- Check `FlavorConfig.isProduction` returns true
- Verify Sentry DSN is correct in bootstrap.dart
- Check network connectivity

**Q: Too many errors?**
- Adjust `tracesSampleRate` in bootstrap.dart
- Add filters in Sentry dashboard
- Use `SentryLevel.warning` for less critical issues

**Q: Missing user context?**
- Ensure `SentryHelper.setUser()` called after login
- Verify user data passed correctly
- Check auth controller `build()` method

## 📚 Resources

- [Sentry Flutter Docs](https://docs.sentry.io/platforms/flutter/)
- [RevenueCat Error Handling](https://docs.revenuecat.com/docs/errors)
- Implementation examples in `/lib/features/.../..._with_sentry_example.dart`

---

**Ready to go! Start with Steps 1-3 and monitor results.** 🎉
