import 'package:drive_easy/documents/ExternalLink.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class OAuth2 extends StatelessWidget {
  Function onpress;
  double? width;
  double? height;
  String? text;

  OAuth2({ 
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
          TextSpan(text: "OAuth2.0", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30, height: 2)),
        ])),),
        Center(child: RichText(textAlign: TextAlign.start, text: TextSpan(style: TextStyle(color: Colors.black, height: 2), children: const [
          TextSpan(text: "Actually, the Authorization method discussed is according to mordern OAuth2.0 framework.\n"),
        ])),),
        Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          Center(child: RichText(textAlign: TextAlign.start, text: TextSpan(style: TextStyle(color: Colors.black, height: 2), children: const [
            TextSpan(text: "1. send auth request\n"),
            TextSpan(text: "2. wait response token\n"),
            TextSpan(text: "3. verify token received\n"),
            TextSpan(text: "4. response\n"),
            TextSpan(text: "5. call APIs: e.g. HTTP requests\n"),
            TextSpan(text: "6. server data response\n"),
          ])),),
          Image.asset("assets/images/tutorial/OAuth.png",),
        ],),
        Center(child: RichText(textAlign: TextAlign.start, text: TextSpan(style: TextStyle(color: Colors.black, height: 2), children: const [
          TextSpan(text: "Conclusion: \n1. You check the permission\n2. click deny or accept.\n3. third-party app and service provider (e.g. Google)\n    take control of operations\n"),
        ])),),
        Center(child: Icon(Icons.emoji_emotions, color: Colors.orange,),),
        Container(
          padding: EdgeInsets.all(10),
          alignment: Alignment.centerRight,
          child: ExternalLink(context: context, url: "https://oauth.net/2/")
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
            TextSpan(text: "1. OAuth: OAuth2.0\n    "),
            TextSpan(
              text: "https://oauth.net/2/\n", 
              style: TextStyle(color: Colors.blue, decoration: TextDecoration.underline),
              recognizer: TapGestureRecognizer()..onTap = () async {
                const _url = "https://oauth.net/2/";
                if (!await launch(_url)) throw 'Could not launch $_url';
              },
            ),
            TextSpan(text: "2. Google: Using OAuth 2.0 to Access Google APIs\n    "),
            TextSpan(
              text: "https://developers.google.com/identity/protocols/oauth2", 
              style: TextStyle(color: Colors.blue, decoration: TextDecoration.underline),
              recognizer: TapGestureRecognizer()..onTap = () async {
                const _url = "https://developers.google.com/identity/protocols/oauth2";
                if (!await launch(_url)) throw 'Could not launch $_url';
              },
            ),
          ])),),
        ),
      ],),
    );
  }
}