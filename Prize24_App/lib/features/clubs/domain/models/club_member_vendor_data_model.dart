import 'package:freezed_annotation/freezed_annotation.dart';
part 'club_member_vendor_data_model.freezed.dart';

/**
 * 		1. `streakTotal` set to 0
		2. `consecutiveDays` = 0
		3. `lastCheckInDate` NULL
		4. `lastBonusDate` NULL
		5. `joinedAt` - Timestamp now
		6. `userName` -> User Name
		7. `userId` -> User ID
 */

@freezed
abstract class ClubMemberVendorDataModel with _$ClubMemberVendorDataModel {
  const factory ClubMemberVendorDataModel({
    required int streakTotal,
    required int consecutiveDays,
    required DateTime? lastCheckInDate,
    required DateTime? lastBonusDate,
    required DateTime joinedAt,
    required String userName,
    required String userId,
  }) = _ClubMemberVendorDataModel;
}
