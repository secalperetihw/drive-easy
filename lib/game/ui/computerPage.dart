import 'package:drive_easy/classes/game/endLevelNotifier.dart';
import 'package:drive_easy/classes/game/warningEmail.dart';
import 'package:drive_easy/game/ui/gameBoard.dart';
import 'package:drive_easy/game/ui/gameEmailPage.dart';
import 'package:drive_easy/game/ui/report.dart';
import 'package:drive_easy/classes/game/email.dart';
import 'package:drive_easy/classes/game/item.dart';
import 'package:drive_easy/classes/game/progress.dart';
import 'package:drive_easy/game/game_home.dart';
import 'package:drive_easy/game/ui/requestPage/requestClasses.dart';
import 'package:drive_easy/game/ui/rules/handbook.dart';
import 'package:drive_easy/global.dart';
import 'package:drive_easy/static/emails.dart';
import 'package:drive_easy/static/requestsOnBoard.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:jiffy/jiffy.dart';
import 'package:tutorial/tutorial.dart';
import 'package:overlay_tutorial/overlay_tutorial.dart';

class ComputerMainPage extends StatefulWidget {
  GameMain? game;
  Item? item;
  Map<String, dynamic>? info;
  Progress progress;
  

  ComputerMainPage({ 
    this.game,
    this.item,
    this.info,
    required this.progress,
    Key? key 
  }) : super(key: key);

  @override
  State<ComputerMainPage> createState() => _ComputerMainPageState();
}

class _ComputerMainPageState extends State<ComputerMainPage> {
  int _selectedIndex = 1;
  late Progress gameProgress;
  Widget display = Container();
  Widget tmp = Container();
  GameEmail? displayEmail;
  late DateTime timeNow;
  // late Timer checkFinishTimer;
  bool showing = false;
  late EndLevel endLevelLayout;
  IconData emailIcon = Icons.mark_email_unread;
  int wrongTimes = 0;
  List<TutorialItem> tutorialItems = [];
  Widget gameBoard = Container();
  bool _isTutorialEnabled = true;
  List<bool> _isTutorialOn = [];
  List<OverlayTutorialRectEntry> tutorialOverlaysEntries = [];

