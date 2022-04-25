import 'package:drive_easy/classes/game/item.dart';
import 'package:drive_easy/classes/game/progress.dart';
import 'package:drive_easy/global.dart';
import 'package:flutter/material.dart';

class GameMakeRequest extends StatefulWidget {
  Progress progress;
  double contentHeight;
  double contentWidth;
  ValueChanged<Map> callback;

  GameMakeRequest({ 
    Key? key,
    required this.progress,
    required this.contentHeight,
    required this.contentWidth,
    required this.callback,
  }) : super(key: key);

  @override
  State<GameMakeRequest> createState() => _GameMakeRequestState();
}

class _GameMakeRequestState extends State<GameMakeRequest> {
  Map<String, bool> displayvalue = {
    "Request Type": false,
    "File Type": false,
    "Source": false,
    "Destination": false,
    "Encryption": false,
    "Action": false,
  };

  Map<String, List<dynamic>> displayString = {
    "Request Type": RequestType.values.map((e) => Item.convert(e)).toList(),
    "File Type": FileType.values.map((e) => Item.convert(e)).toList(),
    "Source": Drives.values.map((e) => Item.convert(e)).toList(),
    "Destination": Drives.values.map((e) => Item.convert(e)).toList(),
    "Encryption": Encryption.values.map((e) => Item.convert(e)).toList(),
    "Action": ActionType.values.map((e) => Item.convert(e)).toList(),
  };

  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.contentHeight,
      width: widget.contentWidth,
      decoration: BoxDecoration(
        color: Colors.transparent,
        border: Border.all(width: 1, color: Colors.white)
      ),
      child: Wrap(children: displayString.values.map((entries) => DropdownButton(
        items: entries.map((element) => DropdownMenuItem(
          value: displayvalue[displayvalue.keys.where((element) => element == displayString.keys.elementAt(displayString.values.toList().indexOf(entries)))],
          child: Text(element)
        )).toList(), 
        onChanged: (value) {

        },
        selectedItemBuilder: (ctx) {
          return entries.map((e) => Container(
            width: widget.contentWidth * 0.3,
            decoration: BoxDecoration(
              // border: Border(bottom: BorderSide(width: 1.0, color: Colors.grey))
            ),
            padding: EdgeInsets.all(1),
            child: Center(child: Text(e, style: TextStyle(color: Colors.grey), overflow: TextOverflow.ellipsis,)),
          )).toList();
        },
      )).toList()
        // DropdownButton(
        //   value: displayvalue,
        //   // onChanged: (int? value){
        //   //   setState(() {
        //   //     displayvalue = value ?? 0;
        //   //   });
        //   // },
        //   items: displayString[""]?.map((e) => DropdownMenuItem(
        //     value: displayvalue[displayvalue.keys.where((element) => element == e)],
        //     child: Text(e)
        //   )).toList(),
        //   selectedItemBuilder: (ctx) {
        //     return scopes.map((e) => Container(
        //       width: widget.contentWidth * 0.3,
        //       decoration: BoxDecoration(
        //         // border: Border(bottom: BorderSide(width: 1.0, color: Colors.grey))
        //       ),
        //       padding: EdgeInsets.all(1),
        //       child: Center(child: Text(e, style: TextStyle(color: Colors.grey), overflow: TextOverflow.ellipsis,)),
        //     )).toList();
        //   },
        // ),
      )
    );
  }
}