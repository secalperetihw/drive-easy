import 'package:drive_easy/classes/game/email.dart';
import 'package:drive_easy/classes/game/progress.dart';
import 'package:flutter/material.dart';

class EmailPage extends StatefulWidget {
  Progress progress;
  GameEmail? displayEmail;
  ValueChanged<bool> allRead;

  EmailPage({
    Key? key,
    required this.displayEmail,
    required this.progress,
    required this.allRead,
  }) : super(key: key);

  

  @override
  State<EmailPage> createState() => _EmailPageState();
}

class _EmailPageState extends State<EmailPage> {
  late ScrollController _scrollController;
  int chosenEmail = 0;
  List<String> content = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _scrollController = ScrollController();
    chosenEmail = widget.progress.emails!.length - 1;

    

    
  }

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
              height: MediaQuery.of(context).size.height * 0.78,
              width: MediaQuery.of(context).size.width * 0.3,
              child: MediaQuery.removePadding(context: context, removeTop: true, 
              child: ListView.builder(itemCount: widget.progress.emails?.length, itemBuilder: (ctx, index)  {
                int realIndex = (widget.progress.emails?.length ?? 1) - index - 1;
                return Container(
                  child: Column(
                    children: [
                      GestureDetector(
                        onLongPress: () async {
                        },
                        onTap: (){
                          setState(() {
                            widget.displayEmail = widget.progress.emails?[realIndex];
                            widget.progress.emails?[realIndex].read = true;
                            _scrollController.jumpTo(0);
                            chosenEmail = realIndex;
                            content = [];
                            content.addAll(widget.displayEmail?.content?.split("\n") ?? []);
                            for (int i=0; i<content.length; i++) {
                              content[i] += "\n";
                            }

                            bool check = true;
                            for (GameEmail email in widget.progress.emails!) {
                              if (!(email.read ?? true)) {
                                check = false;
                              }
                            }
                            widget.allRead(check);
                          });
                        },
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.3,
                          child: Wrap(
                            alignment: WrapAlignment.spaceBetween,
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width * 0.3,
                                child: Wrap(alignment: WrapAlignment.spaceBetween, children: [
                                  Container(
                                    width: MediaQuery.of(context).size.width * 0.25,
                                    child: Text(widget.progress.emails![realIndex].title ?? "", style: TextStyle(color: (widget.progress.emails![realIndex].read ?? false) ? Colors.grey : Colors.white, fontWeight: FontWeight.bold)),
                                  ),
                                  Container(
                                    child: RichText(textAlign: TextAlign.end, text: TextSpan(style: TextStyle(color: Colors.grey), children: [
                                    TextSpan(text: "${widget.progress.emails![realIndex].time?.day.toString()}/${widget.progress.emails![realIndex].time?.month.toString()}", style: TextStyle())
                                  ])),
                                  ),
                                ]),
                              ),
                              
                              Container(
                                width: MediaQuery.of(context).size.width * 0.3,
                                child: Text("from: ${widget.progress.emails![realIndex].from}", style: TextStyle(overflow: TextOverflow.ellipsis, color: (widget.progress.emails![realIndex].read ?? false) ? Colors.grey : Colors.white)),
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width * 0.3,
                                child: Text("${widget.progress.emails![realIndex].content!.split("\n")[0]}", style: TextStyle(overflow: TextOverflow.ellipsis, color: Colors.grey)),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Divider(color:  (chosenEmail == realIndex) ? Colors.blue : Colors.white,),
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
              height: MediaQuery.of(context).size.height * 0.78,
              width: MediaQuery.of(context).size.width * 0.5,
              child: MediaQuery.removePadding(context: context, removeTop: true, child: ListView(
                controller: _scrollController,
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
                      TextSpan(text: "\n   "),
                      for (String s in content)...[
                        
                        TextSpan(text: s, style: widget.displayEmail?.style?[content.indexOf(s)] ?? TextStyle()),
                      ]
                      // TextSpan(text: "\n   ${widget.displayEmail?.content ?? ""}"),
                      
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