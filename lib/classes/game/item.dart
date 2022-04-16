import 'dart:math';

import 'package:drive_easy/global.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Item{
  dynamic reqId;
  String? name;
  dynamic reqType;
  dynamic fileType;
  dynamic source;
  dynamic destination;
  dynamic encryption;
  List<String>? content;
  dynamic action;
  dynamic sessionTime;
  Duration? timeNeeded;
  bool? malicious = false;
  bool? authenticating = false;
  bool? authenticated = false;
  bool? finish = false;
  bool? success;
  bool? checking = false;
  int? score;
  int? totalScore;
  String? mainPoint;

  // ignore: prefer_final_fields
  Map<String, bool> _isFieldCorrect = {
    "reqId": true,
    "reqType": true,
    "fileType": true,
    "source": true,
    "destination": true,
    "encryption": true,
    "content": true,
    "action": true,
    "sessionTime": true,
  };
  Map<String, bool>? get getFields => _isFieldCorrect;

  Map<String, bool> _copyOfField = {};
  Map<String, bool>? get getInitField => _copyOfField;

  void UpdateField(String name, bool value) {
    if(_isFieldCorrect[name] != null) {
      _isFieldCorrect[name] = value;
    }
  }

  Item(
  {
    this.name, 
    this.reqId,
    this.reqType,
    this.fileType,
    this.source,
    this.destination,
    this.encryption,
    this.content,
    this.action,
    this.sessionTime,
    this.timeNeeded,
    this.malicious,
    this.authenticating,
    this.authenticated,
    this.finish,
    this.success,
    this.score,
    this.totalScore,
    this.mainPoint,
  }){
    (reqId is int) ? null : UpdateField("reqId", false);
    (reqType is RequestType) ? null : UpdateField("reqType", false);
    (fileType is FileType) ? null : UpdateField("fileType", false);
    (source is Drives) ? null : UpdateField("source", false);
    (destination is Drives) ? null : UpdateField("destination", false);
    (encryption is Encryption) ? null : UpdateField("encryption", false);
    (action is ActionType) ? null : UpdateField("action", false);
    (sessionTime is DateTime) ? null : UpdateField("sessionTime", false);

    _copyOfField = Map.from(_isFieldCorrect);
  }

  static String _randomMaliciousDrive() {
    return "random";
  }

  static Item generate(){
    int ran = Random().nextInt(dummyFileName.length);
    String fileName = dummyFileName[ran];
    ran = Random().nextInt(Drives.values.length);
    Drives source = Drives.values[ran];
    int ran2 = Random().nextInt(Drives.values.length);
    while (ran2 == ran){
      ran2 = Random().nextInt(Drives.values.length);
    }
    Drives destination = Drives.values[ran2];
    ran = Random().nextInt(Encryption.values.length);
    Encryption encryption = Encryption.values[ran];
    ran = Random().nextInt(FileType.values.length);
    FileType fileType = FileType.values[ran];
    ran = Random().nextInt(1);
    bool malicious = (ran == 0) ? false : true;
    List<String> content = dummyContent;

    Item item = Item(
      name: fileName,
      fileType: fileType,
      source: source,
      destination: destination,
      encryption: encryption,
      content: content,
      malicious: malicious,
    ); 

    return item;
  }

  static Widget convertToImage(Drives drives){
    switch(drives){
      case Drives.googleDrive:
        return const Image(
          image: AssetImage("assets/images/drives/drive_2020q4_48dp.png")
        );
      case Drives.oneDrive:
        return const Image(
          image: AssetImage("assets/images/drives/onedrive.png"),
          height: 50,
          width: 50,
        );
      case Drives.icloud:
        return const Image(
          image: AssetImage("assets/images/drives/2560px-ICloud_logo.svg.png"),
          height: 50,
          width: 50,
        );
      case Drives.dropbox:
        return const Image(
          image: AssetImage("assets/images/drives/1101px-Dropbox_Icon.svg.png"),
          height: 50,
          width: 50,
        );
      case Drives.mega:
        return const Image(
          image: AssetImage("assets/images/drives/mega.png"),
          height: 50,
          width: 50,
        );
      case Drives.local:
        return const Image(
          image: AssetImage("assets/images/drives/folder-icon.png"),
          height: 50,
          width: 50,
        );
      case Drives.malicious:
        // TODO: Handle this case.
        return const Image(
          image: AssetImage("assets/images/drives/drive_2020q4_48dp.png")
        );
    }
  }

  static dynamic convert(dynamic any) {
    if (any is FileType){
      switch(any){
        case FileType.Shortcut:
          return "shortcut";
        case FileType.folder:
          return "folder";
        case FileType.file:
          return "file";
        case FileType.Third_party_shortcut:
          return "Third party shortcut";
      }  
    } else if (any is Drives){
      switch(any){
        case Drives.googleDrive:
          return "Google Drive";
        case Drives.oneDrive:
          return "OneDrive";
        case Drives.icloud:
          return "iCloud";
        case Drives.dropbox:
          return "Dropbox";
        case Drives.mega:
          return "Mega";
        case Drives.local:
          return "Local";
        case Drives.malicious:
          return _randomMaliciousDrive();
      }
    } else if (any is Encryption){
      switch(any){
        case Encryption.AES256:
          return "AES256";
        case Encryption.AES128:
          return "AES128";
      }
    } else if (any is RequestType){
      switch(any){
        case RequestType.uplaod:
          return "upload";
        case RequestType.download:
          return "download";
        case RequestType.transfer:
          return "transfer";
      }
    } else if (any is ActionType){
      switch(any){
        case ActionType.GET:
          return "GET";
        case ActionType.POST:
          return "POST";
        case ActionType.PUT:
          return "PUT";
        case ActionType.DELETE:
          return "DELETE";
        case ActionType.PATCH:
          return "PATCH";
      }
    }

    return any.toString();
  }

  @override
  String toString() {
    return "{Name: $name, File type: $fileType, source: $source, destination: $destination, encryption: $encryption, content: $content, malicious: $malicious}";
  }
  
}