# Firebase Analytics Integration Proposal

## Overview

This document outlines the plan for integrating Firebase Analytics (`firebase_analytics: ^12.1.2`) into the Prize24 app in a clean, testable, and maintainable way — aligned with the existing Riverpod + GoRouter + Sentry + Flavor architecture.

---

## Architecture Decision

### Proposed Structure

```
lib/
└── core/
    └── services/
        └── analytics/
            ├── analytics_service.dart         # Concrete implementation
            ├── analytics_service.g.dart       # Riverpod generated providers
            ├── i_analytics_service.dart       # Abstract interface
            └── analytics_events.dart          # Event name constants
```

---

## Design Principles

### 1. Abstract Interface for Testability
The project uses `mocktail` for testing. The service must be mockable.

```dart
abstract class IAnalyticsService {
  Future<void> setUserIdentifier(String userId);
  Future<void> setUserTrait(String name, String value);
  Future<void> logCustomEvent(String name, Map<String, dynamic> params);
  Future<void> logLogin(String method);
  Future<void> logGiftRedeemed({required String giftId, required String campaignId, required String shopId});
  Future<void> logShopFollowed(String shopId);
  Future<void> logCampaignViewed(String campaignId);
  Future<void> logQrCodeScanned(String shopId);
  Future<void> logSubscriptionStarted(String productId);
}
```

### 2. Riverpod Injection
Do **not** use `FirebaseAnalytics.instance` directly inside the class. Inject it via Riverpod so it can be overridden in tests.

```dart
@riverpod
FirebaseAnalytics firebaseAnalytics(Ref ref) => FirebaseAnalytics.instance;

@riverpod
IAnalyticsService analyticsService(Ref ref) {
  return AnalyticsService(ref.watch(firebaseAnalyticsProvider));
}
```

### 3. Flavor-Aware Collection
Uses the existing `FlavorConfig` from `bootstrap.dart`. Analytics collection is **disabled in development and staging** to keep production data clean.

```dart
AnalyticsService(this._analytics) {
  if (!FlavorConfig.isProduction) {
    _analytics.setAnalyticsCollectionEnabled(false);
  }
}
```

### 4. Safe Logging Wrapper
Analytics should **never crash the app**. All calls are wrapped in a `_safeLog` guard that reports to Sentry in production.

```dart
Future<void> _safeLog(Future<void> Function() action) async {
  try {
    await action();
  } catch (e, st) {
    if (FlavorConfig.isProduction) {
      await Sentry.captureException(e, stackTrace: st);
    }
  }
}
```

### 5. Automatic Screen Tracking via Router Observer
The existing `GoRouterObserver` in `routing/go_observor.dart` only prints to debug console. `FirebaseAnalyticsObserver` will be added alongside it in `app_router.dart` to automatically track every screen view.

```dart
final GoRouter router = GoRouter(
  observers: [
    GoRouterObserver(),
    FirebaseAnalyticsObserver(analytics: FirebaseAnalytics.instance),
  ],
  ...
);
```

### 6. Centralized Event Name Constants
All event name strings live in `analytics_events.dart` — no magic strings scattered across the app.

---

## Domain-Specific Events

Based on the features in this app, the following typed event methods should be added:

| Method | Trigger |
|---|---|
| `logLogin(method)` | Successful sign-in (Google, Apple, Phone) |
| `logGiftRedeemed(...)` | User redeems a gift/coupon |
| `logShopFollowed(shopId)` | User follows a new shop |
| `logCampaignViewed(campaignId)` | User opens a campaign detail |
| `logQrCodeScanned(shopId)` | QR scan during loyalty check-in |
| `logSubscriptionStarted(productId)` | User purchases a subscription via RevenueCat |
| `logGiftAvailed(giftId, campaignId)` | Gift is availed by vendor/staff scan |
| `logClubJoined(clubId)` | User joins a club |

---

## Tasks

### Phase 1 — Foundation
- [x] Create `lib/core/services/analytics/i_analytics_service.dart` — abstract interface
- [x] Create `lib/core/services/analytics/analytics_events.dart` — all event name constants
- [x] Create `lib/core/services/analytics/analytics_service.dart` — concrete implementation with:
  - Riverpod `@riverpod` provider annotations
  - Constructor-based `FlavorConfig` check
  - `_safeLog` wrapper using Sentry
  - All base methods (`setUserIdentifier`, `setUserTrait`, `logCustomEvent`, `logLogin`)
  - All domain-specific typed event methods

### Phase 2 — Router Integration
- [x] Add `FirebaseAnalyticsObserver` to `GoRouter` in `routing/app_router.dart` alongside the existing `GoRouterObserver`

### Phase 3 — Feature Integration
- [x] Call `logLogin()` after successful authentication (Google / Apple / Phone)
- [x] Call `setUserIdentifier()` after login and on app resume when user is already signed in
- [ ] Call `logGiftRedeemed()` in the redeem gift flow
- [ ] Call `logGiftAvailed()` in the scan/avail gift flow
- [ ] Call `logShopFollowed()` when user follows a shop
- [ ] Call `logCampaignViewed()` on campaign detail page open
- [ ] Call `logQrCodeScanned()` in the QR scan page
- [ ] Call `logSubscriptionStarted()` after successful RevenueCat purchase

### Phase 4 — Testing
- [ ] Write unit tests for `AnalyticsService` using `MockAnalyticsService` (mocktail)
- [ ] Verify analytics collection is disabled in dev/staging flavor builds

---

## Files to Create / Modify

| File | Action |
|---|---|
| `lib/core/services/analytics/i_analytics_service.dart` | Create |
| `lib/core/services/analytics/analytics_events.dart` | Create |
| `lib/core/services/analytics/analytics_service.dart` | Create |
| `lib/core/services/analytics/analytics_service.g.dart` | Auto-generated by build_runner |
| `lib/routing/app_router.dart` | Modify — add `FirebaseAnalyticsObserver` |
| Feature pages (auth, gifts, shops, campaigns, QR) | Modify — call analytics methods |

---

## Notes

- `firebase_analytics: ^12.1.2` is already in `pubspec.yaml` ✅
- No new packages needed
- `build_runner watch` is already running — generated files will update automatically
