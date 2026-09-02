/// Centralized Firebase Analytics event name constants.
///
/// Firebase Analytics event names must:
/// - Be 1–40 characters long
/// - Contain only letters, numbers, and underscores
/// - Start with a letter (not a number or underscore)
///
/// Prefer using typed methods on [IAnalyticsService] over referencing
/// these constants directly — they are here to eliminate magic strings.
abstract final class AnalyticsEvents {
  // ---------------------------------------------------------------------------
  // Auth
  // ---------------------------------------------------------------------------

  /// Standard Firebase Analytics event.
  /// [method]: 'google' | 'apple' | 'phone'
  static const String login = 'login';

  // ---------------------------------------------------------------------------
  // QR Scanning
  // ---------------------------------------------------------------------------

  /// Unified QR scan event covering avail, redeem and check-in flows.
  /// Replaces legacy: qr_code_scanned, gift_availed, gift_redeemed.
  ///
  /// Required params: [AnalyticsParams.scanPurpose], [AnalyticsParams.scanResult],
  ///   [AnalyticsParams.scannedId], [AnalyticsParams.shopId].
  /// Optional params: [AnalyticsParams.campaignId], [AnalyticsParams.errorType].
  static const String qrScanAction = 'qr_scan_action';

  // ---------------------------------------------------------------------------
  // Shop & Campaign Management
  // ---------------------------------------------------------------------------

  /// Fired when a shop owner creates or edits a business asset (shop, campaign,
  /// or gift template).
  ///
  /// ⚠️ SCOPE: 'gift' here means a gift *template* being managed by the shop
  /// owner. It is NOT triggered when a customer avails or redeems a gift —
  /// that is covered exclusively by [qrScanAction].
  ///
  /// Required params: [AnalyticsParams.action], [AnalyticsParams.entityType],
  ///   [AnalyticsParams.entityId].
  static const String entityManagement = 'entity_management';

  /// Fired when a shop's staff roster or follower list changes.
  /// Replaces legacy: shop_followed, shop_joined.
  ///
  /// Required params: [AnalyticsParams.action], [AnalyticsParams.role],
  ///   [AnalyticsParams.shopId].
  static const String memberUpdate = 'member_update';

  // ---------------------------------------------------------------------------
  // Social & Recruitment Funnel
  // ---------------------------------------------------------------------------

  /// Fired when a user *sends* a friend or staff invite.
  ///
  /// Required params: [AnalyticsParams.requestType], [AnalyticsParams.targetId].
  /// targetId = user_id when requestType = 'friend'
  /// targetId = shop_id when requestType = 'staff'
  static const String socialRequest = 'social_request';

  /// Fired when the *receiver* acts on a pending request.
  ///
  /// Required params: [AnalyticsParams.requestType], [AnalyticsParams.action].
  static const String requestResponse = 'request_response';

  // ---------------------------------------------------------------------------
  // Subscriptions
  // ---------------------------------------------------------------------------

  /// Fired when a user successfully activates a subscription via RevenueCat.
  ///
  /// Required params: [AnalyticsParams.productId].
  static const String subscriptionStarted = 'subscription_started';

  /// Fired when a vendor successfully completes a RevenueCat purchase and
  /// gains an active entitlement (i.e. new partner registration).
  ///
  /// Required params: [AnalyticsParams.planType].
  static const String partnerRegistration = 'partner_registration';

  // ---------------------------------------------------------------------------
  // User-Side Benefits (FCM-driven)
  // ---------------------------------------------------------------------------

  /// Fired on the *user's* device when an FCM data message confirms that a
  /// benefit (check-in streak credit, gift availed, gift redeemed) was
  /// successfully processed server-side.
  ///
  /// Required params: [AnalyticsParams.benefitType], [AnalyticsParams.shopId].
  /// Optional params: [AnalyticsParams.campaignId], [AnalyticsParams.giftId].
  static const String userBenefitProcessed = 'user_benefit_processed';
}

// ---------------------------------------------------------------------------
// Parameter Keys
// ---------------------------------------------------------------------------

