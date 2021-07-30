import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fire99/Screens/alarm_screen.dart';
import 'package:fire99/login.dart';
import 'package:fire99/screen2.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<SharedPreferences> getSharedPrefs() async {
  return await SharedPreferences.getInstance();
}

Future setRememberMe(bool isRememberMe) async {
  SharedPreferences prefs = await getSharedPrefs();
  await prefs.setBool('isRememberMe', isRememberMe);
}

Future setEmail(String email) async {
  SharedPreferences prefs = await getSharedPrefs();
  await prefs.setString('email', email);
}

Future setPassword(String password) async {
  SharedPreferences prefs = await getSharedPrefs();
  await prefs.setString('password', password);
}

Future<bool> getRememberMe() async {
  SharedPreferences prefs = await getSharedPrefs();
  return prefs.getBool('isRememberMe') ?? false;
}

Future<String> getEmail() async {
  SharedPreferences prefs = await getSharedPrefs();
  return prefs.getString('email') ?? '';
}

Future<String> getPassword() async {
  SharedPreferences prefs = await getSharedPrefs();
  return prefs.getString('password') ?? '';
}

Future clearPrefs(BuildContext context, SharedPreferences prefs) async {
  await prefs.setBool('isRememberMe', false);
  await prefs.setString('email', '');
  await prefs.setString('password', '');
  await prefs.setString('ud', '');

  Navigator.of(context).popAndPushNamed(LoginScreen.routeName);
}

Future<void> routingOnIsRememberMeCondition(
  BuildContext context,
) async {
  bool isRememberMe;
  isRememberMe = await getRememberMe();

  if (isRememberMe) {
    //do the sign in function with firebase here
    var email = await getEmail();
    var password = await getPassword();

    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();

    UserCredential userCredential = await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);

    if (userCredential != null) {
      final user = FirebaseAuth.instance.currentUser;
      final userData = await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .get();
      String ud = userData['username'];
      await setUd(ud);
      // pushReplacement
      print('welcome');
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => screen2(ud)),
      );
    }
    // }
  } else {
    Navigator.popAndPushNamed(context, LoginScreen.routeName);
  }
}

setUd(String ud) async {
  SharedPreferences prefs = await getSharedPrefs();
  await prefs.setString('ud', ud);
}

getUd() async {
  SharedPreferences prefs = await getSharedPrefs();
  prefs.getString('ud');
}
