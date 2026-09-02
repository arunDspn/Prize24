// import 'package:riverpod_annotation/riverpod_annotation.dart';

// class SubscriptionDetails {
//   SubscriptionDetails({
//     required this.subscriptionName,
//   });
//   final String subscriptionName;
// }

// @riverpod
// class BecomeAVendorPaywallController extends _$BecomeAVendorPaywallController {
//   @override
//   FutureOr<SubscriptionDetails?> build() {
//     return null;
//   }

//   Future<void> purchaseBecomeAVendorPackage(
//       OfferingPackage package) async {
//     try {
//       final purchaserInfo =
//           await Purchases.purchasePackage(package);

//       final isVendor = purchaserInfo.entitlements.active
//           .containsKey('become_a_vendor');

//       if (isVendor) {
//         // Update user status to vendor in your app's user management system
//         // This is a placeholder for actual implementation
//         logger.i('User has successfully become a vendor.');
//         state = AsyncData(
//             SubscriptionDetails(subscriptionName: package.packageType.toString()));
//       } else {
//         logger.w('Purchase completed but entitlement not active.');
//         state = AsyncData(null);
//       }
//     } on PurchasesErrorException catch (e) {
//       logger.e('Purchase failed: ${e.message}');
//       state = AsyncError(e);
//     } catch (e) {
//       logger.e('An unexpected error occurred: $e');
//       state = AsyncError(e);
//     }
//   }
// }
