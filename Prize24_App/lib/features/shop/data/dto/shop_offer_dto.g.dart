// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'shop_offer_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ShopOfferDto _$ShopOfferDtoFromJson(Map<String, dynamic> json) =>
    _ShopOfferDto(
      id: json['offerId'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
      startDate: FirebaseHelper.timestampFromJson(json['startDate']),
      endDate: FirebaseHelper.timestampFromJson(json['endDate']),
      createdAt: FirebaseHelper.timestampFromJson(json['createdAt']),
    );

Map<String, dynamic> _$ShopOfferDtoToJson(_ShopOfferDto instance) =>
    <String, dynamic>{
      'offerId': instance.id,
      'name': instance.name,
      'description': instance.description,
      'startDate': FirebaseHelper.timestampToJson(instance.startDate),
      'endDate': FirebaseHelper.timestampToJson(instance.endDate),
      'createdAt': FirebaseHelper.timestampToJson(instance.createdAt),
    };
