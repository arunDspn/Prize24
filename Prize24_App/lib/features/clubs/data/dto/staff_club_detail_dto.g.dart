// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'staff_club_detail_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_StaffClubDetailDto _$StaffClubDetailDtoFromJson(Map<String, dynamic> json) =>
    _StaffClubDetailDto(
      id: json['id'] as String? ?? '',
      name: json['name'] as String,
      description: json['description'] as String,
      giftDayCycle: (json['giftDay'] as num).toInt(),
      campaignId: json['campaignId'] as String,
    );

Map<String, dynamic> _$StaffClubDetailDtoToJson(_StaffClubDetailDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'giftDay': instance.giftDayCycle,
      'campaignId': instance.campaignId,
    };
