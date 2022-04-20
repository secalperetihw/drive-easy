import 'package:drive_easy/documents/ExternalLink.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class SSL_TLS extends StatelessWidget {
  Function onpress;
  double? width;
  double? height;
  String? text;

  SSL_TLS({ 
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
          TextSpan(text: "SSL/TLS\n", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30, height: 2)),
        ])),),
        Center(child: RichText(textAlign: TextAlign.start, text: TextSpan(style: TextStyle(color: Colors.black, height: 2), children: const [
          TextSpan(text: "Transfer protocal used to secure the transfer.\n"),
          TextSpan(text: "Usually refers to Encrypt HTTP requests into HTTPs.\n"),
          TextSpan(text: "But why when the content is encrypted, we still need to filter the data?\n"),
        ])),),
        Container(
          padding: EdgeInsets.only(left: 10, right: 10),
          child: Image.asset("assets/images/tutorial/SSL_TLS.png",),
        ),
        Center(child: RichText(textAlign: TextAlign.start, text: TextSpan(style: TextStyle(color: Colors.black, height: 2), children: const [
          
          TextSpan(text: "This is because there still possible for code injection that will harm the application.\n"),
          TextSpan(text: "The network communication are always in-direct, it will pass through serval DNS server.\n"),
          TextSpan(text: "Which means it exist possiblility that someone will inject code in the request,\n"),
          TextSpan(text: "although they can't see the content inside.\n"),
        ])),),
        Container(
          padding: EdgeInsets.only(left: 50, right: 50),
          child: Image.asset("assets/images/tutorial/mitm.png",),
        ),
        Center(child: RichText(textAlign: TextAlign.start, text: TextSpan(style: TextStyle(color: Colors.black, height: 2), children: const [
          TextSpan(text: "This kind of attack are classifly as "),
          TextSpan(text: "Man-in-the-Middle-Attack", style: TextStyle(color: Colors.red)),
          TextSpan(text: ".\n"),
          TextSpan(text: "\n"),
          TextSpan(text: "Therefore, both "),
          TextSpan(text: "Encryption", style: TextStyle(color: Colors.red)),
          TextSpan(text: " and "),
          TextSpan(text: "Filtering", style: TextStyle(color: Colors.red)),
          TextSpan(text: " is important!\n"),
        ])),),
        Container(
          padding: EdgeInsets.all(10),
          alignment: Alignment.centerRight,
          child: ExternalLink(context: context, url: "https://en.wikipedia.org/wiki/Man-in-the-middle_attack")
        ),
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