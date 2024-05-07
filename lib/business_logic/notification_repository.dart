import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:web_app_template/business_logic/api_caller.dart';

Future<void> handleBackgroundMessage(RemoteMessage message) async {
  debugPrint('Title: ${message.notification?.title}');
  debugPrint('Body: ${message.notification?.body}');
  debugPrint('Payload: ${message.data}');
}

class FirebaseApi {
  final _firebaseMessaging = FirebaseMessaging.instance;

  Future<void> initNotifications() async {
    await _firebaseMessaging.requestPermission();
    final fCMToken = await _firebaseMessaging.getToken();
    debugPrint('------------Token: $fCMToken');
    final APICaller apiCaller = APICaller();
    apiCaller.setUrl('/user/fcm-token', true);
    var response = await apiCaller.getData(needAuthorization: true);
    if (response['fcmToken'] != fCMToken || response['fcmToken'] == 'none') {
      await apiCaller
          .postData(needAuthorization: true, body: {'fcmToken': fCMToken});
    }
    FirebaseMessaging.onBackgroundMessage(handleBackgroundMessage);
  }
}
