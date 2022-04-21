import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class EndLevel extends ChangeNotifier {
  BuildContext context;
  int finishCount;
  int totalCount;
  DateTime time;

  EndLevel({
    required this.context,
    required this.finishCount,
    required this.totalCount,
    required this.time,
  });

  bool valueChanges({
    finishCount, totalCount, time
  }) {
    if (finishCount != null) this.finishCount = finishCount;
    if (totalCount != null) this.totalCount = totalCount;
    if (time != null) this.time = time;

    if (this.finishCount == this.totalCount || this.time.hour == 17) {
      return true;
    }

    notifyListeners();

    return false;
  }

  void showLayout() async {
    
  }
}