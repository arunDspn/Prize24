// import 'dart:async';
// import 'dart:ui';

// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:prize24_app/common_widgets/show_toast.dart';
// import 'package:prize24_app/features/global_controller/auth/auth_controller.dart';
// import 'package:prize24_app/features/global_controller/subscription/subscription_controller.dart';
// import 'package:prize24_app/features/vendor/presentation/become_a_vendor_paywall/view_model/register_user_as_vendor_controller.dart';
// import 'package:purchases_flutter/purchases_flutter.dart';
// import 'package:purchases_ui_flutter/purchases_ui_flutter.dart';

// // ============================================================================
// // DESIGN SYSTEM - Premium Paywall Theme
// // ============================================================================

// class _PaywallColors {
//   // Slate palette
//   static const Color slate50 = Color(0xFFF8FAFC);
//   static const Color slate100 = Color(0xFFF1F5F9);
//   static const Color slate200 = Color(0xFFE2E8F0);
//   static const Color slate300 = Color(0xFFCBD5E1);
//   static const Color slate400 = Color(0xFF94A3B8);
//   static const Color slate500 = Color(0xFF64748B);
//   static const Color slate600 = Color(0xFF475569);
//   static const Color slate800 = Color(0xFF1E293B);
//   static const Color slate900 = Color(0xFF0F172A);

//   // Accent colors
//   static const Color amber400 = Color(0xFFFBBF24);
//   static const Color amber500 = Color(0xFFF59E0B);
//   static const Color orange400 = Color(0xFFFB923C);
//   static const Color orange500 = Color(0xFFF97316);
//   static const Color orange600 = Color(0xFFEA580C);
//   static const Color orange700 = Color(0xFFC2410C);
//   static const Color orange800 = Color(0xFF9A3412);
//   static const Color green500 = Color(0xFF22C55E);
//   static const Color blue100 = Color(0xFFDBEAFE);
//   static const Color orange100 = Color(0xFFFFEDD5);
// }

// enum SubscriptionTier {
//   bronze,
//   silver,
//   gold,
//   platinum,
// }

// const Map<SubscriptionTier, String> tierToPlacementMap = {
//   SubscriptionTier.bronze: 'paywall_bronze_placement',
//   SubscriptionTier.silver: 'paywall_silver_placement',
//   SubscriptionTier.gold: 'paywall_gold_placement',
//   SubscriptionTier.platinum: 'paywall_platinum_placement',
// };

// class BecomeAVendorPaywallPage extends ConsumerStatefulWidget {
//   const BecomeAVendorPaywallPage({super.key});

//   @override
//   ConsumerState<BecomeAVendorPaywallPage> createState() =>
//       _BecomeAVendorPaywallPageState();
// }

// class _BecomeAVendorPaywallPageState
//     extends ConsumerState<BecomeAVendorPaywallPage>
//     with TickerProviderStateMixin {
//   late AnimationController _slideController;
//   late AnimationController _floatController;
//   late Animation<double> _floatAnimation;

//   @override
//   void initState() {
//     super.initState();
//     _slideController = AnimationController(
//       duration: const Duration(milliseconds: 600),
//       vsync: this,
//     )..forward();

//     _floatController = AnimationController(
//       duration: const Duration(seconds: 4),
//       vsync: this,
//     )..repeat(reverse: true);

//     _floatAnimation = Tween<double>(begin: 0, end: -6).animate(
//       CurvedAnimation(parent: _floatController, curve: Curves.easeInOut),
//     );
//   }

//   @override
//   void dispose() {
//     _slideController.dispose();
//     _floatController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     ref.listen(
//       registerUserAsVendorControllerProvider,
//       (previous, next) {
//         next.when(
//           data: (userId) {
//             // Close any open dialogs
//             Navigator.of(context, rootNavigator: true).pop();
//             if (userId != null) {
//               _showToast(context, 'You are now registered as a vendor!', true);

//               ref
//                   .read(authControllerProvider.notifier)
//                   .updateAuthUserWithVendorFlag();

