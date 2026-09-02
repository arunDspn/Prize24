import 'package:prize24_app/features/shop/domain/model/shop_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'edit_shop_profile_controller.g.dart';

@riverpod
class EditShopProfileController extends _$EditShopProfileController {
  @override
  FutureOr<ShopModel?> build() {
    return null;
  }

  Future<void> save({required ShopModel shop}) async {
    state = const AsyncLoading();

    state = await AsyncValue.guard(
      () async {
        // await ref.read(vendorRepositoryProvider).updateVendorDetails(
        //       shopName: shop.,
        //       phoneNumber: shop.phoneNumber,
        //       shopId: shop.id!,
        //     );

        // return shop;
      },
    );
  }
}
