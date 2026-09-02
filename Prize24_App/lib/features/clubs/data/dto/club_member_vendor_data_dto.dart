import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:prize24_app/features/clubs/domain/models/club_member_vendor_data_model.dart';
import 'package:prize24_app/utils/firebase_helper.dart';
part 'club_member_vendor_data_dto.freezed.dart';
part 'club_member_vendor_data_dto.g.dart';

@freezed
abstract class ClubMemberVendorDataDto with _$ClubMemberVendorDataDto {
  const factory ClubMemberVendorDataDto({
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
      fromJson: FirebaseHelper.timestampFromJson,
      toJson: FirebaseHelper.timestampToJson,
    )
    required Timestamp joinedAt,
    required String userName,
    required String userId,
  }) = _ClubMemberVendorDataDto;

  factory ClubMemberVendorDataDto.fromJson(Map<String, dynamic> json) =>
      _$ClubMemberVendorDataDtoFromJson(json);

  // const private constructor
  const ClubMemberVendorDataDto._();

  // To Domain Model
  ClubMemberVendorDataModel toDomain() {
    return ClubMemberVendorDataModel(
      streakTotal: streakTotal,
      consecutiveDays: consecutiveDays,
      lastCheckInDate: lastCheckInDate?.toDate(),
      lastBonusDate: lastBonusDate?.toDate(),
      joinedAt: joinedAt.toDate(),
      userName: userName,
      userId: userId,
    );
  }
}
