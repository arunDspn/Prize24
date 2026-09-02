import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:prize24_app/features/global_controller/subscription/subscription_state.dart';
import 'package:prize24_app/utils/rc_helper_latest.dart';
import 'package:prize24_app/utils/sentry_helper.dart';
import 'package:purchases_flutter/purchases_flutter.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

/// Example implementation showing Sentry integration for subscription operations
/// This is a REFERENCE file showing how to enhance subscription_controller.dart
///
/// DO NOT USE THIS FILE DIRECTLY - Copy the pattern into your actual implementation
class SubscriptionControllerWithSentryExample {
  final Ref ref;

  SubscriptionControllerWithSentryExample(this.ref);

  /// ✅ EXAMPLE: Enhanced build method with Sentry tracking
  Future<SubscriptionState?> build() async {
    return await SentryHelper.executeWithErrorHandling<SubscriptionState?>(
      operationName: 'initializeSubscriptionState',
      operation: () async {
        SentryHelper.addBreadcrumb(
          message: 'Initializing subscription state',
          category: 'subscription',
        );

        try {
          // Get customer info from RevenueCat
          final customerInfo = await Purchases.getCustomerInfo();

          SentryHelper.addBreadcrumb(
            message: 'RevenueCat customer info retrieved',
            category: 'subscription',
            data: {
              'hasActiveEntitlements':
                  customerInfo.entitlements.active.isNotEmpty.toString(),
              'entitlementCount':
                  customerInfo.entitlements.active.length.toString(),
            },
          );

          // Get virtual currencies
          final virtualCurrencies = await Purchases.getVirtualCurrencies();
          final virtualCurrency = virtualCurrencies.all['P24COIN'];
          final balance = virtualCurrency?.balance ?? 0;

          if (customerInfo.entitlements.active.isNotEmpty) {
            final maxShops = RevenueCatHelper.getMaxShops(customerInfo);
            final maxCampaigns = RevenueCatHelper.getMaxCampaigns(customerInfo);
            final maxUserFollowing =
                RevenueCatHelper.getMaxUserFollowing(customerInfo);

            final activeEntitlementName =
                customerInfo.entitlements.active.keys.first;

            SentryHelper.addBreadcrumb(
              message: 'Active subscription found',
              category: 'subscription',
              data: {
                'entitlement': activeEntitlementName,
                'maxShops': maxShops.toString(),
                'maxCampaigns': maxCampaigns.toString(),
                'coinBalance': balance.toString(),
              },
            );

            // Set custom tag for filtering in Sentry
            SentryHelper.setTag('subscription_tier', activeEntitlementName);
            SentryHelper.setTag('has_subscription', 'true');

            return SubscriptionState(
              maxShops: maxShops,
              maxCampaigns: maxCampaigns,
              maxUserFollowing: maxUserFollowing,
              coinBalance: balance,
              rcEntitlementName: activeEntitlementName,
            );
          } else {
            SentryHelper.addBreadcrumb(
              message: 'No active subscription',
              category: 'subscription',
              data: {'coinBalance': balance.toString()},
            );

            SentryHelper.setTag('has_subscription', 'false');

            return SubscriptionState(
              maxShops: 0,
              maxCampaigns: 0,
              maxUserFollowing: 0,
              coinBalance: balance,
              rcEntitlementName: '',
            );
          }
        } on PlatformException catch (e) {
          // Track RevenueCat-specific errors
          await SentryHelper.captureException(
            e,
            stackTrace: StackTrace.current,
            hint: 'RevenueCat Error - Failed to get customer info',
            extra: {
              'error_code': e.code,
              'error_message': e.message,
              'operation': 'getCustomerInfo',
            },
            level: SentryLevel.error,
          );
          rethrow;
        }
      },
      additionalContext: {
        'operation': 'initialize_subscription',
      },
    );
  }

