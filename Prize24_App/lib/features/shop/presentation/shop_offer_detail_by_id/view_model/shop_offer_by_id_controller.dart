import 'package:prize24_app/features/shop/domain/i_shop_repository.dart';
import 'package:prize24_app/features/shop/domain/model/shop_offer_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'shop_offer_by_id_controller.g.dart';

@riverpod
class ShopOfferByIdController extends _$ShopOfferByIdController {
  @override
  FutureOr<ShopOfferModel?> build({
    required String shopOfferId,
    required String shopId,
  }) async {
    return ref.read(shopRepositoryProvider).getShopOfferById(
          shopOfferId: shopOfferId,
          shopId: shopId,
        );
  }
}
