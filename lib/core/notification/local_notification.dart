import 'dart:developer';

import 'package:flutter/widgets.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class FlutterLocalNotificationManager {
  FlutterLocalNotificationManager._();
  static final FlutterLocalNotificationManager instance =
      FlutterLocalNotificationManager._();
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  AndroidInitializationSettings initializationSettingsAndroid =
      const AndroidInitializationSettings('@mipmap/ic_launcher');

  Future<void> init() async {
    try {
      InitializationSettings initializationSettings =
          InitializationSettings(android: initializationSettingsAndroid);
      await flutterLocalNotificationsPlugin.initialize(initializationSettings,
          onDidReceiveNotificationResponse: onSelectNotification);
    } catch (e) {
      debugPrint('Error initializing notifications: $e');
    }
  }

  Future onSelectNotification(NotificationResponse notificationResponse) async {
    final payload = notificationResponse.payload;
    if (payload != null) {
      debugPrint("Notification payload: $payload");
    }
  }

  displayNotification({required String title, required String body}) async {
    try {
      AndroidNotificationDetails androidNotificationDetails =
          const AndroidNotificationDetails(
        'your channel id',
        'your channel name',
        importance: Importance.max,
        priority: Priority.high,
        ticker: 'ticker',
      );
      NotificationDetails notificationDetails =
          NotificationDetails(android: androidNotificationDetails);
      await flutterLocalNotificationsPlugin.show(
          0, title, body, notificationDetails,
          payload: 'Your selection will be noted');
    } catch (e) {
      log(e.toString());
    }
  }
}
