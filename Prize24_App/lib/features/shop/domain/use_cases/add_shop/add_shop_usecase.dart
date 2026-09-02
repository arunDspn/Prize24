import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:prize24_app/features/shop/domain/i_shop_repository.dart';
import 'package:prize24_app/features/shop/domain/model/shop_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'add_shop_usecase.g.dart';

@riverpod
AddShopUsecase addShopUsecase(Ref ref) {
  final shopRepository = ref.watch(shopRepositoryProvider);
  return AddShopUsecase(shopRepository: shopRepository);
}

class AddShopUsecase {
  AddShopUsecase({
    required IShopRepository shopRepository,
  }) : _shopRepository = shopRepository;

  final IShopRepository _shopRepository;

  Future<ShopModel> call(ShopModel shop) async {
    // todo: If any validation is needed, it should be done here
    return _shopRepository.addNewShop(shop: shop);
  }
}
