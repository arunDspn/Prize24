import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:prize24_app/features/shop/domain/model/follower_streak_log_model.dart';
import 'package:prize24_app/utils/firebase_helper.dart';
part 'follower_streak_log_dto.freezed.dart';
part 'follower_streak_log_dto.g.dart';

// @freezed
// abstract class FollowerStreakLogDto with _$FollowerStreakLogDto {
//   const factory FollowerStreakLogDto({
//     required String comment,
//     required int consecutiveDays,
//     required int cumulativeStreak,
//     required bool isGiftDay,
//     @JsonKey(
//       fromJson: FirebaseHelper.timestampFromJson,
//       toJson: FirebaseHelper.timestampToJson,
//     )
//     required Timestamp scanTime,
//     required String scannerId,
//     required String scannerName,
//     required String scannerType,
//   }) = _FollowerStreakLogDto;

//   factory FollowerStreakLogDto.fromJson(Map<String, dynamic> json) =>
//       _$FollowerStreakLogDtoFromJson(json);

//   // Prviate const constructor
//   const FollowerStreakLogDto._();

//   // Convert DTO to Domain Model
//   FollowerStreakLogModel toDomain() {
//     return FollowerStreakLogModel(
//       comment: comment,
//       consecutiveDays: consecutiveDays,
//       cumulativeStreak: cumulativeStreak,
//       isGiftDay: isGiftDay,
//       scanTime: scanTime.toDate(),
//       scannerId: scannerId,
//       scannerName: scannerName,
//       scannerType: scannerType,
//     );
//   }
// }

@freezed
abstract class FollowerStreakLogDto with _$FollowerStreakLogDto {
  const factory FollowerStreakLogDto({
    // required String comment,
    required int consecutiveDays,
    required int cumulativeStreak,
    required bool isGiftDay,
    // bonusApplied true (boolean)
    required bool bonusApplied,
    @JsonKey(
      fromJson: FirebaseHelper.timestampFromJson,
      toJson: FirebaseHelper.timestampToJson,
    )
    required Timestamp timestamp,
  }) = _FollowerStreakLogDto;

  factory FollowerStreakLogDto.fromJson(Map<String, dynamic> json) =>
      _$FollowerStreakLogDtoFromJson(json);

  // Prviate const constructor
  const FollowerStreakLogDto._();

  // Convert DTO to Domain Model
  FollowerStreakLogModel toDomain() {
    return FollowerStreakLogModel(
      // comment: comment,
      consecutiveDays: consecutiveDays,
      cumulativeStreak: cumulativeStreak,
      isGiftDay: isGiftDay,
      bonusApplied: bonusApplied,
      timestamp: timestamp.toDate(),
    );
  }
}
