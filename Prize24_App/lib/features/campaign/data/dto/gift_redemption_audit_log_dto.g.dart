// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'gift_redemption_audit_log_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_GiftRedemptionAuditLogDto _$GiftRedemptionAuditLogDtoFromJson(
  Map<String, dynamic> json,
) => _GiftRedemptionAuditLogDto(
  action: json['action'] as String,
  redeemedBy: json['redeemedBy'] as String,
  redeemerRole: json['redeemerRole'] as String,
  functionName: json['functionName'] as String,
  success: json['success'] as bool,
  timestamp: FirebaseHelper.timestampFromJson(json['timestamp']),
  giftId: json['giftId'] as String?,
  customerId: json['customerId'] as String?,
  shopId: json['shopId'] as String?,
  errorCode: json['errorCode'] as String?,
  errorMessage: json['errorMessage'] as String?,
  phoneNumber: json['phoneNumber'] as String?,
);

Map<String, dynamic> _$GiftRedemptionAuditLogDtoToJson(
  _GiftRedemptionAuditLogDto instance,
) => <String, dynamic>{
  'action': instance.action,
  'redeemedBy': instance.redeemedBy,
  'redeemerRole': instance.redeemerRole,
  'functionName': instance.functionName,
  'success': instance.success,
  'timestamp': FirebaseHelper.timestampToJson(instance.timestamp),
  'giftId': instance.giftId,
  'customerId': instance.customerId,
  'shopId': instance.shopId,
  'errorCode': instance.errorCode,
  'errorMessage': instance.errorMessage,
  'phoneNumber': instance.phoneNumber,
};
