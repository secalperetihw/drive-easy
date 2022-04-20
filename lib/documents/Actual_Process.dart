import 'package:drive_easy/documents/ExternalLink.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class Actual_Process extends StatelessWidget {
  Function onpress;
  double? width;
  double? height;
  String? text;

  Actual_Process({ 
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
          TextSpan(text: "Process of actual file transfer\n", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30, height: 2)),
        ])),),
        // Container(
        //   padding: EdgeInsets.only(left: 50, right: 50),
        //   child: Image.asset("assets/images/tutorial/Encryption_Decryption.png",),
        // ),
        Center(child: RichText(textAlign: TextAlign.start, text: TextSpan(style: TextStyle(color: Colors.black, height: 2), children: const [
          TextSpan(text: "1. Third-party application receive the file transfer request.\n"),
          TextSpan(text: "2. Ask cloud storage service provider for Authentication.\n"),
          TextSpan(text: "3. Authentication done.\n"),
          TextSpan(text: "4. Cloud storage service provider ask user for Authorization.\n"),
          TextSpan(text: "5. Authorization done.\n"),
          TextSpan(text: "6. Third-party application connect API.\n"),
          TextSpan(text: "7. Third-party application initialize HTTP request.\n"),
          TextSpan(text: "8. Using SSL/TLS protocol encrypt the HTTP into HTTPS request.\n"),
          TextSpan(text: "9. Cloud storage service provider server response: success or failed.\n"),
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