// // EXAMPLE USAGE - DELETE THIS FILE AFTER REVIEW

// import 'package:purchases_flutter/purchases_flutter.dart';
// import 'rc_helper.dart';

// /// Example 1: In a Controller - Check if user can create a shop
// class ShopController {
//   Future<void> createShop() async {
//     final customerInfo = await Purchases.getCustomerInfo();
//     final currentShopCount = 2; // Get from your database

//     if (!RevenueCatHelper.canCreateShop(customerInfo, currentShopCount)) {
//       final maxShops = RevenueCatHelper.getMaxShops(customerInfo);
//       throw Exception(
//           'You have reached your limit of $maxShops shops. Upgrade to create more.');
//     }

//     // Proceed with shop creation
//   }
// }

// /// Example 2: In UI - Display user's limits
// class VendorDashboardWidget {
//   Widget build() async {
//     final customerInfo = await Purchases.getCustomerInfo();
//     final limits = RevenueCatHelper.getTierLimits(customerInfo);
//     final tier = RevenueCatHelper.getActiveVendorTier(customerInfo);

//     return Column(
//       children: [
//         Text('Current Tier: ${tier?.name ?? "None"}'),
//         Text('Max Shops: ${limits.maxShops}'),
//         Text('Max Campaigns: ${limits.maxCampaigns}'),
//         Text('Max Following: ${limits.maxUserFollowing}'),
//       ],
//     );
//   }
// }

// /// Example 3: In UI - Show upgrade prompt when limit reached
// class CreateCampaignButton {
//   Widget build(int currentCampaignCount) async {
//     final customerInfo = await Purchases.getCustomerInfo();
//     final canCreate = RevenueCatHelper.canCreateCampaign(
//       customerInfo,
//       currentCampaignCount,
//     );

//     return ElevatedButton(
//       onPressed: canCreate
//           ? () {/* Create campaign */}
//           : () {/* Show upgrade dialog */},
//       child: Text(
//         canCreate ? 'Create Campaign' : 'Upgrade to Create More',
//       ),
//     );
//   }
// }

// /// Example 4: Get specific limits
// void checkLimits() async {
//   final customerInfo = await Purchases.getCustomerInfo();

//   final maxShops = RevenueCatHelper.getMaxShops(customerInfo);
//   final maxCampaigns = RevenueCatHelper.getMaxCampaigns(customerInfo);
//   final maxFollowing = RevenueCatHelper.getMaxUserFollowing(customerInfo);

//   print(
//       'Your limits: $maxShops shops, $maxCampaigns campaigns, $maxFollowing following');
// }
