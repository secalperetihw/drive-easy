import 'package:drive_easy/classes/game/item.dart';
import 'package:drive_easy/game/game_home.dart';
import 'package:drive_easy/game/ui/requestPage/requestApprove.dart';
import 'package:drive_easy/game/ui/requestPage/requestAuth.dart';
import 'package:drive_easy/game/ui/requestPage/requestClasses.dart';
import 'package:drive_easy/game/ui/requestPage/requestDeny.dart';
import 'package:flutter/material.dart';

class requestContents extends StatefulWidget {
  GameMain? game;
  Item item;
  ValueChanged<Item> callback;
  // ValueChanged<int> pageCallback;
  ValueChanged<bool> dataCallback;  
  int? page;
  double contentHeight;
  double contentWidth;

  requestContents({
    required this.game,
    required this.item,
    required this.callback,
    required this.contentHeight,
    required this.contentWidth,
    // required this.pageCallback,
    required this.dataCallback,
    this.page,
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
                child: ListView(children: [Container(height: widget.contentHeight, child: Center(
                  child: RichText(text: TextSpan(
                    children: [
                      TextSpan(text: "{\n", style: TextStyle(color: Colors.white),),
                      TextSpan(text: "  \"Req-id\": ", style: TextStyle(color: Colors.white),),
                      TextSpan(text: "\"${Item.convert(widget.item.reqId)}\"\n", style: TextStyle(color: Colors.blue),),
                      TextSpan(text: "  \"Req-type\": ", style: TextStyle(color: Colors.white),),
                      TextSpan(text: "\"${Item.convert(widget.item.reqType)}\"\n", style: TextStyle(color: Colors.blue),),
                      TextSpan(text: "  \"File-type\": ", style: TextStyle(color: Colors.white),),
                      TextSpan(text: "\"${Item.convert(widget.item.fileType)}\"\n", style: TextStyle(color: Colors.blue),),
                      TextSpan(text: "  \"Source\": ", style: TextStyle(color: Colors.white),),
                      TextSpan(text: "\"${Item.convert(widget.item.source)}\"\n", style: TextStyle(color: Colors.blue),),
                      TextSpan(text: "  \"Destination\": ", style: TextStyle(color: Colors.white),),
                      TextSpan(text: "\"${Item.convert(widget.item.destination)}\"\n", style: TextStyle(color: Colors.blue),),
                      TextSpan(text: "  \"Encryption\": ", style: TextStyle(color: Colors.white),),
                      TextSpan(text: "\"${Item.convert(widget.item.encryption)}\"\n", style: TextStyle(color: Colors.blue),),
                      TextSpan(text: "  \"Action\": ", style: TextStyle(color: Colors.white),),
                      TextSpan(text: "\"${(widget.item.action == null) ? "undefined" : Item.convert(widget.item.action)}\"\n", style: TextStyle(color: Colors.blue),),
                      TextSpan(text: "  \"Session-create-time\": ", style: TextStyle(color: Colors.white),),
                      TextSpan(text: "\"${Item.convert(widget.item.sessionTime)}\"\n", style: TextStyle(color: Colors.blue),),
                      TextSpan(text: "}", style: TextStyle(color: Colors.white),),
                    ])),),
                  )
                ],),
              ),
            )
          ),
          Container(
            width: widget.contentWidth * 0.6,
            height: widget.contentHeight,
            child: PageView(
              onPageChanged: (page){
                // widget.pageCallback(page);
              },
              physics: NeverScrollableScrollPhysics(),
              controller: pageController,
              children: [
                Center(
                  child: Container(
                    child: Wrap(
                      alignment: WrapAlignment.center,
                      children: [
                        requestPageButton(
                          width: widget.contentWidth * 0.25,
                          height: widget.contentHeight * 0.2,
                          onPressed: (value){
                            setState(() {
                              widget.page = 1;
                              pageController!.animateToPage(1, duration: Duration(milliseconds: 500), curve: Curves.ease);
                            });
                          },
                          text: "Authorize",
                        ),
                        requestPageButton(
                          width: widget.contentWidth * 0.25,
                          height: widget.contentHeight * 0.2,
                          onPressed: (value){
                            // pageController!.jumpToPage(1);
                            if (widget.dataCallback != null){
                              widget.dataCallback(true);
                            }

                          },
                          text: "Data",
                        ),
                        requestPageButton(
                          width: widget.contentWidth * 0.25,
                          height: widget.contentHeight * 0.2,
                          onPressed: (value){
                            setState(() {
                              widget.page = 2;
                              pageController!.animateToPage(2, duration: Duration(milliseconds: 500), curve: Curves.ease);
                            });
                          },
                          text: "Deny",
                        ),
                        requestPageButton(
                          width: widget.contentWidth * 0.25,
                          height: widget.contentHeight * 0.2,
                          onPressed: (value){
                            setState(() {
                              widget.page = 3;
                              pageController!.animateToPage(3, duration: Duration(milliseconds: 500), curve: Curves.ease);
                            });
                          },
                          text: "Approve",
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
                      callback: (){
                        // widget.page = 0;
                        pageController!.animateToPage(0, duration: Duration(milliseconds: 500), curve: Curves.ease);
                      },
                      contentHeight: widget.contentHeight,
                      contentWidth: widget.contentWidth * 0.6,
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
                      contentHeight: widget.contentHeight,
                      contentWidth: widget.contentWidth * 0.6,
                      item: widget.item,
                      callback: (){
                        // widget.page = 0;
                        pageController!.animateToPage(0, duration: Duration(milliseconds: 500), curve: Curves.ease);
                      },
                      onComplete: (value){
                        widget.item = value;
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