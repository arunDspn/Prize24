// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vendor_sent_request_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_VendorSentRequestDto _$VendorSentRequestDtoFromJson(
  Map<String, dynamic> json,
) => _VendorSentRequestDto(
  id: json['id'] as String,
  receiverId: json['receiverId'] as String,
  receiverName: json['receiverName'] as String,
  createdAt: DateTime.parse(json['createdAt'] as String),
  status: json['status'] as String,
);

Map<String, dynamic> _$VendorSentRequestDtoToJson(
  _VendorSentRequestDto instance,
) => <String, dynamic>{
  'id': instance.id,
  'receiverId': instance.receiverId,
  'receiverName': instance.receiverName,
  'createdAt': instance.createdAt.toIso8601String(),
  'status': instance.status,
};
