import 'package:drive_easy/game/ui/requestPage/requestClasses.dart';
import 'package:flutter/material.dart';

class requestApprove extends StatefulWidget {
  double contentHeight;
  double contentWidth;
  Function callback;

  requestApprove({ 
    required this.contentHeight,
    required this.contentWidth,
    required this.callback,
    Key? key 
  }) : super(key: key);

  @override
  State<requestApprove> createState() => _requestApproveState();
}

class _requestApproveState extends State<requestApprove> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.contentWidth,
      height: widget.contentHeight,
      alignment: Alignment.center,
      child: Wrap(
        alignment: WrapAlignment.center,
        children: [
          Container(
            width: widget.contentWidth * 0.6,
            height: widget.contentHeight,
            alignment: Alignment.center,
            child: RichText(
              textAlign: TextAlign.center,
              text: TextSpan(children: [
                TextSpan(text: "Are you sure to approve the request? \n\n", style: TextStyle(color: Colors.red, fontSize: 20),),
                TextSpan(text: "Wrong or malicious request will result in punishment of scores, continue?", style: TextStyle(color: Colors.grey, fontSize: 12)),
              ]),
            ),
          ),
          Container(
            width: widget.contentWidth * 0.3,
            height: widget.contentHeight,
            alignment: Alignment.center,
            child: Wrap(
              alignment: WrapAlignment.center,
              children: [
                Text("", style: TextStyle(color: Colors.white)),
                requestPageButton(
                  width: widget.contentWidth * 0.3,
                  height: widget.contentHeight * 0.1,
                  onPressed: (value){
                  }, 
                  text: "Done"
                ),
                requestPageButton(
                  width: widget.contentWidth * 0.3,
                  height: widget.contentHeight * 0.1,
                  onPressed: (value){
                    widget.callback();
                  }, 
                  text: "Back"
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}