# In-App Notification Service Usage

## Overview
The In-App Notification Service handles **UI-level notifications** that appear within your app (like snackbars or banners), separate from system-level push notifications.

## Setup

### 1. Wrap your app with the listener in your main app widget:

```dart
import 'package:prize24_app/common_widgets/in_app_notification_listener.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return InAppNotificationListener(
      child: MaterialApp(
        // your app config
      ),
    );
  }
}
```

### 2. Use the service anywhere in your app:

```dart
import 'package:prize24_app/core/services/in_app_notification_service.dart';

final notificationService = InAppNotificationService();

// Show success notification
notificationService.showSuccess(
  title: 'Order Placed!',
  message: 'Your order has been confirmed',
);

// Show error notification
notificationService.showError(
  title: 'Payment Failed',
  message: 'Please check your payment details',
);

// Show info notification
notificationService.showInfo(
  title: 'New Feature Available',
  message: 'Check out our latest update',
);

// Show warning notification
notificationService.showWarning(
  title: 'Low Balance',
  message: 'Your account balance is running low',
);

// Show custom notification with data
notificationService.showCustom(
  title: 'Special Offer',
  message: 'Limited time offer on selected items',
  data: {'offerId': '123', 'discount': 20},
  duration: Duration(seconds: 5),
);
```

## Use Cases

- ✅ Form validation feedback
- ✅ Operation success/failure messages
- ✅ Real-time updates (new messages, offers, etc.)
- ✅ Warning messages before critical actions
- ✅ Custom in-app alerts

## Difference from System Notifications

| Feature | In-App Notifications | System Notifications (Firebase) |
|---------|---------------------|----------------------------------|
| **Location** | Inside app UI | System notification tray |
| **Visibility** | Only when app is open | Even when app is closed |
| **Persistence** | Temporary (auto-dismiss) | Stays until dismissed |
| **Use Case** | Real-time feedback | Important alerts |
| **Implementation** | This service | Firebase Messaging |
