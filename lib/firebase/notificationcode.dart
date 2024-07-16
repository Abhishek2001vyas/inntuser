import 'dart:math';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart ';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class notification {
  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();

  final AndroidInitializationSettings _androidInitializationSettings =
  AndroidInitializationSettings('INNT');

  void initialiseNotification() async {
    InitializationSettings initializationSettings =
    InitializationSettings(android: _androidInitializationSettings);
    await _flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  void initLocalNotifications(
      BuildContext context,
      RemoteMessage message,
      ) async {
    print("load ${message.toString()}");
    var androidInitializationSettings =
    const AndroidInitializationSettings('@mipmap/ic_launcher');
    var initializationSetting = InitializationSettings(
      android: androidInitializationSettings,
    );
    await _flutterLocalNotificationsPlugin.initialize(initializationSetting,
        onDidReceiveNotificationResponse: (payload) {
          handleMessage(context, message);
        });
  }

  void handleMessage(BuildContext context, RemoteMessage message) {

    // Get.to( Videos_call());
  }

  Future<void> showNotification(RemoteMessage message) async {
    AndroidNotificationChannel channel = AndroidNotificationChannel(
        playSound: true,
        Random.secure().nextInt(100000).toString(),
        "High Importance Notification ",
        importance: Importance.max);
    AndroidNotificationDetails androidNotificationDetails =
    AndroidNotificationDetails(
        channel.id.toString(), channel.name.toString(),
        channelDescription: "Your Channel Description",
        importance: Importance.high,
        priority: Priority.high,
        ticker: "ticker");
    NotificationDetails notificationDetails = NotificationDetails(android: androidNotificationDetails);
    Future.delayed(Duration.zero, () {
      _flutterLocalNotificationsPlugin.show(
          0,
          message.notification!.title.toString(),
          message.notification!.body.toString(),
          notificationDetails);
    });
  }

  void firebaseinit(BuildContext context) {
    FirebaseMessaging.onMessage.listen((message) async {
      var shared_preferences = await SharedPreferences.getInstance();
      // await shared_preferences.setString(
      //     "imcominguserid", message.data["user_id"].toString());
      // await shared_preferences.setString(
      //     "imcomingdoctorid", message.data["doctor_id"].toString());
      initLocalNotifications(context, message);
      showNotification(message);
      if (message.data["call"] != null) {

      } else {
        initLocalNotifications(context, message);
        showNotification(message);
      }
    });
  }



  void ifAcceptedThenRedirectToAgora(channelname, token) {

  }
}
