import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class Authorization_Request_timeout extends StatelessWidget {
  Function onpress;
  double? width;
  double? height;
  String? text;

  Authorization_Request_timeout({ 
    Key? key,
    this.width,
    this.height,
    this.text,
    required this.onpress,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double? imageWidth;
    double? textWidth;
    if (width == null) {
      imageWidth = width;
      textWidth = width;
    } else {
      imageWidth = width! * 0.5;
      textWidth = width! * 0.3;
    }

    
    return Container(
      height: height,
      width: width,
      child: ListView(children: [
        Center(child: RichText(textAlign: TextAlign.center, text: TextSpan(style: TextStyle(color: Colors.black, height: 2), children: const [
          TextSpan(text: "What is Request timeout?\n", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30, height: 2)),
        ])),),
        Center(child: RichText(textAlign: TextAlign.start, text: TextSpan(style: TextStyle(color: Colors.black, height: 2), children: const [
          TextSpan(text: "\n"),
        ])),),
        Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          Container(
            width: textWidth,
            child: Center(child: RichText(textAlign: TextAlign.start, text: TextSpan(style: TextStyle(color: Colors.black, height: 2), children: const [
              TextSpan(text: "Refers to session timeout.\n"),
              TextSpan(text: "or sesion expired. e.g."),
            ])),),
          ),
          Container(
            width: imageWidth,
            padding: EdgeInsets.only(),
            child: Image.asset("assets/images/tutorial/session_timeout.jpg",),
          ),
        ],),
        Center(child: RichText(textAlign: TextAlign.start, text: TextSpan(style: TextStyle(color: Colors.black, height: 2), children: const [
          TextSpan(text: "Usually, most of application gives user certain session time.\n"),
          TextSpan(text: "With no activity after the session time, user will be auto log-out,\n"),
          TextSpan(text: "a re-signin/re-Authorization is need for further access.\n"),
        ])),),
        Center(child: RichText(textAlign: TextAlign.start, text: TextSpan(style: TextStyle(color: Colors.blue, height: 2), children: const [
          TextSpan(text: "\nIn our game it refers to someone wait for so long to give permission\n"),
          TextSpan(text: "and the server, which we communication to, just simply expire this token\n"),
          TextSpan(text: "Typically there's a need for re-Authorization,\n"),
          TextSpan(text: "but since we just simply introduce the idea here,\n"),
          TextSpan(text: "score will be normally given without any further operations.\n"),
        ])),),
        Padding(padding: EdgeInsets.only(left: 30, right: 30, top: 10, bottom: 10), child: Divider(color: Colors.black38,)),
        Center(child: Wrap(children: [ElevatedButton(onPressed: () {
          onpress();
        }, child: Text(text ?? "Next"))],),),
        // Padding(padding: EdgeInsets.only(left: 30, right: 30, top: 10, bottom: 10), child: Divider(color: Colors.black38,)),
        // Container(
        //   padding: EdgeInsets.only(left: 20, right: 20),
        //   child: Center(child: RichText(textAlign: TextAlign.start, text: TextSpan(style: TextStyle(color: Colors.black, height: 2), children: [
        //     TextSpan(text: "References\n", style: TextStyle(fontWeight: FontWeight.bold)),
        //     TextSpan(text: "1. Okta: Authentication vs. Authorization\n    "),
        //     TextSpan(
        //       text: "https://www.okta.com/identity-101/authentication-vs-authorization/", 
        //       style: TextStyle(color: Colors.blue, decoration: TextDecoration.underline),
        //       recognizer: TapGestureRecognizer()..onTap = () async {
        //         const _url = "https://www.okta.com/identity-101/authentication-vs-authorization/";
        //         if (!await launch(_url)) throw 'Could not launch $_url';
        //       },
        //     ),
        //   ])),),

          
        // ),
      ],),
    );
  }
}