//               Navigator.of(context).pop();
//             }
//           },
//           loading: () {
//             // Undismissible show a loading indicator Popup
//             showDialog<void>(
//               context: context,
//               barrierDismissible: false,
//               builder: (context) {
//                 return Dialog(
//                   backgroundColor: Colors.transparent,
//                   elevation: 0,
//                   child: Container(
//                     padding: const EdgeInsets.all(24),
//                     decoration: BoxDecoration(
//                       color: Colors.white,
//                       borderRadius: BorderRadius.circular(16),
//                     ),
//                     child: const Column(
//                       mainAxisSize: MainAxisSize.min,
//                       children: [
//                         CircularProgressIndicator(
//                           valueColor: AlwaysStoppedAnimation<Color>(
//                             _PaywallColors.orange500,
//                           ),
//                         ),
//                         SizedBox(height: 16),
//                         Text(
//                           'Registering as vendor...',
//                           style: TextStyle(
//                             fontSize: 16,
//                             fontWeight: FontWeight.w600,
//                             color: _PaywallColors.slate900,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 );
//               },
//             );
//           },
//           error: (error, stackTrace) {
//             // Close any open dialogs
//             Navigator.of(context, rootNavigator: true).pop();
//             _showToast(context, 'Error, Please try again', false);
//           },
//         );
//       },
//     );

