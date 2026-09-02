// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'follower_streak_log_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_FollowerStreakLogDto _$FollowerStreakLogDtoFromJson(
  Map<String, dynamic> json,
) => _FollowerStreakLogDto(
  consecutiveDays: (json['consecutiveDays'] as num).toInt(),
  cumulativeStreak: (json['cumulativeStreak'] as num).toInt(),
  isGiftDay: json['isGiftDay'] as bool,
  bonusApplied: json['bonusApplied'] as bool,
  timestamp: FirebaseHelper.timestampFromJson(json['timestamp']),
);

Map<String, dynamic> _$FollowerStreakLogDtoToJson(
  _FollowerStreakLogDto instance,
) => <String, dynamic>{
  'consecutiveDays': instance.consecutiveDays,
  'cumulativeStreak': instance.cumulativeStreak,
  'isGiftDay': instance.isGiftDay,
  'bonusApplied': instance.bonusApplied,
  'timestamp': FirebaseHelper.timestampToJson(instance.timestamp),
};
