import 'package:prize24_app/core/services/analytics/analytics_events.dart';
import 'package:prize24_app/core/services/analytics/analytics_service.dart';
import 'package:prize24_app/features/global_controller/auth/auth_controller.dart';
import 'package:prize24_app/features/shop/domain/i_shop_repository.dart';
import 'package:prize24_app/features/shop/domain/model/shop_model.dart';
import 'package:prize24_app/features/shop/domain/use_cases/add_shop/add_shop_usecase.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'add_edit_shop_controller.g.dart';

@riverpod
class AddEditShopController extends _$AddEditShopController {
  @override
  Future<ShopModel?> build() async {
    // Initialize any necessary data or state here
    return null;
  }

  /// Add a new shop.
  Future<void> addShop({
    required String shopName,
    required String? shopEmail,
    required String shopPhone,
    required String shopAddress,
    required String shopDescription,
    required int giftCycleDay,
    required int bonusIncrement,
    required int daysRequired,
    required String? associatedCampaignId,
  }) async {
    final userId = (ref.read(authControllerProvider).requireValue!).userId;

    final shop = ShopModel.createNew(
      shopName: shopName,
      shopPhone: shopPhone,
      shopAddress: shopAddress,
      shopDescription: shopDescription,
      shopVendorId: userId,
      shopEmail: shopEmail,
      giftCycleDay: giftCycleDay,
      bonusIncrement: bonusIncrement,
      daysRequired: daysRequired,
      associatedCampaignId: associatedCampaignId,
    );

    state = const AsyncValue.loading();

    state = await AsyncValue.guard(() async {
      final result = await ref.read(addShopUsecaseProvider).call(shop);
      await ref
          .read(analyticsServiceProvider)
          .logEntityManagement(
            action: EntityAction.add,
            entityType: EntityType.shop,
            entityId: result.id ?? '',
          );
      return result;
    });
  }

  /// Edit an existing shop.
  Future<void> editShop({
    required ShopModel shop,
    // required String shopCategory,
  }) async {
    // Implement the logic to edit an existing shop

    state = const AsyncValue.loading();

    state = await AsyncValue.guard(() async {
      final result = await ref
          .read(shopRepositoryProvider)
          .editShop(shop: shop);
      await ref
          .read(analyticsServiceProvider)
          .logEntityManagement(
            action: EntityAction.edit,
            entityType: EntityType.shop,
            entityId: shop.id ?? '',
          );
      return result;
    });
  }
}
