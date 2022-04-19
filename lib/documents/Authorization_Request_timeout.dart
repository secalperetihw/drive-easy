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
    return Container(
      height: height,
      width: width,
      child: ListView(children: [
        Center(child: RichText(textAlign: TextAlign.center, text: TextSpan(style: TextStyle(color: Colors.black, height: 2), children: const [
          TextSpan(text: "What is Authorization\n", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30, height: 2)),
        ])),),
        
        Container(
          padding: EdgeInsets.only(left: 50, right: 50),
          child: Image.asset("assets/images/tutorial/Authentication_vs_Authorization.png",),
        ),
        Center(child: RichText(textAlign: TextAlign.start, text: TextSpan(style: TextStyle(color: Colors.black, height: 2), children: const [
          TextSpan(text: " - Authentication: identifing user e.g. by password\n"),
        ])),),
        Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          Center(child: RichText(textAlign: TextAlign.start, text: TextSpan(style: TextStyle(color: Colors.black, height: 2), children: const [
            TextSpan(text: "- Authorization: \n  one gives permission to other,\n  For example authorizing using Google:"),
          ])),),
          Container(
            padding: EdgeInsets.only(),
            child: Image.asset("assets/images/tutorial/Auth_user_refuse.jpg",),
          ),
        ],),
        
        Padding(padding: EdgeInsets.only(left: 30, right: 30, top: 10, bottom: 10), child: Divider(color: Colors.black38,)),
        Center(child: Wrap(children: [ElevatedButton(onPressed: () {
          onpress();
        }, child: Text(text ?? "Next"))],),),
        Padding(padding: EdgeInsets.only(left: 30, right: 30, top: 10, bottom: 10), child: Divider(color: Colors.black38,)),
        Container(
          padding: EdgeInsets.only(left: 20, right: 20),
          child: Center(child: RichText(textAlign: TextAlign.start, text: TextSpan(style: TextStyle(color: Colors.black, height: 2), children: [
            TextSpan(text: "References\n", style: TextStyle(fontWeight: FontWeight.bold)),
            TextSpan(text: "1. Okta: Authentication vs. Authorization\n    "),
            TextSpan(
              text: "https://www.okta.com/identity-101/authentication-vs-authorization/", 
              style: TextStyle(color: Colors.blue, decoration: TextDecoration.underline),
              recognizer: TapGestureRecognizer()..onTap = () async {
                const _url = "https://www.okta.com/identity-101/authentication-vs-authorization/";
                if (!await launch(_url)) throw 'Could not launch $_url';
              },
            ),
          ])),),

          
        ),
      ],),
    );
  }
}