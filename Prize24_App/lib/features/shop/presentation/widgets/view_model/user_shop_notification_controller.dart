import 'package:prize24_app/features/global_controller/auth/auth_controller.dart';
import 'package:prize24_app/features/shop/domain/i_shop_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'user_shop_notification_controller.g.dart';

@riverpod
class UserShopNotificationController extends _$UserShopNotificationController {
  @override
  FutureOr<(String, bool)?> build() {
    return null;
  }

  /// Toggle notification settings for a specific shop
  Future<void> toggleShopNotification({
    required String shopId,
    required bool enable,
  }) async {
    state = const AsyncLoading();

    state = await AsyncValue.guard(() async {
      final userId = ref.read(authControllerProvider).requireValue!.userId;

      await ref.read(shopRepositoryProvider).toggleShopNotification(
            shopId: shopId,
            userId: userId,
            userFCMToken: '',
            enable: enable,
          );

      return (shopId, enable);
    });
  }
}
