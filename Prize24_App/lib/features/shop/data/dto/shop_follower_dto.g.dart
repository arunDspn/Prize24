// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'shop_follower_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ShopFollowerDto _$ShopFollowerDtoFromJson(Map<String, dynamic> json) =>
    _ShopFollowerDto(
      userId: json['userId'] as String,
      userName: json['userName'] as String,
      cumulativeStreak: (json['cumulativeStreak'] as num).toInt(),
      followedAt: FirebaseHelper.timestampFromJson(json['followedAt']),
      userPhoneNumber: json['userPhoneNumber'] as String?,
      lastCheckInDate: FirebaseHelper.nullableTimestampFromJson(
        json['lastCheckInDate'],
      ),
      lastGiftDayStreak: (json['lastGiftDayStreak'] as num?)?.toInt(),
      userProfilePic: json['userProfilePic'] as String?,
    );

Map<String, dynamic> _$ShopFollowerDtoToJson(_ShopFollowerDto instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'userName': instance.userName,
      'cumulativeStreak': instance.cumulativeStreak,
      'followedAt': FirebaseHelper.timestampToJson(instance.followedAt),
      'userPhoneNumber': instance.userPhoneNumber,
      'lastCheckInDate': FirebaseHelper.nullableTimestampToJson(
        instance.lastCheckInDate,
      ),
      'lastGiftDayStreak': instance.lastGiftDayStreak,
      'userProfilePic': instance.userProfilePic,
    };