//     return Scaffold(
//       backgroundColor: _PaywallColors.slate50,
//       body: Stack(
//         children: [
//           // Background decorative blurs
//           _buildBackgroundDecor(),
//           // Main content
//           SafeArea(
//             child: Column(
//               children: [
//                 // Custom AppBar
//                 _buildAppBar(context),
//                 // Scrollable content
//                 Expanded(
//                   child: SingleChildScrollView(
//                     padding: const EdgeInsets.symmetric(horizontal: 20),
//                     child: Column(
//                       children: [
//                         const SizedBox(height: 32),
//                         // Header section
//                         _buildHeader(),
//                         const SizedBox(height: 40),
//                         // Subscription cards
//                         _buildSubscriptionCard(
//                           tier: SubscriptionTier.bronze,
//                           delayIndex: 0,
//                         ),
//                         const SizedBox(height: 24),
//                         _buildSubscriptionCard(
//                           tier: SubscriptionTier.silver,
//                           delayIndex: 1,
//                         ),
//                         const SizedBox(height: 24),
//                         _buildSubscriptionCard(
//                           tier: SubscriptionTier.gold,
//                           isPopular: true,
//                           delayIndex: 2,
//                         ),
//                         // const SizedBox(height: 24),
//                         // _buildSubscriptionCard(
//                         //   tier: SubscriptionTier.platinum,
//                         //   delayIndex: 3,
//                         // ),
//                         const SizedBox(height: 48),
//                       ],
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildBackgroundDecor() {
//     return Positioned.fill(
//       child: IgnorePointer(
//         child: Stack(
//           children: [
//             // Orange blur top-left
//             Positioned(
//               top: -60,
//               left: -60,
//               child: Container(
//                 width: 300,
//                 height: 300,
//                 decoration: BoxDecoration(
//                   shape: BoxShape.circle,
//                   color: _PaywallColors.orange100.withOpacity(0.4),
//                 ),
//               ),
//             ),
//             // Blue blur bottom-right
//             Positioned(
//               bottom: -60,
//               right: -60,
//               child: Container(
//                 width: 250,
//                 height: 250,
//                 decoration: BoxDecoration(
//                   shape: BoxShape.circle,
//                   color: _PaywallColors.blue100.withOpacity(0.4),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildAppBar(BuildContext context) {
//     return ClipRRect(
//       child: BackdropFilter(
//         filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
//         child: Container(
//           height: 64,
//           padding: const EdgeInsets.symmetric(horizontal: 12),
//           decoration: BoxDecoration(
//             color: _PaywallColors.slate50.withOpacity(0.8),
//             border: Border(
//               bottom: BorderSide(
//                 color: _PaywallColors.slate200.withOpacity(0.5),
//                 width: 1,
//               ),
//             ),
//           ),
//           child: Row(
//             children: [
//               // Back button
//               GestureDetector(
//                 onTap: () => Navigator.of(context).pop(),
//                 child: Container(
//                   width: 40,
//                   height: 40,
//                   decoration: const BoxDecoration(
//                     shape: BoxShape.circle,
//                     color: Colors.transparent,
//                   ),
//                   child: const Center(
//                     child: Icon(
//                       Icons.arrow_back_ios_new_rounded,
//                       size: 18,
//                       color: _PaywallColors.slate500,
//                     ),
//                   ),
//                 ),
//               ),
//               const SizedBox(width: 8),
//               // Title
//               const Text(
//                 'Become a Vendor',
//                 style: TextStyle(
//                   fontSize: 18,
//                   fontWeight: FontWeight.w700,
//                   color: _PaywallColors.slate900,
//                   letterSpacing: -0.3,
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildHeader() {
//     return SlideTransition(
//       position: Tween<Offset>(
//         begin: const Offset(0, 0.3),
//         end: Offset.zero,
//       ).animate(CurvedAnimation(
//         parent: _slideController,
//         curve: const Cubic(0.16, 1, 0.3, 1),
//       )),
//       child: FadeTransition(
//         opacity: _slideController,
//         child: const Column(
//           children: [
//             Text(
//               'Choose Your Plan',
//               style: TextStyle(
//                 fontSize: 30,
//                 fontWeight: FontWeight.w800,
//                 color: _PaywallColors.slate900,
//                 letterSpacing: -0.5,
//               ),
//               textAlign: TextAlign.center,
//             ),
//             SizedBox(height: 12),
//             Padding(
//               padding: EdgeInsets.symmetric(horizontal: 16),
//               child: Text(
//                 'Unlock premium features and scale your business with our tailored tiers.',
//                 style: TextStyle(
//                   fontSize: 16,
//                   color: _PaywallColors.slate500,
//                   height: 1.5,
//                 ),
//                 textAlign: TextAlign.center,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildSubscriptionCard({
//     required SubscriptionTier tier,
//     bool isPopular = false,
//     required int delayIndex,
//   }) {
//     final tierConfig = _getTierConfig(tier);

//     return TweenAnimationBuilder<double>(
//       tween: Tween(begin: 0, end: 1),
//       duration: Duration(milliseconds: 600 + (delayIndex * 100)),
//       curve: const Cubic(0.16, 1, 0.3, 1),
//       builder: (context, value, child) {
//         return Transform.translate(
//           offset: Offset(0, 30 * (1 - value)),
//           child: Opacity(
//             opacity: value,
//             child: child,
//           ),
//         );
//       },
//       child: Stack(
//         clipBehavior: Clip.none,
//         children: [
//           // Main card
//           Container(
//             decoration: BoxDecoration(
//               color: Colors.white,
//               borderRadius: BorderRadius.circular(28),
//               border: isPopular
//                   ? null
//                   : Border.all(color: _PaywallColors.slate100, width: 1),
//               boxShadow: [
//                 BoxShadow(
//                   color: Colors.black.withOpacity(0.05),
//                   blurRadius: 30,
//                   offset: const Offset(0, 8),
//                   spreadRadius: -4,
//                 ),
//                 if (isPopular)
//                   BoxShadow(
//                     color: _PaywallColors.amber500.withOpacity(0.3),
//                     blurRadius: 40,
//                     offset: const Offset(0, 10),
//                     spreadRadius: -10,
//                   ),
//               ],
//             ),
//             child: Container(
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(28),
//                 border: isPopular
//                     ? Border.all(color: _PaywallColors.amber400, width: 2)
//                     : null,
//               ),
//               padding: const EdgeInsets.all(4),
//               child: Container(
//                 decoration: BoxDecoration(
//                   color: Colors.white,
//                   borderRadius: BorderRadius.circular(24),
//                 ),
//                 child: Stack(
//                   children: [
//                     // Decorative gradient header
//                     Positioned(
//                       top: 0,
//                       left: 0,
//                       right: 0,
//                       height: 128,
//                       child: Container(
//                         decoration: BoxDecoration(
//                           borderRadius: const BorderRadius.vertical(
//                             top: Radius.circular(24),
//                           ),
//                           gradient: LinearGradient(
//                             begin: Alignment.topCenter,
//                             end: Alignment.bottomCenter,
//                             colors: [
//                               tierConfig.gradientStart.withOpacity(0.1),
//                               Colors.transparent,
//                             ],
//                           ),
//                         ),
//                       ),
//                     ),
//                     // Content
//                     Padding(
//                       padding: const EdgeInsets.all(24),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           // Header with icon and title
//                           Row(
//                             children: [
//                               // Icon box
//                               Container(
//                                 width: 48,
//                                 height: 48,
//                                 decoration: BoxDecoration(
//                                   borderRadius: BorderRadius.circular(16),
//                                   gradient: LinearGradient(
//                                     begin: Alignment.topLeft,
//                                     end: Alignment.bottomRight,
//                                     colors: [
//                                       tierConfig.gradientStart,
//                                       tierConfig.gradientEnd,
//                                     ],
//                                   ),
//                                   boxShadow: [
//                                     BoxShadow(
//                                       color: tierConfig.gradientEnd
//                                           .withOpacity(0.3),
//                                       blurRadius: 8,
//                                       offset: const Offset(0, 4),
//                                     ),
//                                   ],
//                                 ),
//                                 child: Center(
//                                   child: Icon(
//                                     tierConfig.icon,
//                                     color: Colors.white,
//                                     size: 24,
//                                   ),
//                                 ),
//                               ),
//                               const SizedBox(width: 12),
//                               // Title and subtitle
//                               Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   Text(
//                                     tierConfig.name,
//                                     style: const TextStyle(
//                                       fontSize: 24,
//                                       fontWeight: FontWeight.w700,
//                                       color: _PaywallColors.slate900,
//                                       letterSpacing: -0.3,
//                                     ),
//                                   ),
//                                   Text(
//                                     tierConfig.subtitle,
//                                     style: const TextStyle(
//                                       fontSize: 11,
//                                       fontWeight: FontWeight.w600,
//                                       color: _PaywallColors.slate400,
//                                       letterSpacing: 1.2,
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ],
//                           ),
//                           const SizedBox(height: 24),
//                           // Features
//                           _buildFeatureRow(
//                             label: 'User Following',
//                             value: tierConfig.maxUserFollowing.toString(),
//                           ),
//                           const SizedBox(height: 16),
//                           _buildFeatureRow(
//                             label: 'Shops',
//                             value: tierConfig.maxShops.toString(),
//                           ),
//                           const SizedBox(height: 16),
//                           _buildFeatureRow(
//                             label: 'Campaigns',
//                             value: tierConfig.maxCampaigns.toString(),
//                           ),
//                           const SizedBox(height: 32),
//                           // Subscribe button
//                           GestureDetector(
//                             onTap: () => _launchPaywall(context, tier, ref),
//                             child: Container(
//                               width: double.infinity,
//                               height: 56,
//                               decoration: BoxDecoration(
//                                 borderRadius: BorderRadius.circular(12),
//                                 gradient: LinearGradient(
//                                   colors: [
//                                     tierConfig.buttonGradientStart,
//                                     tierConfig.buttonGradientEnd,
//                                   ],
//                                 ),
//                                 boxShadow: [
//                                   BoxShadow(
//                                     color: tierConfig.buttonGradientEnd
//                                         .withOpacity(0.4),
//                                     blurRadius: 12,
//                                     offset: const Offset(0, 4),
//                                   ),
//                                 ],
//                               ),
//                               child: const Row(
//                                 mainAxisAlignment: MainAxisAlignment.center,
//                                 children: [
//                                   Text(
//                                     'Subscribe Now',
//                                     style: TextStyle(
//                                       fontSize: 16,
//                                       fontWeight: FontWeight.w700,
//                                       color: Colors.white,
//                                     ),
//                                   ),
//                                   SizedBox(width: 8),
//                                   Icon(
//                                     Icons.arrow_forward_rounded,
//                                     color: Colors.white,
//                                     size: 20,
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//           // Popular badge (floating)
//           if (isPopular)
//             Positioned(
//               top: -16,
//               right: 24,
//               child: AnimatedBuilder(
//                 animation: _floatAnimation,
//                 builder: (context, child) {
//                   return Transform.translate(
//                     offset: Offset(0, _floatAnimation.value),
//                     child: child,
//                   );
//                 },
//                 child: Container(
//                   padding:
//                       const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(20),
//                     gradient: const LinearGradient(
//                       colors: [
//                         _PaywallColors.amber400,
//                         _PaywallColors.orange500,
//                       ],
//                     ),
//                     boxShadow: [
//                       BoxShadow(
//                         color: _PaywallColors.amber500.withOpacity(0.5),
//                         blurRadius: 40,
//                         offset: const Offset(0, 10),
//                         spreadRadius: -10,
//                       ),
//                     ],
//                   ),
//                   child: Container(
//                     padding: const EdgeInsets.all(4),
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(16),
//                       color: Colors.white.withOpacity(0.2),
//                     ),
//                     child: const Text(
//                       'MOST POPULAR',
//                       style: TextStyle(
//                         fontSize: 10,
//                         fontWeight: FontWeight.w700,
//                         color: Colors.white,
//                         letterSpacing: 1.5,
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//         ],
//       ),
//     );
//   }

//   Widget _buildFeatureRow({
//     required String label,
//     required String value,
//   }) {
//     return Container(
//       padding: const EdgeInsets.all(12),
//       decoration: BoxDecoration(
//         color: _PaywallColors.slate50,
//         borderRadius: BorderRadius.circular(12),
//         border: Border.all(color: _PaywallColors.slate100),
//       ),
//       child: Row(
//         children: [
//           // Check icon
//           Container(
//             width: 24,
//             height: 24,
//             decoration: BoxDecoration(
//               shape: BoxShape.circle,
//               color: Colors.white,
//               boxShadow: [
//                 BoxShadow(
//                   color: Colors.black.withOpacity(0.05),
//                   blurRadius: 4,
//                   offset: const Offset(0, 2),
//                 ),
//               ],
//             ),
//             child: const Center(
//               child: Icon(
//                 Icons.check_rounded,
//                 size: 14,
//                 color: _PaywallColors.green500,
//               ),
//             ),
//           ),
//           const SizedBox(width: 12),
//           // Label
//           Expanded(
//             child: Text(
//               label,
//               style: const TextStyle(
//                 fontSize: 14,
//                 fontWeight: FontWeight.w500,
//                 color: _PaywallColors.slate600,
//               ),
//             ),
//           ),
//           // Value
//           Text(
//             value,
//             style: const TextStyle(
//               fontSize: 14,
//               fontWeight: FontWeight.w700,
//               color: _PaywallColors.slate900,
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   void _showToast(BuildContext context, String message, bool isSuccess) {
//     // ScaffoldMessenger.of(context).showSnackBar(
//     //   SnackBar(
//     //     content: Row(
//     //       mainAxisSize: MainAxisSize.min,
//     //       children: [
//     //         Icon(
//     //           isSuccess ? Icons.check_circle_rounded : Icons.error_rounded,
//     //           color: Colors.white,
//     //           size: 18,
//     //         ),
//     //         const SizedBox(width: 12),
//     //         Expanded(
//     //           child: Text(
//     //             message,
//     //             style: const TextStyle(
//     //               fontSize: 14,
//     //               fontWeight: FontWeight.w600,
//     //             ),
//     //           ),
//     //         ),
//     //       ],
//     //     ),
//     //     backgroundColor:
//     //         isSuccess ? _PaywallColors.green500 : const Color(0xFFEF4444),
//     //     behavior: SnackBarBehavior.floating,
//     //     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
//     //     margin: const EdgeInsets.all(16),
//     //     duration: const Duration(seconds: 3),
//     //   ),
//     // );
//     showToastAtTop(context, message, isSuccess);
//   }

//   Future<void> _launchPaywall(
//     BuildContext context,
//     SubscriptionTier tier,
//     WidgetRef ref,
//   ) async {
//     try {
//       final placement = tierToPlacementMap[tier];
//       // Get offering from placement
//       final offering =
//           await Purchases.getCurrentOfferingForPlacement(placement!);
//       if (offering != null) {
//         final result = await RevenueCatUI.presentPaywall(
//           offering: offering,
//         );

//         if (result == PaywallResult.purchased) {
//           // Successful purchase
//           final customerId = await Purchases.getCustomerInfo();
//           // ref
//           //     .read(authControllerProvider.notifier)
//           //     .updateUserWithPurchaseInfo(customerId);

//           await ref
//               .read(subscriptionControllerProvider.notifier)
//               .recheckEntitlements();

//           await ref
//               .read(registerUserAsVendorControllerProvider.notifier)
//               .registerAsVendor();
//           if (context.mounted) {
//             _showToast(
//               context,
//               'Successfully subscribed to ${tier.name} tier!',
//               true,
//             );
//             // Navigator.of(context).pop();
//           }
//         }
//       } else {
//         if (context.mounted) {
//           _showToast(
//             context,
//             'No offering found for ${tier.name} tier',
//             false,
//           );
//         }
//       }
//     } catch (e) {
//       _showToast(
//         context,
//         'Something went wrong',
//         false,
//       );
//       rethrow;
//     }
//   }

//   _TierConfig _getTierConfig(SubscriptionTier tier) {
//     switch (tier) {
//       case SubscriptionTier.bronze:
//         return _TierConfig(
//           name: 'Bronze',
//           subtitle: 'ESSENTIAL',
//           icon: Icons.shield_outlined,
//           gradientStart: _PaywallColors.orange400,
//           gradientEnd: _PaywallColors.orange700,
//           buttonGradientStart: _PaywallColors.orange600,
//           buttonGradientEnd: _PaywallColors.orange800,
//           maxUserFollowing: 300,
//           maxShops: 1,
//           maxCampaigns: 1,
//         );
//       case SubscriptionTier.silver:
//         return _TierConfig(
//           name: 'Silver',
//           subtitle: 'GROWTH',
//           icon: Icons.star_outline_rounded,
//           gradientStart: _PaywallColors.slate300,
//           gradientEnd: _PaywallColors.slate500,
//           buttonGradientStart: _PaywallColors.slate500,
//           buttonGradientEnd: const Color(0xFF334155),
//           maxUserFollowing: 900,
//           maxShops: 3,
//           maxCampaigns: 3,
//         );
//       case SubscriptionTier.gold:
//         return _TierConfig(
//           name: 'Gold',
//           subtitle: 'PROFESSIONAL',
//           icon: Icons.workspace_premium_rounded,
//           gradientStart: const Color(0xFFFCD34D),
//           gradientEnd: _PaywallColors.orange500,
//           buttonGradientStart: _PaywallColors.amber500,
//           buttonGradientEnd: _PaywallColors.orange600,
//           maxUserFollowing: 1800,
//           maxShops: 6,
//           maxCampaigns: 6,
//         );
//       case SubscriptionTier.platinum:
//         return _TierConfig(
//           name: 'Platinum',
//           subtitle: 'ENTERPRISE',
//           icon: Icons.diamond_outlined,
//           gradientStart: const Color(0xFF334155),
//           gradientEnd: _PaywallColors.slate900,
//           buttonGradientStart: _PaywallColors.slate800,
//           buttonGradientEnd: Colors.black,
//           maxUserFollowing: 3600,
//           maxShops: 12,
//           maxCampaigns: 12,
//         );
//     }
//   }
// }

// class _TierConfig {
//   final String name;
//   final String subtitle;
//   final IconData icon;
//   final Color gradientStart;
//   final Color gradientEnd;
//   final Color buttonGradientStart;
//   final Color buttonGradientEnd;
//   final int maxUserFollowing;
//   final int maxShops;
//   final int maxCampaigns;

//   _TierConfig({
//     required this.name,
//     required this.subtitle,
//     required this.icon,
//     required this.gradientStart,
//     required this.gradientEnd,
//     required this.buttonGradientStart,
//     required this.buttonGradientEnd,
//     required this.maxUserFollowing,
//     required this.maxShops,
//     required this.maxCampaigns,
//   });
// }
