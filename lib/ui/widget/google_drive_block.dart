import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:drive_easy/classes/drives/google_drive.dart';
import 'package:drive_easy/classes/ui/blocks.dart';
import 'package:drive_easy/classes/ui/chooseFileType.dart';
import 'package:drive_easy/customException.dart';
import 'package:extension_google_sign_in_as_googleapis_auth/extension_google_sign_in_as_googleapis_auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../auth/auth.dart';
import '../../global.dart';
import 'package:googleapis/drive/v3.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:file_picker/file_picker.dart' as fp;
import 'dart:io' as io;
import 'package:path/path.dart' as path;


class googleDirveBlock extends StatefulWidget {
  Widget? testing;

  googleDirveBlock({
    Key? key,
    this.testing,
  }) : super(key: key);

  @override
  State<googleDirveBlock> createState() => _googleDirveBlockState();
}

class _googleDirveBlockState extends State<googleDirveBlock> {
  final _googleSignIn = GoogleSignIn(
    scopes: <String>[DriveApi.driveFileScope],
  );
  GoogleSignInAccount? account;
  var httpClient;
  DriveApi? driveApi;
  String? s;
  Google_drive_data? google_drive_data;
  
  Future<void> initiate () async {
    await _googleSignIn.authenticatedClient().then((value) => {
      httpClient = value,
      
      driveApi = DriveApi(httpClient),
      driveApi?.about.get($fields: '*').then((value) {
        setState(() {
          google_drive_data = Google_drive_data(
            account_name: account?.displayName ?? '',
            email: account?.email ?? '',
            capacity: int.parse(value.storageQuota?.limit ?? '0'),
            used: int.parse(value.storageQuota?.usage ?? '0'),
            left: int.parse(value.storageQuota?.limit ?? '0') - int.parse(value.storageQuota?.usage ?? '0'),
            data: value,
            // googleSignInAccount: account
          );
          s = 'limit: ' + (value.storageQuota?.limit ?? '') + '\n'
            + 'usage: ' + (value.storageQuota?.usage ?? '');
          content = Container(
            padding: const EdgeInsets.all(10),
            width: 350,
            // height: 150,
            child: Blocks(
              account_data: google_drive_data?.email ?? '',
              drive_name: 'Google Drive',
              capacity: google_drive_data?.getCapacity ?? 0,
              used: google_drive_data?.getUsed ?? 0,
              icon: Image.network(
                GOOGLE_DRIVE_ICON,
              ),
              signout: () async {
                bool signout = false;
                await showDialog<void>(
                  context: context,
                  barrierDismissible: false, // user must tap button!
                  builder: (BuildContext context) { 
                  
                    return AlertDialog(
                      title: Text("Sign out"),
                      content: Text("Are you sure to signout?"),
                      actions: [
                        TextButton(
                          onPressed:(){
                            signout = true;
                            Navigator.pop(context);
                          }, 
                          child: Text("Yes")
                        ),
                        TextButton(
                          onPressed:(){
                            signout = false;
                            Navigator.pop(context);
                          }, 
                          child: Text("No")
                        )
                      ],
                    );
                  }
                );
                if (!signout) return;
                await _googleSignIn.signOut();
                setState(() {
                  content = Center(
                    child: ElevatedButton(
                      child: Text("click to login google"),
                      onPressed: (){
                        _googleSignIn.signIn().then((_account) async {
                          setState(() { account = _account; });
                          initiate();
                        }).catchError((e) => print(e));
                      },
                    ),
                  );
                });
              },
              upload: () async {
                await google_drive_data?.upload(driveApi: driveApi, context: context).catchError((e) {print(e);});
              },
            ),
          );
        });
      }).catchError((e) => { print(e) })
    }).catchError((e) => { print(e)} ).then((value) => {
      
    });
  }

  @override
  void initState() {
    super.initState();

    _googleSignIn.signInSilently().then((_account) => {
      if (_account == null) throw FirstSignInException
      else setState(() { account = _account; }),
      initiate()
    }).catchError((e) => {
      // _googleSignIn.signIn().then((_account) async {
      //   setState(() { account = _account; });
      //   initiate();
      // }).catchError((e) => print(e))
      setState((){
        content = Center(
          child: ElevatedButton(
            child: Text("click to login google"),
            onPressed: (){
              _googleSignIn.signIn().then((_account) async {
                setState(() { account = _account; });
                initiate();
              }).catchError((e) => print(e));
            },
          ),
        );
      })
    });
  }

  Future<void> update() async {
    Map<String, dynamic> json = google_drive_data?.toJson() ?? {};
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    // print(app_user?.user_firebase?.uid);
    // firestore.collection('Google_drive_data').where(
    //   'user',
    //   isEqualTo: app_user?.user_firebase?.uid ?? 'undefined'
    // ).where(
    //   ''
    // )

    
  }

  Future<void> upload_to_firebase() async{
    Map<String, dynamic> json = google_drive_data?.toJson() ?? {};
    // json.addAll({'user': app_user?.user_firebase?.uid});
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    // print(app_user?.user_firebase?.uid);
    firestore.collection('Google_drive_data').doc().set(json);
    // firestore.collection('Users').doc().collection('test').doc().set({'test': 'test'});
  }

  Widget content = Stack(
    children: [
      Container(
        padding: const EdgeInsets.all(10),
        width: 350,
        // height: 150,
        child: Column(
          children: [
            Blocks(
              drive_name: 'Google Drive',
              icon: Image.network(
                GOOGLE_DRIVE_ICON,
              ),
            ),
          ],
        ),
      ),
      BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
        child: Center(child: CircularProgressIndicator()),
      )
    ]
  );

  @override
  Widget build(BuildContext context) {
    return content;
  }
}

