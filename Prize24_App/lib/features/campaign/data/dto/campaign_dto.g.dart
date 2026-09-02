// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'campaign_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_CampaignDto _$CampaignDtoFromJson(Map<String, dynamic> json) => _CampaignDto(
  name: json['name'] as String,
  description: json['description'] as String,
  vendorId: json['vendorId'] as String,
  vendorName: json['vendorName'] as String,
  totalParticipants: (json['totalParticipants'] as num).toInt(),
  remainingParticipants: (json['remainingParticipants'] as num).toInt(),
  totalGifts: (json['totalGifts'] as num).toInt(),
  remainingGifts: (json['remainingGifts'] as num).toInt(),
  visibility: $enumDecode(_$CampaignVisibilityEnumMap, json['visibility']),
  allowedGiftType: $enumDecode(_$GiftTypeEnumMap, json['allowedGiftType']),
  createdAt: DateTime.parse(json['createdAt'] as String),
  updatedAt: DateTime.parse(json['updatedAt'] as String),
  status: json['status'] as String,
  totalGiftsAdded: (json['totalGiftsAdded'] as num).toInt(),
  totalAvailed: (json['totalAvailed'] as num?)?.toInt() ?? 0,
  totalRedeemed: (json['totalRedeemed'] as num?)?.toInt() ?? 0,
  id: json['id'] as String?,
  publicSlug: json['publicSlug'] as String?,
  sharedVendors:
      (json['sharedVendors'] as List<dynamic>?)
          ?.map(
            (e) => CampaignSharedVendorsDto.fromJson(e as Map<String, dynamic>),
          )
          .toList() ??
      const [],
);

Map<String, dynamic> _$CampaignDtoToJson(_CampaignDto instance) =>
    <String, dynamic>{
      'name': instance.name,
      'description': instance.description,
      'vendorId': instance.vendorId,
      'vendorName': instance.vendorName,
      'totalParticipants': instance.totalParticipants,
      'remainingParticipants': instance.remainingParticipants,
      'totalGifts': instance.totalGifts,
      'remainingGifts': instance.remainingGifts,
      'visibility': _$CampaignVisibilityEnumMap[instance.visibility]!,
      'allowedGiftType': _$GiftTypeEnumMap[instance.allowedGiftType]!,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
      'status': instance.status,
      'totalGiftsAdded': instance.totalGiftsAdded,
      'totalAvailed': instance.totalAvailed,
      'totalRedeemed': instance.totalRedeemed,
      'id': ?instance.id,
      'publicSlug': ?instance.publicSlug,
      'sharedVendors': instance.sharedVendors,
    };

const _$CampaignVisibilityEnumMap = {
  CampaignVisibility.public: 'public',
  CampaignVisibility.private: 'private',
};

const _$GiftTypeEnumMap = {GiftType.code: 'code', GiftType.auto: 'auto'};

_CampaignSharedVendorsDto _$CampaignSharedVendorsDtoFromJson(
  Map<String, dynamic> json,
) => _CampaignSharedVendorsDto(
  vendorId: json['id'] as String,
  vendorName: json['name'] as String,
  vendorPhone: json['phone'] as String,
);

Map<String, dynamic> _$CampaignSharedVendorsDtoToJson(
  _CampaignSharedVendorsDto instance,
) => <String, dynamic>{
  'id': instance.vendorId,
  'name': instance.vendorName,
  'phone': instance.vendorPhone,
};
