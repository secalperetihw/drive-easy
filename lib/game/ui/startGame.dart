import 'package:drive_easy/documents/About_The_Game.dart';
import 'package:drive_easy/documents/Cloud_Storage.dart';
import 'package:drive_easy/documents/Third_Party_Application.dart';
import 'package:drive_easy/game/ui/computerPage.dart';
import 'package:drive_easy/global.dart';
import 'package:flutter/material.dart';

class StartGamePage extends StatefulWidget {
  const StartGamePage({ Key? key }) : super(key: key);

  @override
  State<StartGamePage> createState() => _StartGamePageState();
}

class _StartGamePageState extends State<StartGamePage> {
  int _page = 0;
  PageController pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Center(child: Container(padding: EdgeInsets.all(20), child: Text("Game"),)),
        Center(
          child: Container(padding: EdgeInsets.all(20), 
            child: ElevatedButton(
              onPressed: () async {
                await showDialog<void>(
                  context: context,
                  barrierDismissible: false, // user must tap button!
                  builder: (BuildContext ctx) { 
                  
                    return Dialog(
                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.8,
                        width: MediaQuery.of(context).size.width * 0.8,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15)
                        ),
                        child: Stack(
                          children: [
                            PageView(
                              physics: NeverScrollableScrollPhysics(),
                              controller: pageController,
                              children: [
                                About_The_Game(onpress: (){
                                  setState(() {
                                    _page = 1;
                                    pageController.animateToPage(_page, duration: Duration(milliseconds: 500), curve: Curves.ease);
                                  });
                                },),

                                Cloud_Storage(onpress: (){
                                  setState(() {
                                    _page = 2;
                                    pageController.animateToPage(_page, duration: Duration(milliseconds: 500), curve: Curves.ease);
                                  });
                                },),

                                Third_Party_Application(onpress: (){
                                  setState(() {
                                    _page = 3;
                                    pageController.animateToPage(_page, duration: Duration(milliseconds: 500), curve: Curves.ease);
                                  });
                                }),

                                ListView(children: [
                                  Center(child: RichText(textAlign: TextAlign.center, text: TextSpan(style: TextStyle(color: Colors.black, height: 2), children: const [
                                    TextSpan(text: "Let's get started\n", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30, height: 2)),
                                  ])),),
                                  Padding(padding: EdgeInsets.only(left: 30, right: 30, top: 10, bottom: 10), child: Divider(color: Colors.black38,)),
                                  Center(child: Wrap(children: [ElevatedButton(onPressed: () {
                                    Navigator.pop(ctx);
                                    setState(() {
                                      _page = 0;
                                    });
                                  }, child: Text("Start"))],),),
                                  
                                ],),
                              ],
                            ),
                            IconButton(
                              onPressed: () {
                                setState(() {
                                  _page--;
                                  if (_page < 0) _page = 0;
                                  pageController.animateToPage(_page, duration: Duration(milliseconds: 500), curve: Curves.ease);
                                });
                              }, 
                              icon: Icon(Icons.arrow_back)
                            ),
                          ],
                        ),
                      ),
                    );
                  }
                );

                Navigator.push(context, MaterialPageRoute(builder: (ctx) => ComputerMainPage(progress: progress,)));
              },
              child: Text("Start"),
            ),
          ),
        ),
      ]),
    );
  }
}