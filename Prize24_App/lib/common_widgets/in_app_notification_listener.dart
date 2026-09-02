import 'package:flutter/material.dart';
import 'package:prize24_app/core/services/in_app_notification_service.dart';

/// Widget that listens to in-app notifications and displays them
/// Wrap your app with this widget to show notifications globally
class InAppNotificationListener extends StatefulWidget {
  final Widget child;
  final Duration defaultDuration;

  const InAppNotificationListener({
    required this.child,
    this.defaultDuration = const Duration(seconds: 4),
    super.key,
  });

  @override
  State<InAppNotificationListener> createState() =>
      _InAppNotificationListenerState();
}

class _InAppNotificationListenerState extends State<InAppNotificationListener> {
  final _notificationService = InAppNotificationService();

  @override
  void initState() {
    super.initState();
    _listenToNotifications();
  }

  void _listenToNotifications() {
    _notificationService.notificationStream.listen((notification) {
      if (!mounted) return;

      _showNotification(notification);
    });
  }

  void _showNotification(InAppNotification notification) {
    final context = this.context;

    // Determine colors based on notification type
    final colors = _getColorsForType(notification.type);

    // Show as SnackBar (you can customize this to use banners or custom widgets)
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              notification.title,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            if (notification.message != null) ...[
              const SizedBox(height: 4),
              Text(
                notification.message!,
                style: const TextStyle(fontSize: 14),
              ),
            ],
          ],
        ),
        backgroundColor: colors['background'],
        duration: notification.duration ?? widget.defaultDuration,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        action: SnackBarAction(
          label: 'Dismiss',
          textColor: Colors.white,
          onPressed: () {
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
          },
        ),
      ),
    );
  }

  Map<String, Color> _getColorsForType(InAppNotificationType type) {
    switch (type) {
      case InAppNotificationType.success:
        return {'background': Colors.green.shade700};
      case InAppNotificationType.error:
        return {'background': Colors.red.shade700};
      case InAppNotificationType.warning:
        return {'background': Colors.orange.shade700};
      case InAppNotificationType.info:
        return {'background': Colors.blue.shade700};
      case InAppNotificationType.custom:
        return {'background': Colors.purple.shade700};
    }
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
