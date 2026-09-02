// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'gift_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_GiftDto _$GiftDtoFromJson(Map<String, dynamic> json) => _GiftDto(
  name: json['name'] as String,
  description: json['description'] as String,
  createdAt: DateTime.parse(json['createdAt'] as String),
  updatedAt: DateTime.parse(json['updatedAt'] as String),
  campaignId: json['campaignId'] as String,
  campaignName: json['campaignName'] as String,
  totalQuantity: (json['totalQuantity'] as num).toInt(),
  remainingQuantity: (json['remainingQuantity'] as num).toInt(),
  giftType: json['giftType'] as String,
  isRedeemable: json['isRedeemable'] as bool,
  userId: json['userId'] as String,
  id: json['id'] as String?,
  publicSlug: json['publicSlug'] as String?,
  supportedShops: (json['supportedShops'] as List<dynamic>?)
      ?.map((e) => SupportedShopDto.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$GiftDtoToJson(_GiftDto instance) => <String, dynamic>{
  'name': instance.name,
  'description': instance.description,
  'createdAt': instance.createdAt.toIso8601String(),
  'updatedAt': instance.updatedAt.toIso8601String(),
  'campaignId': instance.campaignId,
  'campaignName': instance.campaignName,
  'totalQuantity': instance.totalQuantity,
  'remainingQuantity': instance.remainingQuantity,
  'giftType': instance.giftType,
  'isRedeemable': instance.isRedeemable,
  'userId': instance.userId,
  'id': ?instance.id,
  'publicSlug': instance.publicSlug,
  'supportedShops': instance.supportedShops,
};

_CodeGiftCodeDto _$CodeGiftCodeDtoFromJson(Map<String, dynamic> json) =>
    _CodeGiftCodeDto(
      id: json['id'] as String?,
      code: json['code'] as String,
      payload: json['payload'] as String?,
      isRedeemed: json['isRedeemed'] as bool,
      redeemedByUserId: json['redeemedByUserId'] as String?,
    );

Map<String, dynamic> _$CodeGiftCodeDtoToJson(_CodeGiftCodeDto instance) =>
    <String, dynamic>{
      'id': ?instance.id,
      'code': instance.code,
      'payload': ?instance.payload,
      'isRedeemed': instance.isRedeemed,
      'redeemedByUserId': instance.redeemedByUserId,
    };

_AutoGiftPayloadDto _$AutoGiftPayloadDtoFromJson(Map<String, dynamic> json) =>
    _AutoGiftPayloadDto(
      id: json['id'] as String?,
      content: json['content'] as String,
      redeemedAt: json['redeemedAt'] == null
          ? null
          : DateTime.parse(json['redeemedAt'] as String),
      redeemedByUserId: json['redeemedByUserId'] as String?,
    );

Map<String, dynamic> _$AutoGiftPayloadDtoToJson(_AutoGiftPayloadDto instance) =>
    <String, dynamic>{
      'id': ?instance.id,
      'content': instance.content,
      'redeemedAt': instance.redeemedAt?.toIso8601String(),
      'redeemedByUserId': instance.redeemedByUserId,
    };

_SupportedShopDto _$SupportedShopDtoFromJson(Map<String, dynamic> json) =>
    _SupportedShopDto(
      id: json['id'] as String,
      name: json['name'] as String,
      shopAddress: json['shopAddress'] as String,
      shopPhone: json['shopPhone'] as String,
      shopEmail: json['shopEmail'] as String?,
      shopWebsite: json['shopWebsite'] as String?,
    );

Map<String, dynamic> _$SupportedShopDtoToJson(_SupportedShopDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'shopAddress': instance.shopAddress,
      'shopPhone': instance.shopPhone,
      'shopEmail': instance.shopEmail,
      'shopWebsite': instance.shopWebsite,
    };
