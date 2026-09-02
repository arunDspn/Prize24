// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_AppUser _$AppUserFromJson(Map<String, dynamic> json) => _AppUser(
  userId: json['userId'] as String,
  userEmail: json['userEmail'] as String,
  userName: json['userName'] as String,
  isVendor: json['isVendor'] as bool,
  fcmToken: json['fcmToken'] as String,
  referralCode: json['referralCode'] as String,
  subscribedShopTopics: (json['subscribedShopTopics'] as List<dynamic>?)
      ?.map((e) => e as String)
      .toList(),
  staffShopIds: (json['staffShopIds'] as List<dynamic>?)
      ?.map((e) => e as String)
      .toList(),
  profilePic: json['profilePic'] as String?,
  userPhoneNumber: json['userPhoneNumber'] as String?,
  vendorPhoneNumber: json['vendorPhoneNumber'] as String?,
  referredBy: json['referredBy'] as String?,
  deletionRequestedAt: const TimestampConverter().fromJson(
    json['deletionRequestedAt'],
  ),
);

Map<String, dynamic> _$AppUserToJson(_AppUser instance) => <String, dynamic>{
  'userId': instance.userId,
  'userEmail': instance.userEmail,
  'userName': instance.userName,
  'isVendor': instance.isVendor,
  'fcmToken': instance.fcmToken,
  'referralCode': instance.referralCode,
  'subscribedShopTopics': instance.subscribedShopTopics,
  'staffShopIds': instance.staffShopIds,
  'profilePic': instance.profilePic,
  'userPhoneNumber': instance.userPhoneNumber,
  'vendorPhoneNumber': instance.vendorPhoneNumber,
  'referredBy': instance.referredBy,
  'deletionRequestedAt': const TimestampConverter().toJson(
    instance.deletionRequestedAt,
  ),
};
