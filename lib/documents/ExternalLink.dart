import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

Widget ExternalLink({
  required BuildContext context,
  required String url,
  String? text,
}){
  return GestureDetector(
    onTap: () async {
      bool exit = false;
      await showDialog<void>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) { 
        
          return AlertDialog(
            title: Center(child: Text("External link")),
            content: Text("Are you sure to leave this app?\nLink: $url"),
            actions: [
              TextButton(
                onPressed:(){
                  exit = true;
                  Navigator.pop(context);
                }, 
                child: Text("Yes")
              ),
              TextButton(
                onPressed:(){
                  exit = false;
                  Navigator.pop(context);
                }, 
                child: Text("No")
              )
            ],
          );
        }
      );
      if (!exit) return;
      
      if (!await launch(url)) throw 'Could not launch $url';
    },
    child: Text(text ?? "Learn more", style: TextStyle(color: Colors.blue, decoration: TextDecoration.underline),),
  );
}