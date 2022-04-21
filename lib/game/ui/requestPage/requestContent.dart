import 'package:drive_easy/classes/game/item.dart';
import 'package:drive_easy/classes/game/progress.dart';
import 'package:drive_easy/game/game_home.dart';
import 'package:drive_easy/game/ui/requestPage/requestApprove.dart';
import 'package:drive_easy/game/ui/requestPage/requestAuth.dart';
import 'package:drive_easy/game/ui/requestPage/requestClasses.dart';
import 'package:drive_easy/game/ui/requestPage/requestDeny.dart';
import 'package:flutter/material.dart';
import 'package:jiffy/jiffy.dart';
import 'package:overlay_tutorial/overlay_tutorial.dart';

class requestContents extends StatefulWidget {
  GameMain? game;
  Item item;
  Progress progress;
  ValueChanged<Item> callback;
  ValueChanged<int> pageCallback;
  ValueChanged<bool> dataCallback;  
  ValueChanged<Item> itemCallback;
  int? page;
  double contentHeight;
  double contentWidth;
  bool isTutorialEnabled;
  List<bool> isTutorialOn;
  List<OverlayTutorialRectEntry> tutorialOverlaysEntries;
  ValueChanged<Map> tutorialCallback;
  ValueChanged<Widget> annoncementCallback;
  int? displaylevel;

  requestContents({
    required this.game,
    required this.item,
    required this.progress,
    required this.callback,
    required this.contentHeight,
    required this.contentWidth,
    required this.pageCallback,
    required this.dataCallback,
    required this.itemCallback,
    required this.isTutorialEnabled,
    required this.isTutorialOn,
    required this.tutorialOverlaysEntries,
    required this.tutorialCallback,
    required this.annoncementCallback,
    this.page,
    this.displaylevel,
    Key? key,
  }) : super(key: key);

  @override
  State<requestContents> createState() => _requestContentsState();
}

