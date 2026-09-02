import 'package:prize24_app/core/constants.dart';
import 'package:prize24_app/core/services/analytics/analytics_events.dart';
import 'package:prize24_app/core/services/analytics/analytics_service.dart';
import 'package:prize24_app/features/gift/data/repository/i_gift_repository.dart';
import 'package:prize24_app/features/gift/domain/models/gift_model.dart';
import 'package:prize24_app/features/global_controller/auth/auth_controller.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'add_edit_auto_redeemable_gift_controller.g.dart';

@riverpod
class AddEditAutoRedeemableGiftController
    extends _$AddEditAutoRedeemableGiftController {
  @override
  FutureOr<GiftModel?> build() {
    return null;
  }

  /// Create or update gift
  Future<GiftModel?> saveGift({
    required String campaignId,
    required String campaignName,
    required String giftName,
    required String giftDescription,
    required List<SupportedShopModel> selectedShops,
    required String totalGifts,
  }) async {
    state = const AsyncValue.loading();

    state = await AsyncValue.guard(() async {
      final userId = (ref.read(authControllerProvider).requireValue!).userId;

      final gift = GiftModel(
        id: null,
        name: giftName.trim(),
        description: giftDescription.trim(),
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
        campaignId: campaignId,
        campaignName: campaignName,
        totalQuantity: int.parse(totalGifts),
        remainingQuantity: int.parse(totalGifts),
        giftType: GiftType.auto.toShortString(),
        isRedeemable: true,
        supportedShops: selectedShops,
        userId: userId,
      );

      final result = await ref
          .read(giftRepositoryProvider)
          .createAutoRedeemableGift(gift: gift);
      await ref
          .read(analyticsServiceProvider)
          .logEntityManagement(
            action: EntityAction.add,
            entityType: EntityType.gift,
            entityId: result.id ?? '',
          );
      return result;
    });
    return state.value;
  }

  // Edit gift
  Future<GiftModel?> editGift({
    required GiftModel existingGift,
    required String giftName,
    required String giftDescription,
    required List<SupportedShopModel> selectedShops,
    required String totalGifts,
    required int remainingQuantity,
  }) async {
    state = const AsyncValue.loading();

    state = await AsyncValue.guard(() async {
      final updatedGift = existingGift.copyWith(
        name: giftName.trim(),
        description: giftDescription.trim(),
        updatedAt: DateTime.now(),
        totalQuantity: int.parse(totalGifts),
        remainingQuantity: remainingQuantity,
        supportedShops: selectedShops,
      );

      final result = await ref
          .read(giftRepositoryProvider)
          .editGift(gift: updatedGift);
      await ref
          .read(analyticsServiceProvider)
          .logEntityManagement(
            action: EntityAction.edit,
            entityType: EntityType.gift,
            entityId: existingGift.id ?? '',
          );
      return result;
    });
    return state.value;
  }
}
