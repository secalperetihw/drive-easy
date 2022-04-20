import 'package:drive_easy/documents/ExternalLink.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class Third_Party_Application extends StatelessWidget {
  Function onpress;
  double? width;
  double? height;
  String? text;

  Third_Party_Application({ 
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
          TextSpan(text: "Third Party Application\n", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30, height: 2)),
        ])),),
        // Container(
        //   padding: EdgeInsets.only(left: 50, right: 50),
        //   child: Image.asset("assets/images/tutorial/Encryption_Decryption.png",),
        // ),
        Center(child: RichText(textAlign: TextAlign.start, text: TextSpan(style: TextStyle(color: Colors.black, height: 2), children: const [
          TextSpan(text: "Usually every cloud storage services provider will have their own application,\n"),
          TextSpan(text: "e.g. Google Drive website, moblie application etc.\n", style: TextStyle(color: Colors.grey)),
          TextSpan(text: "but they will also allow other access through the "),
          TextSpan(text: "API", style: TextStyle(color: Colors.red)),
          TextSpan(text: " they provided.\n"),
          TextSpan(text: "\n"),
          TextSpan(text: "In this game the company is simulating a third-party application to access APIs.\n", style: TextStyle(color: Colors.blue)),
        ])),),
        // Container(
        //   padding: EdgeInsets.all(10),
        //   alignment: Alignment.centerRight,
        //   child: ExternalLink(context: context, url: "https://mediawiki.middlebury.edu/LIS/Encryption")
        // ),
        Padding(padding: EdgeInsets.only(left: 30, right: 30, top: 10, bottom: 10), child: Divider(color: Colors.black38,)),
        Center(child: Wrap(children: [ElevatedButton(onPressed: () {
          onpress();
        }, child: Text(text ?? "Next"))],),),
        Padding(padding: EdgeInsets.only(left: 30, right: 30, top: 10, bottom: 10), child: Divider(color: Colors.black38,)),
        // Container(
        //   padding: EdgeInsets.only(left: 20, right: 20),
        //   child: Center(child: RichText(textAlign: TextAlign.start, text: TextSpan(style: TextStyle(color: Colors.black, height: 2), children: [
        //     TextSpan(text: "References\n", style: TextStyle(fontWeight: FontWeight.bold)),
        //     TextSpan(text: "1. Middlebury: Encryption\n    "),
        //     TextSpan(
        //       text: "https://mediawiki.middlebury.edu/LIS/Encryption", 
        //       style: TextStyle(color: Colors.blue, decoration: TextDecoration.underline),
        //       recognizer: TapGestureRecognizer()..onTap = () async {
        //         const _url = "https://mediawiki.middlebury.edu/LIS/Encryption";
        //         if (!await launch(_url)) throw 'Could not launch $_url';
        //       },
        //     ),
        //   ])),),
        // ),
      ],),
    );
  }
}