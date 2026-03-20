import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class NotificationHandler {
  static void init(BuildContext context) {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      debugPrint('Foreground Notification:${message.notification?.title}');
    });
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      debugPrint('Onmessageopenedapp:${message.data['blogId']}');
      context.go('/blog');
    });
  }

  static Future<void> handleInitialMessage(BuildContext context) async {
    RemoteMessage? initialMessage = await FirebaseMessaging.instance
        .getInitialMessage();

    if (initialMessage != null) {
      context.go('/blog');
    }
  }
}
