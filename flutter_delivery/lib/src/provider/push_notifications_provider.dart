import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_delivery/src/models/user.dart';
import 'package:flutter_delivery/src/provider/users_provider.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:http/http.dart' as http;


class PushNotificationsProvider {

AndroidNotificationChannel channel;
FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

void initNotifications() async {

  channel = const AndroidNotificationChannel(
    'high_importance_channel', // id
    'High Importance Notifications', // title
    description:
    'This channel is used for important notifications.', // description
    importance: Importance.high,
  );
  flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
      AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);

  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );
}

void onMessageListener() {

  //recibir las notificaciones en segundo plano
  FirebaseMessaging.instance.getInitialMessage().then((RemoteMessage message) {
    if (message != null) {
      print('Nueva notificación: $message');
    }
  });

  //recibir las notificaciones en primer plano
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    RemoteNotification notification = message.notification;
    AndroidNotification android = message.notification?.android;
    if (notification != null && android != null) {
      flutterLocalNotificationsPlugin.show(
       notification.hashCode,
        notification.title,
        notification.body,
        NotificationDetails(
          android: AndroidNotificationDetails(
            channel.id,
            channel.name,
            channelDescription: channel.description,
            icon: 'launch_background',
          )
        )
      );
    }
  });

  FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
    print('A new onMessageOpenedApp event was published');
  });
}

void saveToken(User user, BuildContext context) async {
  String token = await FirebaseMessaging.instance.getToken();
  UsersProvider usersProvider = new UsersProvider();
  usersProvider.init(context, sessionUser: user);
  usersProvider.updateNotificationToken(user.id, token);
}

Future<void> sendMessage(String to, Map<String, dynamic> data, String title, String body) async {
  Uri uri = Uri.https('fcm.googleapis.com', '/fcm/send');

  await http.post(
    uri,
    headers: <String, String> {
      'Content-Type': 'application/json',
      'Authorization': 'key=AAAA1QiEiyg:APA91bHSrwYWj2cbBdNEY1h6zfU7b3ScVhu-RdZbDhl_knhIZaPX-BRNuOGEIXbaKB2DiKSOiz7vSdqBE70q_MgjMwSYB1GdLYC2UR9kSljunL2tRj0H9vTlFj-QW8P2AzW-rgqoZAis'
    },
    body: jsonEncode(<String, dynamic> {
      'notification': <String, dynamic> {
        'body': body,
        'title': title
      },
      'priority': 'high',
      'ttl': '4500s',
      'data': data,
      'to': to
    })
  );
}

Future<void> sendMessageMultiple(List<String> toList, Map<String, dynamic> data, String title, String body) async {
  Uri uri = Uri.https('fcm.googleapis.com', '/fcm/send');

  await http.post(
      uri,
      headers: <String, String> {
        'Content-Type': 'application/json',
        'Authorization': 'key=AAAA1QiEiyg:APA91bHSrwYWj2cbBdNEY1h6zfU7b3ScVhu-RdZbDhl_knhIZaPX-BRNuOGEIXbaKB2DiKSOiz7vSdqBE70q_MgjMwSYB1GdLYC2UR9kSljunL2tRj0H9vTlFj-QW8P2AzW-rgqoZAis'
      },
      body: jsonEncode(<String, dynamic> {
        'notification': <String, dynamic> {
          'body': body,
          'title': title
        },
        'priority': 'high',
        'ttl': '4500s',
        'data': data,
        'registration_ids': toList
      })
  );
}

}