import 'package:drive_easy/documents/ExternalLink.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class What_is_POST_GET extends StatelessWidget {
  Function onpress;
  double? width;
  double? height;
  String? text;  

  What_is_POST_GET({ 
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
          TextSpan(text: "What is POST/GET?\n", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30, height: 2)),
        ])),),
        Container(
          padding: EdgeInsets.only(left: 0, right: 0),
          child: Image.asset("assets/images/tutorial/HTTP_POST.png",),
        ),
        Center(child: RichText(textAlign: TextAlign.start, text: TextSpan(style: TextStyle(color: Colors.black, height: 2), children: const [
          TextSpan(text: "They are both "),
          TextSpan(text: "HTTP requests ", style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold)),
          TextSpan(text: "that need for communicating between client and server,\n"),
          TextSpan(text: "POST means a request to"),
          TextSpan(text: " update data\n", style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold)),
          TextSpan(text: "Other data are hidden inside the HTTP request body. \n"),
          TextSpan(text: "Just like the above example, it upload files to google drive!"),
        ])),),
        Container(
          padding: EdgeInsets.only(left: 0, right: 0),
          child: Image.asset("assets/images/tutorial/HTTP_POST_2.png",),
        ),
        Center(child: RichText(textAlign: TextAlign.start, text: TextSpan(style: TextStyle(color: Colors.black, height: 2), children: const [
          TextSpan(text: "And GET is requesting to server for receiving certain data\n"),
          TextSpan(text: "The server will responds the data to client."),
        ])),),
        Container(
          padding: EdgeInsets.all(10),
          alignment: Alignment.centerRight,
          child: ExternalLink(context: context, url: "https://www.w3schools.com/tags/ref_httpmethods.asp")
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
            TextSpan(text: "1. w3schools: HTTP Request Methods\n    "),
            TextSpan(
              text: "https://www.w3schools.com/tags/ref_httpmethods.asp", 
              style: TextStyle(color: Colors.blue, decoration: TextDecoration.underline),
              recognizer: TapGestureRecognizer()..onTap = () async {
                const _url = "https://www.w3schools.com/tags/ref_httpmethods.asp";
                if (!await launch(_url)) throw 'Could not launch $_url';
              },
            ),
          ])),),
        ),
      ],),
    );
  }
}