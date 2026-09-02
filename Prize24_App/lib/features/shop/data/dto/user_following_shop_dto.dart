import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:prize24_app/features/shop/domain/model/user_following_shop_model.dart';
import 'package:prize24_app/utils/firebase_helper.dart';
part 'user_following_shop_dto.freezed.dart';
part 'user_following_shop_dto.g.dart';

@freezed
abstract class UserFollowingShopDto with _$UserFollowingShopDto {
  const factory UserFollowingShopDto({
    required String shopId,
    required String shopName,
    required String shopAddress,
    @JsonKey(name: 'shopPhone') required String shopPhoneNumber,
    required bool notificationEnabled,
    required int consecutiveDays,
    required int cumulativeStreak,
    @Default(false) bool isGiftAvailable,
    @JsonKey(
      fromJson: FirebaseHelper.timestampFromJson,
      toJson: FirebaseHelper.timestampToJson,
    )
    required Timestamp followedAt,
    int? giftCycleDays,
    @JsonKey(
      fromJson: FirebaseHelper.nullableTimestampFromJson,
      toJson: FirebaseHelper.nullableTimestampToJson,
    )
    Timestamp? lastCheckInDate,
  }) = _UserFollowingShopDto;

  factory UserFollowingShopDto.fromJson(Map<String, dynamic> json) =>
      _$UserFollowingShopDtoFromJson(json);

  // Private constructor
  const UserFollowingShopDto._();

  // Convert DTO to domain model
  UserFollowingShopModel toDomain() {
    return UserFollowingShopModel(
      shopId: shopId,
      shopName: shopName,
      shopAddress: shopAddress,
      shopPhoneNumber: shopPhoneNumber,
      notificationEnabled: notificationEnabled,
      consecutiveDays: consecutiveDays,
      cumulativeStreak: cumulativeStreak,
      followedAt: followedAt.toDate(),
      giftCycleDays: giftCycleDays!,
      isGiftAvailable: isGiftAvailable,
      lastCheckInDate: lastCheckInDate?.toDate(),
    );
  }
}
