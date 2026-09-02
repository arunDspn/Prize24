import 'package:freezed_annotation/freezed_annotation.dart';
part 'gift_analytics_dto.freezed.dart';
part 'gift_analytics_dto.g.dart';

@freezed
abstract class GiftAnalyticsDto with _$GiftAnalyticsDto {
  const factory GiftAnalyticsDto({
    required String giftId,
    required String giftName,
    required int totalRedeemed,
    required int totalRemaining,
    required DateTime lastRedeemedAt,
    required DateTime createdAt,
    required DateTime updatedAt,

    /// Campaign ID to which this gift belongs
    required String campaignId,
    required String campaignName,

    // Optional fields
    // String? id,
  }) = _GiftAnalyticsDto;

  factory GiftAnalyticsDto.fromJson(Map<String, dynamic> json) =>
      _$GiftAnalyticsDtoFromJson(json);
}
