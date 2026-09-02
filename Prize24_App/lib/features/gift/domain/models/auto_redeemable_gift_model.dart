import 'package:freezed_annotation/freezed_annotation.dart';
part 'auto_redeemable_gift_model.freezed.dart';

@freezed
abstract class AutoRedeemableGiftModel with _$AutoRedeemableGiftModel {
  const factory AutoRedeemableGiftModel({
    required String campaignId,
    required String campaignName,
    required String createdAt,
    required String description,
    required String giftType,
    required bool isRedeemable,
    required String name,
    required String? publicSlug,
    required int remainingQuantity,
    required List<GiftSupportedShopModel> supportedShops,
    required int totalQuantity,
    required String updatedAt,
    required String userId,
  }) = _AutoRedeemableGiftModel;
}

@freezed
abstract class GiftSupportedShopModel with _$GiftSupportedShopModel {
  const factory GiftSupportedShopModel({
    required String id,
    required String name,
    required String shopAddress,
    required String shopEmail,
    required String shopPhone,
    required String shopWebsite,
  }) = _GiftSupportedShopModel;
}
