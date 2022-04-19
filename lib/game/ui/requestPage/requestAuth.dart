import 'dart:math';

import 'package:drive_easy/classes/game/item.dart';
import 'package:drive_easy/game/ui/requestPage/requestClasses.dart';
import 'package:drive_easy/global.dart';
import 'package:flutter/material.dart';
import 'package:overlay_tutorial/overlay_tutorial.dart';

class requestAuth extends StatefulWidget {
  Item item;
  Function backButton;
  ValueChanged<Item> itemCallback;
  ValueChanged<Widget> annoncementCallback;
  double contentHeight;
  double contentWidth;
  bool isTutorialEnabled;
  List<bool> isTutorialOn;
  List<OverlayTutorialRectEntry> tutorialOverlaysEntries;
  ValueChanged<Map> tutorialCallback;

  requestAuth({ 
    required this.itemCallback,
    required this.item,
    required this.backButton,
    required this.contentHeight,
    required this.contentWidth,
    required this.annoncementCallback,
    required this.isTutorialEnabled,
    required this.isTutorialOn,
    required this.tutorialOverlaysEntries,
    required this.tutorialCallback,
    Key? key 
  }) : super(key: key);

  @override
  State<requestAuth> createState() => _requestAuthState();
}

class _requestAuthState extends State<requestAuth> {
  Map<String, bool> chosenType = {
    "POST": false,
    "GET": false,
  };
  String? type;
  int displayvalue = 0;
  int displayRequestType = 0;

  List<String> scopes = [
    "Read only",
    "Write to app folder",
    "Metadata only",
    "All access",
  ];

  List<String> httpType = ["GET", "POST", "PUT", "DELETE", "PATCH"];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 50),
      child: Wrap(
        // crossAxisAlignment: CrossAxisAlignment.end,
        // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        verticalDirection: VerticalDirection.down,
        children: [
          Container(
            width: widget.contentWidth * 0.3,
            height: widget.contentHeight * 0.5,
            child: Wrap(
              alignment: WrapAlignment.center,
              children: [
                Text("Request: ", style: TextStyle(color: Colors.white)),
                OverlayTutorialHole(
                  enabled: (widget.isTutorialEnabled) ? widget.isTutorialOn[15] : false,
                  overlayTutorialEntry: widget.tutorialOverlaysEntries[15],
                  child: DropdownButton(
                    value: displayRequestType,
                    onChanged: (int? value){
                      // type = value.toString();
                      setState(() {
                        if (widget.isTutorialEnabled && widget.isTutorialOn[15]) {
                          widget.isTutorialOn[15] = false;
                          widget.isTutorialOn[16] = true;
                          widget.tutorialCallback({"isTutorialOn": widget.isTutorialOn});
                        }

                        displayRequestType = value ?? 0;
                      });
                      
                    },
                    items: ActionType.values.map((e) => DropdownMenuItem(
                        value: ActionType.values.indexOf(e),
                        child: Text(Item.convert(e))
                      )).toList(),
                    selectedItemBuilder: (ctx) {
                      return ActionType.values.map((e) => Container(
                        width: widget.contentWidth * 0.2,
                        decoration: BoxDecoration(
                          // border: Border(bottom: BorderSide(width: 1.0, color: Colors.grey))
                        ),
                        padding: EdgeInsets.all(1),
                        child: Center(child: Text(Item.convert(e), style: TextStyle(color: Colors.grey), overflow: TextOverflow.ellipsis,)),
                      )).toList();
                    },
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: widget.contentWidth * 0.4,
            child: Wrap(
              alignment: WrapAlignment.center,
              children: [
                Text("Scope: ", style: TextStyle(color: Colors.white)),
                OverlayTutorialHole(
                  enabled: (widget.isTutorialEnabled) ? widget.isTutorialOn[16] : false,
                  overlayTutorialEntry: widget.tutorialOverlaysEntries[17],
                  child: DropdownButton(
                    value: displayvalue,
                    onChanged: (int? value){
                      setState(() {
                        displayvalue = value ?? 0;
                      });
                    },
                    items: scopes.map((e) => DropdownMenuItem(
                      value: scopes.indexOf(e),
                      child: Text(e)
                    )).toList(),
                    selectedItemBuilder: (ctx) {
                      return scopes.map((e) => Container(
                        width: widget.contentWidth * 0.3,
                        decoration: BoxDecoration(
                          // border: Border(bottom: BorderSide(width: 1.0, color: Colors.grey))
                        ),
                        padding: EdgeInsets.all(1),
                        child: Center(child: Text(e, style: TextStyle(color: Colors.grey), overflow: TextOverflow.ellipsis,)),
                      )).toList();
                    },
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: widget.contentWidth * 0.3,
            height: widget.contentHeight * 0.5,
            child: Wrap(
              alignment: WrapAlignment.center,
              children: [
                Text("Hidden^^", style: TextStyle(color: Colors.black)),
                requestPageButton(
                  width: widget.contentWidth * 0.3,
                  height: widget.contentHeight * 0.1,
                  onPressed: (value){
                    setState(() {
                      if (widget.item.authorized ?? false) {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: const Text("Already authorized."),
                          duration: const Duration(seconds: 3),
                          action: SnackBarAction(
                            label: 'OK',
                            onPressed: () { },
                          ),
                        ));
                        return;
                      }
                      if (!Check()) {
                        widget.item.authFailed = true;
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: const Text("Wrong request. You can auth again but won't get score."),
                          duration: const Duration(seconds: 3),
                          action: SnackBarAction(
                            label: 'OK',
                            onPressed: () { },
                          ),
                        ));
                        return;
                      }
                      
                      if (!(widget.item.authFailed ?? false)) {
                        widget.item.score = widget.item.score! + 1;
                      }
                      widget.item.authorized = true;
                      widget.itemCallback(widget.item);


                      widget.item.setResult(widget.item.authSituation, context);
                      if (widget.item.authSituation == 1) {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: const Text("Authorization: User refuse."),
                          duration: const Duration(seconds: 3),
                          action: SnackBarAction(
                            label: 'OK',
                            onPressed: () { },
                          ),
                        ));
                      } else if (widget.item.authSituation == 2) {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: const Text("Authorization: Request timeout."),
                          duration: const Duration(seconds: 3),
                          action: SnackBarAction(
                            label: 'OK',
                            onPressed: () { },
                          ),
                        ));
                      }
                      widget.annoncementCallback(
                        widget.item.getAuthResult
                      );
                    });
                  }, 
                  text: "Send"
                ),
                requestPageButton(
                  width: widget.contentWidth * 0.3,
                  height: widget.contentHeight * 0.1,
                  onPressed: (value){
                    widget.backButton();
                  }, 
                  text: "Back"
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  bool Check() {
    if (ActionType.values[displayRequestType] != widget.item.action) return false;
    if (widget.item.action == ActionType.GET && displayvalue == 0) return true;
    if (widget.item.action == ActionType.POST && displayvalue == 1) return true;

    return false;
  }

}

