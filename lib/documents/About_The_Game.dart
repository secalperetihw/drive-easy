import 'package:drive_easy/documents/ExternalLink.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class About_The_Game extends StatelessWidget {
  Function onpress;
  double? width;
  double? height;
  String? text;

  About_The_Game({ 
    this.width,
    this.height,
    this.text,
    required this.onpress,
    Key? key 
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      child: ListView(children: [
        Center(child: RichText(textAlign: TextAlign.center, text: TextSpan(style: TextStyle(color: Colors.black, height: 2), children: [
          TextSpan(text: "About the Game\n", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30, height: 2)),
        ])),),
        // Container(
        //   padding: EdgeInsets.only(left: 50, right: 50),
        //   child: Image.asset("assets/images/tutorial/Cloud_Storage.png",),
        // ),
        Center(child: RichText(textAlign: TextAlign.start, text: TextSpan(style: TextStyle(color: Colors.black, height: 2), children: const [
          TextSpan(text: "Background\n", style: TextStyle(fontWeight: FontWeight.bold)),
          TextSpan(text: "A company provide function for files transfer between different cloud storage service.\n"),
          TextSpan(text: "Which means a software for allowing manage multiple cloud stoage.\n"),
          TextSpan(text: "A transfer means a single request.\n"),
          TextSpan(text: "In this game, you will be one of the robot AI helping to handle the requests.\n"),
          TextSpan(text: "You are new to the company and need to get more familiar with the job.\n"),
        ])),),
        Padding(padding: EdgeInsets.only(left: 30, right: 30, top: 10, bottom: 10), child: Divider(color: Colors.black38,)),
        Center(child: Wrap(children: [ElevatedButton(onPressed: () {
          onpress();
        }, child: Text(text ?? "Next"))],),),
        Padding(padding: EdgeInsets.only(left: 30, right: 30, top: 10, bottom: 10), child: Divider(color: Colors.black38,)),
      ],),
    );
  }
}