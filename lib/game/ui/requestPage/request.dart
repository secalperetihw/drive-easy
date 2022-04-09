import 'package:drive_easy/classes/game/item.dart';
import 'package:drive_easy/game/game_home.dart';
import 'package:drive_easy/game/ui/requestPage/modify.dart';
import 'package:drive_easy/game/ui/requestPage/requestClasses.dart';
import 'package:drive_easy/game/ui/requestPage/requestContent.dart';
import 'package:drive_easy/game/ui/rules/handbook.dart';
import 'package:drive_easy/global.dart';
import 'package:flame/flame.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class RequestMainPage extends StatefulWidget {
  GameMain? game;
  Item? item;
  Map<String, dynamic>? info;

  RequestMainPage({ 
    this.game,
    this.item,
    this.info,
    Key? key 
  }) : super(key: key);

  @override
  State<RequestMainPage> createState() => _RequestMainPageState();
}

class _RequestMainPageState extends State<RequestMainPage> {
  late PageController pageController;
  Widget? content;
  int current = 0;
  int MAX_PAGE = 2;
  int contentPage = 0;
  int rulesPage = 0;
  bool toDataPage = false;
  bool showArrow = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    
    widget.item ??= Item.generate();
    widget.item?.reqId = 1;
    widget.item?.sessionTime = "15:00:00";
    widget.item?.reqType = RequestType.uplaod;

    pageController = PageController(initialPage: 0);
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight
    ]);
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        shadowColor: Colors.black,
        elevation: 0,
        iconTheme: const IconThemeData(
          color: Colors.white
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back), 
          onPressed: () async {
            if (pageController.page == 0){
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
            } else {
              current = 0;
              pageController.animateToPage(0, duration: Duration(milliseconds: 100), curve: Curves.ease);
            }
          },
        ),
        actions: [
          PopupMenuButton<String>(
            onSelected: popupClicked,
            itemBuilder: (BuildContext context) {
              return {'View Handbook', 'Policies', 'Setting', 'Help', 'Debug', 'Debug 1'}.map((String choice) {
                return PopupMenuItem<String>(
                  value: choice,
                  child: Text(choice),
                );
              }).toList();
            },
          ),
        ],
      ),
      extendBodyBehindAppBar: true,
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Stack(
          children: [
            Wrap(
              // mainAxisAlignment: MainAxisAlignment.end,
              alignment: WrapAlignment.end,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 0.2,
                  child: Center(child: GameAnnoncement())
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 0.8,
                  child: PageView(
                    onPageChanged: (page){
                      if (current != page) { setState(() { current = page; });}
                      if (page == 2){
                        setState(() {
                          showArrow = !showArrow;
                        });
                      }
                      else if (page != 2 && !showArrow){
                        setState(() {
                          showArrow = !showArrow;
                        });
                      }
                    },
                    scrollDirection: Axis.vertical,
                    controller: pageController,
                    children: [
                      requestContents(
                        contentHeight: MediaQuery.of(context).size.height * 0.8,
                        contentWidth: MediaQuery.of(context).size.width,
                        key: UniqueKey(),
                        game: widget.game,
                        item: widget.item ?? Item.generate(),
                        callback: (value){
                          setState(() {
                            widget.item = value;
                          });
                        },
                        // pageCallback: (value){
                        //   setState(() {
                        //     contentPage = value;
                        //   });
                        // },
                        dataCallback: (value){
                          current = 2;
                          pageController.animateToPage(current, duration: Duration(milliseconds: 700), curve: Curves.ease);
                          setState(() {
                            showArrow = false;
                          });
                        },
                        // page: contentPage,
                      ),
                      Handbook(
                        contentHeight: MediaQuery.of(context).size.height * 0.8,
                        contentWidth: MediaQuery.of(context).size.width,
                        pageCallback: (value){
                          setState(() {
                            rulesPage = value;
                          });
                        },
                        page: rulesPage,
                      ),
                      modifyPage(
                        contentHeight: MediaQuery.of(context).size.height * 0.8,
                        contentWidth: MediaQuery.of(context).size.width,
                        item: widget.item ?? Item.generate()
                      ),
                    ],
                  ),
                ),
              ]
            ),
            if (showArrow) Container(
              padding: EdgeInsets.only(right: MediaQuery.of(context).size.width * 0.2),
              alignment: Alignment.bottomCenter,
              child: IconButton(
                iconSize: 20,
                icon: Icon(Icons.arrow_downward, color: Colors.white, size: 20,), 
                onPressed: (){
                  if (current < MAX_PAGE) current++;

                  pageController.animateToPage(current, duration: Duration(milliseconds: 700), curve: Curves.ease);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void popupClicked(String value) {
    switch(value){
      case 'View Handbook':
        pageController.animateToPage(1, duration: Duration(milliseconds: 100), curve: Curves.ease);
        break;
      case 'Debug':
        Flame.device.setLandscape();
        // SystemChrome.setPreferredOrientations([
        //   DeviceOrientation.landscapeLeft,
        //   DeviceOrientation.landscapeRight
        // ]);
        // setState(() {
        //   widget.game.setLandscape();
        // });
        // Flame.device.fullScreen();
        break;
      case 'Debug 1':
        Flame.device.setPortrait();
        
        // SystemChrome.setPreferredOrientations([
        //   DeviceOrientation.portraitDown,
        //   DeviceOrientation.portraitUp,
        // ]);
        break;
      
    }
  }
}





