// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'club_member_vendor_data_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ClubMemberVendorDataDto _$ClubMemberVendorDataDtoFromJson(
  Map<String, dynamic> json,
) => _ClubMemberVendorDataDto(
  streakTotal: (json['streakTotal'] as num).toInt(),
  consecutiveDays: (json['consecutiveDays'] as num).toInt(),
  lastCheckInDate: FirebaseHelper.nullableTimestampFromJson(
    json['lastCheckInDate'],
  ),
  lastBonusDate: FirebaseHelper.nullableTimestampFromJson(
    json['lastBonusDate'],
  ),
  joinedAt: FirebaseHelper.timestampFromJson(json['joinedAt']),
  userName: json['userName'] as String,
  userId: json['userId'] as String,
);

Map<String, dynamic> _$ClubMemberVendorDataDtoToJson(
  _ClubMemberVendorDataDto instance,
) => <String, dynamic>{
  'streakTotal': instance.streakTotal,
  'consecutiveDays': instance.consecutiveDays,
  'lastCheckInDate': FirebaseHelper.nullableTimestampToJson(
    instance.lastCheckInDate,
  ),
  'lastBonusDate': FirebaseHelper.nullableTimestampToJson(
    instance.lastBonusDate,
  ),
  'joinedAt': FirebaseHelper.timestampToJson(instance.joinedAt),
  'userName': instance.userName,
  'userId': instance.userId,
};
