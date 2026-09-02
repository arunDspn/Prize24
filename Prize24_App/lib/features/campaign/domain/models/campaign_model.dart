import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:prize24_app/core/constants.dart';
part 'campaign_model.freezed.dart';

@freezed
abstract class CampaignModel with _$CampaignModel {
  const factory CampaignModel({
    required String name,
    required String description,
    required String vendorId,
    required String vendorName,
    required int totalParticipants,
    required int remainingParticipants,
    // required int totalParticipated,
    required int totalGifts,
    required int remainingGifts,
    required CampaignVisibility visibility,
    required GiftType allowedGiftType,
    required DateTime createdAt,
    required DateTime updatedAt,
    @Default(0) int totalGiftsAdded,
    @JsonKey(defaultValue: CampaignStatus.active)
    required CampaignStatus status,

    required int totalAvailed,
    required int totalRedeemed,
    @JsonKey(includeIfNull: true) String? id,
    String? publicSlug,
    @Default([]) List<CampaignSharedVendorModel> sharedVendors,
  }) = _CampaignModel;
}

@freezed
abstract class CampaignSharedVendorModel with _$CampaignSharedVendorModel {
  const factory CampaignSharedVendorModel({
    required String vendorId,
    required String vendorName,
    required String vendorPhone,
  }) = _CampaignSharedVendorModel;
}
