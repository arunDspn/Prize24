import 'dart:async';
import 'dart:io';

import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:logger/logger.dart';
import 'package:prize24_app/core/services/analytics/analytics_events.dart';
import 'package:prize24_app/routing/app_router.dart';
import 'package:prize24_app/routing/app_routes.dart';
import 'package:purchases_flutter/purchases_flutter.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:timezone/data/latest.dart' as tz_data;
import 'package:timezone/timezone.dart' as tz;

final logger = Logger();
final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

// Store the initial message for handling after app initialization
RemoteMessage? _initialMessage;

final inAppNotifcationsController = StreamController<RemoteMessage>.broadcast();

// Background message handler (must be top-level function)
@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  logger.i('Handling a background message: ${message.messageId}');
}

/// Fires [AnalyticsEvents.userBenefitProcessed] when the FCM data message
/// confirms a benefit was processed on the server side.
/// Uses [FirebaseAnalytics.instance] directly because this runs outside of
/// any Riverpod context (top-level bootstrap function).
void _logFcmBenefitEvent(Map<String, dynamic> data) {
  if (!FlavorConfig.isProduction) return;

  const _benefitTypeMap = {
    'check_in': BenefitType.checkIn,
    'offer_avail_success': BenefitType.availed,
    'offer_redeem_success': BenefitType.redeemed,
  };

  final type = data['type'] as String?;
  final benefitType = type != null ? _benefitTypeMap[type] : null;
  if (benefitType == null) return; // not a benefit message

  final shopId = data['shop_id'] as String?;
  if (shopId == null) return; // shop_id is required

  final params = <String, Object>{
    AnalyticsParams.benefitType: benefitType,
    AnalyticsParams.shopId: shopId,
  };

  final campaignId = data['campaign_id'] as String?;
  if (campaignId != null) params[AnalyticsParams.campaignId] = campaignId;

  final giftId = data['gift_id'] as String?;
  if (giftId != null) params[AnalyticsParams.giftId] = giftId;

  // Fire-and-forget: wrap in unawaited and swallow any error so we never
  // crash the notification stream on an analytics failure.
  unawaited(
    FirebaseAnalytics.instance
        .logEvent(
          name: AnalyticsEvents.userBenefitProcessed,
          parameters: params,
        )
        .catchError((Object e) {
          logger.w('Analytics logEvent failed: $e');
        }),
  );
}

// Centralized notification tap handler
void _handleNotificationTap(Map<String, dynamic> data, {String? title}) {
  logger
    ..i('Notification tapped: $title')
    ..i('Data: $data');

  // Get the notification type
  final type = data['type'] as String?;

  if (type == null) {
    logger.w('No notification type found in data');
    return;
  }

  // Handle different notification types
  switch (type) {
    case 'new_offer':
      final shopId = data['shopId'] as String?;
      if (shopId != null) {
        logger.i('Navigating to shop offers: $shopId');
        router.push(
          AppRoutes.shopOfferDetails,
          extra: {'offerId': data['offerId'] as String?, 'shopId': shopId},
        );
      } else {
        logger.w('Shop ID not found for new_offer notification');
      }
      break;

    case 'new_campaign':
      final campaignId = data['campaign_id'] as String?;
      logger.i('New campaign notification: $campaignId');
      // Navigate to campaigns page or home
      router.go(AppRoutes.home);
      break;

    case 'gift_available':
      final giftId = data['gift_id'] as String?;
      logger.i('Gift available notification: $giftId');
      router.go(AppRoutes.home);
      break;

    case 'club_invite':
      final clubId = data['club_id'] as String?;
      logger.i('Club invite notification: $clubId');
      router.go(AppRoutes.home);
      break;

    default:
      logger.i('Unknown notification type: $type, navigating to home');
      router.go(AppRoutes.home);
  }
}

Future<void> _initializeRevenueCat() async {
  // Use test key in debug builds; fall back to production keys otherwise.
  const useTestKeys = kDebugMode;

  String apiKey;
  if (Platform.isIOS) {
    apiKey = useTestKeys
        ? 'appl_kTlUWkKmgCzAorYHZqsMzyXuzRR'
        : 'appl_rJwKMxiSOuCRPdqETlXBCbbIkkF';
  } else if (Platform.isAndroid) {
    apiKey = useTestKeys
        ? 'test_WnmtyvtGSpJQOpDHAFIgtOaLKtH'
        // ? 'goog_EjITFLAleMwFRcNSXFBTXYnFIsa'
        : 'goog_EjITFLAleMwFRcNSXFBTXYnFIsa';
  } else {
    logger.e('Unsupported platform for RevenueCat');
    throw UnsupportedError('Platform not supported');
  }

  final config = PurchasesConfiguration(apiKey)
    ..diagnosticsEnabled = kDebugMode;

  await Purchases.configure(config);
}

