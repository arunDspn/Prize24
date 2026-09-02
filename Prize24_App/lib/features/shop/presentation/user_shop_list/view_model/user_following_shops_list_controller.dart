import 'package:prize24_app/features/global_controller/auth/auth_controller.dart';
import 'package:prize24_app/features/shop/domain/i_shop_repository.dart';
import 'package:prize24_app/features/shop/domain/model/user_following_shop_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'user_following_shops_list_controller.g.dart';

@riverpod
class UserFollowingShopsListController
    extends _$UserFollowingShopsListController {
  @override
  FutureOr<List<UserFollowingShopModel>> build() {
    final userId = ref.read(authControllerProvider).requireValue!.userId;

    return ref
        .read(shopRepositoryProvider)
        .listUserFollowedShops(userId: userId);

    // Mock data for testing
    // return [
    //   UserFollowingShopModel(
    //     shopId: 'shop_1',
    //     shopName: 'Mock Shop 1',
    //     notificationEnabled: true,
    //     consecutiveDays: 5,
    //     cumulativeStreak: 21,
    //     followedAt: DateTime.now().subtract(const Duration(days: 30)),
    //     giftCycleDays: 5,
    //     isGiftAvailable: false,
    //     shopAddress: '123 Mock St, Mock City',
    //     shopPhoneNumber: '+1234567890',
    //     lastCheckInDate: DateTime.now().subtract(const Duration(days: 1)),
    //   ),
    // ];
  }

  /// Refresh the list of followed shops
  Future<void> refresh() async {
    state = const AsyncLoading();

    state = await AsyncValue.guard(() async {
      final userId = ref.read(authControllerProvider).requireValue!.userId;

      return ref
          .read(shopRepositoryProvider)
          .listUserFollowedShops(userId: userId);
    });
  }

  // Update notification status for a specific shop
  Future<void> updateShopNotificationStatus({
    required String shopId,
    required bool enable,
  }) async {
    final currentState = state;
    state = await AsyncValue.guard(() async {
      return currentState.value!.map((shop) {
        if (shop.shopId == shopId) {
          return shop.copyWith(notificationEnabled: enable);
        }
        return shop;
      }).toList();
    });
  }
}
