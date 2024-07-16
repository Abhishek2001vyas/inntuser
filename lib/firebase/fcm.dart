import 'package:firebase_messaging/firebase_messaging.dart';

late final fCMToken;

Future<void> handleBackgroundMessage(RemoteMessage message) async {
  print('Title: ${message.notification?.title}');
  print('body: ${message.notification?.body}');
  print('payload: ${message.data}');
}

class FirebaseApi {
  final _firebasemessaging = FirebaseMessaging.instance;

  Future<void> initNotification() async {
    await _firebasemessaging.requestPermission();
    fCMToken = await _firebasemessaging.getToken();
    print('TOKEN: $fCMToken');

    FirebaseMessaging.onBackgroundMessage(handleBackgroundMessage);
  }

  void isDeviceTokenRefresh() async {
    _firebasemessaging.onTokenRefresh.listen((event) {
      event.toString();
    });
  }
}
