import 'package:prize24_app/features/clubs/data/repository/club_repository.dart';
import 'package:prize24_app/features/global_controller/auth/auth_controller.dart';
import 'package:prize24_app/features/shop/domain/i_shop_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'add_users_to_club_by_vendor_controller.g.dart';

@riverpod
class AddUsersToClubByVendorController
    extends _$AddUsersToClubByVendorController {
  @override
  FutureOr<void> build() {
    return null;
  }

  /// Add User to Shop
  Future<void> addUserToShop({
    required String shopId,
    required String userId,
  }) async {
    state = const AsyncValue.loading();

    state = await AsyncValue.guard(() async {
      final vendor = ref.read(authControllerProvider).requireValue!;
      final data = await ref.read(shopRepositoryProvider).followShopByVendor(
            shopId: shopId,
            userId: userId,
          );
    });
  }
}
