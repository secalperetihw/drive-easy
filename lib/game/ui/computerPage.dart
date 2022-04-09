import 'package:drive_easy/classes/game/email.dart';
import 'package:drive_easy/classes/game/item.dart';
import 'package:drive_easy/classes/game/progress.dart';
import 'package:drive_easy/game/game_home.dart';
import 'package:drive_easy/game/ui/requestPage/request.dart';
import 'package:drive_easy/global.dart';
import 'package:drive_easy/static/emails.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ComputerMainPage extends StatefulWidget {
  GameMain? game;
  Item? item;
  Map<String, dynamic>? info;
  Progress? progress;

  ComputerMainPage({ 
    this.game,
    this.item,
    this.info,
    this.progress,
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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    
    widget.item ??= Item.generate();
    widget.item?.reqId = 1;
    widget.item?.sessionTime = "15:00:00";
    widget.item?.reqType = RequestType.uplaod;

    gameProgress = progress;
    display = EmailPage(displayEmail: displayEmail);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();

    progress = gameProgress;
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight
    ]);
    return Scaffold(
      backgroundColor: Colors.black,
      extendBodyBehindAppBar: true,
      body: Container(
        height: MediaQuery.of(context).size.height ,
        width: MediaQuery.of(context).size.width ,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
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
                            display = EmailPage(displayEmail: displayEmail);
                          });
                        },
                        child: Container(
                          padding: EdgeInsets.fromLTRB(20, 5, 20, 5),
                          decoration: BoxDecoration(
                            border: (_selectedIndex == 1) ? Border(bottom: BorderSide(color: Colors.blue)) : null,
                          ),
                          child: Icon(Icons.email, color: Colors.white,),
                        ),
                      ),
                      GestureDetector(
                        onTap: (){
                          setState(() {
                            _selectedIndex = 2;
                            display = GameBoardPage();
                          });
                        },
                        child: Container(
                          padding: EdgeInsets.fromLTRB(20, 5, 20, 5),
                          decoration: BoxDecoration(
                            border: (_selectedIndex == 2) ? Border(bottom: BorderSide(color: Colors.blue)) : null,
                          ),
                          child: Icon(Icons.info, color: Colors.white,),
                        ),
                      ),
                      GestureDetector(
                        onTap: (){
                          setState(() {
                            _selectedIndex = 3;
                            display = Container();
                          });
                        },
                        child: Container(
                          padding: EdgeInsets.fromLTRB(20, 5, 20, 5),
                          decoration: BoxDecoration(
                            border: (_selectedIndex == 3) ? Border(bottom: BorderSide(color: Colors.blue)) : null,
                          ),
                          child: Icon(Icons.settings, color: Colors.white,),
                        ),
                      ),
                    ],
                  ),
                  RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(style: TextStyle(color: Colors.white), children: [
                      TextSpan(text: "06/04/2022\n"),
                      TextSpan(text: "15:00:00")
                    ])
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
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
}

class GameBoardPage extends StatelessWidget {
  const GameBoardPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container( 
      height: MediaQuery.of(context).size.height * 0.7,
      width: MediaQuery.of(context).size.width * 0.8,
      decoration: BoxDecoration(
        color: Colors.transparent,
        border: Border.all(width: 1, color: Colors.white)
      ),
      child: ListView (
        children: [
          Wrap(
            alignment: WrapAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.all(10),
                child: GestureDetector(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => RequestMainPage()));
                  },
                  child: Container(
                    decoration: BoxDecoration(color: Colors.black, border: Border.all(width: 1, color: Colors.white)),
                    child: Text("123")
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.all(10),
                child: GestureDetector(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => RequestMainPage()));
                  },
                  child: Container(
                    decoration: BoxDecoration(color: Colors.black, border: Border.all(width: 1, color: Colors.white)),
                    child: Text("123")
                  ),
                ),
              ),
            ]
          ),
        ],
      ),
    );
  }
}

class EmailPage extends StatefulWidget {
  EmailPage({
    Key? key,
    required this.displayEmail,
  }) : super(key: key);

  GameEmail? displayEmail;

  @override
  State<EmailPage> createState() => _EmailPageState();
}

