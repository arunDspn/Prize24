// Shared base for CampaignActivityLogDto and ShopActivityLogDto.
// Do not import directly — use the category-specific files.
// ignore_for_file: avoid_dynamic_calls

import 'package:cloud_firestore/cloud_firestore.dart';

// ---------------------------------------------------------------------------
// Enum
// ---------------------------------------------------------------------------

enum ActivityLogActorRole {
  owner,
  staff,
  sharedVendor,
  system,
  customer;

  static ActivityLogActorRole fromString(String? value) => switch (value) {
        'owner' => owner,
        'staff' => staff,
        'shared_vendor' => sharedVendor,
        'system' => system,
        'customer' => customer,
        _ => system,
      };

  String toJson() => switch (this) {
        owner => 'owner',
        staff => 'staff',
        sharedVendor => 'shared_vendor',
        system => 'system',
        customer => 'customer',
      };
}

// ---------------------------------------------------------------------------
// Shared base DTO
// ---------------------------------------------------------------------------

/// Field keys present on every log entry — used to filter extras.
const kActivityLogBaseKnownKeys = <String>{
  'logId',
  'action',
  'timestamp',
  'success',
  'actorId',
  'actorRole',
  'functionName',
  'errorCode',
  'errorMessage',
  'phoneNumber',
};

/// Common fields shared by every activity log.
abstract class ActivityLogBaseDto {
  const ActivityLogBaseDto({
    required this.logId,
    required this.action,
    required this.timestamp,
    required this.success,
    required this.actorId,
    required this.actorRole,
    required this.functionName,
    this.errorCode,
    this.errorMessage,
    this.phoneNumber,
    required this.extras,
  });

  final String logId;
  final String action;

  /// Raw Firestore [Timestamp] — convert to [DateTime] via your codec.
  final Timestamp timestamp;
  final bool success;
  final String actorId;
  final ActivityLogActorRole actorRole;
  final String functionName;
  final String? errorCode;
  final String? errorMessage;
  final String? phoneNumber;

  /// Fields not captured by typed properties.
  final Map<String, dynamic> extras;

  // -------------------------------------------------------------------------
  // Shared helpers for subclasses
  // -------------------------------------------------------------------------

  static ActivityLogActorRole parseRole(Map<String, dynamic> d) =>
      ActivityLogActorRole.fromString(d['actorRole'] as String?);

  static Map<String, dynamic> parseExtras(
    Map<String, dynamic> data,
    Set<String> knownKeys,
  ) =>
      Map.fromEntries(
        data.entries.where((e) => !knownKeys.contains(e.key)),
      );
}
