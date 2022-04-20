import 'package:drive_easy/documents/ExternalLink.dart';
import 'package:drive_easy/documents/Problem_with_OAuth2_and_SSO.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class REST_API extends StatelessWidget {
  Function onpress;
  double? width;
  double? height;
  String? text;

  REST_API({ 
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
          TextSpan(text: "RESTful APIs\n", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30, height: 2)),
        ])),),
        Center(child: RichText(textAlign: TextAlign.start, text: TextSpan(style: TextStyle(color: Colors.black, height: 2), children: const [
          TextSpan(text: "A model/standard for software developers to implement their API.\n"),
          TextSpan(text: "Aim to provide light-workload implement experiences for third-party application developers\n"),
        ])),),
        Container(
          padding: EdgeInsets.only(left: 50, right: 50),
          child: Image.asset("assets/images/tutorial/rest_api.png",),
        ),
        Center(child: RichText(textAlign: TextAlign.start, text: TextSpan(style: TextStyle(color: Colors.black, height: 2), children: const [
          TextSpan(text: "\n"),
          TextSpan(text: "Nowadays many company adapt the model of RESTful API.\n"),
          TextSpan(text: "\n"),
          TextSpan(text: "For most of the popular personal use cloud storage services providers, \n"),
          TextSpan(text: "they also provide REST APIs for developers,\n"),
          TextSpan(text: "These make implementation more easier combining with OAuth2.0.\n"),
          TextSpan(text: "\n"),
          TextSpan(text: "But the convenience will bring security concern.\n", style: TextStyle(color: Colors.red)),
          TextSpan(text: "Check out previous session for more details.\n"),
        ])),),
        Align(alignment: Alignment.centerRight, child: RichText(textAlign: TextAlign.end, text: TextSpan(style: TextStyle(color: Colors.black, height: 2), children: [
          TextSpan(
            text: "Problem with OAuth2 and SSO\n",
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
                      child: Problem_with_OAuth2_and_SSO(
                        key: key,
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
        Container(
          padding: EdgeInsets.all(10),
          alignment: Alignment.centerRight,
          child: ExternalLink(context: context, url: "https://www.ibm.com/hk-en/cloud/learn/rest-apis")
        ),
        Padding(padding: EdgeInsets.only(left: 30, right: 30, top: 10, bottom: 10), child: Divider(color: Colors.black38,)),
        Center(child: Wrap(children: [ElevatedButton(onPressed: () {
          onpress();
        }, child: Text(text ?? "Next"))],),),
        Padding(padding: EdgeInsets.only(left: 30, right: 30, top: 10, bottom: 10), child: Divider(color: Colors.black38,)),
        Container(
          padding: EdgeInsets.only(left: 20, right: 20),
          child: Center(child: RichText(textAlign: TextAlign.start, text: TextSpan(style: TextStyle(color: Colors.black, height: 2), children: [
            TextSpan(text: "IBM\n", style: TextStyle(fontWeight: FontWeight.bold)),
            TextSpan(text: "1. REST APIs\n    "),
            TextSpan(
              text: "https://www.ibm.com/hk-en/cloud/learn/rest-apis", 
              style: TextStyle(color: Colors.blue, decoration: TextDecoration.underline),
              recognizer: TapGestureRecognizer()..onTap = () async {
                const _url = "https://www.ibm.com/hk-en/cloud/learn/rest-apis";
                if (!await launch(_url)) throw 'Could not launch $_url';
              },
            ),
          ])),),
        ),
      ],),
    );
  }
}