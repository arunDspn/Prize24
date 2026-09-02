import 'package:freezed_annotation/freezed_annotation.dart';
part 'user_following_shop_model.freezed.dart';

@freezed
abstract class UserFollowingShopModel with _$UserFollowingShopModel {
  const factory UserFollowingShopModel({
    required String shopId,
    required String shopName,
    required String shopAddress,
    required String shopPhoneNumber,
    required bool notificationEnabled,
    required int consecutiveDays,
    required int cumulativeStreak,
    required DateTime followedAt,
    required int giftCycleDays,
    required bool isGiftAvailable,
    DateTime? lastCheckInDate,
  }) = _UserFollowingShopModel;
}
