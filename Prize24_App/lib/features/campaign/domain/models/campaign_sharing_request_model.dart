import 'package:freezed_annotation/freezed_annotation.dart';
part 'campaign_sharing_request_model.freezed.dart';

@freezed
abstract class CampaignSharingRequestModel with _$CampaignSharingRequestModel {
  const factory CampaignSharingRequestModel({
    required String id,
    required String campaignId,
    required String campaignName,
    required String senderVendorId,
    required String senderVendorName,
    required DateTime requestAt,
  }) = _CampaignSharingRequestModel;
}
