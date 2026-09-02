import 'package:freezed_annotation/freezed_annotation.dart';
part 'club_entity.freezed.dart';

@freezed

/// Used to create a club
abstract class ClubEntity with _$ClubEntity {
  const factory ClubEntity({
    required String name,
    required String description,
    required int giftDay,
    required String attachedCampaignId,
    int? multipierStreakDaysRequired,
    @Default(2) int bonusIncrement,
  }) = _ClubEntity;
}
