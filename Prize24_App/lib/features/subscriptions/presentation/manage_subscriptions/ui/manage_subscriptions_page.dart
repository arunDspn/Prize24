import 'dart:io';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:prize24_app/features/global_controller/subscription/subscription_controller.dart';
import 'package:prize24_app/utils/rc_helper_latest.dart';
import 'package:purchases_flutter/purchases_flutter.dart';
import 'package:purchases_ui_flutter/purchases_ui_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

// ============================================================================
// DESIGN SYSTEM - Premium Subscription Theme
// ============================================================================

class _SubscriptionColors {
  static const Color slate50 = Color(0xFFF8FAFC);
  static const Color slate100 = Color(0xFFF1F5F9);
  static const Color slate200 = Color(0xFFE2E8F0);
  static const Color slate400 = Color(0xFF94A3B8);
  static const Color slate500 = Color(0xFF64748B);
  static const Color slate600 = Color(0xFF475569);
  static const Color slate900 = Color(0xFF0F172A);
  static const Color amber400 = Color(0xFFFBBF24);
  static const Color amber500 = Color(0xFFF59E0B);
  static const Color orange400 = Color(0xFFFB923C);
  static const Color orange500 = Color(0xFFF97316);
  static const Color orange600 = Color(0xFFEA580C);
  static const Color orange700 = Color(0xFFC2410C);
  static const Color orange800 = Color(0xFF9A3412);
  static const Color green500 = Color(0xFF22C55E);
  static const Color blue100 = Color(0xFFDBEAFE);
  static const Color orange100 = Color(0xFFFFEDD5);
}

enum SubscriptionTier { none, standard }

// const Map<SubscriptionTier, String> tierToPlacementMap = {
//   SubscriptionTier.standard: 'paywall_standard_placement',
// };

class ManageSubscriptionsPage extends ConsumerStatefulWidget {
  const ManageSubscriptionsPage({super.key});

  @override
  ConsumerState<ManageSubscriptionsPage> createState() =>
      _ManageSubscriptionsPageState();
}

