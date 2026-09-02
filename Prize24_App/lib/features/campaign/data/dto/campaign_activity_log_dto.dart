// Campaign activity log DTOs.
// Collection path: campaigns/{campaignId}/activityLogs
// ignore_for_file: avoid_dynamic_calls

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:prize24_app/core/data/audit_log/activity_log_dto.dart';
import 'package:prize24_app/features/campaign/domain/models/campaign_activity_log.dart';

// ---------------------------------------------------------------------------
// Sealed dispatch class
// ---------------------------------------------------------------------------

sealed class CampaignActivityLogDto extends ActivityLogBaseDto {
  const CampaignActivityLogDto({
    required super.logId,
    required super.action,
    required super.timestamp,
    required super.success,
    required super.actorId,
    required super.actorRole,
    required super.functionName,
    super.errorCode,
    super.errorMessage,
    super.phoneNumber,
    required super.extras,
  });

  /// Converts this DTO to the domain [CampaignActivityLogEntry].
  ///
  /// [timestampConverter] maps a Firestore [Timestamp] to a [DateTime],
  /// e.g. `(ts) => (ts as Timestamp).toDate()`.
  CampaignActivityLogEntry toEntry({
    required DateTime Function(dynamic) timestampConverter,
  }) => CampaignActivityLogEntry(
    logId: logId,
    timestamp: timestampConverter(timestamp),
    success: success,
    actorId: actorId,
    actorRole: actorRole,
    functionName: functionName,
    errorCode: errorCode,
    errorMessage: errorMessage,
    phoneNumber: phoneNumber,
    payload: CampaignActivityLogPayload.fromDto(this),
    extras: extras,
  );

  /// Parses a Firestore document from `campaigns/{id}/activityLogs`
  /// into the correct typed subclass.
  static CampaignActivityLogDto fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> doc,
  ) {
    final d = doc.data() ?? {};
    return switch (d['action'] as String? ?? '') {
      'gift_avail_success' => GiftAvailSuccessLogDto._fromMap(doc.id, d),
      'gift_avail_failed' => GiftAvailFailedLogDto._fromMap(doc.id, d),
      'gift_redemption_success' => GiftRedemptionSuccessLogDto._fromMap(
        doc.id,
        d,
      ),
      'gift_redemption_failed' => GiftRedemptionFailedLogDto._fromMap(
        doc.id,
        d,
      ),
      _ => UnknownCampaignLogDto._fromMap(doc.id, d),
    };
  }
}

// ---------------------------------------------------------------------------
// gift_avail_success
// ---------------------------------------------------------------------------

const _kAvailSuccessKeys = <String>{
  ...kActivityLogBaseKnownKeys,
  'customerId',
  'giftId',
  'giftName',
  'redemptionId',
  'isRedeemable',
  'payloadId',
  'luckFactor',
  'randomNumber',
  'remainingGifts',
  'remainingParticipants',
  'availedViaStreak',
  'streakShopId',
};

final class GiftAvailSuccessLogDto extends CampaignActivityLogDto {
  const GiftAvailSuccessLogDto._({
    required super.logId,
    required super.action,
    required super.timestamp,
    required super.success,
    required super.actorId,
    required super.actorRole,
    required super.functionName,
    super.errorCode,
    super.errorMessage,
    super.phoneNumber,
    required super.extras,
    required this.customerId,
    required this.giftId,
    required this.giftName,
    required this.redemptionId,
    required this.isRedeemable,
    this.payloadId,
    required this.luckFactor,
    required this.randomNumber,
    required this.remainingGifts,
    required this.remainingParticipants,
    required this.availedViaStreak,
    this.streakShopId,
  });

  final String customerId;
  final String giftId;
  final String giftName;
  final String redemptionId;
  final bool isRedeemable;
  final String? payloadId;
  final double luckFactor;
  final double randomNumber;
  final int remainingGifts;
  final int remainingParticipants;
  final bool availedViaStreak;
  final String? streakShopId;

  factory GiftAvailSuccessLogDto._fromMap(
    String docId,
    Map<String, dynamic> d,
  ) => GiftAvailSuccessLogDto._(
    logId: d['logId'] as String? ?? docId,
    action: d['action'] as String? ?? 'gift_avail_success',
    timestamp: d['timestamp'] as Timestamp? ?? Timestamp.now(),
    success: d['success'] as bool? ?? true,
    actorId: d['actorId'] as String? ?? '',
    actorRole: ActivityLogBaseDto.parseRole(d),
    functionName: d['functionName'] as String? ?? '',
    errorCode: d['errorCode'] as String?,
    errorMessage: d['errorMessage'] as String?,
    phoneNumber: d['phoneNumber'] as String?,
    extras: ActivityLogBaseDto.parseExtras(d, _kAvailSuccessKeys),
    customerId: d['customerId'] as String? ?? '',
    giftId: d['giftId'] as String? ?? '',
    giftName: d['giftName'] as String? ?? '',
    redemptionId: d['redemptionId'] as String? ?? '',
    isRedeemable: d['isRedeemable'] as bool? ?? false,
    payloadId: d['payloadId'] as String?,
    luckFactor: (d['luckFactor'] as num?)?.toDouble() ?? 0.0,
    randomNumber: (d['randomNumber'] as num?)?.toDouble() ?? 0.0,
    remainingGifts: (d['remainingGifts'] as num?)?.toInt() ?? 0,
    remainingParticipants: (d['remainingParticipants'] as num?)?.toInt() ?? 0,
    availedViaStreak: d['availedViaStreak'] as bool? ?? false,
    streakShopId: d['streakShopId'] as String?,
  );
}

