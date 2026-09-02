import 'package:freezed_annotation/freezed_annotation.dart';
part 'staff_campaign_model.freezed.dart';

@freezed
abstract class StaffCampaignModel with _$StaffCampaignModel {
  const factory StaffCampaignModel({
    required String id,
    required String name,
    required String description,
    required String visibility,
    required String giftType,
    // Total number of gifts available in this campaign
    required int totalGifts,
    // Number of gifts remaining
    required int remainingGifts,
    // Total participants
    required int totalParticipants,
    // Total gifts added
    required int totalGiftsAdded,
  }) = _StaffCampaignModel;
}
