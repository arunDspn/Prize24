import 'package:freezed_annotation/freezed_annotation.dart';
part 'campaign_shared_vendor_dto.freezed.dart';
part 'campaign_shared_vendor_dto.g.dart';

@freezed
abstract class CampaignSharedVendorDto with _$CampaignSharedVendorDto {
  const factory CampaignSharedVendorDto({
    required String userId,
    required String vendorName,
    required String vendorId,
    required List<SharedVendorsShop> sharedVendorsShops,
  }) = _CampaignSharedVendorDto;

  factory CampaignSharedVendorDto.fromJson(Map<String, dynamic> json) =>
      _$CampaignSharedVendorDtoFromJson(json);
}

@freezed
abstract class SharedVendorsShop with _$SharedVendorsShop {
  const factory SharedVendorsShop({
    required String shopId,
    required String shopName,
    required List<CampaignSharedVendorDto> sharedVendors,
  }) = _SharedVendorsShop;

  factory SharedVendorsShop.fromJson(Map<String, dynamic> json) =>
      _$SharedVendorsShopFromJson(json);
}