  @override
  void initState() {
    super.initState();
    
    widget.item ??= Item.generate();
    widget.item?.reqId = 1;
    widget.item?.sessionTime = DateTime(2022, 4, 1, 09, 00);
    widget.item?.reqType = RequestType.uplaod;

    gameProgress = Progress.createDefault();
    display = EmailPage(
      displayEmail: displayEmail, 
      progress: gameProgress,
      allRead: (value) {

      },
    );

    timeNow = DateTime(2022, 04, (1 + (gameProgress.day!)), 9, 00, 00);

    endLevelLayout = EndLevel(
      context: context, 
      finishCount: 0, 
      totalCount: gameProgress.requests!.length, 
      time: timeNow
    );

    _isTutorialOn = [
      true, false, false, false, false, false, false,
    ];

    _isTutorialEnabled = gameProgress.tutorial!["FirstPlay"]!;

    tutorialOverlaysEntries = [
      OverlayTutorialRectEntry(
        overlayTutorialHints: [
          OverlayTutorialWidgetHint(
            builder: (context, entryRect) {
              return Padding(
                padding: const EdgeInsets.only(top: 50),
                child: Center(child: Column(children: [
                  RichText(text: TextSpan(style: TextStyle(color: Colors.white), children: [
                    TextSpan(text: "Hello! new comer!\nWelcome to be our new workforce, your job is to help identifing correctness of packages\n"),
                    TextSpan(text: "Let's start the tutorial!"),
                  ])),
                  TextButton(child: Text("Next"), onPressed: (){
                    setState(() {
                      _isTutorialOn[0] = false;
                      _isTutorialOn[1] = true;
                    });
                  },)
                ],),),
              );
            },
          ),
        ],
      ), 
      OverlayTutorialRectEntry(
        padding: const EdgeInsets.all(8.0),
        radius: const Radius.circular(16.0),
        overlayTutorialHints: [
          OverlayTutorialWidgetHint(
            builder: (context, entryRect) {
              return Positioned(
                top: entryRect.rRect!.top - 24.0,
                left: entryRect.rRect!.left - 50,
                child: Text(
                  
                  'Click here show the tasks today',
                  style: TextStyle(color: Colors.white),
                ),
              );
            },
          ),
          OverlayTutorialWidgetHint(
            // position: (rect) => Offset(rect.center.dx - 50, rect.center.dy),
            builder: (context, entryRect) {
              return Positioned(
                top: (entryRect.rRect!.bottom + entryRect.rRect!.top) / 2,
                left: entryRect.rRect!.left - 24,
                child: Icon(Icons.arrow_right_alt, color: Colors.white),
              );
            },
          ),
        ],
      ),
      OverlayTutorialRectEntry(
        padding: const EdgeInsets.all(8.0),
        radius: const Radius.circular(16.0),
        overlayTutorialHints: [
          OverlayTutorialWidgetHint(
            builder: (context, entryRect) {
              return Positioned(
                top: entryRect.rRect!.top - 24,
                left: entryRect.rRect!.left,
                child: Text(
                  
                  'Click to show details of tasks',
                  style: TextStyle(color: Colors.white),
                ),
              );
            },
          ),
          OverlayTutorialWidgetHint(
            // position: (rect) => Offset(rect.center.dx - 50, rect.center.dy),
            builder: (context, entryRect) {
              return Positioned(
                top: (entryRect.rRect!.bottom + entryRect.rRect!.top) / 2,
                left: entryRect.rRect!.left - 24,
                child: Icon(Icons.arrow_right_alt, color: Colors.white),
              );
            },
          ),
        ],
      ),
      OverlayTutorialRectEntry(
        padding: const EdgeInsets.all(8.0),
        radius: const Radius.circular(16.0),
        overlayTutorialHints: [
          OverlayTutorialWidgetHint(
            builder: (context, entryRect) {
              return Positioned(
                top: entryRect.rRect!.top - 24,
                left: entryRect.rRect!.left,
                child: Text(
                  
                  'Now Let\'s try a package you will need to deny',
                  style: TextStyle(color: Colors.white),
                ),
              );
            },
          ),
          OverlayTutorialWidgetHint(
            // position: (rect) => Offset(rect.center.dx - 50, rect.center.dy),
            builder: (context, entryRect) {
              return Positioned(
                top: (entryRect.rRect!.bottom + entryRect.rRect!.top) / 2,
                left: entryRect.rRect!.left - 24,
                child: Icon(Icons.arrow_right_alt, color: Colors.white),
              );
            },
          ),
        ],
      ),
      OverlayTutorialRectEntry(
        padding: const EdgeInsets.all(8.0),
        radius: const Radius.circular(16.0),
        overlayTutorialHints: [
          OverlayTutorialWidgetHint(
            builder: (context, entryRect) {
              return  Center(
                child: RichText(textAlign: TextAlign.center, text: TextSpan(children: const [
                  TextSpan(text:  'You will receive score once you finish tasks.\nNow Let\'s try what will happen\nif we accept a package which is suspicious', style: TextStyle(color: Colors.white),),
                ])),
              );
            },
          ),
          OverlayTutorialWidgetHint(
            // position: (rect) => Offset(rect.center.dx - 50, rect.center.dy),
            builder: (context, entryRect) {
              return Positioned(
                top: (entryRect.rRect!.bottom + entryRect.rRect!.top) / 2,
                left: entryRect.rRect!.left - 24,
                child: Icon(Icons.arrow_right_alt, color: Colors.white),
              );
            },
          ),
        ],
      ),
      OverlayTutorialRectEntry(
        padding: const EdgeInsets.all(8.0),
        radius: const Radius.circular(16.0),
        overlayTutorialHints: [
          OverlayTutorialWidgetHint(
            builder: (context, entryRect) {
              return  Center(
                child: Wrap(
                  children: [
                    // RichText(textAlign: TextAlign.center, text: TextSpan(children: const [
                    //   ])),
                    GestureDetector(
                      onTap: () {
                        if (_isTutorialEnabled && _isTutorialOn[5]) {
                          setState(() {
                            _isTutorialOn[5] = false;
                            _isTutorialEnabled = false;
                            gameProgress.tutorial!["FirstPlay"] = false;
                            _selectedIndex = 1;
                            display = EmailPage(
                              displayEmail: displayEmail, 
                              progress: gameProgress,
                              allRead: (value) {
                                if (value) {
                                  setState(() {
                                    emailIcon = Icons.mark_email_read;
                                  });
                                } else {
                                  setState(() {
                                    emailIcon = Icons.mark_email_unread;
                                  });
                                }
                              },
                            );
                          });
                        }
                      },
                      child: RichText(textAlign: TextAlign.center, text: TextSpan(children: const [
                        TextSpan(text:  'Oops... uhhh.. don\'t mind about the score,\n you can do well if you get in to this.\nBye Bye...\n', style: TextStyle(color: Colors.white),),
                    
                        TextSpan(text:  'bye', style: TextStyle(color: Colors.blue, decoration: TextDecoration.underline),),
                      ])),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    ];

    gameBoard = GameBoardPage(
      isTutorialEnabled: _isTutorialEnabled,
      isTutorialOn: _isTutorialOn,
      tutorialOverlaysEntries: tutorialOverlaysEntries,
      tutorialCallback: (value) {
        if (value["isTutorialEnabled"] != null) {
          setState(() {
            _isTutorialEnabled = value["isTutorialEnabled"];
          });
        }
        if (value["isTutorialOn"] != null) {
          setState(() {
            _isTutorialOn = value["isTutorialOn"];
          });
        }
        if (value["tutorialOverlaysEntries"] != null) {
          setState(() {
            tutorialOverlaysEntries = value["tutorialOverlaysEntries"];
          });
        }
      },
      progress: gameProgress, 
      timeCallback: (value) async {
        bool check = false;
        setState(() {
          timeNow = timeNow.add(value);
          check = endLevelLayout.valueChanges(
            finishCount: endLevelLayout.finishCount + 1,
            time: timeNow
          );
        });
        if (check){
          endPopup();
        }
      },
      itemCallback: (value) {
        setState(() {
          // widget.item = value;
          
        });
        
        if (!(value.success ?? true)) {
          setState(() {
            gameProgress.totalFailed = gameProgress.totalFailed! + 1;
            wrongTimes++;
            // widget.progress.emails!.add(
            //   WarningEmail.defaultStyle(widget.item!.reqId, widget.item!.getFields!, wrongTimes)
            // );
            gameProgress.emails!.add(
              WarningEmail.defaultStyle(
                id: value.reqId,
                itemField: value.getInitField!, 
                wrongTimes: wrongTimes,
                time: timeNow
              )
            );
            emailIcon = Icons.mark_email_unread;
            if (_isTutorialEnabled) return;
            _selectedIndex = 1;
            display = EmailPage(
              displayEmail: displayEmail, 
              progress: gameProgress,
              allRead: (value) {
                if (value) {
                  setState(() {
                    emailIcon = Icons.mark_email_read;
                  });
                } else {
                  setState(() {
                    emailIcon = Icons.mark_email_unread;
                  });
                }
              },
            );
          });
        } else {
          gameProgress.totalSuccess = gameProgress.totalSuccess! + 1;
        }
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
    // checkFinishTimer.cancel();
    progress = gameProgress;
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight
    ]);
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
    return Scaffold(
      backgroundColor: Colors.black,
      extendBodyBehindAppBar: true,
      body: OverlayTutorialScope(
        enabled: _isTutorialEnabled,
        overlayColor: Colors.black.withOpacity(.6),
        child: Container(
          height: MediaQuery.of(context).size.height ,
          width: MediaQuery.of(context).size.width ,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              OverlayTutorialHole(
                enabled: (_isTutorialEnabled) ? _isTutorialOn[5] : false,
                overlayTutorialEntry: tutorialOverlaysEntries[5],
                child: OverlayTutorialHole(
                  enabled: (_isTutorialEnabled) ? _isTutorialOn[0] : false,
                  overlayTutorialEntry: tutorialOverlaysEntries[0],
                  child: Container()
                ),
              ),
              display,
              Container(
                height: MediaQuery.of(context).size.height * 0.15,
                width: MediaQuery.of(context).size.width * 0.9,
                child: Wrap(
                  alignment: WrapAlignment.spaceBetween,
                  children: [
                    Wrap(
                      alignment: WrapAlignment.start,
                      children: [
                        GestureDetector(
                          onTap: () async {
                            bool exit = false;
                            await showDialog<void>(
                              context: context,
                              barrierDismissible: false, // user must tap button!
                              builder: (BuildContext context) { 
                              
                                return AlertDialog(
                                  title: Text("Exit"),
                                  content: Text("Are you sure to exit?"),
                                  actions: [
                                    TextButton(
                                      onPressed:(){
                                        exit = true;
                                        Navigator.pop(context);
                                      }, 
                                      child: Text("Yes")
                                    ),
                                    TextButton(
                                      onPressed:(){
                                        exit = false;
                                        Navigator.pop(context);
                                      }, 
                                      child: Text("No")
                                    )
                                  ],
                                );
                              }
                            );
                            if(exit){
                              Navigator.pop(context);
                            }
                          },
                          child: Container(
                            padding: EdgeInsets.fromLTRB(20, 5, 20, 5),
                            decoration: BoxDecoration(
                              border: (_selectedIndex == 0) ? Border(bottom: BorderSide(color: Colors.blue)) : null,
                            ),
                            child: Icon(Icons.home, color: Colors.white,),
                          ),
                        ),
                        GestureDetector(
                          onTap: (){
                            setState(() {
                              _selectedIndex = 1;
                              display = EmailPage(
                                displayEmail: displayEmail, 
                                progress: gameProgress,
                                allRead: (value) {
                                  if (value) {
                                    setState(() {
                                      emailIcon = Icons.mark_email_read;
                                    });
                                  } else {
                                    setState(() {
                                      emailIcon = Icons.mark_email_unread;
                                    });
                                  }
                                },
                              );
                            });
                          },
                          child: Container(
                            padding: EdgeInsets.fromLTRB(20, 5, 20, 5),
                            decoration: BoxDecoration(
                              border: (_selectedIndex == 1) ? Border(bottom: BorderSide(color: Colors.blue)) : null,
                            ),
                            child: Icon(emailIcon, color: (emailIcon == Icons.mark_email_read) ? Colors.white : Colors.red,),
                          ),
                        ),
                        GestureDetector(
                          onTap: (){
                            setState(() {
                              _selectedIndex = 2;
                              display = gameBoard;
                              if(_isTutorialEnabled && _isTutorialOn[1]) {
                                _isTutorialOn[1] = false;
                                _isTutorialOn[2] = true;
                              }
                            });
                          },
                          child: Container(
                            padding: EdgeInsets.fromLTRB(20, 5, 20, 5),
                            decoration: BoxDecoration(
                              border: (_selectedIndex == 2) ? Border(bottom: BorderSide(color: Colors.blue)) : null,
                            ),
                            child: OverlayTutorialHole(
                              enabled: (_isTutorialEnabled) ? _isTutorialOn[1] : false,
                              overlayTutorialEntry: tutorialOverlaysEntries[1],
                              child: Icon(Icons.task, color: Colors.white,)
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: (){
                            setState(() {
                              _selectedIndex = 3;
                              display = Handbook(
                                isTutorialEnabled: false,
                                isTutorialOn: const [],
                                tutorialOverlaysEntries: const [],
                                tutorialCallback: (value) {
                                  
                                },
                                rulesVersion: "rules-level1",
                                contentHeight: MediaQuery.of(context).size.height * 0.75,
                                contentWidth: MediaQuery.of(context).size.width * 0.9,
                                pageCallback: (value) { 
          
                                },
                              );
                            });
                          },
                          child: Container(
                            padding: EdgeInsets.fromLTRB(20, 5, 20, 5),
                            decoration: BoxDecoration(
                              border: (_selectedIndex == 3) ? Border(bottom: BorderSide(color: Colors.blue)) : null,
                            ),
                            child: Icon(Icons.bookmark, color: Colors.white,),
                          ),
                        ),
                        GestureDetector(
                          onTap: (){
                            setState(() {
                              _selectedIndex = 4;
                              display = GameReport(progress: gameProgress,);
                            });
                          },
                          child: Container(
                            padding: EdgeInsets.fromLTRB(20, 5, 20, 5),
                            decoration: BoxDecoration(
                              border: (_selectedIndex == 4) ? Border(bottom: BorderSide(color: Colors.blue)) : null,
                            ),
                            child: Icon(Icons.info, color: Colors.white,),
                          ),
                        ),
                        GestureDetector(
                          onTap: (){
                            setState(() {
                              _selectedIndex = 5;
                              display = Container();
                            });
                          },
                          child: Container(
                            padding: EdgeInsets.fromLTRB(20, 5, 20, 5),
                            decoration: BoxDecoration(
                              border: (_selectedIndex == 5) ? Border(bottom: BorderSide(color: Colors.blue)) : null,
                            ),
                            child: Icon(Icons.settings, color: Colors.white,),
                          ),
                        ),
                        GestureDetector(
                          onTap: () async {
                            endPopup();
                          },
                          child: Container(
                            padding: EdgeInsets.fromLTRB(20, 5, 20, 5),
                            decoration: BoxDecoration(
                              border: null,
                            ),
                            child: Icon(Icons.skip_next, color: Colors.white,),
                          ),
                        ),
                        GestureDetector(
                          onTap: (){
                            setState(() {
                              _isTutorialEnabled = false;
                            });
                          },
                          child: Container(
                            padding: EdgeInsets.fromLTRB(20, 5, 20, 5),
                            decoration: BoxDecoration(
                              border: null,
                            ),
                            child: Icon(Icons.restore, color: Colors.white,),
                          ),
                        ),
                      ],
                    ),
                    RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(style: TextStyle(color: Colors.white), children: [
                        TextSpan(text: Jiffy(timeNow).format("dd/MM/yyyy\n")),
                        TextSpan(text: Jiffy(timeNow).format("HH:mm:ss"))
                      ])
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
    
  }

  void endPopup() async {
    await showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext ctx) { 
      
        return dialog(gameProgress.level ?? 0, ctx);
      }
    );
    setState(() {
      gameProgress.level = gameProgress.level! + 1;
      gameProgress.day = gameProgress.day! + 1;
      String s = "level" + gameProgress.level.toString();
      try{
        for (GameEmail email in (emailDatabase[s]!)){
          gameProgress.emails!.add(email);
        }
      } catch(e){ print(e); }
      gameProgress.requests = List.from(requestsOnBoard["level0"]!);
      //requestsOnBoard[s];
      timeNow = DateTime(timeNow.year, timeNow.month, timeNow.day + 1, 09, 00, 00);
      _selectedIndex = 4;
      display = GameReport(progress: gameProgress,);
    });
  }

  void popupClicked(String value) {
    switch(value){
      case 'View Handbook':
        break;
      case 'Debug':
        break;
      case 'Debug 1':
        break;
      
    }
  }

  Widget dialog(int level, BuildContext ctx) {
    switch (level) {
      case 0:
        return Dialog(
          child: Container(
            height: MediaQuery.of(context).size.height * 0.8,
            width: MediaQuery.of(context).size.width * 0.8,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15)
            ),
            child: ListView(children: [
              Container(
                width: MediaQuery.of(context).size.width * 0.7,
                child: Center(child: RichText(textAlign: TextAlign.center, text: TextSpan(style: TextStyle(color: Colors.black), children: [
                  TextSpan(text: "Day ${gameProgress.day.toString()} tasks end\n", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30, height: 2)),
                  TextSpan(text: "${gameProgress.successCount().toString()}/${gameProgress.requests?.length.toString()} tasks finished\n"),
                  TextSpan(text: "Rating: ${gameProgress.rating.toString()}\n"),
                ])),)
              ),
              Center(
                child: Wrap(children: [
                  ElevatedButton(onPressed: () => Navigator.pop(ctx), child: Text("Continue"))
                ],),
              )
            ],),
          ),
        );
    }
    return Container();
  }
}
