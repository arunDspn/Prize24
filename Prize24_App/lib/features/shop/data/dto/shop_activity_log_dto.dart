// Shop activity log DTOs.
// Collection path: shops/{shopId}/activityLogs
// ignore_for_file: avoid_dynamic_calls

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:prize24_app/core/data/audit_log/activity_log_dto.dart';
import 'package:prize24_app/features/shop/domain/model/shop_activity_log.dart';

// ---------------------------------------------------------------------------
// Sealed dispatch class
// ---------------------------------------------------------------------------

sealed class ShopActivityLogDto extends ActivityLogBaseDto {
  const ShopActivityLogDto({
    required super.logId,
    required super.action,
    required super.timestamp,
    required super.success,
    required super.actorId,
    required super.actorRole,
    required super.functionName,
    super.errorCode,
    super.errorMessage,
    required super.extras,
    super.phoneNumber,
  });

  /// Converts this DTO to the domain [ShopActivityLogEntry].
  ///
  /// [timestampConverter] maps a Firestore [Timestamp] to a [DateTime],
  /// e.g. `(ts) => (ts as Timestamp).toDate()`.
  ShopActivityLogEntry toEntry({
    required DateTime Function(dynamic) timestampConverter,
  }) => ShopActivityLogEntry(
    logId: logId,
    timestamp: timestampConverter(timestamp),
    success: success,
    actorId: actorId,
    actorRole: actorRole,
    functionName: functionName,
    errorCode: errorCode,
    errorMessage: errorMessage,
    phoneNumber: phoneNumber,
    payload: ShopActivityLogPayload.fromDto(this),
    extras: extras,
  );

  /// Parses a Firestore document from `shops/{id}/activityLogs`
  /// into the correct typed subclass.
  static ShopActivityLogDto fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> doc,
  ) {
    final d = doc.data() ?? {};
    return switch (d['action'] as String? ?? '') {
      'gift_avail_triggered' => GiftAvailTriggeredLogDto._fromMap(doc.id, d),
      'check_in_success' => CheckInSuccessLogDto._fromMap(doc.id, d),
      'check_in_failed' => CheckInFailedLogDto._fromMap(doc.id, d),
      'follower_added' => FollowerAddedLogDto._fromMap(doc.id, d),
      _ => UnknownShopLogDto._fromMap(doc.id, d),
    };
  }
}

// ---------------------------------------------------------------------------
// gift_avail_triggered
// Written when a streak check-in triggers a campaign avail.
// Dual-logged: also written to campaigns/{id}/activityLogs as gift_avail_*.
// ---------------------------------------------------------------------------

const _kAvailTriggeredKeys = <String>{
  ...kActivityLogBaseKnownKeys,
  'customerId',
  'campaignId',
  'availStatus',
  'triggeredByStreak',
  'streakValue',
  'giftCycleDay',
  'giftId',
  'giftName',
  'shopId',
  'failureReason',
  'luckFactor',
  'randomNumber',
  'redemptionId',
  'isRedeemable',
  'payloadId',
  'remainingGifts',
  'remainingParticipants',
};

final class GiftAvailTriggeredLogDto extends ShopActivityLogDto {
  const GiftAvailTriggeredLogDto._({
    required super.logId,
    required super.action,
    required super.timestamp,
    required super.success,
    required super.actorId,
    required super.actorRole,
    required super.functionName,
    super.errorCode,
    super.errorMessage,
    required super.extras,
    required this.customerId,
    required this.campaignId,
    required this.availStatus,
    required this.triggeredByStreak,
    this.streakValue,
    this.giftCycleDay,
    this.giftId,
    this.giftName,
    this.shopId,
    this.failureReason,
    this.luckFactor,
    this.randomNumber,
    super.phoneNumber,
  });

  final String customerId;
  final String campaignId;

  /// `success` | `failed`
  final String availStatus;
  final bool triggeredByStreak;
  final int? streakValue;
  final int? giftCycleDay;
  final String? giftId;
  final String? giftName;
  final String? shopId;
  final String? failureReason;
  final double? luckFactor;
  final double? randomNumber;

