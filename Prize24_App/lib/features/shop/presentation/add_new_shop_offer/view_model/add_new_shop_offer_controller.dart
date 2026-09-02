import 'package:prize24_app/features/shop/domain/i_shop_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'add_new_shop_offer_controller.g.dart';

@riverpod
class AddNewShopOfferController extends _$AddNewShopOfferController {
  @override
  FutureOr<void> build() async {
    return;
  }

  // Method to add a new shop offer
  Future<void> addShopOffer({
    required String shopId,
    required String name,
    required String description,
    required String startDate,
    required String endDate,
  }) async {
    state = const AsyncValue.loading();

    state = await AsyncValue.guard(() async {
      await ref.read(shopRepositoryProvider).addShopOffer(
            shopId: shopId,
            name: name,
            description: description,
            startDate: startDate,
            endDate: endDate,
          );

      return;
    });
  }
}
