import 'dart:io' as io;
import 'package:file_picker/file_picker.dart' as fp;
import 'package:drive_easy/classes/ui/chooseFileType.dart';
import 'package:drive_easy/customException.dart';
import 'package:drive_easy/global.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

Future<dynamic> pickFileFromLocal({
  required BuildContext context,
}) async{
  PickFileType? fileType;

  await showDialog<void>(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext ctx) { 
    
      return ChooseFileType(
        ctx: ctx,
        onPickFileTypeChanged: (value) => {
          fileType = value
        },
      );
    }
  );
  if (fileType == null) throw pickException();

  List<io.File> file = [];
  
  if (fileType == PickFileType.file){
    fp.FilePickerResult? result = await fp.FilePicker.platform.pickFiles(
      type: fp.FileType.any,
      allowMultiple: true,
      onFileLoading: (fp.FilePickerStatus status) => print(status),

    );
    if (result != null) {
      // print(result.files.single.path!);
      for (var item in result.files){
        file.add(io.File(item.path!));
      }
      
    } else {
      throw pickException();
    }
  } else if (fileType == PickFileType.image){
    final ImagePicker _picker = ImagePicker();
    final List<XFile>? images = await _picker.pickMultiImage();
    try { 
      for(XFile image in images!){
        file.add(io.File(image.path)); 
      }
    }
    catch (e) { print(e); throw pickException();}
  } 
  else if (fileType == PickFileType.video){
    final ImagePicker _picker = ImagePicker();
    final XFile? image = await _picker.pickVideo(source: ImageSource.gallery);
    try { file.add(io.File(image!.path)); }
    catch (e) { print(e); throw pickException();}
  } else if (fileType == PickFileType.cameraImage){
    final ImagePicker _picker = ImagePicker();
    final XFile? image = await _picker.pickImage(source: ImageSource.camera);
    try { file.add(io.File(image!.path)); }
    catch (e) { print(e); throw pickException();}
  } else if (fileType == PickFileType.cameraVideo){
    final ImagePicker _picker = ImagePicker();
    final XFile? image = await _picker.pickVideo(source: ImageSource.camera);
    try { file.add(io.File(image!.path)); }
    catch (e) { print(e); throw pickException();}
  } else if (fileType == PickFileType.folder){
    String? selectedDirectory = await fp.FilePicker.platform.getDirectoryPath();
    if (selectedDirectory == null) throw pickException();
    try { file.add(io.File(selectedDirectory)); }
    catch (e) { print(e); throw pickException();}
  }
  return file;
}

Future<bool> confirmPick({
  required BuildContext context,
}) async {
  bool upload = false;
  await showDialog<void>(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext ctx) { 
      
      return AlertDialog(
        title: Text("Upload Files"),
        content: Text("Are you sure to upload these files?"),
        actions: [
          TextButton(
            onPressed:(){
              upload = true;
              Navigator.pop(context);
            }, 
            child: Text("Yes")
          ),
          TextButton(
            onPressed:(){
              upload = false;
              Navigator.pop(context);
            }, 
            child: Text("No")
          )
        ],
      );
    }
  );

  return upload;
}