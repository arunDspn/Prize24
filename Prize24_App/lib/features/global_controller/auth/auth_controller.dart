import 'package:prize24_app/bootstrap.dart';
import 'package:prize24_app/core/services/analytics/analytics_service.dart';
import 'package:prize24_app/features/authentication/data/repository/auth_repository.dart';
import 'package:prize24_app/features/authentication/domain/model/app_user.dart';
import 'package:prize24_app/features/campaign/presentation/vendor_campaign_detail/view_model/current_campaign_selection_controller.dart';
import 'package:prize24_app/features/vendor/presentation/vendor_home_content/ui/components/vendors_campaign_list/components/vendors_campaign_list_controller.dart';
import 'package:prize24_app/features/vendor/presentation/vendor_home_content/ui/components/vendors_shop_list/view_model/vendor_shop_list_controller.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_controller.g.dart';

/// Purpose
/// -  Gate keeper for authentication state when the app starts.
/// -  Provides methods to check authentication, update user state, and sign out.
/// -  Keeps the authentication state alive across the app lifecycle.
@Riverpod(keepAlive: true)
class AuthController extends _$AuthController {
  @override
  FutureOr<AppUser?> build() async {
    return await ref.read(authRepositoryProvider).checkAuth();
  }

  void updateAuthUser({required AppUser user}) {
    state = AsyncData(user);
  }

  /// Update user to set isVendor to true
  /// Used after successful vendor registration
  /// Partial registration state
  /// Next step is add vendorPhoneNumber
  Future<void> updateAuthUserWithVendorFlag() async {
    final currentUser = state.requireValue;
    if (currentUser == null) {
      logger.w('No authenticated user to update with vendor flag.');
      return;
    }

    final updatedUser = currentUser.copyWith(isVendor: true);

    state = AsyncData(updatedUser);
  }

  void authStateChanged(AppUser user) {
    state = const AsyncLoading();
    state = AsyncData(user);
  }

  Future<void> checkAuth() async {
    state = const AsyncLoading();

    state = await AsyncValue.guard(() async {
      final user = await ref.read(authRepositoryProvider).checkAuth();

      // Re-identify the user in Analytics on every cold start / resume.
      // Safe to call even if user is null — the guard handles it.
      if (user != null) {
        final analytics = ref.read(analyticsServiceProvider);
        await analytics.setUserIdentifier(user.userId);
        await analytics.setUserTrait('is_vendor', user.isVendor.toString());
      }

      return user;
    });
  }

  Future<void> signOut() async {
    state = const AsyncLoading();

    state = await AsyncValue.guard(() async {
      await ref.read(authRepositoryProvider).signOut();

      // Dispose vendor-specific controllers so stale data
      // is never shown to the next user session.
      ref
        // ..invalidate(vendorsCampaignListControllerProvider)
        ..invalidate(currentCampaignSelectionControllerProvider)
        ..invalidate(vendorShopListControllerProvider);

      return null;
    });
  }

  // Update user name
  Future<void> updateUserName(String newUserName) async {
    final currentUser = state.requireValue;
    if (currentUser == null) {
      logger.w('No authenticated user to update user name.');
      return;
    }
    final updatedUser = currentUser.copyWith(userName: newUserName);
    state = AsyncData(updatedUser);
  }

  // Update user phone number
  Future<void> updateUserVendorNumber(String newPhoneNumber) async {
    final currentUser = state.requireValue;
    if (currentUser == null) {
      logger.w('No authenticated user to update phone number.');
      return;
    }
    final updatedUser = currentUser.copyWith(vendorPhoneNumber: newPhoneNumber);
    state = AsyncData(updatedUser);
  }

  // Update users shoplist array
  Future<void> updateUserShopList(String newStaffShopId) async {
    final currentUser = state.requireValue;
    if (currentUser == null) {
      logger.w('No authenticated user to update shop list.');
      return;
    }
    final updatedUser = currentUser.copyWith(
      staffShopIds: [...?currentUser.staffShopIds, newStaffShopId],
    );
    state = AsyncData(updatedUser);
  }

  /// Update user with purchase info
  /// Also set isVendor to true
  // void updateUserWithPurchaseInfo(CustomerInfo customerInfo) {
  //   final currentUser = state.requireValue;
  //   if (currentUser == null) {
  //     logger.w('No authenticated user to update with purchase info.');
  //     return;
  //   }

  //   final maxShops = RevenueCatHelper.getMaxShops(customerInfo);
  //   final maxCampaigns = RevenueCatHelper.getMaxCampaigns(customerInfo);
  //   final maxUserFollowing = RevenueCatHelper.getMaxUserFollowing(customerInfo);

  //   final updatedUser = currentUser.copyWith(
  //     maximumShops: maxShops,
  //     maximumCampaigns: maxCampaigns,
  //     maximumUserFollowing: maxUserFollowing,
  //   );

  //   state = AsyncData(updatedUser.copyWith(isVendor: true));
  // }

  // // Update user with coin balance
  // void updateUserWithCoinBalance(int coinBalance) {
  //   final currentUser = state.requireValue;
  //   if (currentUser == null) {
  //     logger.w('No authenticated user to update with coin balance.');
  //     return;
  //   }
  //   final updatedUser = currentUser.copyWith(
  //     p24Coins: coinBalance,
  //   );
  //   state = AsyncData(updatedUser);
  // }

  // // Update user with Coin balance directly from ReverueCat
  // Future<void> updateUserWithCoinBalanceDirectly() async {
  //   final currentUser = state.requireValue;
  //   if (currentUser == null) {
  //     logger.w('No authenticated user to update with coin balance.');
  //     return;
  //   }

  //   state = await AsyncValue.guard(
  //     () async {
  //       final virtualCurrencies = await Purchases.getVirtualCurrencies();
  //       final virtualCurrency = virtualCurrencies.all['P24COIN'];
  //       final balance = virtualCurrency?.balance;

  //       return currentUser.copyWith(
  //         p24Coins: balance ?? currentUser.p24Coins,
  //       );
  //     },
  //   );
  // }
}
