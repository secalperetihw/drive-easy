import 'package:drive_easy/classes/game/progress.dart';
import 'package:flutter/material.dart';

class GameReport extends StatefulWidget {
  Progress progress;

  GameReport({ 
    required this.progress,
    Key? key 
  }) : super(key: key);

  @override
  State<GameReport> createState() => _GameReportState();
}

class _GameReportState extends State<GameReport> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.8,
      width: MediaQuery.of(context).size.width * 0.9,
      decoration: BoxDecoration(
        color: Colors.transparent,
        border: Border.all(width: 1, color: Colors.white)
      ),
      child: ListView(
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.8,
            width: MediaQuery.of(context).size.width * 0.9,
            child: Wrap(
              children: [
                Container(padding: EdgeInsets.all(5), width: MediaQuery.of(context).size.width * 0.2,child: Wrap(children: [
                  Center(
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.15,
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                        border: Border.all(width: 1, color: Colors.white)
                      ), 
                      child: Center(child: Icon(Icons.account_box, color: Colors.white, size: MediaQuery.of(context).size.width * 0.15,)),
                    ),
                  ),
                  Center(
                    child: Container(width: MediaQuery.of(context).size.width * 0.15, child: RichText(
                      textAlign: TextAlign.start, text: TextSpan(style: TextStyle(height: 1.5, color: Colors.white), children: const [
                        TextSpan(text: "Name: player\n"),
                        TextSpan(text: "ID: 123456\n"),
                        TextSpan(text: "Employed since: 01/04/2022\n"),
                      ]),
                    ),),
                  )
                ],),),
                Container(height: MediaQuery.of(context).size.height * 0.8, child: VerticalDivider(color: Colors.grey,)),
                Container(width: MediaQuery.of(context).size.width * 0.4,child: Wrap(children: [
                  Container(
                    padding: EdgeInsets.all(15), 
                    width: MediaQuery.of(context).size.width * 0.4,
                    child: RichText(textAlign: TextAlign.center, text: TextSpan(style: TextStyle(color: Colors.white, height: 2), children: [
                      TextSpan(text: "Record\n", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30)),
                      TextSpan(text: "Rating: "),
                      TextSpan(text: widget.progress.calRating() + "\n", style: TextStyle(fontSize: 30, color: Colors.red)),
                      TextSpan(text: "Score: "),
                      TextSpan(text: "${widget.progress.lifeScore.toString()}/${widget.progress.lifeTotalScore.toString()}\n", style: TextStyle(color: Colors.red)),
                      TextSpan(text: "Total tasks completed: "),
                      TextSpan(text: (widget.progress.totalSuccess!.toInt() + widget.progress.totalFailed!.toInt()).toString() + "\n", style: TextStyle(color: Colors.red)),
                      TextSpan(text: "Total tasks successed: "),
                      TextSpan(text: widget.progress.totalSuccess.toString() + "\n", style: TextStyle(color: Colors.red)),
                      TextSpan(text: "Total tasks failed: "),
                      TextSpan(text: widget.progress.totalFailed.toString() + "\n", style: TextStyle(color: Colors.red)),
                    ])),
                  )
                ]))
              ],
            ),
          )
          
        ],
      )
    );
  }
}