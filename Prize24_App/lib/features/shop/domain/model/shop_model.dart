// import 'package:equatable/equatable.dart';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:prize24_app/core/constants.dart';
part 'shop_model.freezed.dart';

@freezed
abstract class ShopModel with _$ShopModel {
  const factory ShopModel({
    required String? id,
    required String shopName,
    required String shopPhone,
    required String shopAddress,

    /// Vendor ID == User ID
    required String shopOwnerId,
    @JsonKey(defaultValue: '') String? shopDescription,
    String? shopEmail,
    // required String shopLocation,
    @Default(ShopStatus.active) ShopStatus shopStatus,

    // Streak Data
    required int giftCycleDay,
    required int bonusIncrementValue,
    required int bonusIncrementDaysRequired,
    required int totalFollowers,
    String? associatedCampaignId,
    DateTime? createdAt,
    DateTime? updatedAt,
    // required double shopRating,
    // required int shopReviewsCount,
    // required String shopWebsite,
    // required List<String> shopSocialMediaLinks,
    // required Map<String, String> shopOperatingHours,
  }) = _ShopModel;

  // Default Pricate contrstucnt
  const ShopModel._();

  // Factory create new ShopModel with default values
  // for createdAt and updatedAt and ShopStatus
  factory ShopModel.createNew({
    required String shopName,
    required String shopPhone,
    required String shopAddress,
    required String shopDescription,
    // required String shopCategory,
    required String shopVendorId,
    required String? shopEmail,
    required int giftCycleDay,
    required int bonusIncrement,
    required int daysRequired,
    String? associatedCampaignId,
  }) {
    return ShopModel(
      shopName: shopName,
      shopPhone: shopPhone,
      shopAddress: shopAddress,
      shopDescription: shopDescription,
      // shopCategory: shopCategory,
      shopOwnerId: shopVendorId, id: '',
      shopEmail: shopEmail,
      giftCycleDay: giftCycleDay,
      bonusIncrementValue: bonusIncrement,
      bonusIncrementDaysRequired: daysRequired,
      totalFollowers: 0,
      associatedCampaignId: associatedCampaignId,
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
//     // required this.shopCategory,
//     required this.shopVendorId,
//     // required this.shopLocation,
//     this.shopStatus,
//     this.shopCreatedAt,
//     this.shopUpdatedAt,
//     // required this.shopRating,
//     // required this.shopReviewsCount,
//     // required this.shopWebsite,
//     // required this.shopSocialMediaLinks,
//     // required this.shopOperatingHours,
//   });

//   final String? shopId;
//   final String shopName;
//   final String shopEmail;
//   final String shopPhone;
//   final String shopAddress;
//   // final String shopLogo;
//   final String shopDescription;
//   final String shopCategory;
//   final String shopVendorId;
//   // final String shopLocation;
//   final String? shopStatus;
//   final String? shopCreatedAt;
//   final String? shopUpdatedAt;
//   // final String shopRating;
//   // final String shopReviewsCount;
//   // final String shopWebsite;
//   // final String shopSocialMediaLinks;
//   // final String shopOperatingHours;
//   @override
//   List<Object?> get props => [
//         shopId,
//         shopName,
//         shopEmail,
//         shopPhone,
//         shopAddress,
//         // shopLogo,
//         shopDescription,
//         shopCategory,
//         shopVendorId,
//         // shopLocation,
//         shopStatus,
//         shopCreatedAt,
//         shopUpdatedAt,
//         // shopRating,
//         // shopReviewsCount,
//         // shopWebsite,
//         // shopSocialMediaLinks,
//         // shopOperatingHours
//       ];

//   // Factory method to create a copy of the shop with updated values
//   ShopModel copyWith({
//     String? shopId,
//     String? shopName,
//     String? shopEmail,
//     String? shopPhone,
//     String? shopAddress,
//     // String? shopLogo,
//     String? shopDescription,
//     String? shopCategory,
//     String? shopVendorId,
//     // String? shopLocation,
//     String? shopStatus,
//     String? shopCreatedAt,
//     String? shopUpdatedAt,
//     // String? shopRating,
//     // String? shopReviewsCount,
//     // String? shopWebsite,
//     // String? shopSocialMediaLinks,
//     // String? shopOperatingHours
//   }) {
//     return ShopModel(
//       shopId: shopId ?? this.shopId,
//       shopName: shopName ?? this.shopName,
//       shopEmail: shopEmail ?? this.shopEmail,
//       shopPhone: shopPhone ?? this.shopPhone,
//       shopAddress: shopAddress ?? this.shopAddress,
//       // shopLogo: shopLogo ?? this.shopLogo,
//       shopDescription: shopDescription ?? this.shopDescription,
//       shopCategory: shopCategory ?? this.shopCategory,
//       shopVendorId: shopVendorId ?? this.shopVendorId,
//       // shopLocation: shopLocation ?? this.shopLocation,
//       shopStatus: shopStatus ?? this.shopStatus,
//       shopCreatedAt: shopCreatedAt ?? this.shopCreatedAt,
//       shopUpdatedAt: shopUpdatedAt ?? this.shopUpdatedAt,
//       // shopRating: shopRating ?? this.shopRating,
//       // shopReviewsCount: shopReviewsCount ?? this.shopReviewsCount,
//       // shopWebsite: shopWebsite ?? this.shopWebsite,
//       // shopSocialMediaLinks: shopSocialMediaLinks ?? this.shopSocialMediaLinks,
//       // shopOperatingHours: shopOperatingHours ?? this.shopOperatingHours
//     );
//   }
// }
