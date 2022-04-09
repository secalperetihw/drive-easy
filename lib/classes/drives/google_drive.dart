import 'package:drive_easy/classes/method/pickfile.dart';
import 'package:drive_easy/customException.dart';
import 'package:drive_easy/global.dart';
import 'package:flutter/material.dart';
import 'drives.dart';
import 'package:googleapis/drive/v3.dart';
import 'dart:io' as io;
import 'package:path/path.dart' as path;

class Google_drive_data extends Drive_data{
  // GoogleSignInAccount? googleSignInAccount;
  String? email;

  Google_drive_data({
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

  Future<List<String>?> _initFolder({
    required DriveApi? driveApi,
  }) async {
    List<String> ref = [];
    await driveApi?.files.list(
      q: "mimeType = 'application/vnd.google-apps.folder' and name = 'Drive-Easy'",
      $fields: "files(id, name)"
    ).then((value) async {
      if (value.files?.isEmpty ?? false){
        File metadata = File(
          name: "Drive-Easy",
          mimeType: "application/vnd.google-apps.folder",
        );
        await driveApi.files.create(metadata).then((value) => {
          ref.add(value.id ?? ""),
        });
      } else {
        ref.add(value.files?.first.id ?? "");
      }
    });

    return ref;
  }

  Future<bool> _processDirectory({
    required DriveApi driveApi,
    required List<String>? ref,
    required io.File file,
  }) async {
    io.Directory dir = io.Directory.fromUri(file.absolute.uri);

    print("ref now: $ref");

    String basename = path.basename(file.path);
    File metadata = File(
      name: basename,
      parents: ref,
      mimeType: "application/vnd.google-apps.folder"
    );
    List<String>? newRef = [];
    await driveApi.files.create(metadata).then((value) => {
      newRef.add(value.id ?? "")
    });
    

    for(var item in dir.listSync()){
      io.File f = io.File(item.absolute.path);
      bool isDirectory = await io.Directory.fromUri(item.absolute.uri).exists();
      if (isDirectory){
        print("_processDirectory isDirectory");
        
        print(newRef);
        if (newRef == null) throw pickException();
        await _processDirectory(driveApi: driveApi, ref: newRef, file: f);
      } else {
        print("_processDirectory notDirectory");
        await _handleUpload(driveApi: driveApi, ref: newRef, file: f);
      }
    }

    return true;
  }

  Future<void> _handleUpload({
    required DriveApi driveApi,
    required List<String>? ref,
    required io.File file,
  }) async {
    File driveFile = File();
    driveFile.parents = ref;
    driveFile.name = path.basename(file.absolute.path);
    
    var response = await driveApi.files.create(  
      driveFile,  
      uploadMedia: Media(file.openRead(), file.lengthSync()),  
    ).then((value) async =>  {
      snackbarKey.currentState?.showSnackBar( const SnackBar(
          content: Text('Upload successed!')
        ),
      ),
    }).catchError((e) => {
      snackbarKey.currentState?.showSnackBar( const SnackBar(
          content: Text('Upload failed, please try again.')
        ),
      )
    });  
  }

  Future<bool?> upload({
    required DriveApi? driveApi,
    required BuildContext context,
  }) async {
    if(driveApi == null) return false;

    // Select folder 'Drive-Easy' to continue
    // if not exist, create one.
    var dismiss;
    showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext ctx) { 
        
        dismiss = ctx;
        return Center(child: CircularProgressIndicator(),);
      }
    );
    List<String>? ref = await _initFolder(driveApi: driveApi).catchError((e) => throw uploadException) ?? [];
    Navigator.pop(dismiss);
    
    // Pick files from local
    bool exit = false;
    List<io.File> files = [];
    try{
      files = await pickFileFromLocal(
        context: context, 
      );
    } on pickException catch (e){
      print(e);
      exit = true;
    }
    if(files.isEmpty) return false;

    // Confirm user operation
    exit = await confirmPick(context: context);
    if(!exit) return false;

    
    // Perform upload
    showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext ctx) { 
        
        dismiss = ctx;
        return Center(child: CircularProgressIndicator(),);
      }
    );
    for(io.File file in files){
      bool isDirectory = await io.Directory.fromUri(file.absolute.uri).exists();
      if(isDirectory){
        print("isDirectory");
        bool success = await _processDirectory(driveApi: driveApi, ref: ref, file: file);
        // return success;
      } else {
        await _handleUpload(driveApi: driveApi, ref: ref, file: file);
      }
    }
    Navigator.pop(dismiss);

    return true;
  }
  
  @override
  Map<String, dynamic> toJson(){
    return {
      'account_name': account_name ?? 'undefined',
      'email': email ?? 'undefined',
      'capacity': capacity ?? 'undefined',
      'used': used ?? 'undefined',
      'left': left ?? 'undefined',
      'status': status ?? 'undefined',
      // 'data': (data as About?)?.toString() ?? '',
      // 'googleSignInAccount': googleSignInAccount ?? 'undefined',
    };
  }

  @override
  String toString(){
    return 'account_name: ' + account_name.toString() + ', ' 
    + 'email: ' + email.toString() + ', ' 
    + 'capacity: ' + capacity.toString() + ', ' 
    + 'used: ' + used.toString() + ', ' 
    + 'left: ' + left.toString() + ', ' 
    + 'status: ' + status.toString() + ', ' 
    + 'data: ' + data.toString() + ', '
    // + 'googleSignInAccount: ' + googleSignInAccount.toString() + ', '
    + '\n';
  }
}