// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'become_staff_request_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_BecomeStaffRequestDto _$BecomeStaffRequestDtoFromJson(
  Map<String, dynamic> json,
) => _BecomeStaffRequestDto(
  shopId: json['shopId'] as String,
  shopName: json['shopName'] as String,
  requestedAt: FirebaseHelper.timestampFromJson(json['requestedAt']),
  id: json['id'] as String? ?? '',
);

Map<String, dynamic> _$BecomeStaffRequestDtoToJson(
  _BecomeStaffRequestDto instance,
) => <String, dynamic>{
  'shopId': instance.shopId,
  'shopName': instance.shopName,
  'requestedAt': FirebaseHelper.timestampToJson(instance.requestedAt),
  'id': instance.id,
};
