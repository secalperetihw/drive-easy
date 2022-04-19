import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class Authorization_Whats_important extends StatelessWidget {
  Function onpress;
  double? width;
  double? height;
  String? text;

  Authorization_Whats_important({ 
    Key? key,
    this.width,
    this.height,
    this.text,
    required this.onpress,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      child: ListView(children: [
        Center(child: RichText(textAlign: TextAlign.center, text: TextSpan(style: TextStyle(color: Colors.black, height: 2), children: const [
          TextSpan(text: "What's important about Authorization\n", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30, height: 2)),
        ])),),
        Center(child: RichText(textAlign: TextAlign.start, text: TextSpan(style: TextStyle(color: Colors.black, height: 2), children: const [
          TextSpan(text: " - Giving permission for operations\n"),
          TextSpan(text: " - e.g. Give access to third-party application to access your google drive\n"),
        ])),),
        Container(
          padding: EdgeInsets.only(left: 50, right: 50),
          child: Image.asset("assets/images/tutorial/Authorization_Whats_important.png",),
        ),
        Center(child: RichText(textAlign: TextAlign.start, text: TextSpan(style: TextStyle(color: Colors.black, height: 2), children: const [
          TextSpan(text: "Remember this? Yes! this is simulating a third-party application\n"),
          TextSpan(text: "gaining access from "),
          TextSpan(text: "you", style: TextStyle(color: Colors.red)),
          TextSpan(text: ".\nSome bad attackers can use this permission for bad operation!\n"),
          TextSpan(text: "e.g. delete all your files!\n\n", style: TextStyle(fontWeight: FontWeight.bold)),
          TextSpan(text: "In this circumstance, you are the one responsible for\n"),
          TextSpan(text: "giving out permission \n"),
          TextSpan(text: "Be careful when Authorizing those third-party application!\n", style: TextStyle(color: Colors.red)),
          TextSpan(text: "Watch carefully what permissions it want!\n", style: TextStyle(color: Colors.red)),
        ])),),
        
        Padding(padding: EdgeInsets.only(left: 30, right: 30, top: 10, bottom: 10), child: Divider(color: Colors.black38,)),
        Center(child: Wrap(children: [ElevatedButton(onPressed: () {
          onpress();
        }, child: Text(text ?? "Next"))],),),
      ],),
    );
  }
}