import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:prize24_app/features/shop/domain/model/shop_model.dart';
import 'package:prize24_app/utils/date_convertors.dart';

part 'shop_dto.freezed.dart';
part 'shop_dto.g.dart';

@freezed
abstract class ShopDto with _$ShopDto {
  const factory ShopDto({
    required String shopName,
    required String shopPhone,
    required String shopAddress,
    // required String shopCategory,

    /// The ID of the vendor that owns the shop.
    required String shopOwnerId,
    @Default('active') String shopStatus,
    @JsonKey(includeIfNull: false) String? shopId,
    String? shopDescription,
    @TimestampConverter() DateTime? createdAt,
    @TimestampConverter() DateTime? updatedAt,
    String? shopEmail,

    // Streak Data
    required int giftCycleDay,
    required int bonusIncrementValue,
    required int bonusIncrementDaysRequired,
    @Default(0) int totalFollowers,
    String? associatedCampaignId,
    // required double shopRating,
    // required int shopReviewsCount,
    // required String shopWebsite,
    // required Map<String, String> shopSocialMediaLinks,
    // required Map<String, String> shopOperatingHours,
  }) = _ShopDto;
  // Default private constructor
  const ShopDto._();

  /// Converts a ShopModel to a ShopDto.
  factory ShopDto.fromModel(ShopModel model) {
    return ShopDto(
      shopId: model.id,
      shopName: model.shopName,
      shopPhone: model.shopPhone,
      shopAddress: model.shopAddress,
      shopDescription: model.shopDescription,
      shopOwnerId: model.shopOwnerId,
      shopStatus: model.shopStatus.toShortString(),
      shopEmail: model.shopEmail,
      createdAt: model.createdAt,
      updatedAt: model.updatedAt,
      giftCycleDay: model.giftCycleDay,
      bonusIncrementValue: model.bonusIncrementValue,
      bonusIncrementDaysRequired: model.bonusIncrementDaysRequired,
      totalFollowers: model.totalFollowers,
      associatedCampaignId: model.associatedCampaignId,
      // shopRating: model.shopRating,
      // shopReviewsCount: model.shopReviewsCount,
      // shopWebsite: model.shopWebsite,
      // shopSocialMediaLinks: model.shopSocialMediaLinks,
      // shopOperatingHours: model.shopOperatingHours,
    );
  }

  factory ShopDto.fromJson(Map<String, dynamic> json) =>
      _$ShopDtoFromJson(json);

  /// Converts a ShopDto to a ShopModel.
  ShopModel toModel() {
    return ShopModel(
      id: shopId,
      shopName: shopName,
      shopPhone: shopPhone,
      shopAddress: shopAddress,
      shopDescription: shopDescription,
      shopOwnerId: shopOwnerId,
      shopEmail: shopEmail,
      createdAt: createdAt,
      updatedAt: updatedAt,
      giftCycleDay: giftCycleDay,
      bonusIncrementValue: bonusIncrementValue,
      bonusIncrementDaysRequired: bonusIncrementDaysRequired,
      totalFollowers: totalFollowers,
      associatedCampaignId: associatedCampaignId,
      // shopRating: shopRating,
      // shopReviewsCount: shopReviewsCount,
      // shopWebsite: shopWebsite,
      // shopSocialMediaLinks: shopSocialMediaLinks,
      // shopOperatingHours: shopOperatingHours,
    );
  }
}

// class ShopModel extends Equatable {
//   const ShopModel({
//     required this.shopId,
//     required this.shopName,
//     required this.shopEmail,
//     required this.shopPhone,
//     required this.shopAddress,
//     // required this.shopLogo,
//     required this.shopDescription,
//     required this.shopCategory,
//     required this.shopVendorId,
//     // required this.shopLocation,
//     required this.shopStatus,
//     required this.shopCreatedAt,
//     required this.shopUpdatedAt,
//     // required this.shopRating,
//     // required this.shopReviewsCount,
//     // required this.shopWebsite,
//     // required this.shopSocialMediaLinks,
//     // required this.shopOperatingHours,
//   });
