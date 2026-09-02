// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'campaign_shared_vendor_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_CampaignSharedVendorDto _$CampaignSharedVendorDtoFromJson(
  Map<String, dynamic> json,
) => _CampaignSharedVendorDto(
  userId: json['userId'] as String,
  vendorName: json['vendorName'] as String,
  vendorId: json['vendorId'] as String,
  sharedVendorsShops: (json['sharedVendorsShops'] as List<dynamic>)
      .map((e) => SharedVendorsShop.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$CampaignSharedVendorDtoToJson(
  _CampaignSharedVendorDto instance,
) => <String, dynamic>{
  'userId': instance.userId,
  'vendorName': instance.vendorName,
  'vendorId': instance.vendorId,
  'sharedVendorsShops': instance.sharedVendorsShops,
};

_SharedVendorsShop _$SharedVendorsShopFromJson(Map<String, dynamic> json) =>
    _SharedVendorsShop(
      shopId: json['shopId'] as String,
      shopName: json['shopName'] as String,
      sharedVendors: (json['sharedVendors'] as List<dynamic>)
          .map(
            (e) => CampaignSharedVendorDto.fromJson(e as Map<String, dynamic>),
          )
          .toList(),
    );

Map<String, dynamic> _$SharedVendorsShopToJson(_SharedVendorsShop instance) =>
    <String, dynamic>{
      'shopId': instance.shopId,
      'shopName': instance.shopName,
      'sharedVendors': instance.sharedVendors,
    };
