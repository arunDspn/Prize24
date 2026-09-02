// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_user_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AuthenticatedUserDto _$AuthenticatedUserDtoFromJson(
  Map<String, dynamic> json,
) => AuthenticatedUserDto(
  userId: json['userId'] as String,
  userEmail: json['userEmail'] as String,
  userName: json['userName'] as String,
  isVendor: json['isVendor'] as bool,
  fcmToken: json['fcmToken'] as String,
  userAvatar: json['userAvatar'] as String?,
);

Map<String, dynamic> _$AuthenticatedUserDtoToJson(
  AuthenticatedUserDto instance,
) => <String, dynamic>{
  'userId': instance.userId,
  'userEmail': instance.userEmail,
  'userName': instance.userName,
  'userAvatar': instance.userAvatar,
  'isVendor': instance.isVendor,
  'fcmToken': instance.fcmToken,
};
