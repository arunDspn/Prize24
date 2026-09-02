// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'staff_request_send_item_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_StaffRequestSendItemDto _$StaffRequestSendItemDtoFromJson(
  Map<String, dynamic> json,
) => _StaffRequestSendItemDto(
  id: json['id'] as String?,
  receiverName: json['receiverName'] as String,
  shopId: json['shopId'] as String,
  receiverId: json['receiverId'] as String,
  requestedAt: FirebaseHelper.timestampFromJson(json['requestedAt']),
  respondedAt: FirebaseHelper.nullableTimestampFromJson(json['respondedAt']),
  status: json['status'] as String,
);

Map<String, dynamic> _$StaffRequestSendItemDtoToJson(
  _StaffRequestSendItemDto instance,
) => <String, dynamic>{
  'id': instance.id,
  'receiverName': instance.receiverName,
  'shopId': instance.shopId,
  'receiverId': instance.receiverId,
  'requestedAt': FirebaseHelper.timestampToJson(instance.requestedAt),
  'respondedAt': FirebaseHelper.nullableTimestampToJson(instance.respondedAt),
  'status': instance.status,
};