// ---------------------------------------------------------------------------
// gift_avail_failed
// ---------------------------------------------------------------------------

const _kAvailFailedKeys = <String>{
  ...kActivityLogBaseKnownKeys,
  'customerId',
  'failureReason',
  'luckFactor',
  'randomNumber',
  'remainingGifts',
  'remainingParticipants',
  'availedViaStreak',
  'streakShopId',
};

final class GiftAvailFailedLogDto extends CampaignActivityLogDto {
  const GiftAvailFailedLogDto._({
    required super.logId,
    required super.action,
    required super.timestamp,
    required super.success,
    required super.actorId,
    required super.actorRole,
    required super.functionName,
    super.errorCode,
    super.errorMessage,
    super.phoneNumber,
    required super.extras,
    required this.customerId,
    this.failureReason,
    this.luckFactor,
    this.randomNumber,
    this.remainingGifts,
    this.remainingParticipants,
    required this.availedViaStreak,
    this.streakShopId,
  });

  final String customerId;
  final String? failureReason;
  final double? luckFactor;
  final double? randomNumber;
  final int? remainingGifts;
  final int? remainingParticipants;
  final bool availedViaStreak;
  final String? streakShopId;

  factory GiftAvailFailedLogDto._fromMap(
    String docId,
    Map<String, dynamic> d,
  ) => GiftAvailFailedLogDto._(
    logId: d['logId'] as String? ?? docId,
    action: d['action'] as String? ?? 'gift_avail_failed',
    timestamp: d['timestamp'] as Timestamp? ?? Timestamp.now(),
    success: d['success'] as bool? ?? false,
    actorId: d['actorId'] as String? ?? '',
    actorRole: ActivityLogBaseDto.parseRole(d),
    functionName: d['functionName'] as String? ?? '',
    errorCode: d['errorCode'] as String?,
    errorMessage: d['errorMessage'] as String?,
    phoneNumber: d['phoneNumber'] as String?,
    extras: ActivityLogBaseDto.parseExtras(d, _kAvailFailedKeys),
    customerId: d['customerId'] as String? ?? '',
    failureReason: d['failureReason'] as String?,
    luckFactor: (d['luckFactor'] as num?)?.toDouble(),
    randomNumber: (d['randomNumber'] as num?)?.toDouble(),
    remainingGifts: (d['remainingGifts'] as num?)?.toInt(),
    remainingParticipants: (d['remainingParticipants'] as num?)?.toInt(),
    availedViaStreak: d['availedViaStreak'] as bool? ?? false,
    streakShopId: d['streakShopId'] as String?,
  );
}

// ---------------------------------------------------------------------------
// gift_redemption_success
// ---------------------------------------------------------------------------

const _kRedemptionSuccessKeys = <String>{
  ...kActivityLogBaseKnownKeys,
  'customerId',
  'userGiftId',
  'giftId',
  'giftName',
  'redemptionId',
  'redemptionMethod',
  'shopId',
};

final class GiftRedemptionSuccessLogDto extends CampaignActivityLogDto {
  const GiftRedemptionSuccessLogDto._({
    required super.logId,
    required super.action,
    required super.timestamp,
    required super.success,
    required super.actorId,
    required super.actorRole,
    required super.functionName,
    super.errorCode,
    super.errorMessage,
    super.phoneNumber,
    required super.extras,
    required this.customerId,
    required this.userGiftId,
    required this.giftId,
    required this.giftName,
    required this.redemptionId,
    required this.redemptionMethod,
    this.shopId,
  });

  final String customerId;
  final String userGiftId;
  final String giftId;
  final String giftName;
  final String redemptionId;

  /// `owner_scan` | `shared_vendor_scan` | `staff_scan`
  final String redemptionMethod;
  final String? shopId;

