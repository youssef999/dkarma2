import 'package:fire99/Screens/alarm_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class LocalNotif {
  FlutterLocalNotificationsPlugin localNotifPlugin =
      new FlutterLocalNotificationsPlugin();
  AndroidInitializationSettings androidInitializationSettings =
      AndroidInitializationSettings('app_icon');
  IOSInitializationSettings iosInitializationSettings =
      new IOSInitializationSettings();

  Future initializeLocalNotifPlugin(BuildContext context) async {
    InitializationSettings initializationSettings = InitializationSettings(
        android: androidInitializationSettings, iOS: iosInitializationSettings);
    await localNotifPlugin.initialize(initializationSettings,
        onSelectNotification: (b) async {
      onSelectedNotif(context);
    });
  }

  Future setNotification(String alarmTitle, String alarmBody) async {
    AndroidNotificationDetails androidDetails = AndroidNotificationDetails(
        "Channel Id", "DealKarma", "Play some more",
        priority: Priority.high,
        color: Colors.deepPurple,
        importance: Importance.high,
        fullScreenIntent: true);
    IOSNotificationDetails isoDetails = IOSNotificationDetails();
    NotificationDetails notif =
        NotificationDetails(android: androidDetails, iOS: isoDetails);
    await this.localNotifPlugin.show(0, alarmTitle, alarmBody, notif);
  }

  onSelectedNotif(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return AlarmScreen();
    }));
  }
}
