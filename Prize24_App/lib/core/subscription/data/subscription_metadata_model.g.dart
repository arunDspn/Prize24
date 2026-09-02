// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'subscription_metadata_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_SubscriptionMetadata _$SubscriptionMetadataFromJson(
  Map<String, dynamic> json,
) => _SubscriptionMetadata(
  maxShops: (json['maxShops'] as num).toInt(),
  maxCampaigns: (json['maxCampaigns'] as num).toInt(),
  maxUsers: (json['maxUsers'] as num).toInt(),
);

Map<String, dynamic> _$SubscriptionMetadataToJson(
  _SubscriptionMetadata instance,
) => <String, dynamic>{
  'maxShops': instance.maxShops,
  'maxCampaigns': instance.maxCampaigns,
  'maxUsers': instance.maxUsers,
};