  factory GiftRedemptionSuccessLogDto._fromMap(
    String docId,
    Map<String, dynamic> d,
  ) => GiftRedemptionSuccessLogDto._(
    logId: d['logId'] as String? ?? docId,
    action: d['action'] as String? ?? 'gift_redemption_success',
    timestamp: d['timestamp'] as Timestamp? ?? Timestamp.now(),
    success: d['success'] as bool? ?? true,
    actorId: d['actorId'] as String? ?? '',
    actorRole: ActivityLogBaseDto.parseRole(d),
    functionName: d['functionName'] as String? ?? '',
    errorCode: d['errorCode'] as String?,
    errorMessage: d['errorMessage'] as String?,
    phoneNumber: d['phoneNumber'] as String?,
    extras: ActivityLogBaseDto.parseExtras(d, _kRedemptionSuccessKeys),
    customerId: d['customerId'] as String? ?? '',
    userGiftId: d['userGiftId'] as String? ?? '',
    giftId: d['giftId'] as String? ?? '',
    giftName: d['giftName'] as String? ?? '',
    redemptionId: d['redemptionId'] as String? ?? '',
    redemptionMethod: d['redemptionMethod'] as String? ?? '',
    shopId: d['shopId'] as String?,
  );
}

// ---------------------------------------------------------------------------
// gift_redemption_failed
// ---------------------------------------------------------------------------

const _kRedemptionFailedKeys = <String>{
  ...kActivityLogBaseKnownKeys,
  'customerId',
  'userGiftId',
  'giftId',
  'giftName',
  'redemptionId',
  'failureReason',
  'redemptionMethod',
  'shopId',
};

final class GiftRedemptionFailedLogDto extends CampaignActivityLogDto {
  const GiftRedemptionFailedLogDto._({
    required super.logId,
    required super.action,
    required super.timestamp,
    required super.success,
    required super.actorId,
    required super.actorRole,
    required super.functionName,
    super.errorCode,
    super.errorMessage,
    super.phoneNumber,
    required super.extras,
    this.customerId,
    this.userGiftId,
    this.giftId,
    this.giftName,
    this.redemptionId,
    this.failureReason,
    required this.redemptionMethod,
    this.shopId,
  });

  final String? customerId;
  final String? userGiftId;
  final String? giftId;
  final String? giftName;
  final String? redemptionId;
  final String? failureReason;

  /// `owner_scan` | `shared_vendor_scan` | `staff_scan`
  final String redemptionMethod;
  final String? shopId;

  factory GiftRedemptionFailedLogDto._fromMap(
    String docId,
    Map<String, dynamic> d,
  ) => GiftRedemptionFailedLogDto._(
    logId: d['logId'] as String? ?? docId,
    action: d['action'] as String? ?? 'gift_redemption_failed',
    timestamp: d['timestamp'] as Timestamp? ?? Timestamp.now(),
    success: d['success'] as bool? ?? false,
    actorId: d['actorId'] as String? ?? '',
    actorRole: ActivityLogBaseDto.parseRole(d),
    functionName: d['functionName'] as String? ?? '',
    errorCode: d['errorCode'] as String?,
    errorMessage: d['errorMessage'] as String?,
    phoneNumber: d['phoneNumber'] as String?,
    extras: ActivityLogBaseDto.parseExtras(d, _kRedemptionFailedKeys),
    customerId: d['customerId'] as String?,
    userGiftId: d['userGiftId'] as String?,
    giftId: d['giftId'] as String?,
    giftName: d['giftName'] as String?,
    redemptionId: d['redemptionId'] as String?,
    failureReason: d['failureReason'] as String?,
    redemptionMethod: d['redemptionMethod'] as String? ?? '',
    shopId: d['shopId'] as String?,
  );
}

// ---------------------------------------------------------------------------
// Unknown / fallback
// ---------------------------------------------------------------------------

final class UnknownCampaignLogDto extends CampaignActivityLogDto {
  const UnknownCampaignLogDto._({
    required super.logId,
    required super.action,
    required super.timestamp,
    required super.success,
    required super.actorId,
    required super.actorRole,
    required super.functionName,
    super.errorCode,
    super.errorMessage,
    super.phoneNumber,
    required super.extras,
  });

  factory UnknownCampaignLogDto._fromMap(
    String docId,
    Map<String, dynamic> d,
  ) => UnknownCampaignLogDto._(
    logId: d['logId'] as String? ?? docId,
    action: d['action'] as String? ?? '',
    timestamp: d['timestamp'] as Timestamp? ?? Timestamp.now(),
    success: d['success'] as bool? ?? false,
    actorId: d['actorId'] as String? ?? '',
    actorRole: ActivityLogBaseDto.parseRole(d),
    functionName: d['functionName'] as String? ?? '',
    errorCode: d['errorCode'] as String?,
    errorMessage: d['errorMessage'] as String?,
    phoneNumber: d['phoneNumber'] as String?,
    extras: ActivityLogBaseDto.parseExtras(d, kActivityLogBaseKnownKeys),
  );
}
