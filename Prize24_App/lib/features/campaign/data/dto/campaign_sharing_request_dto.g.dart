// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'campaign_sharing_request_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_CampaignSharingRequestDto _$CampaignSharingRequestDtoFromJson(
  Map<String, dynamic> json,
) => _CampaignSharingRequestDto(
  campaignId: json['campaignId'] as String,
  campaignName: json['campaignName'] as String,
  senderVendorId: json['ownerVendorId'] as String,
  senderVendorName: json['ownerVendorName'] as String,
  requestAt: FirebaseHelper.timestampFromJson(json['requestedAt']),
  id: json['id'] as String? ?? '',
);

Map<String, dynamic> _$CampaignSharingRequestDtoToJson(
  _CampaignSharingRequestDto instance,
) => <String, dynamic>{
  'campaignId': instance.campaignId,
  'campaignName': instance.campaignName,
  'ownerVendorId': instance.senderVendorId,
  'ownerVendorName': instance.senderVendorName,
  'requestedAt': FirebaseHelper.timestampToJson(instance.requestAt),
  'id': instance.id,
};
