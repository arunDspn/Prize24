// dart format width=120
// Shop activity log domain model.
// Run: dart run build_runner build --delete-conflicting-outputs
// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:prize24_app/core/data/audit_log/activity_log_dto.dart';
import 'package:prize24_app/features/shop/data/dto/shop_activity_log_dto.dart';

part 'shop_activity_log.freezed.dart';

// ---------------------------------------------------------------------------
// ShopActivityLogEntry — the domain object your UI/BLoC works with
// ---------------------------------------------------------------------------

class ShopActivityLogEntry {
  const ShopActivityLogEntry({
    required this.logId,
    required this.timestamp,
    required this.success,
    required this.actorId,
    required this.actorRole,
    required this.functionName,
    required this.payload,
    required this.extras,
    this.errorCode,
    this.errorMessage,
    this.phoneNumber,
  });
  factory ShopActivityLogEntry.fromDto(
    ShopActivityLogDto dto, {
    required DateTime Function(dynamic) timestampConverter,
  }) => ShopActivityLogEntry(
    logId: dto.logId,
    timestamp: timestampConverter(dto.timestamp),
    success: dto.success,
    actorId: dto.actorId,
    actorRole: dto.actorRole,
    functionName: dto.functionName,
    errorCode: dto.errorCode,
    errorMessage: dto.errorMessage,
    phoneNumber: dto.phoneNumber,
    payload: ShopActivityLogPayload.fromDto(dto),
    extras: dto.extras,
  );

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
  final ShopActivityLogPayload payload;

  /// Any unrecognised fields from Firestore.
  final Map<String, dynamic> extras;

  String get action => payload.action;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ShopActivityLogEntry && runtimeType == other.runtimeType && logId == other.logId;

  @override
  int get hashCode => logId.hashCode;

  @override
  String toString() => 'ShopActivityLogEntry(logId: $logId, action: $action, success: $success)';
}

// ---------------------------------------------------------------------------
// ShopActivityLogPayload — Freezed sealed union of action-specific fields
// ---------------------------------------------------------------------------

@freezed
sealed class ShopActivityLogPayload with _$ShopActivityLogPayload {
  const ShopActivityLogPayload._();

  // ── gift_avail_triggered ─────────────────────────────────────────────────
  // Written when a streak check-in triggers a campaign avail.
  // Also dual-logged to campaigns/{id}/activityLogs as gift_avail_*.

  const factory ShopActivityLogPayload.giftAvailTriggered({
    required String customerId,
    required String campaignId,

    /// `success` | `failed`
    required String availStatus,
    required bool triggeredByStreak,
    int? streakValue,
    int? giftCycleDay,
    String? giftId,
    String? giftName,
    String? shopId,
    String? failureReason,
    double? luckFactor,
    double? randomNumber,
  }) = ShopGiftAvailTriggeredPayload;

  // ── check_in_success ─────────────────────────────────────────────────────

  const factory ShopActivityLogPayload.checkInSuccess({
    required String customerId,
    required String shopId,
    required int cumulativeStreak,
    required int consecutiveDays,
    required bool bonusApplied,
    required bool isGiftDay,
    required bool wasAutoFollowed,
    required int previousStreak,
    int? bonusValue,
    String? campaignId,
  }) = ShopCheckInSuccessPayload;

  // ── check_in_failed ──────────────────────────────────────────────────────

  const factory ShopActivityLogPayload.checkInFailed({
    required String customerId,
    required String shopId,
    String? failureReason,
  }) = ShopCheckInFailedPayload;

  // ── follower_added ───────────────────────────────────────────────────────

  const factory ShopActivityLogPayload.followerAdded({
    required String customerId,
    required String shopId,

    /// e.g. `auto_check_in`
    required String addedMethod,
    required int initialStreak,
  }) = ShopFollowerAddedPayload;

  // ── unknown ──────────────────────────────────────────────────────────────

  const factory ShopActivityLogPayload.unknown() = UnknownShopPayload;

  // -------------------------------------------------------------------------
  // Derived helpers
  // -------------------------------------------------------------------------

  String get action => switch (this) {
    ShopGiftAvailTriggeredPayload() => 'gift_avail_triggered',
    ShopCheckInSuccessPayload() => 'check_in_success',
    ShopCheckInFailedPayload() => 'check_in_failed',
    ShopFollowerAddedPayload() => 'follower_added',
    UnknownShopPayload() => 'unknown',
  };

  factory ShopActivityLogPayload.fromDto(ShopActivityLogDto dto) => switch (dto) {
    GiftAvailTriggeredLogDto d => ShopActivityLogPayload.giftAvailTriggered(
      customerId: d.customerId,
      campaignId: d.campaignId,
      availStatus: d.availStatus,
      triggeredByStreak: d.triggeredByStreak,
      streakValue: d.streakValue,
      giftCycleDay: d.giftCycleDay,
      giftId: d.giftId,
      giftName: d.giftName,
      shopId: d.shopId,
      failureReason: d.failureReason,
      luckFactor: d.luckFactor,
      randomNumber: d.randomNumber,
    ),
    CheckInSuccessLogDto d => ShopActivityLogPayload.checkInSuccess(
      customerId: d.customerId,
      shopId: d.shopId,
      cumulativeStreak: d.cumulativeStreak,
      consecutiveDays: d.consecutiveDays,
      bonusApplied: d.bonusApplied,
      bonusValue: d.bonusValue,
      isGiftDay: d.isGiftDay,
      campaignId: d.campaignId,
      wasAutoFollowed: d.wasAutoFollowed,
      previousStreak: d.previousStreak,
    ),
    CheckInFailedLogDto d => ShopActivityLogPayload.checkInFailed(
      customerId: d.customerId,
      shopId: d.shopId,
      failureReason: d.failureReason,
    ),
    FollowerAddedLogDto d => ShopActivityLogPayload.followerAdded(
      customerId: d.customerId,
      shopId: d.shopId,
      addedMethod: d.addedMethod,
      initialStreak: d.initialStreak,
    ),
    UnknownShopLogDto() => const ShopActivityLogPayload.unknown(),
  };
}
