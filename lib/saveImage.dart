import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
//import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:fire99/login.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Utility {
  static const String img_key = "Image_key";
  
  static Future<bool> saveImageToPrefrences(String value) async {
    final SharedPreferences prefrences = await SharedPreferences.getInstance();

    return prefrences.setString(img_key, value);
  }

  static Future<String> getImageFromPrefrences() async {
    final SharedPreferences prefrences = await SharedPreferences.getInstance();

    return prefrences.getString(img_key);
  }

  static String base64String(Uint8List data) {
    return base64Encode(data);
  }

  static Image imagefrombase64String(String base64String) {
    return Image.memory(base64Decode(base64String), fit: BoxFit.fill);

  }
}
