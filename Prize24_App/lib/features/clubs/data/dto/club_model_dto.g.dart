// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'club_model_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ClubModelDto _$ClubModelDtoFromJson(Map<String, dynamic> json) =>
    _ClubModelDto(
      name: json['name'] as String,
      description: json['description'] as String,
      giftDay: (json['giftDay'] as num).toInt(),
      attachedCampaignId: json['campaignId'] as String,
      campaignName: json['campaignName'] as String,
      campaignDescription: json['campaignDescription'] as String,
      createdAt: FirebaseHelper.timestampFromJson(json['createdAt']),
      updatedAt: FirebaseHelper.timestampFromJson(json['updatedAt']),
      totalMembers: (json['totalMembers'] as num).toInt(),
      id: json['id'] as String?,
      multipierStreak: json['multipierStreak'] == null
          ? null
          : MultiplierRuleDto.fromJson(
              json['multipierStreak'] as Map<String, dynamic>,
            ),
    );

Map<String, dynamic> _$ClubModelDtoToJson(_ClubModelDto instance) =>
    <String, dynamic>{
      'name': instance.name,
      'description': instance.description,
      'giftDay': instance.giftDay,
      'campaignId': instance.attachedCampaignId,
      'campaignName': instance.campaignName,
      'campaignDescription': instance.campaignDescription,
      'createdAt': FirebaseHelper.timestampToJson(instance.createdAt),
      'updatedAt': FirebaseHelper.timestampToJson(instance.updatedAt),
      'totalMembers': instance.totalMembers,
      'id': instance.id,
      'multipierStreak': instance.multipierStreak,
    };

_MultiplierRuleDto _$MultiplierRuleDtoFromJson(Map<String, dynamic> json) =>
    _MultiplierRuleDto(
      bonusIncrement: (json['bonusIncrement'] as num).toInt(),
      daysRequired: (json['daysRequired'] as num).toInt(),
    );

Map<String, dynamic> _$MultiplierRuleDtoToJson(_MultiplierRuleDto instance) =>
    <String, dynamic>{
      'bonusIncrement': instance.bonusIncrement,
      'daysRequired': instance.daysRequired,
    };

_ClubShopListDto _$ClubShopListDtoFromJson(Map<String, dynamic> json) =>
    _ClubShopListDto(
      shopId: json['shopId'] as String,
      shopName: json['shopName'] as String,
      shopAddress: json['address'] as String,
      phoneNumber: json['phoneNumber'] as String,
    );

Map<String, dynamic> _$ClubShopListDtoToJson(_ClubShopListDto instance) =>
    <String, dynamic>{
      'shopId': instance.shopId,
      'shopName': instance.shopName,
      'address': instance.shopAddress,
      'phoneNumber': instance.phoneNumber,
    };
