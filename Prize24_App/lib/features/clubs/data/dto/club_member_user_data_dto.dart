import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:prize24_app/features/clubs/domain/models/club_member_user_data_model.dart';
import 'package:prize24_app/features/shop_staffs/data/dto/staff_request_send_item_dto.dart';
import 'package:prize24_app/utils/firebase_helper.dart';
part 'club_member_user_data_dto.g.dart';
part 'club_member_user_data_dto.freezed.dart';

@freezed
abstract class ClubMemberUserDataDto with _$ClubMemberUserDataDto {
  const factory ClubMemberUserDataDto({
    required int streakTotal,
    required int consecutiveDays,
    @JsonKey(
      fromJson: FirebaseHelper.nullableTimestampFromJson,
      toJson: FirebaseHelper.nullableTimestampToJson,
    )
    required Timestamp? lastCheckInDate,
    @JsonKey(
      fromJson: FirebaseHelper.nullableTimestampFromJson,
      toJson: FirebaseHelper.nullableTimestampToJson,
    )
    required Timestamp? lastBonusDate,
    @JsonKey(
      fromJson: FirebaseHelper.nullableTimestampFromJson,
      toJson: FirebaseHelper.nullableTimestampToJson,
    )
    required Timestamp? lastGiftDate,
    required int giftDayCycle,
    required String clubName,
    required String clubDescription,
    String? clubId,
  }) = _ClubMemberUserDataDto;

  factory ClubMemberUserDataDto.fromJson(Map<String, dynamic> json) =>
      _$ClubMemberUserDataDtoFromJson(json);

  // const private constructor
  const ClubMemberUserDataDto._();

  // To Domain Model
  ClubMemberUserDataModel toDomain() {
    return ClubMemberUserDataModel(
      streakTotal: streakTotal,
      consecutiveDays: consecutiveDays,
      lastCheckInDate: lastCheckInDate?.toDate(),
      lastBonusDate: lastBonusDate?.toDate(),
      lastGiftDate: lastGiftDate?.toDate(),
      giftDayCycle: giftDayCycle,
      clubName: clubName,
      clubDescription: clubDescription,
      clubId: clubId!,
    );
  }
}
