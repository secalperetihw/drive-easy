import 'package:drive_easy/documents/Authorization_Whats_important.dart';
import 'package:drive_easy/documents/show_document.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'What_is_Authoriaztion.dart';

class Authorization_User_refuse extends StatelessWidget {
  Function onpress;
  double? width;
  double? height;
  String? text;

  Authorization_User_refuse({ 
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
          TextSpan(text: "What is User refuse?\n", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30, height: 2)),
        ])),),
        Align(alignment: Alignment.centerRight, child: RichText(textAlign: TextAlign.end, text: TextSpan(style: TextStyle(color: Colors.black, height: 2), children: [
          TextSpan(
            text: "Previous on Authoriation\n",
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
                      child: What_is_Authorization(
                        key: key,
                        onpress: () async {
                          await showDialog<void>(
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
                                    text: "Go Back",
                                    onpress: (){
                                      Navigator.pop(key.currentContext!);
                                    },
                                  )
                                )
                              );
                            }
                          );
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
        
        Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          Center(child: RichText(textAlign: TextAlign.start, text: TextSpan(style: TextStyle(color: Colors.black, height: 2), children: const [
            TextSpan(text: "To understand this, we need to know what Authorization is doing.\n"),
            TextSpan(text: "The user may don't want give permission to third-party application\n"),
            TextSpan(text: "Then he/she may simply "),
            TextSpan(text: "refuse to Authorize", style: TextStyle(color: Colors.red)),
            TextSpan(text: " it.\n"),
            TextSpan(text: "Applying to our game, the user don't want us\n to modify his/her files in drives!\n", style: TextStyle(color: Colors.blue)),
          ])),),
          Container(
            padding: EdgeInsets.only(),
            child: Image.asset("assets/images/tutorial/Auth_user_refuse.jpg",),
          ),
        ],),
        
        Center(child: RichText(textAlign: TextAlign.start, text: TextSpan(style: TextStyle(color: Colors.black, height: 2), children: const [
          TextSpan(text: "But don't worry, \nyou will still get score for this request\n", style: TextStyle(color: Colors.blue)),
        ])),),
        Padding(padding: EdgeInsets.only(left: 30, right: 30, top: 10, bottom: 10), child: Divider(color: Colors.black38,)),
        Center(child: Wrap(children: [ElevatedButton(onPressed: () {
          onpress();
        }, child: Text(text ?? "Next"))],),),
      ],),
    );
  }
}