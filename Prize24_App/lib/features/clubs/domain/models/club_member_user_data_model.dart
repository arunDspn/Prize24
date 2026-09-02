import 'package:freezed_annotation/freezed_annotation.dart';
part 'club_member_user_data_model.freezed.dart';

/**
 * 	1. `streakTotal` set to 0
		2. `consecutiveDays` = 0
		3. `lastCheckInDate` NULL
		4. `lastBonusDate` NULL
		5. `clubName`
		6. `clubDescription`
 */

@freezed
abstract class ClubMemberUserDataModel with _$ClubMemberUserDataModel {
  const factory ClubMemberUserDataModel({
    required int streakTotal,
    required int consecutiveDays,
    required DateTime? lastCheckInDate,
    required DateTime? lastBonusDate,
    required DateTime? lastGiftDate,
    required int giftDayCycle,
    required String clubName,
    required String clubDescription,
    required String clubId,
  }) = _ClubMemberUserDataModel;
}
