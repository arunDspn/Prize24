import 'package:prize24_app/bootstrap.dart';
import 'package:prize24_app/flavor_config.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

/// Centralized Sentry error handling helper
/// Only captures errors in production environment
class SentryHelper {
  SentryHelper._();

  /// Check if Sentry should be enabled
  static bool get _shouldCapture => FlavorConfig.isProduction;

  /// Capture an exception with optional context
  /// Only sends to Sentry in production
  static Future<void> captureException(
    dynamic exception, {
    StackTrace? stackTrace,
    String? hint,
    Map<String, dynamic>? extra,
    SentryLevel level = SentryLevel.error,
  }) async {
    // Always log locally
    logger.e('Error captured: $exception',
        error: exception, stackTrace: stackTrace);

    // Only send to Sentry in production
    if (!_shouldCapture) {
      return;
    }

    await Sentry.captureException(
      exception,
      stackTrace: stackTrace,
      // hint: hint,
      withScope: (scope) {
        scope.level = level;
        if (extra != null) {
          extra.forEach((key, value) {
            scope.setExtra(key, value);
          });
        }
      },
    );
  }

  /// Capture a message (non-exception log)
  static Future<void> captureMessage(
    String message, {
    SentryLevel level = SentryLevel.info,
    Map<String, dynamic>? extra,
  }) async {
    logger.i(message);

    if (!_shouldCapture) {
      return;
    }

    await Sentry.captureMessage(
      message,
      level: level,
      withScope: (scope) {
        if (extra != null) {
          extra.forEach((key, value) {
            scope.setExtra(key, value);
          });
        }
      },
    );
  }

  /// Execute a function with error handling
  /// Automatically captures errors to Sentry in production
  static Future<T?> executeWithErrorHandling<T>({
    required Future<T> Function() operation,
    required String operationName,
    Map<String, dynamic>? additionalContext,
    T? fallbackValue,
  }) async {
    try {
      return await operation();
    } catch (e, stackTrace) {
      await captureException(
        e,
        stackTrace: stackTrace,
        hint: 'Operation: $operationName',
        extra: {
          'operation': operationName,
          ...?additionalContext,
        },
      );
      return fallbackValue;
    }
  }

  /// Set user context for Sentry
  static void setUser({
    required String? userId,
    String? email,
    String? username,
  }) {
    if (!_shouldCapture) {
      return;
    }

    Sentry.configureScope((scope) {
      scope.setUser(
        SentryUser(
          id: userId,
          email: email,
          username: username,
        ),
      );
    });
  }

  /// Clear user context
  static void clearUser() {
    if (!_shouldCapture) {
      return;
    }

    Sentry.configureScope((scope) {
      scope.setUser(null);
    });
  }

  /// Add breadcrumb for tracking user actions
  static void addBreadcrumb({
    required String message,
    String? category,
    Map<String, dynamic>? data,
    SentryLevel level = SentryLevel.info,
  }) {
    if (!_shouldCapture) {
      return;
    }

    Sentry.addBreadcrumb(
      Breadcrumb(
        message: message,
        category: category,
        data: data,
        level: level,
        timestamp: DateTime.now(),
      ),
    );
  }

  /// Set custom tags for filtering in Sentry
  static void setTag(String key, String value) {
    if (!_shouldCapture) {
      return;
    }

    Sentry.configureScope((scope) {
      scope.setTag(key, value);
    });
  }
}
