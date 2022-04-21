import 'package:drive_easy/classes/game/item.dart';
import 'package:drive_easy/classes/game/progress.dart';
import 'package:drive_easy/game/ui/requestPage/request.dart';
import 'package:flutter/material.dart';
import 'package:overlay_tutorial/overlay_tutorial.dart';

class GameBoardPage extends StatefulWidget {
  Progress progress;
  ValueChanged<Duration> timeCallback;
  ValueChanged<Item> itemCallback;
  bool isTutorialEnabled;
  List<bool> isTutorialOn;
  List<OverlayTutorialRectEntry> tutorialOverlaysEntries;
  ValueChanged<Map> tutorialCallback;
  ValueChanged<Progress> progressCallback;
  DateTime timeNow;

  GameBoardPage({
    required this.progress,
    required this.timeCallback,
    required this.itemCallback,
    required this.isTutorialEnabled,
    required this.isTutorialOn,
    required this.tutorialOverlaysEntries,
    required this.tutorialCallback,
    required this.timeNow,
    required this.progressCallback,
    Key? key,
  }) : super(key: key);

  @override
  State<GameBoardPage> createState() => _GameBoardPageState();
}

class _GameBoardPageState extends State<GameBoardPage> {
  Widget _callRequestPage = Container();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      alignment: WrapAlignment.center,
      children: [
        Container(
          height: MediaQuery.of(context).size.height * 0.1,
          width: MediaQuery.of(context).size.width,
          child: Center(child: Text("Total Score: ${widget.progress.scoreCount().toString()}/${widget.progress.totalScoreCount().toString()}", style: TextStyle(color: Colors.white,)))
        ),
        Container( 
          height: MediaQuery.of(context).size.height * 0.7,
          width: MediaQuery.of(context).size.width * 0.8,
          decoration: BoxDecoration(
            color: Colors.transparent,
            border: Border.all(width: 1, color: Colors.white)
          ),
          child: 
          ListView (
            children: [
              Wrap(
                alignment: WrapAlignment.spaceEvenly,
                children: widget.progress.requests?.map((e) {
                  _callRequestPage = Container(
                    padding: EdgeInsets.all(10),
                    child: GestureDetector(
                      onTap: () async {
                        
                        await Navigator.push(context, MaterialPageRoute(builder: (context) => RequestMainPage(
                          progressCallback: (value) {
                            setState(() {
                              widget.progress = value;
                              widget.progressCallback(value);
                            });
                          },
                          tutorial: (widget.progress.tutorial!["FirstPlay"]! && widget.progress.level == 0) 
                          ? true 
                          : (widget.progress.tutorial!["Authorization"]! && widget.progress.level == 1)
                            ? true
                            : (widget.progress.tutorial!["Data"]! && widget.progress.level == 2)
                              ? true
                              : false,
                          tutorialOffset: (e.reqId is String) ? int.parse(e.reqId) : e.reqId,
                          itemCallback: (value) {
                            setState(() {
                              e = value;
                            });
                          },
                          progress: widget.progress,
                          item: e,
                          timeNow: widget.timeNow,
                        )));
                        if (e.finish ?? false)  {
                          if(e.checking ?? false) return;
                          setState(() {
                            e.checking = true;
                            widget.timeCallback(e.timeNeeded!);
                            widget.itemCallback(e);
                          });
                        }
                        if (widget.isTutorialEnabled) {
                          setState(() {
                            int id = 0;
                            if (e.reqId == 0) id=2;
                            else if (e.reqId == 1) id=3;
                            else if (e.reqId.toString() == "999") id=4;
                            if (widget.isTutorialOn[id] == true) {
                              widget.isTutorialOn[id] = false;
                              widget.isTutorialOn[id + 1] = true;
                            }
                            widget.tutorialCallback({
                              "isTutorialOn": widget.isTutorialOn,
                            });
                          });
                        }
                      },
                      child: Container(
                        padding: EdgeInsets.all(15),
                        decoration: BoxDecoration(
                          color: Colors.black, 
                          border: Border.all(
                            width: 1, 
                            color: (e.finish ?? false) ? ( (e.success ?? false) ? Colors.green : Colors.red) : Colors.white
                          )
                        ),
                        child: Column(
                          children: [
                            RichText(text: TextSpan(style: TextStyle(color: (e.finish ?? false) ? Colors.grey : Colors.white), children: [
                              TextSpan(text: "request: ", style: TextStyle(color: Colors.grey)),
                              TextSpan(text: "${e.name}\n"),
                              TextSpan(text: "ID: ", style: TextStyle(color: Colors.grey)),
                              TextSpan(text: "${e.reqId.toString()}\n"),
                              TextSpan(text: "Task: ", style: TextStyle(color: Colors.grey)),
                              TextSpan(text: "${Item.convert(e.reqType)}\n"),
                              TextSpan(text: "Time needed: ", style: TextStyle(color: Colors.grey)),
                              TextSpan(text: "${e.timeNeeded?.inHours.toString()} hours\n"),
                              
                            ]),),
                            if (e.finish ?? false) ...[
                              RichText(text: TextSpan(style: TextStyle(color: (e.finish ?? false) ? Colors.grey : Colors.white), children: [
                                TextSpan(text: "Score: ", style: TextStyle(color: Colors.grey)),
                                TextSpan(text: "${
                                  (e.finish ?? false) ? e.score : 0
                                }/${
                                  (e.finish ?? false) ? e.totalScore : 0
                                }"),
                              ]),),
                            ],
                          ],
                        )
                      ),
                    ),
                  );
                  if (e.reqId == 0) {
                    return OverlayTutorialHole(
                      enabled: (widget.isTutorialEnabled) ? widget.isTutorialOn[2] : false,
                      overlayTutorialEntry: widget.tutorialOverlaysEntries[2],
                      child: _callRequestPage,
                    );
                  } else if (e.reqId == 1) {
                    return OverlayTutorialHole(
                      enabled: (widget.isTutorialEnabled) ? widget.isTutorialOn[3] : false,
                      overlayTutorialEntry: widget.tutorialOverlaysEntries[3],
                      child: _callRequestPage,
                    );
                  } else if (e.reqId == 999.toString()) {
                    return OverlayTutorialHole(
                      enabled: (widget.isTutorialEnabled) ? widget.isTutorialOn[4] : false,
                      overlayTutorialEntry: widget.tutorialOverlaysEntries[4],
                      child: _callRequestPage,
                    );
                  } else {
                    return _callRequestPage;
                  }
                }).toList() as List<Widget>
                  
                
              ),
            ],
          ),
        ),
      ],
    );
  }
}