  /// ✅ EXAMPLE: Enhanced recheckEntitlements with Sentry tracking
  Future<void> recheckEntitlements() async {
    await SentryHelper.executeWithErrorHandling(
      operationName: 'recheckEntitlements',
      operation: () async {
        SentryHelper.addBreadcrumb(
          message: 'Rechecking entitlements',
          category: 'subscription',
        );

        try {
          // Get fresh customer info from RevenueCat
          final customerInfo = await Purchases.getCustomerInfo();

          SentryHelper.addBreadcrumb(
            message: 'Fresh customer info retrieved',
            category: 'subscription',
            data: {
              'hasActiveEntitlements':
                  customerInfo.entitlements.active.isNotEmpty.toString(),
            },
          );

          // Get virtual currencies and balance
          final virtualCurrencies = await Purchases.getVirtualCurrencies();
          final virtualCurrency = virtualCurrencies.all['P24COIN'];
          final balance = virtualCurrency?.balance ?? 0;

          if (customerInfo.entitlements.active.isNotEmpty) {
            final maxShops = RevenueCatHelper.getMaxShops(customerInfo);
            final maxCampaigns = RevenueCatHelper.getMaxCampaigns(customerInfo);
            final maxUserFollowing =
                RevenueCatHelper.getMaxUserFollowing(customerInfo);

            final activeEntitlementId =
                customerInfo.entitlements.active.keys.first;

            SentryHelper.addBreadcrumb(
              message: 'Entitlements updated',
              category: 'subscription',
              data: {
                'entitlement': activeEntitlementId,
                'maxShops': maxShops.toString(),
                'maxCampaigns': maxCampaigns.toString(),
              },
            );

            // Update tags
            SentryHelper.setTag('subscription_tier', activeEntitlementId);
            SentryHelper.setTag('has_subscription', 'true');

            // State update logic here...
          } else {
            SentryHelper.addBreadcrumb(
              message: 'No active entitlements after recheck',
              category: 'subscription',
            );

            SentryHelper.setTag('has_subscription', 'false');

            // State update logic here...
          }
        } on PlatformException catch (e) {
          // Track RevenueCat errors during entitlement recheck
          await SentryHelper.captureException(
            e,
            stackTrace: StackTrace.current,
            hint: 'RevenueCat Error - Failed to recheck entitlements',
            extra: {
              'error_code': e.code,
              'error_message': e.message,
              'operation': 'recheckEntitlements',
            },
            level: SentryLevel.error,
          );
          rethrow;
        }
      },
      additionalContext: {
        'operation': 'recheck_entitlements',
      },
    );
  }

  /// ✅ EXAMPLE: Enhanced refreshCoinBalance with Sentry tracking
  Future<void> refreshCoinBalance() async {
    await SentryHelper.executeWithErrorHandling(
      operationName: 'refreshCoinBalance',
      operation: () async {
        SentryHelper.addBreadcrumb(
          message: 'Refreshing coin balance',
          category: 'virtual_currency',
        );

        try {
          final virtualCurrencies = await Purchases.getVirtualCurrencies();
          final virtualCurrency = virtualCurrencies.all['P24COIN'];
          final balance = virtualCurrency?.balance ?? 0;

          SentryHelper.addBreadcrumb(
            message: 'Coin balance refreshed',
            category: 'virtual_currency',
            data: {
              'newBalance': balance.toString(),
            },
          );

          // State update logic here...
        } on PlatformException catch (e) {
          // Track virtual currency errors
          await SentryHelper.captureException(
            e,
            stackTrace: StackTrace.current,
            hint: 'RevenueCat Error - Failed to refresh coin balance',
            extra: {
              'error_code': e.code,
              'error_message': e.message,
              'operation': 'getVirtualCurrencies',
            },
            level:
                SentryLevel.warning, // Less critical than subscription errors
          );

          // Don't rethrow - keep current state on error
        }
      },
      additionalContext: {
        'operation': 'refresh_coin_balance',
      },
    );
  }
}