class _EmailPageState extends State<EmailPage> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: MediaQuery.of(context).size.height * 0.8,
        width: MediaQuery.of(context).size.width * 0.9,
        decoration: BoxDecoration(
          color: Colors.transparent,
          border: Border.all(width: 1, color: Colors.white)
        ),
        child: Wrap(
          alignment: WrapAlignment.spaceEvenly,
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.8,
              width: MediaQuery.of(context).size.width * 0.3,
              child: MediaQuery.removePadding(context: context, removeTop: true, 
              child: ListView.builder(itemCount: progress.emails?.length, itemBuilder: (ctx, index)  {
                int realIndex = (progress.emails?.length ?? 1) - index - 1;
                return Container(
                  child: Column(
                    children: [
                      GestureDetector(
                        onLongPress: () async {
                        },
                        onTap: (){
                          setState(() {
                            widget.displayEmail = progress.emails?[realIndex];
                            progress.emails?[realIndex].read = true;
                          });
                        },
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.3,
                          child: Wrap(
                            alignment: WrapAlignment.spaceBetween,
                            children: [
                               Container(
                                 width: MediaQuery.of(context).size.width * 0.2,
                                 child: RichText(text: TextSpan(style: TextStyle(color: (progress.emails![realIndex].read ?? false) ? Colors.grey : Colors.white), children: [
                                   TextSpan(text: progress.emails![realIndex].title, style: TextStyle(fontWeight: FontWeight.bold))
                                 ])),
                               ),
                               Container(
                                 width: MediaQuery.of(context).size.width * 0.1,
                                 child: RichText(textAlign: TextAlign.end, text: TextSpan(style: TextStyle(color: Colors.grey), children: [
                                  TextSpan(text: "${progress.emails![realIndex].time?.day.toString()}/${progress.emails![realIndex].time?.month.toString()}", style: TextStyle())
                                ])),
                               ),
                               Container(
                                 width: MediaQuery.of(context).size.width * 0.3,
                                 child: Text("from: ${progress.emails![realIndex].from}", style: TextStyle(overflow: TextOverflow.ellipsis, color: (progress.emails![realIndex].read ?? false) ? Colors.grey : Colors.white)),
                               ),
                               Container(
                                 width: MediaQuery.of(context).size.width * 0.3,
                                 child: Text("${progress.emails![realIndex].content}", style: TextStyle(overflow: TextOverflow.ellipsis, color: Colors.grey)),
                               ),
                            ],
                          ),
                        ),
                      ),
                      Divider(color: Colors.white,),
                    ],
                  ),
                );
              })),
            ),
            Container(
              height: MediaQuery.of(context).size.height * 0.78,
              child: VerticalDivider(color: Colors.white)
            ),
            Container(
              height: MediaQuery.of(context).size.height * 0.8,
              width: MediaQuery.of(context).size.width * 0.5,
              child: MediaQuery.removePadding(context: context, removeTop: true, child: ListView(
                children: [
                  Divider(color: Colors.black,),
                  RichText(
                    textAlign: TextAlign.start,
                    text: TextSpan(
                    style: TextStyle(color: Colors.white,),
                    children: [
                      TextSpan(text: "Title: ",style: TextStyle(color: Colors.grey),),
                      TextSpan(text: (widget.displayEmail?.title ?? ""))
                    ]
                  )),
                  Divider(color: Colors.white,),
                  RichText(
                    textAlign: TextAlign.start,text: TextSpan(
                    style: TextStyle(color: Colors.white),
                    children: [
                      TextSpan(text: "From: ",style: TextStyle(color: Colors.grey),),
                      TextSpan(text: (widget.displayEmail?.from ?? ""))
                    ]
                  )),
                  Divider(color: Colors.white,),
                  RichText(
                    textAlign: TextAlign.start,text: TextSpan(
                    style: TextStyle(color: Colors.white),
                    children: [
                      TextSpan(text: "To: ",style: TextStyle(color: Colors.grey),),
                      TextSpan(text: (widget.displayEmail?.to ?? ""))
                    ]
                  )),
                  Divider(color: Colors.white,),
                  RichText(
                    textAlign: TextAlign.start,text: TextSpan(
                    style: TextStyle(color: Colors.white),
                    children: [
                      TextSpan(text: "cc: ",style: TextStyle(color: Colors.grey),),
                      TextSpan(text: (widget.displayEmail?.cc ?? ""))
                    ]
                  )),
                  Divider(color: Colors.white,),
                  RichText(
                    textAlign: TextAlign.start,text: TextSpan(
                    style: TextStyle(color: Colors.white, height: 1.5),
                    children: [
                      TextSpan(text: widget.displayEmail?.dear ?? ""),
                      TextSpan(text: "\n\t${widget.displayEmail?.content ?? ""}"),
                      
                    ]
                  )),
                ],
              ))
            ),
          ],
        ),
      ),
    );
  }
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