import 'package:prize24_app/features/happy_hours/domain/model/shop_follower_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'add_new_follower_vendor_controller.g.dart';

@riverpod
class AddNewFollowerVendorController extends _$AddNewFollowerVendorController {
  @override
  FutureOr<ShopFollowerModel?> build() {
    return null;
  }

  /// Adds a new follower to the shop by vendor.
  Future<void> addNewFollowerByVendor({
    required String shopId,
    required String userId,
    required String userFCMToken,
  }) async {
    state = const AsyncLoading();
  }
}
