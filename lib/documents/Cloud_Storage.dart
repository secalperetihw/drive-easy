import 'package:drive_easy/documents/ExternalLink.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class Cloud_Storage extends StatelessWidget {
  Function onpress;
  double? width;
  double? height;
  String? text;

  Cloud_Storage({ 
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
          TextSpan(text: "Cloud Storage\n", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30, height: 2)),
        ])),),
        Container(
          padding: EdgeInsets.only(left: 50, right: 50),
          child: Image.asset("assets/images/tutorial/Cloud_Storage.png",),
        ),
        Center(child: RichText(textAlign: TextAlign.start, text: TextSpan(style: TextStyle(color: Colors.black, height: 2), children: const [
          TextSpan(text: "Cloud storage gives data storage resources through online access.\n"),
          TextSpan(text: "There are free services towards personal uses.\n"),
          TextSpan(text: "e.g. Google Drive, iCloud, OneDrive etc.\n", style: TextStyle(color: Colors.grey)),
          TextSpan(text: "Also exist other towards business uses.\n"),
          TextSpan(text: "\n"),
          TextSpan(text: "It is also a leaf of SaaS model under modern cloud computing architecture.\n"),
          TextSpan(text: "\n"),
        ])),),
        Container(
          padding: EdgeInsets.all(10),
          alignment: Alignment.centerRight,
          child: ExternalLink(context: context, url: "https://electricalfundablog.com/cloud-storage-architecture-types/")
        ),
        Padding(padding: EdgeInsets.only(left: 30, right: 30, top: 10, bottom: 10), child: Divider(color: Colors.black38,)),
        Center(child: Wrap(children: [ElevatedButton(onPressed: () {
          onpress();
        }, child: Text(text ?? "Next"))],),),
        Padding(padding: EdgeInsets.only(left: 30, right: 30, top: 10, bottom: 10), child: Divider(color: Colors.black38,)),
        Container(
          padding: EdgeInsets.only(left: 20, right: 20),
          child: Center(child: RichText(textAlign: TextAlign.start, text: TextSpan(style: TextStyle(color: Colors.black, height: 2), children: [
            TextSpan(text: "References\n", style: TextStyle(fontWeight: FontWeight.bold)),
            TextSpan(text: "1. Laxmi Ashrit: What is Cloud Storage - Architecture, Types, Advantages & Disadvantages\n    "),
            TextSpan(
              text: "https://electricalfundablog.com/cloud-storage-architecture-types/", 
              style: TextStyle(color: Colors.blue, decoration: TextDecoration.underline),
              recognizer: TapGestureRecognizer()..onTap = () async {
                const _url = "https://electricalfundablog.com/cloud-storage-architecture-types/";
                if (!await launch(_url)) throw 'Could not launch $_url';
              },
            ),
          ])),),
        ),
      ],),
    );
  }
}