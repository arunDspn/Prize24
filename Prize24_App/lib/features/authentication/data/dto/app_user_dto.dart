import 'package:json_annotation/json_annotation.dart';

part 'app_user_dto.g.dart';

abstract class AppUserDto {}

@JsonSerializable()
class AuthenticatedUserDto extends AppUserDto {
  AuthenticatedUserDto({
    required this.userId,
    required this.userEmail,
    required this.userName,
    required this.isVendor,
    required this.fcmToken,
    this.userAvatar,
  });

  final String userId;
  final String userEmail;
  final String userName;
  final String? userAvatar;
  final bool isVendor;
  final String fcmToken;

  AuthenticatedUserDto copyWith({
    String? userId,
    String? userEmail,
    String? userName,
    String? userAvatar,
    bool? isVendor,
    String? fcmToken,
  }) {
    return AuthenticatedUserDto(
      userId: userId ?? this.userId,
      userEmail: userEmail ?? this.userEmail,
      userName: userName ?? this.userName,
      userAvatar: userAvatar ?? this.userAvatar,
      isVendor: isVendor ?? this.isVendor,
      fcmToken: fcmToken ?? this.fcmToken,
    );
  }
}

// class GuestUserDto extends AppUserDto {}
