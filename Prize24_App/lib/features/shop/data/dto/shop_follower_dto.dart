import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:prize24_app/features/happy_hours/domain/model/shop_follower_model.dart';
import 'package:prize24_app/utils/firebase_helper.dart';
part 'shop_follower_dto.freezed.dart';
part 'shop_follower_dto.g.dart';

@freezed
abstract class ShopFollowerDto with _$ShopFollowerDto {
  const factory ShopFollowerDto({
    required String userId,
    required String userName,
    required int cumulativeStreak,
    @JsonKey(
      fromJson: FirebaseHelper.timestampFromJson,
      toJson: FirebaseHelper.timestampToJson,
    )
    required Timestamp followedAt,
    String? userPhoneNumber,
    @JsonKey(
      fromJson: FirebaseHelper.nullableTimestampFromJson,
      toJson: FirebaseHelper.nullableTimestampToJson,
    )
    Timestamp? lastCheckInDate,

    int? lastGiftDayStreak,
    String? userProfilePic,
  }) = _ShopFollowerDto;

  factory ShopFollowerDto.fromJson(Map<String, dynamic> json) =>
      _$ShopFollowerDtoFromJson(json);

  // Private constructor
  const ShopFollowerDto._();

  // Convert DTO to domain model
  ShopFollowerModel toDomain() {
    return ShopFollowerModel(
      userId: userId,
      userName: userName,
      userPhoneNumber: userPhoneNumber,
      cumulativeStreak: cumulativeStreak,
      lastCheckInDate: lastCheckInDate?.toDate(),
      lastGiftDayStreak: lastGiftDayStreak,
      followedAt: followedAt.toDate(),
      userProfilePic: userProfilePic,
    );
  }
}
