import 'package:drive_easy/classes/game/item.dart';
import 'package:drive_easy/classes/game/progress.dart';
import 'package:drive_easy/game/ui/requestPage/requestClasses.dart';
import 'package:flutter/material.dart';
import 'package:overlay_tutorial/overlay_tutorial.dart';

class requestDeny extends StatefulWidget {
  Item item;
  ValueChanged<Item> itemCallback;
  Function callback;
  double contentHeight;
  double contentWidth;
  bool isTutorialEnabled;
  List<bool> isTutorialOn;
  List<OverlayTutorialRectEntry> tutorialOverlaysEntries;
  ValueChanged<Map> tutorialCallback;
  Progress progress;

  requestDeny({ 
    required this.item,
    required this.itemCallback,
    required this.callback,
    required this.contentHeight,
    required this.contentWidth,
    required this.isTutorialEnabled,
    required this.isTutorialOn,
    required this.tutorialOverlaysEntries,
    required this.tutorialCallback,
    required this.progress,
    Key? key 
  }) : super(key: key);

  @override
  State<requestDeny> createState() => _requestDenyState();
}

class _requestDenyState extends State<requestDeny> {
  List<String> reasons = [
    "Request ID incorrect",
    "Unmatch type and action",
    "Wrong file type",
    "Mysterious source",
    "Undefined destination",
    "Unsafe encryption",
    "Session Expired",
    "Others",
  ];

  List<bool> _listOfBool = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    for (int i=0; i<reasons.length; i++){
      _listOfBool.add(false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(5),
      width: widget.contentWidth,
      height: widget.contentHeight,
      alignment: Alignment.center,
      child: Wrap(
        alignment: WrapAlignment.center,
        // verticalDirection: VerticalDirection.down,
        children: [
          Container(
            width: widget.contentWidth * 0.6,
            height: widget.contentHeight * 0.7,
            child: Wrap(
              alignment: WrapAlignment.center,
              children: [
                Container(
                  alignment: Alignment.center,
                  width: widget.contentWidth * 0.6,
                  padding: EdgeInsets.only(top: 5, bottom: 5),
                  child: Text("What's wrong?", style: TextStyle(color: Colors.white))
                ),
                Container(
                  width: widget.contentWidth * 0.6,
                  height: widget.contentHeight * 0.7,
                  child: MediaQuery.removePadding(
                    context: context,
                    removeTop: true,
                    child: ListView.builder(
                      itemCount: reasons.length,
                      itemBuilder: ((context, index) {
                        if (index == 3) {
                          return OverlayTutorialHole(
                            enabled: (widget.isTutorialEnabled) ? widget.isTutorialOn[9] : false,
                            overlayTutorialEntry: widget.tutorialOverlaysEntries[9],
                            child: requestPageButton(
                              chosen: _listOfBool[index],
                              padding: EdgeInsets.all(0),
                              onPressed: (value){
                                setState(() {
                                  _listOfBool[index] = value;
                                });
                                if (widget.isTutorialEnabled && widget.isTutorialOn[9]) {
                                  setState(() {
                                    widget.isTutorialOn[9] = false;
                                    widget.isTutorialOn[10] = true;

                                    widget.tutorialCallback({"isTutorialOn": widget.isTutorialOn});
                                  });
                                }
                              },
                              text: reasons[index],
                            ),
                          );
                        } else {
                          return requestPageButton(
                            chosen: _listOfBool[index],
                            padding: EdgeInsets.all(0),
                            onPressed: (value){
                              setState(() {
                                _listOfBool[index] = value;
                              });
                            },
                            text: reasons[index],
                          );
                        }
                      })
                    ),
                  )
                )
              ],
            ),
          ),
          Container(
            width: widget.contentWidth * 0.3,
            height: widget.contentHeight * 0.1,
            child: Wrap(
              alignment: WrapAlignment.center,
              children: [
                Text("", style: TextStyle(color: Colors.white)),
                OverlayTutorialHole(
                  enabled: (widget.isTutorialEnabled) ? widget.isTutorialOn[10] : false,
                  overlayTutorialEntry: widget.tutorialOverlaysEntries[10],
                  child: requestPageButton(
                    width: widget.contentWidth * 0.3,
                    height: widget.contentHeight * 0.1,
                    onPressed: (value){
                      bool check = false;
                      _listOfBool.forEach((element) { 
                        if(element) check = true;
                      });
                
                      if (!check) {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: const Text("Please choose at least a reason."),
                          duration: const Duration(seconds: 3),
                          action: SnackBarAction(
                            label: 'OK',
                            onPressed: () { },
                          ),
                        ));
                        return;
                      }
                
                      widget.item.finish = true;
                      widget.item = Check(widget.item);
                      
                      widget.itemCallback(widget.item);

                      if (widget.isTutorialEnabled && widget.isTutorialOn[10]) {
                        setState(() {
                          widget.isTutorialOn[10] = false;
                          widget.isTutorialOn[11] = true;

                          widget.tutorialCallback({"isTutorialOn": widget.isTutorialOn});
                        });
                      }

                      Navigator.pop(context);
                    }, 
                    text: "Done"
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

  Item Check(Item item) {
    Map<String, bool>? map = item.getFields;
    Map<String, bool>? initMap = item.getInitField;
    bool check = false;
    int score = 0;

    map?.forEach((key, value) { 
      if (value == false) {
        check = true;
      }
    });

    for (int i=0; i<map!.length; i++) {
      if (i==7) {
        map[map.keys.elementAt(i)] = !_listOfBool[1];
      } else if (i==8) {
        map[map.keys.elementAt(8)] = !_listOfBool[7];
      } else {
        map[map.keys.elementAt(i)] = !_listOfBool[i];
      }
    }
    if (check) score++;

    initMap?.forEach((key, value) {
      if (value == false) {
        if (map[key] != value) {
          score++;
        }
      }
    });

    item.success = check;
    item.score = score;

    return item;
  }
}