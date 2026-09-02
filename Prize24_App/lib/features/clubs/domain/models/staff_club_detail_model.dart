import 'package:freezed_annotation/freezed_annotation.dart';
part 'staff_club_detail_model.freezed.dart';

@freezed
abstract class StaffClubDetailModel with _$StaffClubDetailModel {
  const factory StaffClubDetailModel({
    required String id,
    required String name,
    required String description,
    required int giftDayCycle,
    required String campaignId,
  }) = _StaffClubDetailModel;
}
