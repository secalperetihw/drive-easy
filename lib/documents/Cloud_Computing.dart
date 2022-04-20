import 'package:drive_easy/documents/ExternalLink.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class Cloud_Computing extends StatelessWidget {
  Function onpress;
  double? width;
  double? height;
  String? text;

  Cloud_Computing({ 
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
          TextSpan(text: "Cloud Computing\n", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30, height: 2)),
        ])),),
        Center(child: RichText(textAlign: TextAlign.start, text: TextSpan(style: TextStyle(color: Colors.black, height: 2), children: const [
          TextSpan(text: "Provide online access to connect service provders servers,\n"),
          TextSpan(text: "which the servers are typically virtuallized hardware resources.\n"),
          TextSpan(text: "The resoures distribution, load balances, virtual resources etc.\n"),
          TextSpan(text: "they are all describing what Cloud Computing is doing.\n"),
          TextSpan(text: "There are 3 important model in Cloud Computing:\n"),
          TextSpan(text: "SaaS, PaaS and IaaS.\n"),
        ])),),
        Container(
          padding: EdgeInsets.only(left: 50, right: 50),
          child: Image.asset("assets/images/tutorial/Cloud_Computing.png",),
        ),
        Center(child: RichText(textAlign: TextAlign.start, text: TextSpan(style: TextStyle(color: Colors.black, height: 2), children: const [
          TextSpan(text: "For modern personal use cloud storage/cloud drives,\n"),
          TextSpan(text: "it is categorize to Software-as-a-Service(SaaS).\n"),
          TextSpan(text: "It provide limited access to the virtual resources.\n"),
          TextSpan(text: "where PaaS refers to e.g. providing database, web servers.\n"),
          TextSpan(text: "IaaS refers to e.g. providing virtual machines. \n"),
          TextSpan(text: "\n"),
          TextSpan(text: "Different layer means different level that the client can take control of.\n", style: TextStyle(color: Colors.red)),
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
        Container(
          padding: EdgeInsets.only(left: 20, right: 20),
          child: Center(child: RichText(textAlign: TextAlign.start, text: TextSpan(style: TextStyle(color: Colors.black, height: 2), children: [
            TextSpan(text: "References\n", style: TextStyle(fontWeight: FontWeight.bold)),
            TextSpan(text: "1. C. Miyachi: What is Cloud\n    "),
            TextSpan(
              text: "https://web.archive.org/web/20190306204414id_/http://pdfs.semanticscholar.org/cbb4/4eca5afb5901b1a95fd8522528f9e0da7851.pdf", 
              style: TextStyle(color: Colors.blue, decoration: TextDecoration.underline),
              recognizer: TapGestureRecognizer()..onTap = () async {
                const _url = "https://web.archive.org/web/20190306204414id_/http://pdfs.semanticscholar.org/cbb4/4eca5afb5901b1a95fd8522528f9e0da7851.pdf";
                if (!await launch(_url)) throw 'Could not launch $_url';
              },
            ),
          ])),),
        ),
      ],),
    );
  }
}