/// Centralized Firebase Analytics parameter key constants.
///
/// Parameter names must:
/// - Be 1–40 characters long
/// - Contain only letters, numbers, and underscores
abstract final class AnalyticsParams {
  // Shared
  static const String shopId = 'shop_id';
  static const String campaignId = 'campaign_id';
  static const String productId = 'product_id';
  static const String method = 'method';

  // QR Scan
  static const String scanPurpose = 'scan_purpose';
  static const String scanResult = 'scan_result';
  static const String scannedId = 'scanned_id';
  static const String errorType = 'error_type';

  // Entity Management
  static const String action = 'action';
  static const String entityType = 'entity_type';
  static const String entityId = 'entity_id';

  // Member Update
  static const String role = 'role';

  // Social
  static const String requestType = 'request_type';
  static const String targetId = 'target_id';

  // Subscriptions / Partner
  static const String planType = 'plan_type';

  // User Benefit
  static const String benefitType = 'benefit_type';
  static const String giftId = 'gift_id';
}

// ---------------------------------------------------------------------------
// Value Constants
// ---------------------------------------------------------------------------

/// Values for [AnalyticsParams.scanPurpose].
abstract final class ScanPurpose {
  /// Vendor / staff scans a customer's QR code to avail a campaign gift.
  /// scanned_id = user_id of the customer.
  static const String avail = 'avail';

  /// Vendor / staff scans a gift QR code to mark it as redeemed.
  /// scanned_id = gift_id of the availed gift.
  static const String redeem = 'redeem';

  /// Vendor / staff scans a customer's QR code to record a loyalty check-in.
  /// scanned_id = user_id of the customer.
  static const String checkIn = 'check_in';
}

/// Values for [AnalyticsParams.scanResult].
abstract final class ScanResult {
  static const String success = 'success';
  static const String error = 'error';
}

/// Values for [AnalyticsParams.errorType].
abstract final class ScanErrorType {
  static const String invalidCode = 'invalid_code';
  static const String timeout = 'timeout';
  static const String expired = 'expired';
}

/// Values for [AnalyticsParams.action] used in [AnalyticsEvents.entityManagement].
abstract final class EntityAction {
  static const String add = 'add';
  static const String edit = 'edit';
}

/// Values for [AnalyticsParams.entityType] used in [AnalyticsEvents.entityManagement].
abstract final class EntityType {
  static const String shop = 'shop';
  static const String campaign = 'campaign';

  /// A gift *template* managed by the shop owner in the dashboard.
  /// ⚠️ Not to be confused with a customer availing/redeeming a gift
  /// (tracked via [AnalyticsEvents.qrScanAction]).
  static const String gift = 'gift';
}

/// Values for [AnalyticsParams.action] used in [AnalyticsEvents.memberUpdate].
abstract final class MemberAction {
  static const String add = 'add';
  static const String remove = 'remove';
}

/// Values for [AnalyticsParams.role] used in [AnalyticsEvents.memberUpdate].
abstract final class MemberRole {
  static const String staff = 'staff';
  static const String follower = 'follower';
}

/// Values for [AnalyticsParams.requestType] used in [AnalyticsEvents.socialRequest]
/// and [AnalyticsEvents.requestResponse].
abstract final class RequestType {
  static const String friend = 'friend';
  static const String staff = 'staff';
}

/// Values for [AnalyticsParams.action] used in [AnalyticsEvents.requestResponse].
abstract final class RequestResponseAction {
  static const String accept = 'accept';
  static const String decline = 'decline';
  static const String ignore = 'ignore';
}

/// Values for [AnalyticsParams.benefitType] used in
/// [AnalyticsEvents.userBenefitProcessed].
abstract final class BenefitType {
  /// User earned a loyalty streak check-in credit.
  static const String checkIn = 'check_in';

  /// User received a campaign gift via QR scan.
  static const String availed = 'availed';

  /// User's availed gift was marked as redeemed at the shop.
  static const String redeemed = 'redeemed';
}

/// Values for the [AnalyticsParams.method] parameter of the login event.
abstract final class LoginMethod {
  static const String google = 'google';
  static const String apple = 'apple';
  static const String phone = 'phone';
}

/// Values for the 'user_role' User Property.
abstract final class UserRole {
  static const String shopOwner = 'shop_owner';
  static const String staff = 'staff';
  static const String customer = 'customer';
}
