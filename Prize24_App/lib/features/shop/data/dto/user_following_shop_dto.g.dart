// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_following_shop_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_UserFollowingShopDto _$UserFollowingShopDtoFromJson(
  Map<String, dynamic> json,
) => _UserFollowingShopDto(
  shopId: json['shopId'] as String,
  shopName: json['shopName'] as String,
  shopAddress: json['shopAddress'] as String,
  shopPhoneNumber: json['shopPhone'] as String,
  notificationEnabled: json['notificationEnabled'] as bool,
  consecutiveDays: (json['consecutiveDays'] as num).toInt(),
  cumulativeStreak: (json['cumulativeStreak'] as num).toInt(),
  isGiftAvailable: json['isGiftAvailable'] as bool? ?? false,
  followedAt: FirebaseHelper.timestampFromJson(json['followedAt']),
  giftCycleDays: (json['giftCycleDays'] as num?)?.toInt(),
  lastCheckInDate: FirebaseHelper.nullableTimestampFromJson(
    json['lastCheckInDate'],
  ),
);

Map<String, dynamic> _$UserFollowingShopDtoToJson(
  _UserFollowingShopDto instance,
) => <String, dynamic>{
  'shopId': instance.shopId,
  'shopName': instance.shopName,
  'shopAddress': instance.shopAddress,
  'shopPhone': instance.shopPhoneNumber,
  'notificationEnabled': instance.notificationEnabled,
  'consecutiveDays': instance.consecutiveDays,
  'cumulativeStreak': instance.cumulativeStreak,
  'isGiftAvailable': instance.isGiftAvailable,
  'followedAt': FirebaseHelper.timestampToJson(instance.followedAt),
  'giftCycleDays': instance.giftCycleDays,
  'lastCheckInDate': FirebaseHelper.nullableTimestampToJson(
    instance.lastCheckInDate,
  ),
};
