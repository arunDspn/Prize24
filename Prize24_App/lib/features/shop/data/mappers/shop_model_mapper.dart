// import 'package:prize24_app/features/shop/data/dto/shop_dto.dart';
// import 'package:prize24_app/features/shop/domain/model/shop_model.dart';
// import 'package:prize24_app/utils/model_mapper_contract.dart';

// class ShopModelMapper implements ModelMapper<ShopModel, ShopDto> {
//   @override
//   ShopModel fromDto(ShopDto dto) {
//     return ShopModel(
//       id: dto.shopId,
//       shopName: dto.shopName,
//       shopEmail: dto.shopEmail,
//       shopPhone: dto.shopPhone,
//       shopAddress: dto.shopAddress,
//       shopDescription: dto.shopDescription,
//       shopCategory: dto.shopCategory,
//       shopVendorId: dto.shopVendorId,
//       shopStatus: dto.shopStatus,
//       createdAt: dto.shopCreatedAt?.toIso8601String(),
//       updatedAt: dto.shopUpdatedAt?.toIso8601String(),
//     );
//   }

//   @override
//   ShopDto toDto(ShopModel domainModel) {
//     return ShopDto(
//       shopId: domainModel.shopId,
//       shopName: domainModel.shopName,
//       shopEmail: domainModel.shopEmail,
//       shopPhone: domainModel.shopPhone,
//       shopAddress: domainModel.shopAddress,
//       // shopLogo: domainModel.shopLogo,
//       shopDescription: domainModel.shopDescription,
//       shopCategory: domainModel.shopCategory,
//       shopVendorId: domainModel.shopVendorId,
//       // shopLocation: domainModel.shopLocation,
//       shopStatus: domainModel.shopStatus,
//       createdAt: domainModel.shopCreatedAt != null
//           ? DateTime.parse(domainModel.shopCreatedAt!)
//           : null,
//       updatedAt: domainModel.shopUpdatedAt != null
//           ? DateTime.parse(domainModel.shopUpdatedAt!)
//           : null,

//       // shopRating: domainModel.shopRating,
//       // shopReviewsCount: domainModel.shopReviewsCount,
//       // shopWebsite: domainModel.shopWebsite,
//       // shopSocialMediaLinks: domainModel.shopSocialMediaLinks,
//       // shopOperatingHours: domainModel.shopOperatingHours,
//     );
//   }
// }

// // Extension Methods for ShopModel forto and from dto
// extension ShopModelExtension on ShopModel {
//   ShopDto toDto() => ShopModelMapper().toDto(this);
// }

// extension ShopDtoExtension on ShopDto {
//   ShopModel fromDto() => ShopModelMapper().fromDto(this);
// }
