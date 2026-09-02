// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'shop_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ShopDto _$ShopDtoFromJson(Map<String, dynamic> json) => _ShopDto(
  shopName: json['shopName'] as String,
  shopPhone: json['shopPhone'] as String,
  shopAddress: json['shopAddress'] as String,
  shopOwnerId: json['shopOwnerId'] as String,
  shopStatus: json['shopStatus'] as String? ?? 'active',
  shopId: json['shopId'] as String?,
  shopDescription: json['shopDescription'] as String?,
  createdAt: const TimestampConverter().fromJson(json['createdAt']),
  updatedAt: const TimestampConverter().fromJson(json['updatedAt']),
  shopEmail: json['shopEmail'] as String?,
  giftCycleDay: (json['giftCycleDay'] as num).toInt(),
  bonusIncrementValue: (json['bonusIncrementValue'] as num).toInt(),
  bonusIncrementDaysRequired: (json['bonusIncrementDaysRequired'] as num)
      .toInt(),
  totalFollowers: (json['totalFollowers'] as num?)?.toInt() ?? 0,
  associatedCampaignId: json['associatedCampaignId'] as String?,
);

Map<String, dynamic> _$ShopDtoToJson(_ShopDto instance) => <String, dynamic>{
  'shopName': instance.shopName,
  'shopPhone': instance.shopPhone,
  'shopAddress': instance.shopAddress,
  'shopOwnerId': instance.shopOwnerId,
  'shopStatus': instance.shopStatus,
  'shopId': ?instance.shopId,
  'shopDescription': instance.shopDescription,
  'createdAt': const TimestampConverter().toJson(instance.createdAt),
  'updatedAt': const TimestampConverter().toJson(instance.updatedAt),
  'shopEmail': instance.shopEmail,
  'giftCycleDay': instance.giftCycleDay,
  'bonusIncrementValue': instance.bonusIncrementValue,
  'bonusIncrementDaysRequired': instance.bonusIncrementDaysRequired,
  'totalFollowers': instance.totalFollowers,
  'associatedCampaignId': instance.associatedCampaignId,
};
