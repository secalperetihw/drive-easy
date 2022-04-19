import 'package:drive_easy/documents/ExternalLink.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class What_is_Encryption extends StatelessWidget {
  Function onpress;
  double? width;
  double? height;
  String? text;

  What_is_Encryption({ 
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
          TextSpan(text: "What is Encryption?\n", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30, height: 2)),
        ])),),
        Container(
          padding: EdgeInsets.only(left: 50, right: 50),
          child: Image.asset("assets/images/tutorial/Encryption_Decryption.png",),
        ),
        Center(child: RichText(textAlign: TextAlign.start, text: TextSpan(style: TextStyle(color: Colors.black, height: 2), children: const [
          TextSpan(text: "Encrypt data, change all plain text to ciphtext that no one can read.\n"),
          TextSpan(text: "For HTTP requests, encryption will be using"),
          TextSpan(text: " HTTPS ", style: TextStyle(color: Colors.red)), 
          TextSpan(text: "protocol on top of TLS.\n\n"),
          TextSpan(text: "!!! IMPORTANT !!!\n", style: TextStyle(color: Colors.red)), 
          TextSpan(text: "Nowadays, data will be encrypted is most secure algorithms such as AES256\n"),
          TextSpan(text: "E.g. Google drive use mordern AES256 to encrypt all data,\nbut some old data are encrypted in AES128 is also accepted\n"),
          TextSpan(text: "In later game, you will need to check the encryption type with destination drive\n", style: TextStyle(color: Colors.red)),
          TextSpan(text: "E.g. Google drive can use both AES256 and AES128, but others may not\n", style: TextStyle(color: Colors.red)),
          TextSpan(text: "\nAdvanced Encryption Standard (AES) is a trusted standard by US government nowadays\n"),
        ])),),
        Container(
          padding: EdgeInsets.all(10),
          alignment: Alignment.centerRight,
          child: ExternalLink(context: context, url: "https://mediawiki.middlebury.edu/LIS/Encryption")
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
            TextSpan(text: "1. Middlebury: Encryption\n    "),
            TextSpan(
              text: "https://mediawiki.middlebury.edu/LIS/Encryption", 
              style: TextStyle(color: Colors.blue, decoration: TextDecoration.underline),
              recognizer: TapGestureRecognizer()..onTap = () async {
                const _url = "https://mediawiki.middlebury.edu/LIS/Encryption";
                if (!await launch(_url)) throw 'Could not launch $_url';
              },
            ),
          ])),),
        ),
      ],),
    );
  }
}