  factory GiftAvailTriggeredLogDto._fromMap(
    String docId,
    Map<String, dynamic> d,
  ) => GiftAvailTriggeredLogDto._(
    logId: d['logId'] as String? ?? docId,
    action: d['action'] as String? ?? 'gift_avail_triggered',
    timestamp: d['timestamp'] as Timestamp? ?? Timestamp.now(),
    success: d['success'] as bool? ?? false,
    actorId: d['actorId'] as String? ?? '',
    actorRole: ActivityLogBaseDto.parseRole(d),
    functionName: d['functionName'] as String? ?? '',
    errorCode: d['errorCode'] as String?,
    errorMessage: d['errorMessage'] as String?,
    extras: ActivityLogBaseDto.parseExtras(d, _kAvailTriggeredKeys),
    customerId: d['customerId'] as String? ?? '',
    campaignId: d['campaignId'] as String? ?? '',
    availStatus: d['availStatus'] as String? ?? '',
    triggeredByStreak: d['triggeredByStreak'] as bool? ?? false,
    streakValue: (d['streakValue'] as num?)?.toInt(),
    giftCycleDay: (d['giftCycleDay'] as num?)?.toInt(),
    giftId: d['giftId'] as String?,
    giftName: d['giftName'] as String?,
    shopId: d['shopId'] as String?,
    failureReason: d['failureReason'] as String?,
    luckFactor: (d['luckFactor'] as num?)?.toDouble(),
    randomNumber: (d['randomNumber'] as num?)?.toDouble(),
    phoneNumber: d['phoneNumber'] as String?,
  );
}

// ---------------------------------------------------------------------------
// check_in_success
// ---------------------------------------------------------------------------

const _kCheckInSuccessKeys = <String>{
  ...kActivityLogBaseKnownKeys,
  'customerId',
  'shopId',
  'cumulativeStreak',
  'consecutiveDays',
  'bonusApplied',
  'bonusValue',
  'isGiftDay',
  'campaignId',
  'wasAutoFollowed',
  'previousStreak',
  'billNumber',
  'billAmount',
  'cycleBillSum',
  'previousCycleBillSum',
  'cumulativeBillSum',
};

final class CheckInSuccessLogDto extends ShopActivityLogDto {
  const CheckInSuccessLogDto._({
    required super.logId,
    required super.action,
    required super.timestamp,
    required super.success,
    required super.actorId,
    required super.actorRole,
    required super.functionName,
    super.errorCode,
    super.errorMessage,
    required super.extras,
    required this.customerId,
    required this.shopId,
    required this.cumulativeStreak,
    required this.consecutiveDays,
    required this.bonusApplied,
    this.bonusValue,
    required this.isGiftDay,
    this.campaignId,
    required this.wasAutoFollowed,
    required this.previousStreak,
    required this.billNumber,
    required this.billAmount,
    required this.cycleBillSum,
    required this.previousCycleBillSum,
    required this.cumulativeBillSum,
    super.phoneNumber,
  });

  final String customerId;
  final String shopId;
  final int cumulativeStreak;
  final int consecutiveDays;
  final bool bonusApplied;
  final int? bonusValue;
  final bool isGiftDay;
  final String? campaignId;
  final bool wasAutoFollowed;
  final int previousStreak;
  final String billNumber;
  final double billAmount;
  final double cycleBillSum;
  final double previousCycleBillSum;
  final double cumulativeBillSum;

  factory CheckInSuccessLogDto._fromMap(String docId, Map<String, dynamic> d) =>
      CheckInSuccessLogDto._(
        logId: d['logId'] as String? ?? docId,
        action: d['action'] as String? ?? 'check_in_success',
        timestamp: d['timestamp'] as Timestamp? ?? Timestamp.now(),
        success: d['success'] as bool? ?? true,
        actorId: d['actorId'] as String? ?? '',
        actorRole: ActivityLogBaseDto.parseRole(d),
        functionName: d['functionName'] as String? ?? '',
        errorCode: d['errorCode'] as String?,
        errorMessage: d['errorMessage'] as String?,
        extras: ActivityLogBaseDto.parseExtras(d, _kCheckInSuccessKeys),
        customerId: d['customerId'] as String? ?? '',
        shopId: d['shopId'] as String? ?? '',
        cumulativeStreak: (d['cumulativeStreak'] as num?)?.toInt() ?? 0,
        consecutiveDays: (d['consecutiveDays'] as num?)?.toInt() ?? 0,
        bonusApplied: d['bonusApplied'] as bool? ?? false,
        bonusValue: (d['bonusValue'] as num?)?.toInt(),
        isGiftDay: d['isGiftDay'] as bool? ?? false,
        campaignId: d['campaignId'] as String?,
        wasAutoFollowed: d['wasAutoFollowed'] as bool? ?? false,
        previousStreak: (d['previousStreak'] as num?)?.toInt() ?? 0,
        billNumber: d['billNumber'] as String? ?? '',
        billAmount: (d['billAmount'] as num?)?.toDouble() ?? 0,
        cycleBillSum: (d['cycleBillSum'] as num?)?.toDouble() ?? 0,
        previousCycleBillSum:
            (d['previousCycleBillSum'] as num?)?.toDouble() ?? 0,
        cumulativeBillSum: (d['cumulativeBillSum'] as num?)?.toDouble() ?? 0,
        phoneNumber: d['phoneNumber'] as String?,
      );
}

// ---------------------------------------------------------------------------
// check_in_failed
// ---------------------------------------------------------------------------