Future<void> _initializeLocalNotifications() async {
  const androidSettings = AndroidInitializationSettings(
    '@mipmap/launcher_icon',
  );
  const iosSettings = DarwinInitializationSettings(
    requestAlertPermission: true,
  );

  const initSettings = InitializationSettings(
    android: androidSettings,
    iOS: iosSettings,
  );

  await flutterLocalNotificationsPlugin.initialize(
    initSettings,
    onDidReceiveNotificationResponse: (details) {
      if (details.payload != null && details.payload!.isNotEmpty) {
        try {
          // Parse the payload as it's a map string representation
          final data = <String, dynamic>{};
          // Simple parsing - in production, consider using jsonDecode if you send JSON
          _handleNotificationTap(data, title: 'Foreground notification');
        } catch (e) {
          logger.e('Error parsing notification payload: $e');
        }
      }
    },
  );

  // Create notification channel for Android
  const androidChannel = AndroidNotificationChannel(
    'high_importance_channel',
    'High Importance Notifications',
    description: 'This channel is used for important notifications.',
    importance: Importance.high,
  );

  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin
      >()
      ?.createNotificationChannel(androidChannel);
}

Future<void> _showNotification(RemoteMessage message) async {
  final notification = message.notification;
  final android = message.notification?.android;

  if (notification != null) {
    await flutterLocalNotificationsPlugin.show(
      notification.hashCode,
      notification.title,
      notification.body,
      NotificationDetails(
        android: AndroidNotificationDetails(
          'high_importance_channel',
          'High Importance Notifications',
          channelDescription:
              'This channel is used for important notifications.',
          importance: Importance.high,
          priority: Priority.high,
          icon: android?.smallIcon ?? '@mipmap/launcher_icon',
        ),
        iOS: const DarwinNotificationDetails(
          presentAlert: true,
          presentBadge: true,
          presentSound: true,
        ),
      ),
      payload: message.data.toString(),
    );
  }
}

enum Flavor { development, staging, production }

class FlavorConfig {
  static Flavor? _flavor;
  static Flavor get flavor => _flavor ?? Flavor.production;

  static bool get isDevelopment => _flavor == Flavor.development;
  static bool get isStaging => _flavor == Flavor.staging;
  static bool get isProduction => _flavor == Flavor.production;

  static String get name => _flavor?.name ?? 'production';
}

Future<void> bootstrap(
  FutureOr<Widget> Function() builder, {
  required Flavor flavor,
  bool enableSentry = false,
  String? sentryDsn,
}) async {
  FlavorConfig._flavor = flavor;
  // Lock app in portrait mode
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  FlutterError.onError = (details) {
    logger.e('Flutter Error: ${details.exceptionAsString()}');
    if (enableSentry && !kDebugMode && sentryDsn != null) {
      Sentry.captureException(details.exception, stackTrace: details.stack);
    }
  };

  await _initializeRevenueCat();

  // Firebase is initialized in main_*.dart files before calling bootstrap
  // DO NOT initialize Firebase here to avoid duplicate app error

  // Initialize timezone data
  tz_data.initializeTimeZones();

  // Initialize local notifications
  await _initializeLocalNotifications();

  // Set up background handler
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  // Check if app was opened from a terminated state by tapping a notification
  _initialMessage = await FirebaseMessaging.instance.getInitialMessage();
  if (_initialMessage != null) {
    logger.i('App opened from terminated state via notification');
    _handleNotificationTap(
      _initialMessage!.data,
      title: _initialMessage!.notification?.title,
    );
  }

  // Request permission
  final settings = await FirebaseMessaging.instance.requestPermission(
    alert: true,
    badge: true,
    sound: true,
  );

  logger.i('Notification permission: ${settings.authorizationStatus}');

  // Handle foreground messages - show notification
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    logger.i('Foreground message: ${message.notification?.title}');
    if (message.notification != null) {
      _showNotification(message);
    } else {
      inAppNotifcationsController.add(message);
      _logFcmBenefitEvent(message.data);
      if (message.data['type'] == 'check_in') {
        // Schedule local notification for 30 days later
        // Content -- It’s been a while! Visit {ShopName} today and keep your streak going 🔥”
        final shopName = message.data['shop_name'] ?? 'your favorite shop';
        final scheduledDate = tz.TZDateTime.now(
          tz.local,
        ).add(const Duration(days: 30));
        flutterLocalNotificationsPlugin.zonedSchedule(
          0,
          'It’s been a while!',
          'Visit $shopName today and keep your streak going 🔥',
          scheduledDate,
          const NotificationDetails(
            android: AndroidNotificationDetails(
              'high_importance_channel',
              'High Importance Notifications',
              channelDescription:
                  'This channel is used for important notifications.',
              importance: Importance.high,
              priority: Priority.high,
              icon: '@mipmap/launcher_icon',
            ),
            iOS: DarwinNotificationDetails(
              presentAlert: true,
              presentBadge: true,
              presentSound: true,
            ),
          ),
          androidScheduleMode: AndroidScheduleMode.inexactAllowWhileIdle,
          // uiLocalNotificationDateInterpretation:
          //     UILocalNotificationDateInterpretation.absoluteTime,
        );
      }
    }
  });

  // Handle notification tap when app is in background
  FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
    logger.i('Notification opened app from background');
    _handleNotificationTap(message.data, title: message.notification?.title);
  });

  // Add cross-flavor configuration here

  final app = await builder();

  if (enableSentry && sentryDsn != null) {
    await SentryFlutter.init((options) {
      options
        ..dsn = sentryDsn
        ..tracesSampleRate = 1.0
        ..profilesSampleRate = 1.0
        ..enableAutoSessionTracking = true
        ..attachScreenshot = true
        ..attachViewHierarchy = true;
    }, appRunner: () => runApp(app));
  } else {
    // ignore: missing_provider_scope
    runApp(app);
  }
}
