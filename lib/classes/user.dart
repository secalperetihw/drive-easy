// ignore_for_file: prefer_initializing_formals

import 'package:firebase_auth/firebase_auth.dart';

import 'devices/devices.dart';
import 'drives/google_drive.dart';

class AppUser{
  User? user_firebase;
  UserCredential? userCredential_firebase;
  bool? auth_fail;
  List<Google_drive_data>? google_drive_data;
  List<Devices>? devices;
  String? app_check_token;

  AppUser({
    User? user_firebase,
    UserCredential? userCredential_firebase,
    bool auth_fail = true,
    List<Google_drive_data>? google_drive_data,
    String? app_check_token
    }){
      this.user_firebase = user_firebase;
      this.userCredential_firebase = userCredential_firebase;
      this.auth_fail = auth_fail;
      this.google_drive_data = google_drive_data;
      this.app_check_token = app_check_token;
    }
}