import 'package:drive_easy/documents/Authorization_Whats_important.dart';
import 'package:drive_easy/documents/ExternalLink.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class Problem_with_OAuth2_and_SSO extends StatelessWidget {
  Function onpress;
  double? width;
  double? height;
  String? text;

  Problem_with_OAuth2_and_SSO({ 
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
          TextSpan(text: "Problem with OAuth2.0 and SSO?\n", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30, height: 2)),
        ])),),
        Align(alignment: Alignment.centerRight, child: RichText(textAlign: TextAlign.end, text: TextSpan(style: TextStyle(color: Colors.black, height: 2), children: [
          TextSpan(
            text: "Previous on Authorization\n",
            style: TextStyle(color: Colors.blue, decoration: TextDecoration.underline),
            recognizer: TapGestureRecognizer()..onTap = () {
              showDialog<void>(
                context: context,
                barrierDismissible: false,
                builder: (BuildContext ctx) { 
                  var key = GlobalKey();
                  return Dialog(
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.8,
                      width: MediaQuery.of(context).size.width * 0.8,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15)
                      ),
                      child: Authorization_Whats_important(
                        key: key,
                        text: "Go back",
                        onpress: () async {
                          Navigator.pop(key.currentContext!);
                        },
                      )
                    )
                  );
                }
              );
            }
          ),
        ])),),
        Center(child: RichText(textAlign: TextAlign.start, text: TextSpan(style: TextStyle(color: Colors.black, height: 2), children: const [
          TextSpan(text: "Remember on Authorization Chapter?\n"),
          TextSpan(text: "Attacker can easily take control of your online resources if gain permission.\n"),
          TextSpan(text: "But how did they gain the access?\n"),
        ])),),
        Container(
          padding: EdgeInsets.only(left: 50, right: 50),
          child: Image.asset("assets/images/tutorial/mitm.png",),
        ),
        Center(child: RichText(textAlign: TextAlign.start, text: TextSpan(style: TextStyle(color: Colors.black, height: 2), children: const [
          TextSpan(text: "\nWith OAuth2.0, if you give permission to bad guys,\n"),
          TextSpan(text: "they will have the token for accessing your account!\n"),
          TextSpan(text: "What even worst, with SSO attackers can access other application by your token!\n"),
        ])),),
        Container(
          padding: EdgeInsets.only(left: 50, right: 50),
          child: Image.asset("assets/images/tutorial/google_security_alert.png",),
        ),
        Center(child: RichText(textAlign: TextAlign.start, text: TextSpan(style: TextStyle(color: Colors.black, height: 2), children: const [
          TextSpan(text: "But don't worry, your service provider will probably be aware of this,\n"),
          TextSpan(text: "security alert should be sent, please keep concern with the alerts!\n\n"),
          TextSpan(text: "Basically, you need more attention on both Authorization and alerts nowadays!!\n", style: TextStyle(color: Colors.red)),
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
        // Padding(padding: EdgeInsets.only(left: 30, right: 30, top: 10, bottom: 10), child: Divider(color: Colors.black38,)),
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