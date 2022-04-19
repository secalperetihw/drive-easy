import 'package:drive_easy/documents/ExternalLink.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import 'What_is_POST_GET.dart';

class Relation_between_action_and_reqtype extends StatelessWidget {
  Function onpress;
  double? width;
  double? height;
  String? text;

  Relation_between_action_and_reqtype({ 
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
          TextSpan(text: "Relationship between \nAction and Request type\n", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30, height: 2)),
        ])),),
        Align(alignment: Alignment.centerRight, child: RichText(textAlign: TextAlign.end, text: TextSpan(style: TextStyle(color: Colors.black, height: 2), children: [
          TextSpan(
            text: "Previous on POST/GET\n",
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
                      child: What_is_POST_GET(
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
          TextSpan(text: "It's simply about the principle of Least Privilege in Cyber Security\n"),
          TextSpan(text: " - Give least possible permission in each operation\n\n", style: TextStyle(color: Colors.red)),
          TextSpan(text: "POST - Give write permission on certain folder\n"),
          TextSpan(text: "GET - Give read only permission for getting files\n"),
          TextSpan(text: "For security, all access should be highly avoided\n"),
        ])),),
        Container(
          padding: EdgeInsets.all(10),
          alignment: Alignment.centerRight,
          child: ExternalLink(context: context, url: "https://www.cisa.gov/uscert/bsi/articles/knowledge/principles/least-privilege")
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
            TextSpan(text: "1. CISA: Least Privilege\n    "),
            TextSpan(
              text: "https://www.cisa.gov/uscert/bsi/articles/knowledge/principles/least-privilege", 
              style: TextStyle(color: Colors.blue, decoration: TextDecoration.underline),
              recognizer: TapGestureRecognizer()..onTap = () async {
                const _url = "https://www.cisa.gov/uscert/bsi/articles/knowledge/principles/least-privilege";
                if (!await launch(_url)) throw 'Could not launch $_url';
              },
            ),
          ])),),
        ),
      ],),
    );
  }
}