// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'shop_staff_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ShopStaffDto _$ShopStaffDtoFromJson(Map<String, dynamic> json) =>
    _ShopStaffDto(
      staffId: json['staffId'] as String?,
      staffName: json['staffName'] as String,
      addedAt: FirebaseHelper.timestampFromJson(json['addedAt']),
      staffPhone: json['staffPhone'] as String?,
    );

Map<String, dynamic> _$ShopStaffDtoToJson(_ShopStaffDto instance) =>
    <String, dynamic>{
      'staffId': instance.staffId,
      'staffName': instance.staffName,
      'addedAt': FirebaseHelper.timestampToJson(instance.addedAt),
      'staffPhone': instance.staffPhone,
    };