class _ManageSubscriptionsPageState
    extends ConsumerState<ManageSubscriptionsPage>
    with TickerProviderStateMixin {
  CustomerInfo? _customerInfo;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadCustomerInfo();
  }

  Future<void> _loadCustomerInfo() async {
    try {
      final customerInfo = await Purchases.getCustomerInfo();
      if (mounted) {
        setState(() {
          _customerInfo = customerInfo;
          _isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() => _isLoading = false);
        _showToast('Error loading subscription info: $e', false);
      }
    }
  }

  SubscriptionTier _getCurrentTier() {
    if (_customerInfo == null) return SubscriptionTier.none;
    final entitlements = _customerInfo!.entitlements.active;

    // Debug: Print all active entitlements
    // if (entitlements.isNotEmpty) {
    //   print('🔍 Active entitlements found: ${entitlements.keys.toList()}');
    //   entitlements.forEach((key, value) {
    //     print(
    //         '   - $key: isActive=${value.isActive}, willRenew=${value.willRenew}');
    //   });
    // } else {
    //   print('⚠️ No active entitlements found');
    // }

    if (entitlements.isEmpty) return SubscriptionTier.none;

    // Check for the standard entitlement using the constant from RevenueCatHelper
    if (entitlements.containsKey(RevenueCatHelper.standardEntitlement)) {
      // print('✅ Standard subscription detected');
      return SubscriptionTier.standard;
    }

    // If any active entitlement exists, treat as standard (fallback)
    if (entitlements.isNotEmpty) {
      // print(
      //     '⚠️ Unknown entitlement found, treating as standard: ${entitlements.keys.first}');
      return SubscriptionTier.standard;
    }

    return SubscriptionTier.none;
  }

  void _showToast(String message, bool isSuccess) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Icon(
              isSuccess ? Icons.check_circle_rounded : Icons.error_rounded,
              color: Colors.white,
              size: 18,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                message,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
        backgroundColor: isSuccess
            ? _SubscriptionColors.green500
            : const Color(0xFFEF4444),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        margin: const EdgeInsets.all(16),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final currentTier = _getCurrentTier();
    return Scaffold(
      backgroundColor: _SubscriptionColors.slate50,
      body: Stack(
        children: [
          _buildBackgroundDecor(),
          SafeArea(
            child: Column(
              children: [
                _buildAppBar(),
                Expanded(
                  child: _isLoading
                      ? _buildLoadingState()
                      : RefreshIndicator(
                          onRefresh: _loadCustomerInfo,
                          color: _SubscriptionColors.orange500,
                          child: SingleChildScrollView(
                            physics: const AlwaysScrollableScrollPhysics(),
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Column(
                              children: [
                                const SizedBox(height: 32),
                                // Debug info in debug mode
                                // if (_customerInfo != null) _buildDebugInfo(),
                                _buildHeader(),
                                const SizedBox(height: 32),
                                _buildCurrentSubscriptionCard(currentTier),
                                const SizedBox(height: 40),
                                if (currentTier == SubscriptionTier.none) ...[
                                  _buildSubscribeHeader(),
                                  const SizedBox(height: 24),
                                  _buildStandardTierCard(),
                                  const SizedBox(height: 24),
                                  // _buildEnterpriseCard(),
                                ] else ...[
                                  // _buildEnterpriseUpgradeHeader(),
                                  // const SizedBox(height: 24),
                                  // _buildEnterpriseCard(),
                                ],
                                const SizedBox(height: 48),
                              ],
                            ),
                          ),
                        ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBackgroundDecor() {
    return Positioned.fill(
      child: IgnorePointer(
        child: Stack(
          children: [
            Positioned(
              top: -60,
              left: -60,
              child: Container(
                width: 300,
                height: 300,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: _SubscriptionColors.orange100.withOpacity(0.4),
                ),
              ),
            ),
            Positioned(
              bottom: -60,
              right: -60,
              child: Container(
                width: 250,
                height: 250,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: _SubscriptionColors.blue100.withOpacity(0.4),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAppBar() {
    return ClipRRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
          height: 64,
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            color: _SubscriptionColors.slate50.withOpacity(0.8),
            border: Border(
              bottom: BorderSide(
                color: _SubscriptionColors.slate200.withOpacity(0.5),
              ),
            ),
          ),
          child: Row(
            children: [
              GestureDetector(
                onTap: () => Navigator.of(context).pop(),
                child: Container(
                  width: 40,
                  height: 40,
                  decoration: const BoxDecoration(shape: BoxShape.circle),
                  child: const Center(
                    child: Icon(
                      Icons.arrow_back_ios_new_rounded,
                      size: 18,
                      color: _SubscriptionColors.slate500,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              const Expanded(
                child: Text(
                  'Manage Subscription',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: _SubscriptionColors.slate900,
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  setState(() => _isLoading = true);
                  _loadCustomerInfo();
                },
                child: Container(
                  width: 40,
                  height: 40,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: _SubscriptionColors.slate100,
                  ),
                  child: const Center(
                    child: Icon(
                      Icons.refresh_rounded,
                      size: 20,
                      color: _SubscriptionColors.slate600,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLoadingState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 64,
            height: 64,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white,
              boxShadow: [
                BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 20),
              ],
            ),
            child: const Padding(
              padding: EdgeInsets.all(16),
              child: CircularProgressIndicator(
                strokeWidth: 3,
                color: _SubscriptionColors.orange500,
              ),
            ),
          ),
          const SizedBox(height: 24),
          const Text(
            'Loading subscription...',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: _SubscriptionColors.slate600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return const Column(
      children: [
        Text(
          'Your Subscription',
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.w800,
            color: _SubscriptionColors.slate900,
            letterSpacing: -0.5,
          ),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 8),
        Text(
          'Manage your vendor plan',
          style: TextStyle(fontSize: 16, color: _SubscriptionColors.slate500),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  // Widget _buildDebugInfo() {
  //   final entitlements = _customerInfo!.entitlements.active;
  //   if (entitlements.isEmpty) {
  //     return Container(
  //       margin: const EdgeInsets.only(bottom: 16),
  //       padding: const EdgeInsets.all(12),
  //       decoration: BoxDecoration(
  //         color: Colors.orange.withOpacity(0.1),
  //         borderRadius: BorderRadius.circular(12),
  //         border: Border.all(color: Colors.orange, width: 1),
  //       ),
  //       child: Column(
  //         crossAxisAlignment: CrossAxisAlignment.start,
  //         children: [
  //           const Row(
  //             children: [
  //               Icon(Icons.bug_report, size: 16, color: Colors.orange),
  //               SizedBox(width: 8),
  //               Text(
  //                 'Debug Info',
  //                 style: TextStyle(
  //                   fontWeight: FontWeight.w600,
  //                   color: Colors.orange,
  //                 ),
  //               ),
  //             ],
  //           ),
  //           const SizedBox(height: 8),
  //           Text(
  //             'No active entitlements found in RevenueCat.\nExpected entitlement: "${RevenueCatHelper.standardEntitlement}"',
  //             style: const TextStyle(fontSize: 12, color: Colors.black87),
  //           ),
  //         ],
  //       ),
  //     );
  //   }
  //
  //   return Container(
  //     margin: const EdgeInsets.only(bottom: 16),
  //     padding: const EdgeInsets.all(12),
  //     decoration: BoxDecoration(
  //       color: Colors.green.withOpacity(0.1),
  //       borderRadius: BorderRadius.circular(12),
  //       border: Border.all(color: Colors.green, width: 1),
  //     ),
  //     child: Column(
  //       crossAxisAlignment: CrossAxisAlignment.start,
  //       children: [
  //         const Row(
  //           children: [
  //             Icon(Icons.check_circle, size: 16, color: Colors.green),
  //             SizedBox(width: 8),
  //             Text(
  //               'Debug Info - Active Entitlements',
  //               style: TextStyle(
  //                 fontWeight: FontWeight.w600,
  //                 color: Colors.green,
  //               ),
  //             ),
  //           ],
  //         ),
  //         const SizedBox(height: 8),
  //         ...entitlements.entries.map((entry) => Padding(
  //               padding: const EdgeInsets.only(bottom: 4),
  //               child: Text(
  //                 '• ${entry.key} (Active: ${entry.value.isActive})',
  //                 style: const TextStyle(fontSize: 12, color: Colors.black87),
  //               ),
  //             )),
  //       ],
  //     ),
  //   );
  // }

  Widget _buildCurrentSubscriptionCard(SubscriptionTier tier) {
    final config = _getTierConfig(tier);
    final isActive = tier != SubscriptionTier.none;
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(28),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: isActive
              ? [config.gradientStart, config.gradientEnd]
              : [_SubscriptionColors.slate400, _SubscriptionColors.slate500],
        ),
        boxShadow: [
          BoxShadow(
            color:
                (isActive ? config.gradientEnd : _SubscriptionColors.slate500)
                    .withOpacity(0.4),
            blurRadius: 30,
            offset: const Offset(0, 15),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'CURRENT PLAN',
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                          color: Colors.white.withOpacity(0.7),
                          letterSpacing: 1.2,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        config.name,
                        style: const TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.w800,
                          color: Colors.white,
                          letterSpacing: -0.5,
                        ),
                      ),
                      if (isActive)
                        Text(
                          config.subtitle,
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: Colors.white.withOpacity(0.8),
                          ),
                        ),
                    ],
                  ),
                ),
                Container(
                  width: 56,
                  height: 56,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white.withOpacity(0.2),
                  ),
                  child: Center(
                    child: Icon(
                      isActive ? config.icon : Icons.info_outline_rounded,
                      size: 28,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            Container(height: 1, color: Colors.white.withOpacity(0.2)),
            const SizedBox(height: 20),
            _buildFeatureRowWhite(
              'User Following',
              config.maxUserFollowing.toString(),
            ),
            const SizedBox(height: 12),
            _buildFeatureRowWhite('Shops', config.maxShops.toString()),
            const SizedBox(height: 12),
            _buildFeatureRowWhite('Campaigns', config.maxCampaigns.toString()),
            if (_customerInfo != null &&
                _customerInfo!.entitlements.active.isNotEmpty) ...[
              const SizedBox(height: 20),
              Container(height: 1, color: Colors.white.withOpacity(0.2)),
              const SizedBox(height: 16),
              _buildSubscriptionDetails(),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildFeatureRowWhite(String label, String value) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.15),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Container(
            width: 24,
            height: 24,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white.withOpacity(0.25),
            ),
            child: const Center(
              child: Icon(Icons.check_rounded, size: 14, color: Colors.white),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              label,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Colors.white.withOpacity(0.9),
              ),
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w700,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSubscriptionDetails() {
    final activeEntitlements = _customerInfo!.entitlements.active.values;
    if (activeEntitlements.isEmpty) return const SizedBox.shrink();
    final entitlement = activeEntitlements.first;
    final expirationDate = entitlement.expirationDate;
    final willRenew = entitlement.willRenew;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (expirationDate != null)
          Row(
            children: [
              Icon(
                Icons.calendar_today_rounded,
                size: 16,
                color: Colors.white.withOpacity(0.8),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  willRenew
                      ? 'Renews on ${_formatDate(expirationDate)}'
                      : 'Expires on ${_formatDate(expirationDate)}',
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.white.withOpacity(0.8),
                  ),
                ),
              ),
            ],
          ),
        if (!willRenew) ...[
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.orange.withOpacity(0.3),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.warning_amber_rounded,
                  size: 16,
                  color: Colors.white,
                ),
                SizedBox(width: 8),
                Text(
                  'Subscription will not renew',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ],
        const SizedBox(height: 16),
        GestureDetector(
          onTap: _manageSubscription,
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: Colors.white.withOpacity(0.3),
                width: 1.5,
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.settings_outlined,
                  size: 18,
                  color: Colors.white.withOpacity(0.9),
                ),
                const SizedBox(width: 8),
                Text(
                  'Manage Subscription',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Colors.white.withOpacity(0.9),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  String _formatDate(String dateString) {
    try {
      final date = DateTime.parse(dateString);
      return '${date.day}/${date.month}/${date.year}';
    } catch (e) {
      return dateString;
    }
  }

  Widget _buildSubscribeHeader() {
    return const Column(
      children: [
        Text(
          'Subscribe to Vendor Plan',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w700,
            color: _SubscriptionColors.slate900,
          ),
        ),
        SizedBox(height: 8),
        Text(
          'Start selling with our standard plan',
          style: TextStyle(fontSize: 15, color: _SubscriptionColors.slate500),
        ),
      ],
    );
  }

  Widget _buildEnterpriseUpgradeHeader() {
    return const Column(
      children: [
        Text(
          'Need More?',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w700,
            color: _SubscriptionColors.slate900,
          ),
        ),
        SizedBox(height: 8),
        Text(
          'Contact us for enterprise solutions',
          style: TextStyle(fontSize: 15, color: _SubscriptionColors.slate500),
        ),
      ],
    );
  }

  Widget _buildStandardTierCard() {
    final config = _getTierConfig(SubscriptionTier.standard);
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0, end: 1),
      duration: const Duration(milliseconds: 600),
      curve: const Cubic(0.16, 1, 0.3, 1),
      builder: (context, value, child) => Transform.translate(
        offset: Offset(0, 30 * (1 - value)),
        child: Opacity(opacity: value, child: child),
      ),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(28),
          border: Border.all(color: _SubscriptionColors.amber400, width: 2),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 30,
              offset: const Offset(0, 8),
            ),
            BoxShadow(
              color: _SubscriptionColors.amber500.withOpacity(0.3),
              blurRadius: 40,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [config.gradientStart, config.gradientEnd],
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: config.gradientEnd.withOpacity(0.3),
                          blurRadius: 8,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Center(
                      child: Icon(config.icon, color: Colors.white, size: 24),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        config.name,
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w700,
                          color: _SubscriptionColors.slate900,
                          letterSpacing: -0.3,
                        ),
                      ),
                      Text(
                        config.subtitle,
                        style: const TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                          color: _SubscriptionColors.slate400,
                          letterSpacing: 1.2,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 24),
              _buildFeatureRow(
                'User Following',
                config.maxUserFollowing.toString(),
              ),
              const SizedBox(height: 16),
              _buildFeatureRow('Shops', config.maxShops.toString()),
              const SizedBox(height: 16),
              _buildFeatureRow('Campaigns', config.maxCampaigns.toString()),
              const SizedBox(height: 32),
              GestureDetector(
                onTap: () => _launchPaywall(context, SubscriptionTier.standard),
                child: Container(
                  width: double.infinity,
                  height: 56,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    gradient: LinearGradient(
                      colors: [
                        config.buttonGradientStart,
                        config.buttonGradientEnd,
                      ],
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: config.buttonGradientEnd.withOpacity(0.4),
                        blurRadius: 12,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Subscribe Now',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(width: 8),
                      Icon(
                        Icons.arrow_forward_rounded,
                        color: Colors.white,
                        size: 20,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildEnterpriseCard() {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0, end: 1),
      duration: const Duration(milliseconds: 700),
      curve: const Cubic(0.16, 1, 0.3, 1),
      builder: (context, value, child) => Transform.translate(
        offset: Offset(0, 30 * (1 - value)),
        child: Opacity(opacity: value, child: child),
      ),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(28),
          border: Border.all(color: _SubscriptionColors.slate200, width: 2),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 30,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      gradient: const LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          _SubscriptionColors.slate600,
                          _SubscriptionColors.slate900,
                        ],
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: _SubscriptionColors.slate600.withOpacity(0.3),
                          blurRadius: 8,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: const Center(
                      child: Icon(
                        Icons.business_center_rounded,
                        color: Colors.white,
                        size: 24,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Enterprise',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w700,
                          color: _SubscriptionColors.slate900,
                          letterSpacing: -0.3,
                        ),
                      ),
                      Text(
                        'CUSTOM SOLUTION',
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                          color: _SubscriptionColors.slate400,
                          letterSpacing: 1.2,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 24),
              _buildFeatureRow('User Following', 'Unlimited'),
              const SizedBox(height: 16),
              _buildFeatureRow('Shops', 'Unlimited'),
              const SizedBox(height: 16),
              _buildFeatureRow('Campaigns', 'Unlimited'),
              const SizedBox(height: 16),
              _buildFeatureRow('Priority Support', '24/7'),
              const SizedBox(height: 32),
              GestureDetector(
                onTap: _launchWhatsApp,
                child: Container(
                  width: double.infinity,
                  height: 56,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    gradient: const LinearGradient(
                      colors: [Color(0xFF25D366), Color(0xFF128C7E)],
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFF25D366).withOpacity(0.4),
                        blurRadius: 12,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.chat_bubble_outline_rounded,
                        color: Colors.white,
                        size: 20,
                      ),
                      SizedBox(width: 8),
                      Text(
                        'Contact on WhatsApp',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFeatureRow(String label, String value) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: _SubscriptionColors.slate50,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: _SubscriptionColors.slate100),
      ),
      child: Row(
        children: [
          Container(
            width: 24,
            height: 24,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: const Center(
              child: Icon(
                Icons.check_rounded,
                size: 14,
                color: _SubscriptionColors.green500,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              label,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: _SubscriptionColors.slate600,
              ),
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w700,
              color: _SubscriptionColors.slate900,
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _launchWhatsApp() async {
    final message = Uri.encodeComponent(
      "Hi, I'm interested in the Enterprise plan for vendor services.",
    );
    final whatsappUrl = Uri.parse('https://wa.me/1234567899?text=$message');

    try {
      if (await canLaunchUrl(whatsappUrl)) {
        await launchUrl(whatsappUrl, mode: LaunchMode.externalApplication);
      } else {
        _showToast('WhatsApp is not installed', false);
      }
    } catch (e) {
      _showToast('Error launching WhatsApp: $e', false);
    }
  }

  Future<void> _launchPaywall(
    BuildContext context,
    SubscriptionTier tier,
  ) async {
    try {
      final offerings = await Purchases.getOfferings();
      final offering = offerings.all['Standard Plan Offering'];

      if (offering != null) {
        final result = await RevenueCatUI.presentPaywall(offering: offering);
        if (result == PaywallResult.purchased) {
          await Purchases.getCustomerInfo();
          // ref
          //     .read(authControllerProvider.notifier)
          //     .updateUserWithPurchaseInfo(customerId);
          await ref
              .read(subscriptionControllerProvider.notifier)
              .recheckEntitlements(isNewPurchase: true);
          await _loadCustomerInfo();
          if (context.mounted) {
            _showToast('Successfully upgraded to ${tier.name} tier!', true);
          }
        }
      } else {
        if (context.mounted) {
          _showToast('No offering found for ${tier.name} tier', false);
        }
      }
    } catch (e) {
      if (context.mounted) {
        _showToast('Error upgrading subscription: $e', false);
      }
    }
  }

  Future<void> _manageSubscription() async {
    try {
      String managementUrl;
      String instructions;

      if (Platform.isIOS) {
        managementUrl = 'https://apps.apple.com/account/subscriptions';
        instructions =
            'To manage or cancel your subscription:\n\n'
            '1. Open the Settings app\n'
            '2. Tap your name at the top\n'
            '3. Tap Subscriptions\n'
            '4. Select this app\'s subscription\n'
            '5. Tap Cancel Subscription';
      } else if (Platform.isAndroid) {
        managementUrl = 'https://play.google.com/store/account/subscriptions';
        instructions =
            'To manage or cancel your subscription:\n\n'
            '1. Open the Google Play Store app\n'
            '2. Tap your profile icon\n'
            '3. Tap Payments & subscriptions\n'
            '4. Tap Subscriptions\n'
            '5. Select this app\'s subscription\n'
            '6. Tap Cancel subscription';
      } else {
        _showToast('Platform not supported', false);
        return;
      }

      if (!mounted) return;

      // Show dialog with instructions and action button
      final result = await showDialog<bool>(
        context: context,
        builder: (context) => AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          title: const Text(
            'Manage Subscription',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w700,
              color: _SubscriptionColors.slate900,
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                instructions,
                style: const TextStyle(
                  fontSize: 14,
                  height: 1.5,
                  color: _SubscriptionColors.slate600,
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: const Text(
                'Close',
                style: TextStyle(
                  color: _SubscriptionColors.slate500,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () => Navigator.of(context).pop(true),
              style: ElevatedButton.styleFrom(
                backgroundColor: _SubscriptionColors.orange500,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 12,
                ),
              ),
              child: const Text(
                'Open Settings',
                style: TextStyle(fontWeight: FontWeight.w700),
              ),
            ),
          ],
        ),
      );

      if (result == true) {
        final url = Uri.parse(managementUrl);
        if (await canLaunchUrl(url)) {
          await launchUrl(url, mode: LaunchMode.externalApplication);
        } else {
          if (mounted) {
            _showToast('Could not open subscription settings', false);
          }
        }
      }
    } catch (e) {
      if (mounted) {
        _showToast('Error: $e', false);
      }
    }
  }

  _TierConfig _getTierConfig(SubscriptionTier tier) {
    switch (tier) {
      case SubscriptionTier.none:
        return _TierConfig(
          name: 'No Active Plan',
          subtitle: 'NOT SUBSCRIBED',
          icon: Icons.info_outline_rounded,
          gradientStart: _SubscriptionColors.slate400,
          gradientEnd: _SubscriptionColors.slate500,
          buttonGradientStart: _SubscriptionColors.slate500,
          buttonGradientEnd: _SubscriptionColors.slate600,
          maxUserFollowing: 0,
          maxShops: 0,
          maxCampaigns: 0,
        );
      case SubscriptionTier.standard:
        return _TierConfig(
          name: 'Standard',
          subtitle: 'VENDOR PLAN',
          icon: Icons.store_outlined,
          gradientStart: _SubscriptionColors.orange400,
          gradientEnd: _SubscriptionColors.orange700,
          buttonGradientStart: _SubscriptionColors.orange600,
          buttonGradientEnd: _SubscriptionColors.orange800,
          maxUserFollowing: 5000,
          maxShops: 3,
          maxCampaigns: 10,
        );
    }
  }
}

class _TierConfig {
  _TierConfig({
    required this.name,
    required this.subtitle,
    required this.icon,
    required this.gradientStart,
    required this.gradientEnd,
    required this.buttonGradientStart,
    required this.buttonGradientEnd,
    required this.maxUserFollowing,
    required this.maxShops,
    required this.maxCampaigns,
  });
  final String name;
  final String subtitle;
  final IconData icon;
  final Color gradientStart;
  final Color gradientEnd;
  final Color buttonGradientStart;
  final Color buttonGradientEnd;
  final int maxUserFollowing;
  final int maxShops;
  final int maxCampaigns;
}
