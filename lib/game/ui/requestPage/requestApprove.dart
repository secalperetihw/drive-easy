import 'package:drive_easy/classes/game/item.dart';
import 'package:drive_easy/classes/game/progress.dart';
import 'package:drive_easy/game/ui/requestPage/requestClasses.dart';
import 'package:flutter/material.dart';
import 'package:overlay_tutorial/overlay_tutorial.dart';

class requestApprove extends StatefulWidget {
  double contentHeight;
  double contentWidth;
  Function callback;
  Item item;
  ValueChanged<Item> itemCallback;
  bool isTutorialEnabled;
  List<bool> isTutorialOn;
  List<OverlayTutorialRectEntry> tutorialOverlaysEntries;
  ValueChanged<Map> tutorialCallback;
  Progress progress;

  requestApprove({ 
    required this.contentHeight,
    required this.contentWidth,
    required this.callback,
    required this.item,
    required this.itemCallback,
    required this.isTutorialEnabled,
    required this.isTutorialOn,
    required this.tutorialOverlaysEntries,
    required this.tutorialCallback,
    required this.progress,
    Key? key 
  }) : super(key: key);

  @override
  State<requestApprove> createState() => _requestApproveState();
}

class _requestApproveState extends State<requestApprove> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.contentWidth,
      height: widget.contentHeight,
      alignment: Alignment.center,
      child: Wrap(
        alignment: WrapAlignment.center,
        children: [
          Container(
            width: widget.contentWidth * 0.6,
            height: widget.contentHeight,
            alignment: Alignment.center,
            child: RichText(
              textAlign: TextAlign.center,
              text: TextSpan(children: [
                TextSpan(text: "Are you sure to approve the request? \n\n", style: TextStyle(color: Colors.red, fontSize: 20),),
                TextSpan(text: "Wrong or malicious request will result in punishment of scores, continue?", style: TextStyle(color: Colors.grey, fontSize: 12)),
              ]),
            ),
          ),
          Container(
            width: widget.contentWidth * 0.3,
            height: widget.contentHeight,
            alignment: Alignment.center,
            child: Wrap(
              alignment: WrapAlignment.center,
              children: [
                Text("", style: TextStyle(color: Colors.white)),
                OverlayTutorialHole(
                  enabled: (widget.isTutorialEnabled) ? widget.isTutorialOn[13] : false,
                  overlayTutorialEntry: widget.tutorialOverlaysEntries[13],
                  child: OverlayTutorialHole(
                    enabled: (widget.isTutorialEnabled) ? widget.isTutorialOn[2] : false,
                    overlayTutorialEntry: widget.tutorialOverlaysEntries[2],
                    child: requestPageButton(
                      width: widget.contentWidth * 0.3,
                      height: widget.contentHeight * 0.1,
                      onPressed: (value){
                        widget.item.finish = true;
                        widget.item = Check(widget.item);
                        widget.itemCallback(widget.item);
                        if (widget.isTutorialEnabled && widget.isTutorialOn[2]) {
                          setState(() {
                            widget.isTutorialOn[2] = false;
                            widget.isTutorialOn[3] = true;
                
                            widget.tutorialCallback({"isTutorialOn": widget.isTutorialOn});
                          });
                        } else if (widget.isTutorialEnabled && widget.isTutorialOn[13]) {
                          setState(() {
                            widget.isTutorialOn[13] = false;
                            widget.isTutorialOn[14] = true;
                
                            widget.tutorialCallback({"isTutorialOn": widget.isTutorialOn});
                          });
                        }
                        
                        Navigator.pop(context);
                      }, 
                      text: "Done"
                    ),
                  ),
                ),
                requestPageButton(
                  width: widget.contentWidth * 0.3,
                  height: widget.contentHeight * 0.1,
                  onPressed: (value){
                    widget.callback();
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

  Item Check(item) {
    Map<String, bool>? map = widget.item.getFields;
    Map<String, bool>? initMap = item.getInitField;
    bool check = true;
    int score = 0;


    map?.forEach((key, value) { 
      if (value == false) {
        check = false;
      }
    });
    if (check) score+=2;

    initMap?.forEach((key, value) {
      if (value == false) {
        print(key);
        if (map?[key] != value) {
          score++;
        }
      }
    });

    item.success = check;
    item.score = score;

    return item;
  }
}