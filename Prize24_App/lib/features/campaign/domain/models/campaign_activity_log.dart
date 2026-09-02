// dart format width=120
// Campaign activity log domain model.
// Run: dart run build_runner build --delete-conflicting-outputs
// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:prize24_app/core/data/audit_log/activity_log_dto.dart';
import 'package:prize24_app/features/campaign/data/dto/campaign_activity_log_dto.dart';

part 'campaign_activity_log.freezed.dart';

// ---------------------------------------------------------------------------
// CampaignActivityLogEntry — the domain object your UI/BLoC works with
// ---------------------------------------------------------------------------

class CampaignActivityLogEntry {
  const CampaignActivityLogEntry({
    required this.logId,
    required this.timestamp,
    required this.success,
    required this.actorId,
    required this.actorRole,
    required this.functionName,
    this.errorCode,
    this.errorMessage,
    this.phoneNumber,
    required this.payload,
    required this.extras,
  });

  final String logId;

  /// Converted from Firestore Timestamp via your codec.
  final DateTime timestamp;
  final bool success;
  final String actorId;
  final ActivityLogActorRole actorRole;
  final String functionName;
  final String? errorCode;
  final String? errorMessage;
  final String? phoneNumber;

  /// Action-specific typed data.
  final CampaignActivityLogPayload payload;

  /// Any unrecognised fields from Firestore.
  final Map<String, dynamic> extras;

  String get action => payload.action;

  factory CampaignActivityLogEntry.fromDto(
    CampaignActivityLogDto dto, {
    required DateTime Function(dynamic) timestampConverter,
  }) => CampaignActivityLogEntry(
    logId: dto.logId,
    timestamp: timestampConverter(dto.timestamp),
    success: dto.success,
    actorId: dto.actorId,
    actorRole: dto.actorRole,
    functionName: dto.functionName,
    errorCode: dto.errorCode,
    errorMessage: dto.errorMessage,
    phoneNumber: dto.phoneNumber,
    payload: CampaignActivityLogPayload.fromDto(dto),
    extras: dto.extras,
  );

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CampaignActivityLogEntry && runtimeType == other.runtimeType && logId == other.logId;

  @override
  int get hashCode => logId.hashCode;

  @override
  String toString() => 'CampaignActivityLogEntry(logId: $logId, action: $action, success: $success)';
}

// ---------------------------------------------------------------------------
// CampaignActivityLogPayload — Freezed sealed union of action-specific fields
// ---------------------------------------------------------------------------

@freezed
sealed class CampaignActivityLogPayload with _$CampaignActivityLogPayload {
  const CampaignActivityLogPayload._();

  // ── gift_avail_success ───────────────────────────────────────────────────

  const factory CampaignActivityLogPayload.giftAvailSuccess({
    required String customerId,
    required String giftId,
    required String giftName,
    required String redemptionId,
    required bool isRedeemable,
    String? payloadId,
    required double luckFactor,
    required double randomNumber,
    required int remainingGifts,
    required int remainingParticipants,
    required bool availedViaStreak,
    String? streakShopId,
  }) = CampaignGiftAvailSuccessPayload;

  // ── gift_avail_failed ────────────────────────────────────────────────────

  const factory CampaignActivityLogPayload.giftAvailFailed({
    required String customerId,
    String? failureReason,
    double? luckFactor,
    double? randomNumber,
    int? remainingGifts,
    int? remainingParticipants,
    required bool availedViaStreak,
    String? streakShopId,
  }) = CampaignGiftAvailFailedPayload;

  // ── gift_redemption_success ──────────────────────────────────────────────

  const factory CampaignActivityLogPayload.giftRedemptionSuccess({
    required String customerId,
    required String userGiftId,
    required String giftId,
    required String giftName,
    required String redemptionId,

    /// `owner_scan` | `shared_vendor_scan` | `staff_scan`
    required String redemptionMethod,
    String? shopId,
  }) = CampaignGiftRedemptionSuccessPayload;

  // ── gift_redemption_failed ───────────────────────────────────────────────

  const factory CampaignActivityLogPayload.giftRedemptionFailed({
    String? customerId,
    String? userGiftId,
    String? giftId,
    String? giftName,
    String? redemptionId,
    String? failureReason,

    /// `owner_scan` | `shared_vendor_scan` | `staff_scan`
    required String redemptionMethod,
    String? shopId,
  }) = CampaignGiftRedemptionFailedPayload;

  // ── unknown ──────────────────────────────────────────────────────────────

  const factory CampaignActivityLogPayload.unknown() = UnknownCampaignPayload;

  // -------------------------------------------------------------------------
  // Derived helpers
  // -------------------------------------------------------------------------

  String get action => switch (this) {
    CampaignGiftAvailSuccessPayload() => 'gift_avail_success',
    CampaignGiftAvailFailedPayload() => 'gift_avail_failed',
    CampaignGiftRedemptionSuccessPayload() => 'gift_redemption_success',
    CampaignGiftRedemptionFailedPayload() => 'gift_redemption_failed',
    UnknownCampaignPayload() => 'unknown',
  };

  factory CampaignActivityLogPayload.fromDto(CampaignActivityLogDto dto) => switch (dto) {
    GiftAvailSuccessLogDto d => CampaignActivityLogPayload.giftAvailSuccess(
      customerId: d.customerId,
      giftId: d.giftId,
      giftName: d.giftName,
      redemptionId: d.redemptionId,
      isRedeemable: d.isRedeemable,
      payloadId: d.payloadId,
      luckFactor: d.luckFactor,
      randomNumber: d.randomNumber,
      remainingGifts: d.remainingGifts,
      remainingParticipants: d.remainingParticipants,
      availedViaStreak: d.availedViaStreak,
      streakShopId: d.streakShopId,
    ),
    GiftAvailFailedLogDto d => CampaignActivityLogPayload.giftAvailFailed(
      customerId: d.customerId,
      failureReason: d.failureReason,
      luckFactor: d.luckFactor,
      randomNumber: d.randomNumber,
      remainingGifts: d.remainingGifts,
      remainingParticipants: d.remainingParticipants,
      availedViaStreak: d.availedViaStreak,
      streakShopId: d.streakShopId,
    ),
    GiftRedemptionSuccessLogDto d => CampaignActivityLogPayload.giftRedemptionSuccess(
      customerId: d.customerId,
      userGiftId: d.userGiftId,
      giftId: d.giftId,
      giftName: d.giftName,
      redemptionId: d.redemptionId,
      redemptionMethod: d.redemptionMethod,
      shopId: d.shopId,
    ),
    GiftRedemptionFailedLogDto d => CampaignActivityLogPayload.giftRedemptionFailed(
      customerId: d.customerId,
      userGiftId: d.userGiftId,
      giftId: d.giftId,
      giftName: d.giftName,
      redemptionId: d.redemptionId,
      failureReason: d.failureReason,
      redemptionMethod: d.redemptionMethod,
      shopId: d.shopId,
    ),
    UnknownCampaignLogDto() => const CampaignActivityLogPayload.unknown(),
  };
}
