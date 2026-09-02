abstract class IAnalyticsService {
  // ---------------------------------------------------------------------------
  // User Identity
  // ---------------------------------------------------------------------------

  /// Sets the Firebase Analytics user ID.
  /// Call after successful login and on app resume when the user is already
  /// signed in.
  Future<void> setUserIdentifier(String userId);

  /// Sets a User Property on the analytics profile.
  /// Use [UserRole] constants for the 'user_role' property.
  Future<void> setUserTrait(String name, String value);

  // ---------------------------------------------------------------------------
  // Generic (escape hatch)
  // ---------------------------------------------------------------------------

  /// Logs a fully custom event with arbitrary parameters.
  /// Prefer the typed domain methods below over calling this directly.
  Future<void> logCustomEvent(String name, Map<String, Object> params);

  // ---------------------------------------------------------------------------
  // Auth
  // ---------------------------------------------------------------------------

  /// Logs a successful login.
  /// [method] must be one of the [LoginMethod] constants.
  Future<void> logLogin(String method);

  // ---------------------------------------------------------------------------
  // QR Scanning  (replaces logQrCodeScanned, logGiftAvailed, logGiftRedeemed)
  // ---------------------------------------------------------------------------

  /// Logs a successful QR scan action.
  ///
  /// [purpose]   — [ScanPurpose] constant (avail | redeem | check_in).
  /// [scannedId] — user_id for avail/check_in; gift_id for redeem.
  /// [shopId]    — the shop where the scan occurred.
  /// [campaignId]— the related campaign (avail/redeem only; omit for check_in).
  Future<void> logQrScanSuccess({
    required String purpose,
    required String scannedId,
    required String shopId,
    String? campaignId,
  });

  /// Logs a failed QR scan action.
  ///
  /// [purpose]   — [ScanPurpose] constant (avail | redeem | check_in).
  /// [scannedId] — the ID that was read (or empty string if unreadable).
  /// [shopId]    — the shop where the scan occurred.
  /// [errorType] — [ScanErrorType] constant (invalid_code | timeout | expired).
  /// [campaignId]— the related campaign if applicable.
  Future<void> logQrScanError({
    required String purpose,
    required String scannedId,
    required String shopId,
    required String errorType,
    String? campaignId,
  });

  // ---------------------------------------------------------------------------
  // Shop & Campaign Management
  // ---------------------------------------------------------------------------

  /// Logs when a shop owner creates or edits a business asset.
  ///
  /// [action]     — [EntityAction] constant (add | edit).
  /// [entityType] — [EntityType] constant (shop | campaign | gift).
  /// [entityId]   — the ID of the created/modified entity.
  ///
  /// ⚠️ entityType 'gift' here refers to a gift *template*, not an avail/redeem
  /// action. Those are tracked via [logQrScanSuccess] / [logQrScanError].
  Future<void> logEntityManagement({
    required String action,
    required String entityType,
    required String entityId,
  });

  /// Logs when a shop's staff roster or follower list changes.
  /// Replaces legacy logShopFollowed / logShopJoined.
  ///
  /// [action]  — [MemberAction] constant (add | remove).
  /// [role]    — [MemberRole] constant (staff | follower).
  /// [shopId]  — the shop whose membership changed.
  Future<void> logMemberUpdate({
    required String action,
    required String role,
    required String shopId,
  });

  // ---------------------------------------------------------------------------
  // Social & Recruitment Funnel
  // ---------------------------------------------------------------------------

  /// Logs when a user *sends* a friend or staff invite.
  ///
  /// [requestType] — [RequestType] constant (friend | staff).
  /// [targetId]    — user_id when requestType = friend;
  ///                 shop_id when requestType = staff.
  Future<void> logSocialRequest({
    required String requestType,
    required String targetId,
  });

  /// Logs when the *receiver* acts on a pending request.
  ///
  /// [requestType] — [RequestType] constant (friend | staff).
  /// [action]      — [RequestResponseAction] constant (accept | decline | ignore).
  Future<void> logRequestResponse({
    required String requestType,
    required String action,
  });

  // ---------------------------------------------------------------------------
  // Subscriptions
  // ---------------------------------------------------------------------------

  /// Logs when a user successfully activates a subscription via RevenueCat.
  /// [productId] — the RevenueCat product identifier.
  Future<void> logSubscriptionStarted(String productId);

  /// Logs when a vendor successfully acquires an active entitlement (new
  /// partner registration) after completing a RevenueCat purchase.
  /// [planType] — the RevenueCat entitlement identifier (e.g. 'standard_plan').
  Future<void> logPartnerRegistration(String planType);

  // ---------------------------------------------------------------------------
  // User-Side Benefits (FCM-driven)
  // ---------------------------------------------------------------------------

  /// Logs on the *user's* device when an FCM data message confirms a benefit
  /// was processed server-side.
  ///
  /// [benefitType] — [BenefitType] constant (check_in | availed | redeemed).
  /// [shopId]      — the shop where the benefit originated.
  /// [campaignId]  — the campaign (availed/redeemed only; omit for check_in).
  /// [giftId]      — the availed gift (redeemed only).
  Future<void> logUserBenefitProcessed({
    required String benefitType,
    required String shopId,
    String? campaignId,
    String? giftId,
  });
}
