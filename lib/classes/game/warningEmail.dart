import 'package:drive_easy/classes/game/email.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class WarningEmail extends GameEmail {
  int? wrongTimes;
  String? reqID;
  String? mainPoint;

  WarningEmail({
    id,
    content,
    title,
    from,
    to,
    cc,
    dear,
    read,
    time,
    style,
    this.wrongTimes,
  }) : super(id: id, content: content, title: title, from: from, to: to, cc: cc, dear: dear, read: read, time: time, style: style);

  static WarningEmail defaultStyle({
    required int id, 
    required Map<String, bool> itemField,
    required int wrongTimes, 
    required DateTime time
  }) {
    String s = "";
    List<TextStyle?> tmp = [
      null,
      null,
      null,
      TextStyle(color: Colors.red),
      null,
    ];

    bool check = true;
    itemField.forEach((key, value) {
      if (!value) {
        s += "  - $key is not correct\n";
        check = false;
      }
    });
    if (check) {
      s += "  - The package content has nothing suspicious.\n";
    }

    for (int i=0; i<s.split("\n").length; i++) {
      tmp.add(TextStyle(color: Colors.red),);
    }
    tmp.addAll(
      [
        null,
        TextStyle(color: Colors.red),
        null,
        null,
        null,
        null,
        null,
        null,
      ]
    );

    print(itemField);

    return WarningEmail(
      id: id,
      title: "Warning! Wrong package being sent!",
      from: "Drive easy",
      to: "Player",
      content: ("This is a automating generated email.\n")
      + ("  A previous packages was detected to be wrongly proceeded by you.\n")
      + ("  reqID: \n")
      + ("  $id\n")
      + ("  What's wrong: \n")
      + ("$s \n")
      + ("  Your total failed task count today:\n ")
      + ("  $wrongTimes\n")
      + ("\n")
      + ("  Please noted that if you exceed certain number of failed you will be fired.\n")
      + ("\n")
      + ("\n")
      + ("Best regards,\n")
      + ("Drive easy\n"),
      dear: "Dear employee, \n",
      time: time,
      wrongTimes: wrongTimes,
      read: false,
      style: tmp
    );
  }
}