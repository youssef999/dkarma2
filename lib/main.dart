import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:fire99/Screens/Splash.dart';
import 'package:fire99/screen2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_native_admob/generated/i18n.dart';
import 'dart:async';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'Helpers/remember_me.dart';
import 'colorr.dart';
import 'login.dart';

void main() => runApp(MyApp());


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Splash Screen',
      theme: ThemeData(),
      home: SplashScreen(),

      routes: {LoginScreen.routeName: (context) => LoginScreen()},
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    super.initState();
    initializeNotif();
  }

  @override
  Widget build(BuildContext context) {
    throw UnimplementedError();
  }
}
  addPostFrame(BuildContext context) async {
    String ud = await getUd();
    Future.delayed(Duration(seconds: 5), () async {
      await routingOnIsRememberMeCondition(context);
    });
    AwesomeNotifications().actionStream.listen((receivedNotification) {
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => screen2(ud)));
    });
  }

  initializeNotif() async {
    await AwesomeNotifications().initialize(
      // set the icon to null if you want to use the default app icon
        'resource://drawable/app_icon',
        [
          NotificationChannel(
              vibrationPattern: highVibrationPattern,
              enableVibration: true,
              enableLights: true,
              importance: NotificationImportance.High,
              channelKey: 'high_intensity',
              channelName: 'High intensity notifications',
              channelDescription: 'Notification channel for reminders',
              defaultColor: Color(0xFF9D50DD),
              ledColor: Colors.amber)
        ]);

    await AwesomeNotifications().isNotificationAllowed().then((isAllowed) {
      if (!isAllowed) {
        AwesomeNotifications().requestPermissionToSendNotifications();
      }
    });
  }




