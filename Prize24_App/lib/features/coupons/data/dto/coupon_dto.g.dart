// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'coupon_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_CouponDto _$CouponDtoFromJson(Map<String, dynamic> json) => _CouponDto(
  couponName: json['couponName'] as String,
  storeName: json['storeName'] as String,
  description: json['description'] as String,
  couponCode: json['couponCode'] as String,
  drawDateTime: DateTime.parse(json['drawDateTime'] as String),
  expiryDate: DateTime.parse(json['expiryDate'] as String),
  prizePools: (json['prizePools'] as List<dynamic>)
      .map((e) => PricePoolDto.fromJson(e as Map<String, dynamic>))
      .toList(),
  shopId: json['shopId'] as String,
  id: json['id'] as String?,
);

Map<String, dynamic> _$CouponDtoToJson(_CouponDto instance) =>
    <String, dynamic>{
      'couponName': instance.couponName,
      'storeName': instance.storeName,
      'description': instance.description,
      'couponCode': instance.couponCode,
      'drawDateTime': instance.drawDateTime.toIso8601String(),
      'expiryDate': instance.expiryDate.toIso8601String(),
      'prizePools': instance.prizePools,
      'shopId': instance.shopId,
      'id': instance.id,
    };
