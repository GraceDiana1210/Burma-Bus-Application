import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationService {
  final FlutterLocalNotificationsPlugin notificationsPlugin =
      FlutterLocalNotificationsPlugin();

      Future<void> initNotification() async {
  const AndroidInitializationSettings initializationSettingsAndroid =
      AndroidInitializationSettings('@mipmap/ic_launcher');

  const DarwinInitializationSettings initializationSettingsIOS =
      DarwinInitializationSettings(
          requestAlertPermission: true,
          requestBadgePermission: true,
          requestSoundPermission: true);

  const InitializationSettings initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS);

  await notificationsPlugin.initialize(initializationSettings);

  // Register the notification channel
  const AndroidNotificationChannel channel = AndroidNotificationChannel(
    'channelId', // ID must match in NotificationDetails
    'channelName', // Name visible to the user
    description: 'This is the channel description',
    importance: Importance.max,
  );

  await notificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);
}

  NotificationDetails notificationDetails() {
  return const NotificationDetails(
    android: AndroidNotificationDetails(
      'channelId', // Must match channel ID in initNotification
      'channelName',
      importance: Importance.max,
      priority: Priority.high,
    ),
    iOS: DarwinNotificationDetails(),
  );
}

  AndroidNotificationChannel channel = const AndroidNotificationChannel(
  'channelId', // ID must match in NotificationDetails
  'channelName', // Name visible to the user
  description: 'This is the channel description',
  importance: Importance.max, // Set importance
);

  Future<void> showNotification({
  int id = 0,
  String? title,
  String? body,
  String? payLoad,
}) async {
  try {
    await notificationsPlugin.show(
      id,
      title,
      body,
      notificationDetails(),
    );
  } catch (e) {
    print('Error showing notification: $e');
  }
}
}