import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PushNotificationProvider {
  FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;

  initNotifications() async {
    await firebaseMessaging.requestPermission();
    LocalNotifications.initialize();
    FirebaseMessaging.onMessage.listen((message) {
      LocalNotifications.showBigTextNotification(
          title: 'It is time to train!',
          body: 'You must comply with your routine');
    });
  }

  addNewSubscription(String topic) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey('currentSub')) {
      var currentTopic = prefs.getString('currentSub');
      await firebaseMessaging.unsubscribeFromTopic(currentTopic!);
      prefs.setString('currentSub', topic);
      await firebaseMessaging.subscribeToTopic(topic);
    } else {
      prefs.setString('currentSub', topic);
      await firebaseMessaging.subscribeToTopic(topic);
    }
  }
}

class LocalNotifications {
  static FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  static Future initialize() async {
    var androidInitialize =
        const AndroidInitializationSettings('mipmap/ic_launcher');
    var initializationsSettings =
        InitializationSettings(android: androidInitialize);
    await flutterLocalNotificationsPlugin.initialize(initializationsSettings);
  }

  static Future showBigTextNotification(
      {var id = 0,
      required String title,
      required String body,
      var payload}) async {
    AndroidNotificationDetails androidPlatformChannelSpecifics =
        const AndroidNotificationDetails(
      'channel1',
      'fitness_channel',
      playSound: true,
      importance: Importance.max,
      priority: Priority.high,
    );

    var not = NotificationDetails(android: androidPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.show(0, title, body, not);
  }
}
