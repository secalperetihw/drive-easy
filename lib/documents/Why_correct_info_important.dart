import 'package:flutter/material.dart';

class Why_correct_info_important extends StatelessWidget {
  Function onpress;
  double? width;
  double? height;
  String? text;

  Why_correct_info_important({
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
        Center(child: RichText(textAlign: TextAlign.center, text: TextSpan(style: TextStyle(color: Colors.black, height: 2), children: const [
          TextSpan(text: "Why correct info important?\n", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30, height: 2)),
        ])),),
        Center(child: RichText(textAlign: TextAlign.start, text: TextSpan(style: TextStyle(color: Colors.black, height: 2), children: const [
          TextSpan(text: "- We cannot simply \"guess\" what user want\n"),
          TextSpan(text: "- need to ensure the package is basically correct\n"),
          TextSpan(text: "- Wrong requests parameters may means package corrupt,\n  data inside may corrupt too!"),
        ])),),
        Padding(padding: EdgeInsets.only(left: 30, right: 30, top: 10, bottom: 10), child: Divider(color: Colors.black38,)),
        Center(child: Wrap(children: [ElevatedButton(onPressed: (){
          onpress();
        }, child: Text(text ?? "Next"))],),),
      ],),
    );
  }
}