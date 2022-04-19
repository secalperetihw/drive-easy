import 'package:drive_easy/classes/game/progress.dart';
import 'package:drive_easy/classes/user.dart';
import 'package:drive_easy/game/game_home.dart';
import 'package:drive_easy/static/emails.dart';
import 'package:drive_easy/static/requestsOnBoard.dart';
import 'package:flutter/material.dart';
import 'package:googleapis/streetviewpublish/v1.dart';

String GOOGLE_DRIVE_ICON = "https://ssl.gstatic.com/images/branding/product/1x/drive_2020q4_48dp.png";

AppUser? app_user;

final game = GameMain();

final GlobalKey<ScaffoldMessengerState> snackbarKey = GlobalKey<ScaffoldMessengerState>();

Progress progress = Progress.createDefault();

enum Drives {
  googleDrive,
  oneDrive,
  icloud,
  dropbox,
  mega,
  local,
  malicious,
}

enum Encryption {
  AES256,
  AES128,
}

enum FileType {
  folder,
  file,
  Shortcut,
  Third_party_shortcut,
}

enum PickFileType{
  file,
  image,
  video,
  cameraImage,
  cameraVideo,
  folder,
}

enum RequestType{
  upload,
  download,
  transfer,
}

enum ActionType{
  GET,
  POST,
  PUT,
  DELETE,
  PATCH,
}

List<String> dummyFileName = ["Random", "qweeew", "asdxczs", "sdxcrt", "secret"];

List<String> dummyContent = [
  "qwfe5^%\$gdrg5WSDF567u564",
  "ergergfbdr4ert65846",
  "5454 /5fgqweqh",
  "p[ew3]12sddf",
  "gfdjkghfdoigjrefi43",
  "EWRFvFD4dsf3G!331",
  "!dfsfE#\$@dfreg%\$ERG"
  "function inject(){execute inject!}",
];