import 'package:purchases_flutter/purchases_flutter.dart';

/// Centralized helper class for RevenueCat entitlement management
/// This ensures consistent tier limits across the app
class RevenueCatHelper {
  RevenueCatHelper._();

  // Entitlement identifier - should match RevenueCat dashboard configuration
  static const String standardEntitlement = 'standard_pacakge_entitlement';

  // Standard plan limits
  static const int _maxShops = 1;
  static const int _maxCampaigns = 1;
  static const int _maxUserFollowing = 1500;

  /// Check if user has an active subscription
  static bool hasActiveSubscription(CustomerInfo customerInfo) {
    return customerInfo.entitlements.active.isNotEmpty;
  }

  /// Get maximum allowed shops for the active subscription
  static int getMaxShops(CustomerInfo customerInfo) {
    return hasActiveSubscription(customerInfo) ? _maxShops : 0;
  }

  /// Get maximum allowed campaigns for the active subscription
  static int getMaxCampaigns(CustomerInfo customerInfo) {
    return hasActiveSubscription(customerInfo) ? _maxCampaigns : 0;
  }

  /// Get maximum allowed user following for the active subscription
  static int getMaxUserFollowing(CustomerInfo customerInfo) {
    return hasActiveSubscription(customerInfo) ? _maxUserFollowing : 0;
  }

  /// Get all limits for the active subscription
  static TierLimits getTierLimits(CustomerInfo customerInfo) {
    if (!hasActiveSubscription(customerInfo)) {
      return TierLimits(
        maxUserFollowing: 0,
        maxShops: 0,
        maxCampaigns: 0,
      );
    }
    return TierLimits(
      maxUserFollowing: _maxUserFollowing,
      maxShops: _maxShops,
      maxCampaigns: _maxCampaigns,
    );
  }

  /// Check if user can create a new shop
  static bool canCreateShop(CustomerInfo customerInfo, int currentShopCount) {
    final maxShops = getMaxShops(customerInfo);
    return currentShopCount < maxShops;
  }

  /// Check if user can create a new campaign
  static bool canCreateCampaign(
    CustomerInfo customerInfo,
    int currentCampaignCount,
  ) {
    final maxCampaigns = getMaxCampaigns(customerInfo);
    return currentCampaignCount < maxCampaigns;
  }

  /// Check if user can follow more users
  static bool canFollowMoreUsers(
    CustomerInfo customerInfo,
    int currentFollowingCount,
  ) {
    final maxFollowing = getMaxUserFollowing(customerInfo);
    return currentFollowingCount < maxFollowing;
  }
}

/// Tier limits configuration
class TierLimits {
  TierLimits({
    required this.maxUserFollowing,
    required this.maxShops,
    required this.maxCampaigns,
  });
  final int maxUserFollowing;
  final int maxShops;
  final int maxCampaigns;
}