/// ✅ EXAMPLE: Enhanced purchase flow with Sentry tracking
/// This would be in your paywall controller or similar
class PurchaseFlowWithSentryExample {
  Future<void> launchPaywall(String tier, String placement) async {
    await SentryHelper.executeWithErrorHandling(
      operationName: 'launchPaywall',
      operation: () async {
        SentryHelper.addBreadcrumb(
          message: 'Launching paywall',
          category: 'purchase',
          data: {
            'tier': tier,
            'placement': placement,
          },
        );

        try {
          // Get offering from placement
          final offering =
              await Purchases.getCurrentOfferingForPlacement(placement);

          if (offering == null) {
            // Track missing offering as a warning
            await SentryHelper.captureMessage(
              'No offering found for placement',
              level: SentryLevel.warning,
              extra: {
                'tier': tier,
                'placement': placement,
              },
            );

            SentryHelper.addBreadcrumb(
              message: 'Offering not found',
              category: 'purchase',
              data: {
                'tier': tier,
                'placement': placement,
              },
              level: SentryLevel.warning,
            );

            throw Exception('No offering found for placement: $placement');
          }

          SentryHelper.addBreadcrumb(
            message: 'Offering retrieved successfully',
            category: 'purchase',
            data: {
              'offeringId': offering.identifier,
              'availablePackages': offering.availablePackages.length.toString(),
            },
          );

          // Present paywall (implementation detail)
          // final result = await RevenueCatUI.presentPaywall(offering: offering);

          // Track purchase outcome
          // if (result == PaywallResult.purchased) {
          //   SentryHelper.addBreadcrumb(
          //     message: 'Purchase successful',
          //     category: 'purchase',
          //     data: {
          //       'tier': tier,
          //     },
          //   );
          //
          //   // Update subscription tag
          //   SentryHelper.setTag('subscription_tier', tier);
          //   SentryHelper.setTag('has_subscription', 'true');
          // } else if (result == PaywallResult.error) {
          //   await SentryHelper.captureMessage(
          //     'Purchase failed',
          //     level: SentryLevel.error,
          //     extra: {
          //       'tier': tier,
          //       'placement': placement,
          //     },
          //   );
          // }
        } on PlatformException catch (e) {
          // Track RevenueCat purchase errors
          await SentryHelper.captureException(
            e,
            stackTrace: StackTrace.current,
            hint: 'RevenueCat Error - Purchase flow failed',
            extra: {
              'error_code': e.code,
              'error_message': e.message,
              'tier': tier,
              'placement': placement,
            },
            level: SentryLevel.error,
          );
          rethrow;
        }
      },
      additionalContext: {
        'operation': 'purchase_flow',
        'tier': tier,
        'placement': placement,
      },
    );
  }

  /// ✅ EXAMPLE: Restore purchases with Sentry tracking
  Future<void> restorePurchases() async {
    await SentryHelper.executeWithErrorHandling(
      operationName: 'restorePurchases',
      operation: () async {
        SentryHelper.addBreadcrumb(
          message: 'Restoring purchases',
          category: 'purchase',
        );

        try {
          final customerInfo = await Purchases.restorePurchases();

          final hasActiveEntitlements =
              customerInfo.entitlements.active.isNotEmpty;

          SentryHelper.addBreadcrumb(
            message: 'Purchases restore completed',
            category: 'purchase',
            data: {
              'hasActiveEntitlements': hasActiveEntitlements.toString(),
              'entitlementCount':
                  customerInfo.entitlements.active.length.toString(),
            },
          );

          if (hasActiveEntitlements) {
            final activeEntitlement =
                customerInfo.entitlements.active.keys.first;
            SentryHelper.setTag('subscription_tier', activeEntitlement);
            SentryHelper.setTag('has_subscription', 'true');
          }
        } on PlatformException catch (e) {
          // Track restore purchase errors
          await SentryHelper.captureException(
            e,
            stackTrace: StackTrace.current,
            hint: 'RevenueCat Error - Failed to restore purchases',
            extra: {
              'error_code': e.code,
              'error_message': e.message,
            },
            level: SentryLevel.error,
          );
          rethrow;
        }
      },
      additionalContext: {
        'operation': 'restore_purchases',
      },
    );
  }
}
