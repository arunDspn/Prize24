// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'club_entity_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ClubEntityDto _$ClubEntityDtoFromJson(Map<String, dynamic> json) =>
    _ClubEntityDto(
      name: json['name'] as String,
      description: json['description'] as String,
      giftDay: (json['giftDay'] as num).toInt(),
      attachedCampaignId: json['attachedCampaignId'] as String,
      multipierStreakDaysRequired: (json['multipierStreakDaysRequired'] as num?)
          ?.toInt(),
      bonusIncrement: (json['bonusIncrement'] as num?)?.toInt() ?? 2,
    );

Map<String, dynamic> _$ClubEntityDtoToJson(_ClubEntityDto instance) =>
    <String, dynamic>{
      'name': instance.name,
      'description': instance.description,
      'giftDay': instance.giftDay,
      'attachedCampaignId': instance.attachedCampaignId,
      'multipierStreakDaysRequired': instance.multipierStreakDaysRequired,
      'bonusIncrement': instance.bonusIncrement,
    };
