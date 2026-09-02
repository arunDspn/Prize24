import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:prize24_app/core/constants.dart';
import 'package:prize24_app/features/campaign/domain/models/campaign_model.dart';
part 'campaign_dto.freezed.dart';
part 'campaign_dto.g.dart';

@freezed
abstract class CampaignDto with _$CampaignDto {
  const factory CampaignDto({
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
    required String status,
    required int totalGiftsAdded,
    @JsonKey(defaultValue: 0) required int totalAvailed,
    @JsonKey(defaultValue: 0) required int totalRedeemed,
    @JsonKey(includeIfNull: false) String? id,
    @JsonKey(includeIfNull: false) String? publicSlug,
    @Default([]) List<CampaignSharedVendorsDto> sharedVendors,
  }) = _CampaignDto;

  factory CampaignDto.fromJson(Map<String, dynamic> json) =>
      _$CampaignDtoFromJson(json);

  // Default private constructor
  const CampaignDto._();

  /// Converts a CampaignModel to a CampaignDto.
  factory CampaignDto.fromModel(CampaignModel model) {
    return CampaignDto(
      id: model.id,
      name: model.name,
      description: model.description,
      vendorId: model.vendorId,
      vendorName: model.vendorName,
      totalParticipants: model.totalParticipants,
      // totalParticipated: model.totalParticipated,
      remainingParticipants: model.remainingParticipants,
      remainingGifts: model.remainingGifts,
      totalGifts: model.totalGifts,
      visibility: model.visibility,
      allowedGiftType: model.allowedGiftType,
      createdAt: model.createdAt,
      updatedAt: model.updatedAt,
      publicSlug: model.publicSlug,
      status: model.status.name,
      totalGiftsAdded: model.totalGiftsAdded,
      totalAvailed: model.totalAvailed,
      totalRedeemed: model.totalRedeemed,
      sharedVendors: model.sharedVendors
          .map((e) => CampaignSharedVendorsDto.fromModel(e))
          .toList(),
    );
  }

  /// Converts a CampaignDto to a CampaignModel.
  CampaignModel toModel() {
    return CampaignModel(
      id: id,
      name: name,
      description: description,
      vendorId: vendorId,
      vendorName: vendorName,
      totalParticipants: totalParticipants,
      // totalParticipated: totalParticipated,
      remainingParticipants: remainingParticipants,
      remainingGifts: remainingGifts,
      totalGifts: totalGifts,
      visibility: visibility,
      allowedGiftType: allowedGiftType,
      createdAt: createdAt,
      updatedAt: updatedAt,
      publicSlug: publicSlug,
      totalGiftsAdded: totalGiftsAdded,
      status: CampaignStatus.fromString(status),
      sharedVendors: sharedVendors.map((e) => e.toModel()).toList(),
      totalAvailed: totalAvailed,
      totalRedeemed: totalRedeemed,
    );
  }
}

@freezed
abstract class CampaignSharedVendorsDto with _$CampaignSharedVendorsDto {
  const factory CampaignSharedVendorsDto({
    @JsonKey(name: 'id') required String vendorId,
    @JsonKey(name: 'name') required String vendorName,
    @JsonKey(name: 'phone') required String vendorPhone,
  }) = _CampaignSharedVendorsDto;

  factory CampaignSharedVendorsDto.fromJson(Map<String, dynamic> json) =>
      _$CampaignSharedVendorsDtoFromJson(json);

  // Default private constructor
  const CampaignSharedVendorsDto._();

  /// Converts a CampaignSharedVendorModel to a CampaignSharedVendorsDto.
  factory CampaignSharedVendorsDto.fromModel(CampaignSharedVendorModel model) {
    return CampaignSharedVendorsDto(
      vendorId: model.vendorId,
      vendorName: model.vendorName,
      vendorPhone: model.vendorPhone,
    );
  }

  /// Converts a CampaignSharedVendorsDto to a CampaignSharedVendorModel.
  CampaignSharedVendorModel toModel() {
    return CampaignSharedVendorModel(
      vendorId: vendorId,
      vendorName: vendorName,
      vendorPhone: vendorPhone,
    );
  }
}
