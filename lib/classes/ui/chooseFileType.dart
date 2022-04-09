import 'package:drive_easy/global.dart';
import 'package:flutter/material.dart';

class ChooseFileType extends StatefulWidget {
  final ValueChanged<PickFileType> onPickFileTypeChanged;
  final BuildContext ctx;

  const ChooseFileType({
    Key? key,
    required this.onPickFileTypeChanged,
    required this.ctx, 
  }) : super(key: key);

  @override
  State<ChooseFileType> createState() => _ChooseFileTypeState();
}

class _ChooseFileTypeState extends State<ChooseFileType> {
  String? type;
  int displayvalue = 0;

  @override
  Widget build(BuildContext context) {
    
    return AlertDialog(
      title: Text("Choose file type"),
      content: DropdownButton(
        value: displayvalue,
        onChanged: (int? value){
          // type = value.toString();
          setState(() {
            displayvalue = value ?? 0;
          });
          
        },
        items: const [
          DropdownMenuItem(
            value: 0,
            child: Text("File")
          ),
          DropdownMenuItem(
            value: 1,
            child: Text("images")
          ),
          DropdownMenuItem(
            value: 2,
            child: Text("videos")
          ),
          DropdownMenuItem(
            value: 3,
            child: Text("Image from camera")
          ),
          DropdownMenuItem(
            value: 4,
            child: Text("Video from camera")
          ),
          DropdownMenuItem(
            value: 5,
            child: Text("Folder")
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed:(){
            widget.onPickFileTypeChanged(PickFileType.values[displayvalue]);

            Navigator.pop(widget.ctx);
          }, 
          child: Text("Continue")
        ),
        TextButton(
          onPressed:(){
            Navigator.pop(widget.ctx);
          }, 
          child: Text("Cancel")
        )
      ],
    );
  }
}

