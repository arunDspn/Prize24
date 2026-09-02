import 'package:prize24_app/core/services/analytics/analytics_service.dart';
import 'package:prize24_app/core/subscription/data/subscription_service.dart';
import 'package:prize24_app/features/global_controller/subscription/subscription_state.dart';
import 'package:prize24_app/utils/rc_helper_latest.dart';
import 'package:purchases_flutter/purchases_flutter.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'subscription_controller.g.dart';

@riverpod
class SubscriptionController extends _$SubscriptionController {
  @override
  FutureOr<SubscriptionState?> build() async {
    // Get revenue cat customer info and update user purchase info
    final customerInfo = await Purchases.getCustomerInfo();

    // Get virtual currencies and balance
    final virtualCurrencies = await Purchases.getVirtualCurrencies();
    final virtualCurrency = virtualCurrencies.all['P24COIN'];
    final balance = virtualCurrency?.balance ?? 0;

    if (customerInfo.entitlements.active.isNotEmpty) {
      // Debug: Print all entitlement keys to find the actual name
      print(
        '🔍 Active entitlements: ${customerInfo.entitlements.active.keys.toList()}',
      );

      // final maxShops = RevenueCatHelper.getMaxShops(customerInfo);
      // final maxCampaigns = RevenueCatHelper.getMaxCampaigns(customerInfo);
      // final maxUserFollowing = RevenueCatHelper.getMaxUserFollowing(
      //   customerInfo,
      // );
      // Use Subscription service

      final subData = await ref
          .read(subscriptionServiceProvider)
          .getEntitlementMetadata(customerInfo.entitlements.active.keys.first);

      final maxShops = subData.maxShops;
      final maxCampaigns = subData.maxCampaigns;
      final maxUserFollowing = subData.maxUsers;

      print(
        '📊 Max shops: $maxShops, campaigns: $maxCampaigns, following: $maxUserFollowing',
      );

      // Get the active entitlement name
      final activeEntitlementName = customerInfo.entitlements.active.keys.first;

      return SubscriptionState(
        maxShops: maxShops,
        maxCampaigns: maxCampaigns,
        maxUserFollowing: maxUserFollowing,
        coinBalance: balance,
        rcEntitlementName: activeEntitlementName,
      );
    }

    return null;
  }

  /// Update coin balance in the current state
  Future<void> updateCoinBalance(int newBalance) async {
    final currentState = state.value;
    if (currentState == null) return;

    state = AsyncData(currentState.copyWith(coinBalance: newBalance));
  }

  /// Fetch latest coin balance from RevenueCat and update state
  Future<void> refreshCoinBalance() async {
    final currentState = state.value;
    if (currentState == null) return;

    try {
      final virtualCurrencies = await Purchases.getVirtualCurrencies();
      final virtualCurrency = virtualCurrencies.all['P24COIN'];
      final balance = virtualCurrency?.balance ?? 0;

      state = AsyncData(currentState.copyWith(coinBalance: balance));
    } catch (e) {
      // Keep current state on error
      state = AsyncError(e, StackTrace.current);
    }
  }

  /// Recheck entitlements and update subscription state
  /// This fetches fresh data from RevenueCat without using ref.invalidateSelf()
  ///
  /// Set [isNewPurchase] to `true` when called immediately after a successful
  /// RevenueCat paywall purchase — this triggers the [partner_registration]
  /// analytics event.
  Future<void> recheckEntitlements({bool isNewPurchase = false}) async {
    state = const AsyncLoading();

    try {
      // Get fresh customer info from RevenueCat
      final customerInfo = await Purchases.getCustomerInfo();

      // Get virtual currencies and balance
      final virtualCurrencies = await Purchases.getVirtualCurrencies();
      final virtualCurrency = virtualCurrencies.all['P24COIN'];
      final balance = virtualCurrency?.balance ?? 0;

      if (customerInfo.entitlements.active.isNotEmpty) {
        // Debug: Print all entitlement keys to find the actual name
        print(
          '🔍 [Recheck] Active entitlements: ${customerInfo.entitlements.active.keys.toList()}',
        );

        final subData = await ref
            .read(subscriptionServiceProvider)
            .getEntitlementMetadata(
              customerInfo.entitlements.active.keys.first,
            );

        final maxShops = subData.maxShops;
        final maxCampaigns = subData.maxCampaigns;
        final maxUserFollowing = subData.maxUsers;

        print(
          '📊 [Recheck] Max shops: $maxShops, campaigns: $maxCampaigns, following: $maxUserFollowing',
        );

        // Get the active entitlement ID
        final activeEntitlementId = customerInfo.entitlements.active.keys.first;

        state = AsyncData(
          SubscriptionState(
            maxShops: maxShops,
            maxCampaigns: maxCampaigns,
            maxUserFollowing: maxUserFollowing,
            coinBalance: balance,
            rcEntitlementName: activeEntitlementId,
          ),
        );

        // Fire partner_registration only when this call follows a real purchase.
        if (isNewPurchase) {
          await ref
              .read(analyticsServiceProvider)
              .logPartnerRegistration(activeEntitlementId);
        }
      } else {
        state = AsyncData(
          SubscriptionState(
            maxShops: 0,
            maxCampaigns: 0,
            maxUserFollowing: 0,
            coinBalance: balance,
            rcEntitlementName: '',
          ),
        );
      }
    } catch (e, stackTrace) {
      state = AsyncError(e, stackTrace);
    }
  }

  /// Alternative: Use ref.invalidateSelf() to trigger a rebuild
  /// This is simpler and reuses the build() logic
  void refreshSubscription() {
    ref.invalidateSelf();
  }

  /// Check if user has an active subscription
  bool hasActiveSubscription() {
    final currentState = state.value;
    if (currentState == null) return false;
    return currentState.rcEntitlementName.isNotEmpty;
  }

  /// Check if user can create a shop
  bool canCreateShop(int currentShopCount) {
    final currentState = state.value;
    if (currentState == null) return false;
    return currentShopCount < currentState.maxShops;
  }

  /// Check if user can create a campaign
  bool canCreateCampaign(int currentCampaignCount) {
    final currentState = state.value;
    if (currentState == null) return false;
    return currentCampaignCount < currentState.maxCampaigns;
  }

  /// Check if user can follow more users
  bool canFollowMoreUsers(int currentFollowingCount) {
    final currentState = state.value;
    if (currentState == null) return false;
    return currentFollowingCount < currentState.maxUserFollowing;
  }
}
