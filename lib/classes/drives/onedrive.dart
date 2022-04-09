import 'package:drive_easy/classes/method/pickfile.dart';
import 'package:drive_easy/customException.dart';
import 'package:drive_easy/global.dart';
import 'package:flutter/material.dart';
import 'drives.dart';
import 'package:googleapis/drive/v3.dart';
import 'dart:io' as io;
import 'package:path/path.dart' as path;

class onedrive_data extends Drive_data{
  // GoogleSignInAccount? googleSignInAccount;
  String? email;

  onedrive_data({
    String? account_name,
    String? email,
    int? capacity,
    int? used,
    int? left,
    var status,
    var data,
    // GoogleSignInAccount? googleSignInAccount
  }){
    this.account_name = account_name;
    this.email = email;
    this.capacity = capacity;
    this.used = used;
    this.left = left;
    this.status = status;
    this.data = data;
    // this.googleSignInAccount = googleSignInAccount;
  }

  @override
  Map<String, dynamic> toJson(){
    return {};
  }
}