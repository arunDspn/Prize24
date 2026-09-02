import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:prize24_app/features/clubs/domain/models/staff_club_detail_model.dart';
part 'staff_club_detail_dto.freezed.dart';
part 'staff_club_detail_dto.g.dart';

@freezed
abstract class StaffClubDetailDto with _$StaffClubDetailDto {
  const factory StaffClubDetailDto({
    @Default('') String id,
    required String name,
    required String description,
    @JsonKey(name: 'giftDay') required int giftDayCycle,
    @JsonKey(name: 'campaignId') required String campaignId,
  }) = _StaffClubDetailDto;

  factory StaffClubDetailDto.fromJson(Map<String, dynamic> json) =>
      _$StaffClubDetailDtoFromJson(json);

  // Private constructor
  const StaffClubDetailDto._();

  StaffClubDetailModel toDomain() {
    return StaffClubDetailModel(
      id: id,
      name: name,
      description: description,
      giftDayCycle: giftDayCycle,
      campaignId: campaignId,
    );
  }
}
