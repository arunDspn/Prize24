import 'package:freezed_annotation/freezed_annotation.dart';
part 'share_campaign_request_model.freezed.dart';

@freezed
abstract class ShareCampaignRequestModel with _$ShareCampaignRequestModel {
  const factory ShareCampaignRequestModel({
    required String id,
    required String campaignId,
    required String campaignName,
    required String ownerVendorId,
    required String ownerVendorName,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _ShareCampaignRequestModel;
}
