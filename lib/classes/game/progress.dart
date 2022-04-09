import 'package:drive_easy/classes/game/email.dart';

class Progress {
  int? level;
  int? day;
  double? totalScore;
  double? rating;
  int? totalSuccess;
  int? totalFailed;
  List<GameEmail>? emails;

  Progress({
    this.level,
    this.day,
    this.totalScore,
    this.rating,
    this.totalFailed,
    this.totalSuccess,
    this.emails,
  });

  void save() {

  }

  void load() {

  }
}