class _requestContentsState extends State<requestContents> {
  PageController? pageController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    pageController = PageController(initialPage: widget.page ?? 0);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.contentWidth,
      height: widget.contentHeight,
      child: Wrap(
        children: [
          Container(
            width: widget.contentWidth * 0.4,
            height: widget.contentHeight,
            child: MediaQuery.removePadding(
              context: context,
              removeTop: true,
              child: NotificationListener<OverscrollIndicatorNotification>(
                onNotification: (OverscrollIndicatorNotification overscroll) {
                  overscroll.disallowIndicator();

                  return true;
                },
                // enabled: (widget.isTutorialEnabled) ? widget.isTutorialOn[0] : false,
                      // overlayTutorialEntry: widget.tutorialOverlaysEntries[0],
                child: ListView( children: [OverlayTutorialHole(
                  enabled: (widget.isTutorialEnabled) ? widget.isTutorialOn[11] : false,
                  overlayTutorialEntry: widget.tutorialOverlaysEntries[11],
                  child: OverlayTutorialHole(
                    enabled: (widget.isTutorialEnabled) ? widget.isTutorialOn[0] : false,
                    overlayTutorialEntry: widget.tutorialOverlaysEntries[0],
                    child: Container(
                      width: widget.contentWidth * 0.4,
                      height: widget.contentHeight,
                      child: Center(child: Wrap(children: [
                        Container(
                          width: widget.contentWidth * 0.3,
                          child: RichText(text: TextSpan(children: [
                            TextSpan(text: "{\n", style: TextStyle(color: Colors.white),),
                            TextSpan(text: "  \"Req-id\": ", style: TextStyle(color: Colors.white),),
                            TextSpan(text: "\"${Item.convert(widget.item.reqId)}\"\n", style: TextStyle(color: ((widget.item.finish ?? false) && !(widget.item.getInitField!["reqId"]!)) ? Colors.red : Colors.blue),),
                            TextSpan(text: "  \"Req-type\": ", style: TextStyle(color: Colors.white),),
                            TextSpan(text: "\"${Item.convert(widget.item.reqType)}\"\n", style: TextStyle(color: ((widget.item.finish ?? false) && !(widget.item.getInitField!["reqType"]!)) ? Colors.red : ((widget.item.finish ?? false) && (!(widget.item.getInitField!["matchAandT"]!)) ? Colors.red : Colors.blue),)),
                            TextSpan(text: "  \"File-type\": ", style: TextStyle(color: Colors.white),),
                            TextSpan(text: "\"${Item.convert(widget.item.fileType)}\"\n", style: TextStyle(color: ((widget.item.finish ?? false) && !(widget.item.getInitField!["fileType"]!)) ? Colors.red : Colors.blue),),
                            TextSpan(text: "  \"Source\": ", style: TextStyle(color: Colors.white),),
                            TextSpan(text: "\"${Item.convert(widget.item.source)}\"", style: TextStyle(color: ((widget.item.finish ?? false) && !(widget.item.getInitField!["source"]!)) ? Colors.red : Colors.blue),),
                            
                          ])),
                        ),
                        Container(
                          width: widget.contentWidth * 0.3,
                          child: OverlayTutorialHole(
                            enabled: (widget.isTutorialEnabled) ? widget.isTutorialOn[3] : false,
                            overlayTutorialEntry: widget.tutorialOverlaysEntries[3],
                            child: RichText(text: TextSpan(children: [
                              TextSpan(text: "  \"Destination\": ", style: TextStyle(color: Colors.white),),
                              TextSpan(text: "\"${Item.convert(widget.item.destination)}\"", style: TextStyle(color: ((widget.item.finish ?? false) && !(widget.item.getInitField!["destination"]!)) ? Colors.red : Colors.blue),),
                            ])),
                          ),
                        ),
                        Container(
                          width: widget.contentWidth * 0.3,
                          child: RichText(text: TextSpan(children: [
                            TextSpan(text: "  \"Encryption\": ", style: TextStyle(color: Colors.white),),
                            TextSpan(text: "\"${Item.convert(widget.item.encryption)}\"", style: TextStyle(color: ((widget.item.finish ?? false) && !(widget.item.getInitField!["encryption"]!)) ? Colors.red : Colors.blue),),
                            
                          ]))
                        ),
                        Container(
                          width: widget.contentWidth * 0.3,
                          child: OverlayTutorialHole(
                            enabled: (widget.isTutorialEnabled) ? widget.isTutorialOn[15] : false,
                            overlayTutorialEntry: widget.tutorialOverlaysEntries[16],
                            child: RichText(text: TextSpan(children: [
                              TextSpan(text: "  \"Action\": ", style: TextStyle(color: Colors.white),),
                              TextSpan(text: "\"${(widget.item.action == null) ? "undefined" : Item.convert(widget.item.action)}\"", style: TextStyle(color: ((widget.item.finish ?? false) && !(widget.item.getInitField!["action"]!)) ? Colors.red : ((widget.item.finish ?? false) && (!(widget.item.getInitField!["matchAandT"]!)) ? Colors.red : Colors.blue),),),
                            ])),
                          ),
                        ),
                        Container(
                          width: widget.contentWidth * 0.3,
                          child: RichText(text: TextSpan(children: [
                            TextSpan(text: "  \"Session-create-time\": ", style: TextStyle(color: Colors.white),),
                            TextSpan(text: "\"${Jiffy(widget.item.sessionTime as DateTime).format("MM-dd hh:mm")}\"\n", style: TextStyle(color: ((widget.item.finish ?? false) && !(widget.item.getInitField!["sessionTime"]!)) ? Colors.red : Colors.blue),),
                            TextSpan(text: "}", style: TextStyle(color: Colors.white),),
                          ])),
                        ),],),
                      ),
                    ),
                  ),
                ),],),
              ),
            )
          ),
          Container(
            width: widget.contentWidth * 0.6,
            height: widget.contentHeight,
            child: PageView(
              onPageChanged: (page){
                widget.page = page;
              },
              physics: NeverScrollableScrollPhysics(),
              controller: pageController,
              children: [
                Center(
                  child: Container(
                    child: Wrap(
                      alignment: WrapAlignment.center,
                      children: [
                        OverlayTutorialHole(
                          enabled: (widget.isTutorialEnabled) ? widget.isTutorialOn[14] : false,
                          overlayTutorialEntry: widget.tutorialOverlaysEntries[14],
                          child: requestPageButton(
                            width: widget.contentWidth * 0.25,
                            height: widget.contentHeight * 0.2,
                            color: (widget.progress.level! >= 2) ? null : Colors.grey.shade700,
                            onPressed: (value){
                              if(widget.item.finish ?? false) return;
                              if((widget.displaylevel ?? widget.progress.level!) >= 2) {
                                setState(() {
                                  widget.page = 1;
                                  pageController!.animateToPage(1, duration: Duration(milliseconds: 500), curve: Curves.ease);
                                  if (widget.isTutorialEnabled && widget.isTutorialOn[14]) {
                                    widget.isTutorialOn[14] = false;
                                    widget.isTutorialOn[15] = true;
                                    widget.tutorialCallback({"isTutorialOn": widget.isTutorialOn});
                                  }
                                });
                              }
                            },
                            text: "Authorize",
                          ),
                        ),
                        OverlayTutorialHole(
                          enabled: (widget.isTutorialEnabled) ? widget.isTutorialOn[17] : false,
                          overlayTutorialEntry: widget.tutorialOverlaysEntries[18],
                          child: requestPageButton(
                            width: widget.contentWidth * 0.25,
                            height: widget.contentHeight * 0.2,
                            color: (widget.progress.level! >= 4) ? null : Colors.grey.shade700,
                            onPressed: (value){
                              // if(widget.item.finish ?? false) return;
                              // pageController!.jumpToPage(1);
                              if(widget.progress.level! >= 4) {
                                if (widget.dataCallback != null){
                                  widget.dataCallback(true);
                                }
                              }

                              if (widget.isTutorialEnabled && widget.isTutorialOn[17]) {
                                widget.isTutorialOn[17] = false;
                                widget.isTutorialOn[18] = true;
                                widget.tutorialCallback({"isTutorialOn": widget.isTutorialOn});
                              }
                        
                            },
                            
                            text: "Data",
                          ),
                        ),
                        OverlayTutorialHole(
                          enabled: (widget.isTutorialEnabled) ? widget.isTutorialOn[8] : false,
                          overlayTutorialEntry: widget.tutorialOverlaysEntries[8],
                          child: requestPageButton(
                            width: widget.contentWidth * 0.25,
                            height: widget.contentHeight * 0.2,
                            onPressed: (value){
                              if(widget.item.finish ?? false) return;
                              setState(() {
                                if (widget.isTutorialEnabled && widget.isTutorialOn[8]) {
                                  widget.isTutorialOn[8] = false;
                                  widget.isTutorialOn[9] = true;
                                  widget.tutorialCallback({"isTutorialOn": widget.isTutorialOn});
                                }
                                widget.page = 2;
                                pageController!.animateToPage(2, duration: Duration(milliseconds: 500), curve: Curves.ease);
                              });
                            },
                            text: "Deny",
                          ),
                        ),
                        OverlayTutorialHole(
                          enabled: (widget.isTutorialEnabled) ? widget.isTutorialOn[12] : false,
                          overlayTutorialEntry: widget.tutorialOverlaysEntries[12],
                          child: OverlayTutorialHole(
                            enabled: (widget.isTutorialEnabled) ? widget.isTutorialOn[1] : false,
                            overlayTutorialEntry: widget.tutorialOverlaysEntries[1],
                            child: requestPageButton(
                              width: widget.contentWidth * 0.25,
                              height: widget.contentHeight * 0.2,
                              onPressed: (value){
                                if(widget.item.finish ?? false) return;
                                setState(() {
                                  if (widget.isTutorialEnabled && widget.isTutorialOn[1]) {
                                    widget.isTutorialOn[1] = false;
                                    widget.isTutorialOn[2] = true;
                                    widget.tutorialCallback({"isTutorialOn": widget.isTutorialOn});
                                  } else if (widget.isTutorialOn[12]) {
                                    widget.isTutorialOn[12] = false;
                                    widget.isTutorialOn[13] = true;
                                    widget.tutorialCallback({"isTutorialOn": widget.isTutorialOn});
                                  }
                                  widget.page = 3;
                                  pageController!.animateToPage(3, duration: Duration(milliseconds: 500), curve: Curves.ease);
                                });
                              },
                              text: "Approve",
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Stack(
                  children: [
                    IconButton(
                      onPressed: (){
                        // widget.page = 0;
                        pageController!.animateToPage(0, duration: Duration(milliseconds: 500), curve: Curves.ease);
                      }, 
                      icon: Icon(Icons.arrow_back, color: Colors.white,),
                    ),
                    requestAuth(
                      displaylevel: widget.displaylevel,
                      isTutorialEnabled: widget.isTutorialEnabled,
                      isTutorialOn: widget.isTutorialOn,
                      tutorialOverlaysEntries: widget.tutorialOverlaysEntries,
                      tutorialCallback: (value) {
                        if (widget.isTutorialEnabled) {
                          widget.tutorialCallback(value);
                        }
                      },
                      annoncementCallback: (value) {
                        setState(() {
                          widget.annoncementCallback(value);
                        });
                      },
                      backButton: (){
                        // widget.page = 0;
                        pageController!.animateToPage(0, duration: Duration(milliseconds: 500), curve: Curves.ease);
                      },
                      contentHeight: widget.contentHeight,
                      contentWidth: widget.contentWidth * 0.6,
                      item: widget.item,
                      itemCallback: (value) {
                        setState(() {
                          widget.item = value;
                          widget.itemCallback(value);
                        });
                      },
                    ),
                  ],
                ),
                Stack(
                  children: [
                    IconButton(
                      onPressed: (){
                        // widget.page = 0;
                        pageController!.animateToPage(0, duration: Duration(milliseconds: 500), curve: Curves.ease);
                      }, 
                      icon: Icon(Icons.arrow_back, color: Colors.white,),
                    ),
                    requestDeny(
                      progress: widget.progress,
                      isTutorialEnabled: widget.isTutorialEnabled,
                      isTutorialOn: widget.isTutorialOn,
                      tutorialOverlaysEntries: widget.tutorialOverlaysEntries,
                      tutorialCallback: (value) {
                        if (value["isTutorialEnabled"] != null) {
                          setState(() {
                            widget.isTutorialEnabled = value["isTutorialEnabled"];
                          });
                        }
                        if (value["isTutorialOn"] != null) {
                          setState(() {
                            widget.isTutorialOn = value["isTutorialOn"];
                          });
                        }
                        if (value["tutorialOverlaysEntries"] != null) {
                          setState(() {
                            widget.tutorialOverlaysEntries = value["tutorialOverlaysEntries"];
                          });
                        }

                        widget.tutorialCallback({
                          "isTutorialEnabled": widget.isTutorialEnabled,
                          "isTutorialOn": widget.isTutorialOn,
                          "tutorialOverlaysEntries": widget.tutorialOverlaysEntries,
                        });
                      },
                      contentHeight: widget.contentHeight,
                      contentWidth: widget.contentWidth * 0.6,
                      item: widget.item,
                      callback: (){
                        // widget.page = 0;
                        pageController!.animateToPage(0, duration: Duration(milliseconds: 500), curve: Curves.ease);
                      },
                      itemCallback: (value){
                        setState(() {
                          widget.item = value;
                          widget.itemCallback(value);
                        });
                        
                      },
                    ),
                  ],
                ),
                Stack(
                  children: [
                    IconButton(
                      onPressed: (){
                        // widget.page = 0;
                        pageController!.animateToPage(0, duration: Duration(milliseconds: 500), curve: Curves.ease);
                      }, 
                      icon: Icon(Icons.arrow_back, color: Colors.white,),
                    ),
                    requestApprove(
                      progress: widget.progress,
                      isTutorialEnabled: widget.isTutorialEnabled,
                      isTutorialOn: widget.isTutorialOn,
                      tutorialOverlaysEntries: widget.tutorialOverlaysEntries,
                      tutorialCallback: (value) {
                        if (value["isTutorialEnabled"] != null) {
                          setState(() {
                            widget.isTutorialEnabled = value["isTutorialEnabled"];
                          });
                        }
                        if (value["isTutorialOn"] != null) {
                          setState(() {
                            widget.isTutorialOn = value["isTutorialOn"];
                          });
                        }
                        if (value["tutorialOverlaysEntries"] != null) {
                          setState(() {
                            widget.tutorialOverlaysEntries = value["tutorialOverlaysEntries"];
                          });
                        }

                        widget.tutorialCallback({
                          "isTutorialEnabled": widget.isTutorialEnabled,
                          "isTutorialOn": widget.isTutorialOn,
                          "tutorialOverlaysEntries": widget.tutorialOverlaysEntries,
                        });
                      },
                      item: widget.item,
                      itemCallback: (value) {
                        setState(() {
                          widget.item = value;
                          widget.itemCallback(value);
                        });
                      },
                      callback: (){
                        // widget.page = 0;
                        pageController!.animateToPage(0, duration: Duration(milliseconds: 500), curve: Curves.ease);
                      },
                      contentHeight: widget.contentHeight,
                      contentWidth: widget.contentWidth * 0.6,
                    ),
                  ],
                ),

              ],
            ),
          )
        ]
      ),
    );
  }
}