// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'club_member_user_data_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ClubMemberUserDataDto _$ClubMemberUserDataDtoFromJson(
  Map<String, dynamic> json,
) => _ClubMemberUserDataDto(
  streakTotal: (json['streakTotal'] as num).toInt(),
  consecutiveDays: (json['consecutiveDays'] as num).toInt(),
  lastCheckInDate: FirebaseHelper.nullableTimestampFromJson(
    json['lastCheckInDate'],
  ),
  lastBonusDate: FirebaseHelper.nullableTimestampFromJson(
    json['lastBonusDate'],
  ),
  lastGiftDate: FirebaseHelper.nullableTimestampFromJson(json['lastGiftDate']),
  giftDayCycle: (json['giftDayCycle'] as num).toInt(),
  clubName: json['clubName'] as String,
  clubDescription: json['clubDescription'] as String,
  clubId: json['clubId'] as String?,
);

Map<String, dynamic> _$ClubMemberUserDataDtoToJson(
  _ClubMemberUserDataDto instance,
) => <String, dynamic>{
  'streakTotal': instance.streakTotal,
  'consecutiveDays': instance.consecutiveDays,
  'lastCheckInDate': FirebaseHelper.nullableTimestampToJson(
    instance.lastCheckInDate,
  ),
  'lastBonusDate': FirebaseHelper.nullableTimestampToJson(
    instance.lastBonusDate,
  ),
  'lastGiftDate': FirebaseHelper.nullableTimestampToJson(instance.lastGiftDate),
  'giftDayCycle': instance.giftDayCycle,
  'clubName': instance.clubName,
  'clubDescription': instance.clubDescription,
  'clubId': instance.clubId,
};
