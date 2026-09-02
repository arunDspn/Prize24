import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:prize24_app/features/campaign/domain/models/campaign_sharing_request_model.dart';
import 'package:prize24_app/utils/firebase_helper.dart';
part 'campaign_sharing_request_dto.freezed.dart';
part 'campaign_sharing_request_dto.g.dart';

@freezed
abstract class CampaignSharingRequestDto with _$CampaignSharingRequestDto {
  const factory CampaignSharingRequestDto({
    required String campaignId,
    required String campaignName,
    @JsonKey(name: 'ownerVendorId') required String senderVendorId,
    @JsonKey(name: 'ownerVendorName') required String senderVendorName,
    @JsonKey(
      name: 'requestedAt',
      fromJson: FirebaseHelper.timestampFromJson,
      toJson: FirebaseHelper.timestampToJson,
    )
    required Timestamp requestAt,
    @Default('') String id,
  }) = _CampaignSharingRequestDto;

  factory CampaignSharingRequestDto.fromJson(Map<String, dynamic> json) =>
      _$CampaignSharingRequestDtoFromJson(json);

  /// Const private constructor
  const CampaignSharingRequestDto._();

  factory CampaignSharingRequestDto.fromModel(
    CampaignSharingRequestModel model,
  ) =>
      CampaignSharingRequestDto(
        id: model.id,
        campaignId: model.campaignId,
        campaignName: model.campaignName,
        senderVendorId: model.senderVendorId,
        senderVendorName: model.senderVendorName,
        requestAt: Timestamp.fromDate(model.requestAt),
      );

  CampaignSharingRequestModel toModel() => CampaignSharingRequestModel(
        id: id,
        campaignId: campaignId,
        campaignName: campaignName,
        senderVendorId: senderVendorId,
        senderVendorName: senderVendorName,
        requestAt: requestAt.toDate(),
      );
}
