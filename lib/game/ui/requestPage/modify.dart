import 'package:drive_easy/classes/game/item.dart';
import 'package:drive_easy/game/game_home.dart';
import 'package:drive_easy/game/ui/requestPage/requestClasses.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:googleapis/admob/v1.dart';

class modifyPage extends StatefulWidget {
  modifyPage({ 
    Key? key,
    this.game,
    required this.item,
    required this.contentHeight,
    required this.contentWidth
  }) : super(key: key);

  final GameMain? game;
  Item item;
  double contentWidth;
  double contentHeight;

  @override
  _modifyPageState createState() => _modifyPageState();
}

class _modifyPageState extends State<modifyPage> {
  String text = "";
  int selected = 0;

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight
    ]);
    return Container(
      width: widget.contentWidth,
      height: widget.contentHeight,
      padding: EdgeInsets.all(25),
      color: Colors.black,
      child: Wrap(
        children: [
          Container(
            height: widget.contentHeight * 0.8,
            width: widget.contentWidth * 0.5,
            child: MediaQuery.removePadding(
              context: context,
              removeTop: true,
              child: ListView(
                scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                padding: EdgeInsets.zero,
                children: [
                  Container(
                    width: widget.contentWidth * 0.5,
                    // height: widget.contentHeight * 0.7,
                    child: Wrap(
                      children: (widget.item.content?.map((e) => 
                        Container(
                          width: widget.contentWidth * 0.5,
                          // height: widget.contentHeight * 0.2,
                          padding: EdgeInsets.only(bottom: 5),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey)
                          ),
                          child: ListTile(
                            title: Row(
                              children: [
                                Container(
                                  child: Text("${widget.item.content?.indexOf(e).toString() ?? ""}   ", style: TextStyle(color: Colors.grey),)
                                ),
                                Container(
                                  width: widget.contentWidth * 0.4,
                                  child: RichText(
                                    text: TextSpan(
                                      children: [
                                        TextSpan(text: e.toString(), style: TextStyle(color: Colors.white),),
                                      ],
                                    )
                                  ),
                                ),
                              ],
                            ),
                            onTap: (){
                              setState(() {
                                selected = widget.item.content?.indexOf(e) ?? 0;
                                text = e;
                              });
                            },
                            tileColor: Colors.white,
                          ),
                        )
                      ) ?? {}).toList(),
                    ),
                  ),
                  
                ],
              ),
            ),
          ),
          Container(
            width: widget.contentWidth * 0.4,
            height: widget.contentHeight * 0.8,
            alignment: Alignment.center,
            child: Wrap(
              alignment: WrapAlignment.center,
              children: [
                Container(
                  alignment: Alignment.center,
                  width: widget.contentWidth * 0.4,
                  child: Text(
                    "Functions:",
                    style: TextStyle(color: Colors.red),
                  ),
                ),
                requestPageButton(
                  width: widget.contentWidth * 0.15,
                  height: widget.contentHeight * 0.1,
                  onPressed: (value){

                  },
                  text: "Encrypt",
                ),
                requestPageButton(
                  width: widget.contentWidth * 0.15,
                  height: widget.contentHeight * 0.1,
                  onPressed: (value){

                  },
                  text: "Decrypt",
                ),
                requestPageButton(
                  width: widget.contentWidth * 0.15,
                  height: widget.contentHeight * 0.1,
                  onPressed: (value){
                    setState(() {
                      widget.item.content?[selected] = widget.item.content![selected].replaceAll("(", "\\(");
                      widget.item.content?[selected] = widget.item.content![selected].replaceAll(")", "\\)");
                      widget.item.content?[selected] = widget.item.content![selected].replaceAll("{", "\\{");
                      widget.item.content?[selected] = widget.item.content![selected].replaceAll("}", "\\}");
                      text = widget.item.content?[selected] ?? "";
                    });
                  },
                  text: "Actions",
                ),
              ],
            ),
          ),
          Container(
            width: widget.contentWidth,
            padding: EdgeInsets.all(5),
            child: Text(
              widget.item.source.toString().split(".")[1] + 
              "\\DriveEasy\\" + widget.item.name.toString() + "\\>" + text + "_", 
              style: TextStyle(color: Colors.white),
              overflow: TextOverflow.clip,
            ),
          )
        ],
      )
    );
  }
}