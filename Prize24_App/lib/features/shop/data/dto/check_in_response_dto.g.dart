// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'check_in_response_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_CheckInResponseDto _$CheckInResponseDtoFromJson(Map<String, dynamic> json) =>
    _CheckInResponseDto(
      success: json['success'] as bool,
      message: json['message'] as String,
      error: json['error'] as String?,
      data: json['data'] == null
          ? null
          : CheckInResponseDataDto.fromJson(
              json['data'] as Map<String, dynamic>,
            ),
    );

Map<String, dynamic> _$CheckInResponseDtoToJson(_CheckInResponseDto instance) =>
    <String, dynamic>{
      'success': instance.success,
      'message': instance.message,
      'error': instance.error,
      'data': instance.data,
    };

_CheckInResponseDataDto _$CheckInResponseDataDtoFromJson(
  Map<String, dynamic> json,
) => _CheckInResponseDataDto(
  cumulativeStreak: (json['cumulativeStreak'] as num).toInt(),
  consecutiveDays: (json['consecutiveDays'] as num).toInt(),
  bonusApplied: json['bonusApplied'] as bool,
  isGiftDay: json['isGiftDay'] as bool,
  isNewUser: json['isNewUser'] as bool,
);

Map<String, dynamic> _$CheckInResponseDataDtoToJson(
  _CheckInResponseDataDto instance,
) => <String, dynamic>{
  'cumulativeStreak': instance.cumulativeStreak,
  'consecutiveDays': instance.consecutiveDays,
  'bonusApplied': instance.bonusApplied,
  'isGiftDay': instance.isGiftDay,
  'isNewUser': instance.isNewUser,
};
