// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'gift_analytics_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_GiftAnalyticsDto _$GiftAnalyticsDtoFromJson(Map<String, dynamic> json) =>
    _GiftAnalyticsDto(
      giftId: json['giftId'] as String,
      giftName: json['giftName'] as String,
      totalRedeemed: (json['totalRedeemed'] as num).toInt(),
      totalRemaining: (json['totalRemaining'] as num).toInt(),
      lastRedeemedAt: DateTime.parse(json['lastRedeemedAt'] as String),
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      campaignId: json['campaignId'] as String,
      campaignName: json['campaignName'] as String,
    );

Map<String, dynamic> _$GiftAnalyticsDtoToJson(_GiftAnalyticsDto instance) =>
    <String, dynamic>{
      'giftId': instance.giftId,
      'giftName': instance.giftName,
      'totalRedeemed': instance.totalRedeemed,
      'totalRemaining': instance.totalRemaining,
      'lastRedeemedAt': instance.lastRedeemedAt.toIso8601String(),
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
      'campaignId': instance.campaignId,
      'campaignName': instance.campaignName,
    };
