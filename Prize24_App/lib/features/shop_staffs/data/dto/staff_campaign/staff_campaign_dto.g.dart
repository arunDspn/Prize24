// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'staff_campaign_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_StaffCampaignDto _$StaffCampaignDtoFromJson(Map<String, dynamic> json) =>
    _StaffCampaignDto(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
      visibility: json['visibility'] as String,
      giftType: json['giftType'] as String,
      totalGifts: (json['totalGifts'] as num).toInt(),
      remainingGifts: (json['remainingGifts'] as num).toInt(),
      totalParticipants: (json['totalParticipants'] as num).toInt(),
      totalGiftsAdded: (json['totalGiftsAdded'] as num).toInt(),
    );

Map<String, dynamic> _$StaffCampaignDtoToJson(_StaffCampaignDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'visibility': instance.visibility,
      'giftType': instance.giftType,
      'totalGifts': instance.totalGifts,
      'remainingGifts': instance.remainingGifts,
      'totalParticipants': instance.totalParticipants,
      'totalGiftsAdded': instance.totalGiftsAdded,
    };
