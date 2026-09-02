import 'package:prize24_app/features/global_controller/auth/auth_controller.dart';
import 'package:prize24_app/features/shop/domain/model/shop_model.dart';
import 'package:prize24_app/features/shop/domain/use_cases/vendors_shop_list/vendors_shop_list_usecase.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'vendor_shop_list_controller.g.dart';

@Riverpod(keepAlive: true)
class VendorShopListController extends _$VendorShopListController {
  @override
  FutureOr<List<ShopModel>> build() async {
    final userCase = ref.read(vendorsShopListUsecaseProvider);

    final vendorId = (ref.read(authControllerProvider).requireValue!).userId;

    return userCase.call(vendorId: vendorId);
  }

  Future<void> locallyUpdateShop(ShopModel updatedShop) async {
    final previousState = state.value ?? [];
    final existingShopIndex = previousState.indexWhere(
      (shop) => shop.id == updatedShop.id,
    );

    if (existingShopIndex != -1) {
      // Update existing shop
      state = AsyncValue.data([
        for (int i = 0; i < previousState.length; i++)
          if (i == existingShopIndex) updatedShop else previousState[i],
      ]);
    } else {
      // Add new shop as last item
      state = AsyncValue.data([...previousState, updatedShop]);
    }
  }
}
