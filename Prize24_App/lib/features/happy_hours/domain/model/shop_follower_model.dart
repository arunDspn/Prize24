import 'package:freezed_annotation/freezed_annotation.dart';
part 'shop_follower_model.freezed.dart';

@freezed
abstract class ShopFollowerModel with _$ShopFollowerModel {
  const factory ShopFollowerModel({
    required String userId,
    required String userName,
    required int cumulativeStreak,
    required DateTime followedAt,
    String? userPhoneNumber,
    DateTime? lastCheckInDate,

    int? lastGiftDayStreak,
    String? userProfilePic,
  }) = _ShopFollowerModel;
}
