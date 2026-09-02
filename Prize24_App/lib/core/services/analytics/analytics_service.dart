import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:prize24_app/bootstrap.dart';
import 'package:prize24_app/core/services/analytics/analytics_events.dart';
import 'package:prize24_app/core/services/analytics/i_analytics_service.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

part 'analytics_service.g.dart';

// ---------------------------------------------------------------------------
// Providers
// ---------------------------------------------------------------------------

@Riverpod(keepAlive: true)
FirebaseAnalytics firebaseAnalytics(Ref ref) => FirebaseAnalytics.instance;

@Riverpod(keepAlive: true)
IAnalyticsService analyticsService(Ref ref) {
  return AnalyticsService(ref.watch(firebaseAnalyticsProvider));
}

// ---------------------------------------------------------------------------
// Implementation
// ---------------------------------------------------------------------------

class AnalyticsService implements IAnalyticsService {
  AnalyticsService(this._analytics) {
    // Disable data collection in non-production environments so dev / staging
    // events never pollute the production Firebase Analytics dashboard.
    if (!FlavorConfig.isProduction) {
      _analytics.setAnalyticsCollectionEnabled(false);
    }
  }

  final FirebaseAnalytics _analytics;

  // ── Internal safe-log guard ───────────────────────────────────────────────

  /// Wraps every analytics call so that a failure never crashes the app.
  /// In production, exceptions are forwarded to Sentry for visibility.
  Future<void> _safeLog(Future<void> Function() action) async {
    try {
      await action();
    } catch (e, st) {
      if (FlavorConfig.isProduction) {
        await Sentry.captureException(e, stackTrace: st);
      }
    }
  }

  // ── User Identity ─────────────────────────────────────────────────────────

  @override
  Future<void> setUserIdentifier(String userId) async {
    await _safeLog(() => _analytics.setUserId(id: userId));
  }

  @override
  Future<void> setUserTrait(String name, String value) async {
    await _safeLog(() => _analytics.setUserProperty(name: name, value: value));
  }

  // ── Generic (escape hatch) ────────────────────────────────────────────────

  @override
  Future<void> logCustomEvent(String name, Map<String, Object> params) async {
    await _safeLog(() => _analytics.logEvent(name: name, parameters: params));
  }

  // ── Auth ──────────────────────────────────────────────────────────────────

  @override
  Future<void> logLogin(String method) async {
    await _safeLog(() => _analytics.logLogin(loginMethod: method));
  }

  // ── QR Scanning ───────────────────────────────────────────────────────────

  @override
  Future<void> logQrScanSuccess({
    required String purpose,
    required String scannedId,
    required String shopId,
    String? campaignId,
  }) async {
    await _safeLog(
      () => _analytics.logEvent(
        name: AnalyticsEvents.qrScanAction,
        parameters: {
          AnalyticsParams.scanPurpose: purpose,
          AnalyticsParams.scanResult: ScanResult.success,
          AnalyticsParams.scannedId: scannedId,
          AnalyticsParams.shopId: shopId,
          if (campaignId != null) AnalyticsParams.campaignId: campaignId,
        },
      ),
    );
  }

  @override
  Future<void> logQrScanError({
    required String purpose,
    required String scannedId,
    required String shopId,
    required String errorType,
    String? campaignId,
  }) async {
    await _safeLog(
      () => _analytics.logEvent(
        name: AnalyticsEvents.qrScanAction,
        parameters: {
          AnalyticsParams.scanPurpose: purpose,
          AnalyticsParams.scanResult: ScanResult.error,
          AnalyticsParams.scannedId: scannedId,
          AnalyticsParams.shopId: shopId,
          AnalyticsParams.errorType: errorType,
          if (campaignId != null) AnalyticsParams.campaignId: campaignId,
        },
      ),
    );
  }

  // ── Shop & Campaign Management ────────────────────────────────────────────

  @override
  Future<void> logEntityManagement({
    required String action,
    required String entityType,
    required String entityId,
  }) async {
    await _safeLog(
      () => _analytics.logEvent(
        name: AnalyticsEvents.entityManagement,
        parameters: {
          AnalyticsParams.action: action,
          AnalyticsParams.entityType: entityType,
          AnalyticsParams.entityId: entityId,
        },
      ),
    );
  }

  @override
  Future<void> logMemberUpdate({
    required String action,
    required String role,
    required String shopId,
  }) async {
    await _safeLog(
      () => _analytics.logEvent(
        name: AnalyticsEvents.memberUpdate,
        parameters: {
          AnalyticsParams.action: action,
          AnalyticsParams.role: role,
          AnalyticsParams.shopId: shopId,
        },
      ),
    );
  }

  // ── Social & Recruitment Funnel ───────────────────────────────────────────

  @override
  Future<void> logSocialRequest({
    required String requestType,
    required String targetId,
  }) async {
    await _safeLog(
      () => _analytics.logEvent(
        name: AnalyticsEvents.socialRequest,
        parameters: {
          AnalyticsParams.requestType: requestType,
          AnalyticsParams.targetId: targetId,
        },
      ),
    );
  }

  @override
  Future<void> logRequestResponse({
    required String requestType,
    required String action,
  }) async {
    await _safeLog(
      () => _analytics.logEvent(
        name: AnalyticsEvents.requestResponse,
        parameters: {
          AnalyticsParams.requestType: requestType,
          AnalyticsParams.action: action,
        },
      ),
    );
  }

  // ── Subscriptions ─────────────────────────────────────────────────────────

  @override
  Future<void> logSubscriptionStarted(String productId) async {
    await _safeLog(
      () => _analytics.logEvent(
        name: AnalyticsEvents.subscriptionStarted,
        parameters: {AnalyticsParams.productId: productId},
      ),
    );
  }

  @override
  Future<void> logPartnerRegistration(String planType) async {
    await _safeLog(
      () => _analytics.logEvent(
        name: AnalyticsEvents.partnerRegistration,
        parameters: {AnalyticsParams.planType: planType},
      ),
    );
  }

  // ── User-Side Benefits (FCM-driven) ───────────────────────────────────────

  @override
  Future<void> logUserBenefitProcessed({
    required String benefitType,
    required String shopId,
    String? campaignId,
    String? giftId,
  }) async {
    await _safeLog(
      () => _analytics.logEvent(
        name: AnalyticsEvents.userBenefitProcessed,
        parameters: {
          AnalyticsParams.benefitType: benefitType,
          AnalyticsParams.shopId: shopId,
          if (campaignId != null) AnalyticsParams.campaignId: campaignId,
          if (giftId != null) AnalyticsParams.giftId: giftId,
        },
      ),
    );
  }
}
