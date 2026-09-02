import 'package:prize24_app/features/shop/domain/i_shop_repository.dart';
import 'package:prize24_app/features/shop/domain/model/shop_follow_response_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'staff_add_user_to_shop_controller.g.dart';

@riverpod
class StaffAddUserToShopController extends _$StaffAddUserToShopController {
  @override
  FutureOr<ShopFollowResponseModel?> build() async {
    // Initialize any state here if needed
    return null;
  }

  Future<void> addUser({
    required String shopId,
    required String userId,
  }) async {
    state = const AsyncValue.loading();

    state = await AsyncValue.guard(() async {
      final data = await ref.read(shopRepositoryProvider).followShopByStaff(
            shopId: shopId,
            userId: userId,
          );
      return data;
    });
  }
}