const _kCheckInFailedKeys = <String>{
  ...kActivityLogBaseKnownKeys,
  'customerId',
  'shopId',
  'failureReason',
};

final class CheckInFailedLogDto extends ShopActivityLogDto {
  const CheckInFailedLogDto._({
    required super.logId,
    required super.action,
    required super.timestamp,
    required super.success,
    required super.actorId,
    required super.actorRole,
    required super.functionName,
    super.errorCode,
    super.errorMessage,
    required super.extras,
    required this.customerId,
    required this.shopId,
    this.failureReason,
    super.phoneNumber,
  });

  final String customerId;
  final String shopId;
  final String? failureReason;

  factory CheckInFailedLogDto._fromMap(String docId, Map<String, dynamic> d) =>
      CheckInFailedLogDto._(
        logId: d['logId'] as String? ?? docId,
        action: d['action'] as String? ?? 'check_in_failed',
        timestamp: d['timestamp'] as Timestamp? ?? Timestamp.now(),
        success: d['success'] as bool? ?? false,
        actorId: d['actorId'] as String? ?? '',
        actorRole: ActivityLogBaseDto.parseRole(d),
        functionName: d['functionName'] as String? ?? '',
        errorCode: d['errorCode'] as String?,
        errorMessage: d['errorMessage'] as String?,
        extras: ActivityLogBaseDto.parseExtras(d, _kCheckInFailedKeys),
        customerId: d['customerId'] as String? ?? '',
        shopId: d['shopId'] as String? ?? '',
        failureReason: d['failureReason'] as String?,
        phoneNumber: d['phoneNumber'] as String?,
      );
}

// ---------------------------------------------------------------------------
// follower_added
// ---------------------------------------------------------------------------

const _kFollowerAddedKeys = <String>{
  ...kActivityLogBaseKnownKeys,
  'customerId',
  'shopId',
  'addedMethod',
  'initialStreak',
};

final class FollowerAddedLogDto extends ShopActivityLogDto {
  const FollowerAddedLogDto._({
    required super.logId,
    required super.action,
    required super.timestamp,
    required super.success,
    required super.actorId,
    required super.actorRole,
    required super.functionName,
    super.errorCode,
    super.errorMessage,
    required super.extras,
    required this.customerId,
    required this.shopId,
    required this.addedMethod,
    required this.initialStreak,
    super.phoneNumber,
  });

  final String customerId;
  final String shopId;

  /// e.g. `auto_check_in`
  final String addedMethod;
  final int initialStreak;

  factory FollowerAddedLogDto._fromMap(String docId, Map<String, dynamic> d) =>
      FollowerAddedLogDto._(
        logId: d['logId'] as String? ?? docId,
        action: d['action'] as String? ?? 'follower_added',
        timestamp: d['timestamp'] as Timestamp? ?? Timestamp.now(),
        success: d['success'] as bool? ?? true,
        actorId: d['actorId'] as String? ?? '',
        actorRole: ActivityLogBaseDto.parseRole(d),
        functionName: d['functionName'] as String? ?? '',
        errorCode: d['errorCode'] as String?,
        errorMessage: d['errorMessage'] as String?,
        extras: ActivityLogBaseDto.parseExtras(d, _kFollowerAddedKeys),
        customerId: d['customerId'] as String? ?? '',
        shopId: d['shopId'] as String? ?? '',
        addedMethod: d['addedMethod'] as String? ?? '',
        initialStreak: (d['initialStreak'] as num?)?.toInt() ?? 1,
        phoneNumber: d['phoneNumber'] as String?,
      );
}

// ---------------------------------------------------------------------------
// Unknown / fallback
// ---------------------------------------------------------------------------

final class UnknownShopLogDto extends ShopActivityLogDto {
  const UnknownShopLogDto._({
    required super.logId,
    required super.action,
    required super.timestamp,
    required super.success,
    required super.actorId,
    required super.actorRole,
    required super.functionName,
    super.errorCode,
    super.errorMessage,
    required super.extras,
    super.phoneNumber,
  });

  factory UnknownShopLogDto._fromMap(String docId, Map<String, dynamic> d) =>
      UnknownShopLogDto._(
        logId: d['logId'] as String? ?? docId,
        action: d['action'] as String? ?? '',
        timestamp: d['timestamp'] as Timestamp? ?? Timestamp.now(),
        success: d['success'] as bool? ?? false,
        actorId: d['actorId'] as String? ?? '',
        actorRole: ActivityLogBaseDto.parseRole(d),
        functionName: d['functionName'] as String? ?? '',
        errorCode: d['errorCode'] as String?,
        errorMessage: d['errorMessage'] as String?,
        extras: ActivityLogBaseDto.parseExtras(d, kActivityLogBaseKnownKeys),
        phoneNumber: d['phoneNumber'] as String?,
      );
}
