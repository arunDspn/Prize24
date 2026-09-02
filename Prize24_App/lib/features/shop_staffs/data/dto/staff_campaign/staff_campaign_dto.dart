import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:prize24_app/features/shop_staffs/domain/model/staff_campaigns/staff_campaign_model.dart';
part 'staff_campaign_dto.freezed.dart';
part 'staff_campaign_dto.g.dart';

@freezed
abstract class StaffCampaignDto with _$StaffCampaignDto {
  const factory StaffCampaignDto({
    required String id,
    required String name,
    required String description,
    required String visibility,
    required String giftType,
    // Total number of gifts available in this campaign
    required int totalGifts,
    // Number of gifts remaining
    required int remainingGifts,
    // Maximum participants
    required int totalParticipants,

    required int totalGiftsAdded,
  }) = _StaffCampaignDto;

  // Convert domain model to DTO
  factory StaffCampaignDto.fromDomain(StaffCampaignModel model) {
    return StaffCampaignDto(
      id: model.id,
      name: model.name,
      description: model.description,
      visibility: model.visibility,
      giftType: model.giftType,
      totalGifts: model.totalGifts,
      remainingGifts: model.remainingGifts,
      totalParticipants: model.totalParticipants,
      totalGiftsAdded: model.totalGiftsAdded,
    );
  }

  factory StaffCampaignDto.fromJson(Map<String, dynamic> json) =>
      _$StaffCampaignDtoFromJson(json);

  // Private const constructor
  const StaffCampaignDto._();

  // Convert DTO to domain model
  StaffCampaignModel toDomain() {
    return StaffCampaignModel(
      id: id,
      name: name,
      description: description,
      visibility: visibility,
      giftType: giftType,
      totalGifts: totalGifts,
      remainingGifts: remainingGifts,
      totalParticipants: totalParticipants,
      totalGiftsAdded: totalGiftsAdded,
    );
  }
}
