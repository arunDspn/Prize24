// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auto_redeemable_gift_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_AutoRedeemableGiftDto _$AutoRedeemableGiftDtoFromJson(
  Map<String, dynamic> json,
) => _AutoRedeemableGiftDto(
  campaignId: json['campaignId'] as String,
  campaignName: json['campaignName'] as String,
  createdAt: json['createdAt'] as String,
  description: json['description'] as String,
  giftType: json['giftType'] as String,
  isRedeemable: json['isRedeemable'] as bool,
  name: json['name'] as String,
  publicSlug: json['publicSlug'] as String?,
  remainingQuantity: (json['remainingQuantity'] as num).toInt(),
  supportedShops: (json['supportedShops'] as List<dynamic>)
      .map((e) => GiftSupportedShopDto.fromJson(e as Map<String, dynamic>))
      .toList(),
  totalQuantity: (json['totalQuantity'] as num).toInt(),
  updatedAt: json['updatedAt'] as String,
  userId: json['userId'] as String,
);

Map<String, dynamic> _$AutoRedeemableGiftDtoToJson(
  _AutoRedeemableGiftDto instance,
) => <String, dynamic>{
  'campaignId': instance.campaignId,
  'campaignName': instance.campaignName,
  'createdAt': instance.createdAt,
  'description': instance.description,
  'giftType': instance.giftType,
  'isRedeemable': instance.isRedeemable,
  'name': instance.name,
  'publicSlug': instance.publicSlug,
  'remainingQuantity': instance.remainingQuantity,
  'supportedShops': instance.supportedShops,
  'totalQuantity': instance.totalQuantity,
  'updatedAt': instance.updatedAt,
  'userId': instance.userId,
};

_GiftSupportedShopDto _$GiftSupportedShopDtoFromJson(
  Map<String, dynamic> json,
) => _GiftSupportedShopDto(
  id: json['id'] as String,
  name: json['name'] as String,
  shopAddress: json['shopAddress'] as String,
  shopEmail: json['shopEmail'] as String,
  shopPhone: json['shopPhone'] as String,
  shopWebsite: json['shopWebsite'] as String,
);

Map<String, dynamic> _$GiftSupportedShopDtoToJson(
  _GiftSupportedShopDto instance,
) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'shopAddress': instance.shopAddress,
  'shopEmail': instance.shopEmail,
  'shopPhone': instance.shopPhone,
  'shopWebsite': instance.shopWebsite,
};
