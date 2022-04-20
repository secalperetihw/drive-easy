import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class SSO extends StatelessWidget {
  Function onpress;
  double? width;
  double? height;
  String? text;

  SSO({ 
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
          TextSpan(text: "Single Sign On (SSO)\n", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30, height: 2)),
        ])),),
        Center(child: RichText(textAlign: TextAlign.start, text: TextSpan(style: TextStyle(color: Colors.black, height: 2), children: const [
          TextSpan(text: "SSO means technology allows one sign-in to access multiple applications\n"),
        ])),),
        Container(
          padding: EdgeInsets.only(left: 50, right: 50),
          child: Image.asset("assets/images/tutorial/SSO.jpg",),
        ),
        Center(child: RichText(textAlign: TextAlign.start, text: TextSpan(style: TextStyle(color: Colors.black, height: 2), children: const [
          TextSpan(text: "For example, you can sign-in Apple ID once to use multiple software,\n"),
          TextSpan(text: "iCloud, iTunes and App store etc.\n"),
          TextSpan(text: "Within session time or Company specific period.\n"),
          TextSpan(text: "\n"),
        ])),),
        Padding(padding: EdgeInsets.only(left: 30, right: 30, top: 10, bottom: 10), child: Divider(color: Colors.black38,)),
        Center(child: Wrap(children: [ElevatedButton(onPressed: () {
          onpress();
        }, child: Text(text ?? "Next"))],),),
        Padding(padding: EdgeInsets.only(left: 30, right: 30, top: 10, bottom: 10), child: Divider(color: Colors.black38,)),
        Container(
          padding: EdgeInsets.only(left: 20, right: 20),
          child: Center(child: RichText(textAlign: TextAlign.start, text: TextSpan(style: TextStyle(color: Colors.black, height: 2), children: [
            TextSpan(text: "References\n", style: TextStyle(fontWeight: FontWeight.bold)),
            TextSpan(text: "1. imangodoc: Introduction to SSO\n    "),
            TextSpan(
              text: "https://www.imangodoc.com/169371.html", 
              style: TextStyle(color: Colors.blue, decoration: TextDecoration.underline),
              recognizer: TapGestureRecognizer()..onTap = () async {
                const _url = "https://www.imangodoc.com/169371.html";
                if (!await launch(_url)) throw 'Could not launch $_url';
              },
            ),
          ])),),
        ),
      ],),
    );
  }
}