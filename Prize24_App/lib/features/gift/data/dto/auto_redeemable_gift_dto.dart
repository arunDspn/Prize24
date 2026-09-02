import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:prize24_app/features/gift/domain/models/auto_redeemable_gift_model.dart';
part 'auto_redeemable_gift_dto.freezed.dart';
part 'auto_redeemable_gift_dto.g.dart';

@freezed
abstract class AutoRedeemableGiftDto with _$AutoRedeemableGiftDto {
  const factory AutoRedeemableGiftDto({
    required String campaignId,
    required String campaignName,
    required String createdAt,
    required String description,
    required String giftType,
    required bool isRedeemable,
    required String name,
    required String? publicSlug,
    required int remainingQuantity,
    required List<GiftSupportedShopDto> supportedShops,
    required int totalQuantity,
    required String updatedAt,
    required String userId,
  }) = _AutoRedeemableGiftDto;

  factory AutoRedeemableGiftDto.fromJson(Map<String, dynamic> json) =>
      _$AutoRedeemableGiftDtoFromJson(json);

  // Private constructor for freezed
  const AutoRedeemableGiftDto._();

  // To convert DTO to Model
  AutoRedeemableGiftModel toModel() {
    return AutoRedeemableGiftModel(
      campaignId: campaignId,
      campaignName: campaignName,
      createdAt: createdAt,
      description: description,
      giftType: giftType,
      isRedeemable: isRedeemable,
      name: name,
      publicSlug: publicSlug,
      remainingQuantity: remainingQuantity,
      supportedShops: supportedShops.map((shop) => shop.toModel()).toList(),
      totalQuantity: totalQuantity,
      updatedAt: updatedAt,
      userId: userId,
    );
  }
}

@freezed
abstract class GiftSupportedShopDto with _$GiftSupportedShopDto {
  const factory GiftSupportedShopDto({
    required String id,
    required String name,
    required String shopAddress,
    required String shopEmail,
    required String shopPhone,
    required String shopWebsite,
  }) = _GiftSupportedShopDto;

  factory GiftSupportedShopDto.fromJson(Map<String, dynamic> json) =>
      _$GiftSupportedShopDtoFromJson(json);

  // Private constructor for freezed
  const GiftSupportedShopDto._();

  // To convert DTO to Model
  GiftSupportedShopModel toModel() {
    return GiftSupportedShopModel(
      id: id,
      name: name,
      shopAddress: shopAddress,
      shopEmail: shopEmail,
      shopPhone: shopPhone,
      shopWebsite: shopWebsite,
    );
  }
}
