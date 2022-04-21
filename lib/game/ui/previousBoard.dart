import 'package:drive_easy/classes/game/item.dart';
import 'package:drive_easy/classes/game/progress.dart';
import 'package:drive_easy/game/ui/requestPage/request.dart';
import 'package:flutter/material.dart';

class PreviousBoard extends StatefulWidget {
  Progress progress;
  double contentHeight;
  double contentWidth;
  DateTime timeNow;

  PreviousBoard({ 
    Key? key,
    required this.progress,
    required this.contentHeight,
    required this.contentWidth,
    required this.timeNow,
  }) : super(key: key);

  @override
  State<PreviousBoard> createState() => _PreviousBoardState();
}

class _PreviousBoardState extends State<PreviousBoard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.contentHeight,
      width: widget.contentWidth,
      decoration: BoxDecoration(
        color: Colors.transparent,
        border: Border.all(width: 1, color: Colors.white)
      ),
      child: ListView (
        children: [
          // Wrap(
          //   alignment: WrapAlignment.spaceEvenly,
          //   children: widget.progress.previousRequests.map((e) {
          //     Container(
          //       padding: EdgeInsets.all(10),
          //       child: GestureDetector(
          //         onTap: () async {
                    
          //           await Navigator.push(context, MaterialPageRoute(builder: (context) => RequestMainPage(
          //             tutorial: false,
          //             tutorialOffset: (e.reqId is String) ? int.parse(e.reqId) : e.reqId,
          //             itemCallback: (value) {
          //             },
          //             progress: widget.progress,
          //             item: e,
          //             timeNow: widget.timeNow,
          //           )));
                    
          //         },
          //         child: Container(
          //           padding: EdgeInsets.all(15),
          //           decoration: BoxDecoration(
          //             color: Colors.black, 
          //             border: Border.all(
          //               width: 1, 
          //               color: (e.finish ?? false) ? ( (e.success ?? false) ? Colors.green : Colors.red) : Colors.white
          //             )
          //           ),
          //           child: Column(
          //             children: [
          //               RichText(text: TextSpan(style: TextStyle(color: (e.finish ?? false) ? Colors.grey : Colors.white), children: [
          //                 TextSpan(text: "request: ", style: TextStyle(color: Colors.grey)),
          //                 TextSpan(text: "${e.name}\n"),
          //                 TextSpan(text: "ID: ", style: TextStyle(color: Colors.grey)),
          //                 TextSpan(text: "${e.reqId.toString()}\n"),
          //                 TextSpan(text: "Task: ", style: TextStyle(color: Colors.grey)),
          //                 TextSpan(text: "${Item.convert(e.reqType)}\n"),
          //                 TextSpan(text: "Time needed: ", style: TextStyle(color: Colors.grey)),
          //                 TextSpan(text: "${e.timeNeeded?.inHours.toString()} hours\n"),
                          
          //               ]),),
          //               if (e.finish ?? false) ...[
          //                 RichText(text: TextSpan(style: TextStyle(color: (e.finish ?? false) ? Colors.grey : Colors.white), children: [
          //                   TextSpan(text: "Score: ", style: TextStyle(color: Colors.grey)),
          //                   TextSpan(text: "${
          //                     (e.finish ?? false) ? e.score : 0
          //                   }/${
          //                     (e.finish ?? false) ? e.totalScore : 0
          //                   }"),
          //                 ]),),
          //               ],
          //             ],
          //           )
          //         ),
          //       ),
          //     );
          //   }).toList() as List<Widget>
              
            
          // ),
        ],
      ),
    );
  }
}