import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:prize24_app/features/shop/domain/i_shop_repository.dart'
    show IShopRepository, shopRepositoryProvider;
import 'package:prize24_app/features/shop/domain/model/shop_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'vendors_shop_list_usecase.g.dart';

@riverpod
VendorsShopListByVendorIdUsecase vendorsShopListUsecase(Ref ref) {
  final shopRepository = ref.read(shopRepositoryProvider);
  return VendorsShopListByVendorIdUsecase(
    shopRepository: shopRepository,
  );
}

class VendorsShopListByVendorIdUsecase {
  VendorsShopListByVendorIdUsecase({
    required IShopRepository shopRepository,
  }) : _shopRepository = shopRepository;

  final IShopRepository _shopRepository;

  Future<List<ShopModel>> call({
    required String vendorId,
    int page = 1,
    int limit = 10,
  }) async {
    final shops = await _shopRepository.listAllShopsOfVendor(
      vendorId: vendorId,
      page: page,
      limit: limit,
    );

    return shops;
  }
}
