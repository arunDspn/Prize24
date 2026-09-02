// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'staff_shop_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_StaffShopDto _$StaffShopDtoFromJson(Map<String, dynamic> json) =>
    _StaffShopDto(
      shopName: json['shopName'] as String,
      id: json['id'] as String?,
      associatedCampaignId: json['associatedCampaignId'] as String?,
    );

Map<String, dynamic> _$StaffShopDtoToJson(_StaffShopDto instance) =>
    <String, dynamic>{
      'shopName': instance.shopName,
      'id': instance.id,
      'associatedCampaignId': instance.associatedCampaignId,
    };
