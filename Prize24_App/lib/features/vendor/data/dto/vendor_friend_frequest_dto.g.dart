// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vendor_friend_frequest_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_VendorFriendFrequestDto _$VendorFriendFrequestDtoFromJson(
  Map<String, dynamic> json,
) => _VendorFriendFrequestDto(
  id: json['id'] as String,
  vendorId: json['vendorId'] as String,
  vendorName: json['vendorName'] as String,
  createdAt: DateTime.parse(json['createdAt'] as String),
);

Map<String, dynamic> _$VendorFriendFrequestDtoToJson(
  _VendorFriendFrequestDto instance,
) => <String, dynamic>{
  'id': instance.id,
  'vendorId': instance.vendorId,
  'vendorName': instance.vendorName,
  'createdAt': instance.createdAt.toIso8601String(),
};
