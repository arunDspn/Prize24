// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'shop_follow_response_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ShopFollowResponseDto _$ShopFollowResponseDtoFromJson(
  Map<String, dynamic> json,
) => _ShopFollowResponseDto(
  success: json['success'] as bool,
  message: json['message'] as String,
  data: json['data'] as Map<String, dynamic>?,
  error: json['error'] as String?,
);

Map<String, dynamic> _$ShopFollowResponseDtoToJson(
  _ShopFollowResponseDto instance,
) => <String, dynamic>{
  'success': instance.success,
  'message': instance.message,
  'data': instance.data,
  'error': instance.error,
};
