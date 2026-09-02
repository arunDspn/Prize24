// import 'package:purchases_flutter/purchases_flutter.dart';

// /// Centralized helper class for RevenueCat entitlement management
// /// This ensures consistent tier limits across the app
// class RevenueCatHelper {
//   RevenueCatHelper._();

//   // Entitlement identifiers - should match RevenueCat dashboard configuration
//   static const String bronzeEntitlement = 'bronze';
//   static const String silverEntitlement = 'silver';
//   static const String goldEntitlement = 'gold';
//   static const String platinumEntitlement = 'platinum';

//   /// Get the active vendor tier from customer info
//   static VendorTier? getActiveVendorTier(CustomerInfo customerInfo) {
//     if (customerInfo.entitlements.active.isEmpty) {
//       return null;
//     }

//     // Check in priority order (highest to lowest)
//     if (customerInfo.entitlements.active.containsKey(platinumEntitlement)) {
//       return VendorTier.platinum;
//     } else if (customerInfo.entitlements.active.containsKey(goldEntitlement)) {
//       return VendorTier.gold;
//     } else if (customerInfo.entitlements.active
//         .containsKey(silverEntitlement)) {
//       return VendorTier.silver;
//     } else if (customerInfo.entitlements.active
//         .containsKey(bronzeEntitlement)) {
//       return VendorTier.bronze;
//     }

//     return null;
//   }

//   /// Get maximum allowed shops for the active tier
//   static int getMaxShops(CustomerInfo customerInfo) {
//     final tier = getActiveVendorTier(customerInfo);
//     if (tier == null) return 0;
//     return _getTierLimits(tier).maxShops;
//   }

//   /// Get maximum allowed campaigns for the active tier
//   static int getMaxCampaigns(CustomerInfo customerInfo) {
//     final tier = getActiveVendorTier(customerInfo);
//     if (tier == null) return 0;
//     return _getTierLimits(tier).maxCampaigns;
//   }

//   /// Get maximum allowed user following for the active tier
//   static int getMaxUserFollowing(CustomerInfo customerInfo) {
//     final tier = getActiveVendorTier(customerInfo);
//     if (tier == null) return 0;
//     return _getTierLimits(tier).maxUserFollowing;
//   }

//   /// Get all limits for the active tier
//   static TierLimits getTierLimits(CustomerInfo customerInfo) {
//     final tier = getActiveVendorTier(customerInfo);
//     if (tier == null) {
//       return TierLimits(
//         maxUserFollowing: 0,
//         maxShops: 0,
//         maxCampaigns: 0,
//       );
//     }
//     return _getTierLimits(tier);
//   }

//   /// Check if user can create a new shop
//   static bool canCreateShop(CustomerInfo customerInfo, int currentShopCount) {
//     final maxShops = getMaxShops(customerInfo);
//     return currentShopCount < maxShops;
//   }

//   /// Check if user can create a new campaign
//   static bool canCreateCampaign(
//     CustomerInfo customerInfo,
//     int currentCampaignCount,
//   ) {
//     final maxCampaigns = getMaxCampaigns(customerInfo);
//     return currentCampaignCount < maxCampaigns;
//   }

//   /// Check if user can follow more users
//   static bool canFollowMoreUsers(
//     CustomerInfo customerInfo,
//     int currentFollowingCount,
//   ) {
//     final maxFollowing = getMaxUserFollowing(customerInfo);
//     return currentFollowingCount < maxFollowing;
//   }

//   /// Get tier limits configuration
//   static TierLimits _getTierLimits(VendorTier tier) {
//     switch (tier) {
//       case VendorTier.bronze:
//         return TierLimits(
//           maxUserFollowing: 300,
//           maxShops: 1,
//           maxCampaigns: 1,
//         );
//       case VendorTier.silver:
//         return TierLimits(
//           maxUserFollowing: 900,
//           maxShops: 3,
//           maxCampaigns: 3,
//         );
//       case VendorTier.gold:
//         return TierLimits(
//           maxUserFollowing: 1800,
//           maxShops: 6,
//           maxCampaigns: 6,
//         );
//       case VendorTier.platinum:
//         return TierLimits(
//           maxUserFollowing: 3600,
//           maxShops: 12,
//           maxCampaigns: 12,
//         );
//     }
//   }

//   /// Get entitlement identifier for a specific tier
//   static String getEntitlementId(VendorTier tier) {
//     switch (tier) {
//       case VendorTier.bronze:
//         return bronzeEntitlement;
//       case VendorTier.silver:
//         return silverEntitlement;
//       case VendorTier.gold:
//         return goldEntitlement;
//       case VendorTier.platinum:
//         return platinumEntitlement;
//     }
//   }
// }

// /// Vendor subscription tiers
// enum VendorTier {
//   bronze,
//   silver,
//   gold,
//   platinum,
// }

// /// Tier limits configuration
// class TierLimits {
//   TierLimits({
//     required this.maxUserFollowing,
//     required this.maxShops,
//     required this.maxCampaigns,
//   });
//   final int maxUserFollowing;
//   final int maxShops;
//   final int maxCampaigns;
// }
