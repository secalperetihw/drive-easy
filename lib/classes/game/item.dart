import 'dart:math';

import 'package:drive_easy/documents/Authorization_Request_timeout.dart';
import 'package:drive_easy/documents/Authorization_User_refuse.dart';
import 'package:drive_easy/global.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:googleapis/cloudbuild/v1.dart';

class Item{
  dynamic reqId;
  String? name;
  dynamic reqType;
  dynamic fileType;
  dynamic source;
  dynamic destination;
  dynamic encryption;
  String? content;
  dynamic action;
  dynamic sessionTime;
  Duration? timeNeeded;
  bool? malicious;
  bool? authorizing = false;
  bool? authorized = false;
  bool? authFailed = false;
  bool? finish = false;
  bool? success;
  bool? checking = false;
  bool? wrongDenyReason;
  int? score;
  int? totalScore;
  int? finalScore;
  String? mainPoint;
  int? authSituation;
  String? key;

  Map<int, bool>? maliciousPosition;
  bool? encrypted = false;
  bool? wrapped = false;
  bool? wrappedAfterEncrpyt = false;

  Widget _authResult = Container();
  Widget get getAuthResult => _authResult;

  // ignore: prefer_final_fields
  Map<String, bool> _isFieldCorrect = {
    "reqId": true,
    "reqType": true,
    "fileType": true,
    "source": true,
    "destination": true,
    "encryption": true,
    "action": true,
    "sessionTime": true,
    "matchAandT": true,
    "content": true,
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
    this.authorizing,
    this.authorized,
    this.authFailed,
    this.finish,
    this.success,
    this.score,
    this.totalScore,
    this.mainPoint,
    this.authSituation,
    this.wrongDenyReason,
    this.key,
    this.maliciousPosition,
  }){
    (reqId is int) ? null : UpdateField("reqId", false);
    (reqType is RequestType) ? null : UpdateField("reqType", false);
    (fileType is FileType) ? null : UpdateField("fileType", false);
    (source is Drives) ? null : UpdateField("source", false);
    (destination is Drives) ? null : UpdateField("destination", false);
    (encryption is Encryption) ? null : UpdateField("encryption", false);
    (action is ActionType) ? null : UpdateField("action", false);
    (sessionTime is DateTime) ? null : UpdateField("sessionTime", false);

    if (reqType is RequestType && action is ActionType) {
      if (reqType == RequestType.upload && action != ActionType.POST) UpdateField("matchAandT", false);
      if (reqType == RequestType.download && action != ActionType.GET) UpdateField("matchAandT", false);
      if (reqType == RequestType.transfer && action != ActionType.POST) UpdateField("matchAandT", false);
    }
    if (reqType is !RequestType && action is !ActionType) UpdateField("matchAandT", false);

    if (encryption is Encryption && destination is Drives) {
      if (encryption == Encryption.AES128 && destination != Drives.googleDrive) {
        UpdateField("encryption", false);
      }
    }

    _copyOfField = Map.from(_isFieldCorrect);

    if (content != null) {  
      List<String> input = content!.split(" ");

      for (int i=0; i< input.length; i++) {
        if (input[i].contains("*")) {
          if (maliciousPosition == null) {
            maliciousPosition = {i: true};
          } else {
            maliciousPosition!.addAll({i: true});
          }
        }
      }
    }
    
  }

  void setResult (int? num, BuildContext ctx) {

    switch (num) {
      case null:
        _authResult = Container();
        break;
      case 0:
        _authResult = RichText(textAlign: TextAlign.center, text: TextSpan(children: const [
          TextSpan(text: "Authorization: done",  style: TextStyle(color: Colors.blue),),
        ]),);
        break;
      case 1:
        PageController pageController = PageController(initialPage: 0);
        int _page = 0;
        _authResult = Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          RichText(textAlign: TextAlign.center, text: TextSpan(children: const [
            TextSpan(text: "Authorization: User refuse", style: TextStyle(color: Colors.red),),
          ]),),
          Container(padding: EdgeInsets.only(left: 15), child: GestureDetector(
            onTap: () async {
              await showDialog<void>(
                context: ctx,
                barrierDismissible: false, 
                builder: (BuildContext buildContext) { 
                  return Dialog(
                    child: Container(
                      height: MediaQuery.of(ctx).size.height * 0.8,
                      width: MediaQuery.of(ctx).size.width * 0.8,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15)
                      ),
                      child: PageView(
                        controller: pageController,
                        children: [
                          Authorization_User_refuse(
                            onpress: () {
                              Navigator.pop(buildContext);
                            },
                            text: "Got it!",
                          )
                        ],
                      ),
                    ),
                  );
                }
              );
            },
            child: Icon(Icons.help_center, color: Colors.red),
          ),)
        ],);
        break;
      case 2:
        PageController pageController = PageController(initialPage: 0);
        int _page = 0;
        _authResult = Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          RichText(textAlign: TextAlign.center, text: TextSpan(children: const [
            TextSpan(text: "Authorization: Request timeout", style: TextStyle(color: Colors.red),),
          ]),),
          Container(padding: EdgeInsets.only(left: 15), child: GestureDetector(
            onTap: () async {
              await showDialog<void>(
                context: ctx,
                barrierDismissible: false, 
                builder: (BuildContext buildContext) { 
                  return Dialog(
                    child: Container(
                      height: MediaQuery.of(ctx).size.height * 0.8,
                      width: MediaQuery.of(ctx).size.width * 0.8,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15)
                      ),
                      child: PageView(
                        controller: pageController,
                        children: [
                          Authorization_Request_timeout(
                            width: MediaQuery.of(ctx).size.width * 0.8,
                            onpress: () {
                              Navigator.pop(buildContext);
                            },
                            text: "Got it!",
                          )
                        ],
                      ),
                    ),
                  );
                }
              );
            },
            child: Icon(Icons.help_center, color: Colors.red),
          ),)
        ],);
        break;
    }
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

    String content = "";

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

  static String randomStringGenerator({required int length, String? pool}) {
    Random _rnd = Random();
    String _pool = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789!@#^&_+ ";
    String result = "";

    // for (int i=0; i<numOfString; i++) {
      for (int j=0; j<length; j++) {
        result += (pool ?? _pool)[_rnd.nextInt((pool ?? _pool).length)];
      }
    // }

    return result;
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
        case RequestType.upload:
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