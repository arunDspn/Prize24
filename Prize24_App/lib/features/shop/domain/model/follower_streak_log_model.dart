import 'package:freezed_annotation/freezed_annotation.dart';
part 'follower_streak_log_model.freezed.dart';

@freezed
abstract class FollowerStreakLogModel with _$FollowerStreakLogModel {
  const factory FollowerStreakLogModel({
    // required String comment,
    required int consecutiveDays,
    required int cumulativeStreak,
    required bool isGiftDay,
    required bool bonusApplied,
    required DateTime timestamp,
  }) = _FollowerStreakLogModel;
}
