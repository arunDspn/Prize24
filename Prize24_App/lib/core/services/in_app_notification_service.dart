import 'dart:async';

/// Types of in-app notifications
enum InAppNotificationType {
  info,
  success,
  warning,
  error,
  custom,
}

/// Model for in-app notification data
class InAppNotification {
  final String id;
  final String title;
  final String? message;
  final InAppNotificationType type;
  final Map<String, dynamic>? data;
  final DateTime timestamp;
  final Duration? duration;

  InAppNotification({
    required this.id,
    required this.title,
    this.message,
    this.type = InAppNotificationType.info,
    this.data,
    DateTime? timestamp,
    this.duration,
  }) : timestamp = timestamp ?? DateTime.now();

  @override
  String toString() => 'InAppNotification(id: $id, title: $title, type: $type)';
}

/// Service to manage in-app notifications (non-system level)
/// Use this for showing banners, snackbars, or custom UI notifications within the app
class InAppNotificationService {
  // Singleton pattern
  static final InAppNotificationService _instance =
      InAppNotificationService._internal();
  factory InAppNotificationService() => _instance;
  InAppNotificationService._internal();

  // Stream controller for broadcasting notifications
  final _notificationController =
      StreamController<InAppNotification>.broadcast();

  /// Stream of in-app notifications
  /// Listen to this in your UI to display notifications
  Stream<InAppNotification> get notificationStream =>
      _notificationController.stream;

  /// Show an info notification
  void showInfo({
    required String title,
    String? message,
    Map<String, dynamic>? data,
    Duration? duration,
  }) {
    _addNotification(
      title: title,
      message: message,
      type: InAppNotificationType.info,
      data: data,
      duration: duration,
    );
  }

  /// Show a success notification
  void showSuccess({
    required String title,
    String? message,
    Map<String, dynamic>? data,
    Duration? duration,
  }) {
    _addNotification(
      title: title,
      message: message,
      type: InAppNotificationType.success,
      data: data,
      duration: duration,
    );
  }

  /// Show a warning notification
  void showWarning({
    required String title,
    String? message,
    Map<String, dynamic>? data,
    Duration? duration,
  }) {
    _addNotification(
      title: title,
      message: message,
      type: InAppNotificationType.warning,
      data: data,
      duration: duration,
    );
  }

  /// Show an error notification
  void showError({
    required String title,
    String? message,
    Map<String, dynamic>? data,
    Duration? duration,
  }) {
    _addNotification(
      title: title,
      message: message,
      type: InAppNotificationType.error,
      data: data,
      duration: duration,
    );
  }

  /// Show a custom notification
  void showCustom({
    required String title,
    String? message,
    Map<String, dynamic>? data,
    Duration? duration,
  }) {
    _addNotification(
      title: title,
      message: message,
      type: InAppNotificationType.custom,
      data: data,
      duration: duration,
    );
  }

  /// Add a notification to the stream
  void _addNotification({
    required String title,
    String? message,
    required InAppNotificationType type,
    Map<String, dynamic>? data,
    Duration? duration,
  }) {
    final notification = InAppNotification(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      title: title,
      message: message,
      type: type,
      data: data,
      duration: duration,
    );

    _notificationController.add(notification);
  }

  /// Dispose the service (call this when app is closing)
  void dispose() {
    _notificationController.close();
  }
}
