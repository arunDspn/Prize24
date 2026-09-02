// import 'package:json_annotation/json_annotation.dart';
// part 'app_user.g.dart';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:prize24_app/utils/date_convertors.dart';

part 'app_user.freezed.dart';
part 'app_user.g.dart';

@freezed
abstract class AppUser with _$AppUser {
  const factory AppUser({
    required String userId,
    required String userEmail,
    required String userName,
    required bool isVendor,
    required String fcmToken,
    required String referralCode, // @Default(0) int p24Coins,
    List<String>? subscribedShopTopics,
    List<String>? staffShopIds,
    String? profilePic,
    String? userPhoneNumber,
    // int? maximumShops,
    // int? maximumCampaigns,
    // int? maximumUserFollowing,
    String? vendorPhoneNumber,

    // Referrer's userId, if any
    String? referredBy,

    // Set when the user has requested account deletion; null while active.
    // Source of truth for the request itself lives in the
    // `accountDeletionRequests` collection - this is a denormalized copy
    // used to gate login without an extra query.
    @TimestampConverter() DateTime? deletionRequestedAt,
  }) = _AppUser;

  factory AppUser.fromJson(Map<String, dynamic> json) =>
      _$AppUserFromJson(json);
}

// abstract class AppUser {}

// @JsonSerializable()
// class AuthenticatedUser extends AppUser {
//   AuthenticatedUser({
//     required this.userId,
//     required this.userEmail,
//     required this.userName,
//     required this.isVendor,
//     required this.isVerified,
//     this.userPhoneNumber,
//     this.userAvatar,
//   });

//   final String userId;
//   final String userEmail;
//   final String userName;
//   final String? userAvatar;
//   // Will give user functionality like vendor, admin, etc.
//   final bool isVendor;
//   final bool isVerified;
//   final String? userPhoneNumber;

//   // CopyWith
//   AuthenticatedUser copyWith({
//     String? userId,
//     String? userEmail,
//     String? userName,
//     String? userAvatar,
//     bool? isVendor,
//     bool? isVerified,
//     String? userPhoneNumber,
//   }) {
//     return AuthenticatedUser(
//       userId: userId ?? this.userId,
//       userEmail: userEmail ?? this.userEmail,
//       userName: userName ?? this.userName,
//       userAvatar: userAvatar ?? this.userAvatar,
//       isVendor: isVendor ?? this.isVendor,
//       isVerified: isVerified ?? this.isVerified,
//       userPhoneNumber: userPhoneNumber ?? this.userPhoneNumber,
//     );
//   }
// }

// class GuestUser extends AppUser {
//   // final String userId;

//   // GuestUser({required this.userId});
//   // @override
//   // String get uid => this.userId;
// }
