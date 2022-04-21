import 'package:drive_easy/classes/game/email.dart';
import 'package:drive_easy/classes/game/item.dart';
import 'package:drive_easy/static/emails.dart';
import 'package:drive_easy/static/requestsOnBoard.dart';

class Progress {
  int? level;
  int? day;
  int? totalScore = 0;
  double? rating;
  int? totalSuccess;
  int? totalFailed;
  int? lifeTotalSuccess;
  int? lifeTotalFailed;
  int? lifeScore = 0;
  int? lifeTotalScore = 0;
  double? textOffset;
  List<GameEmail>? emails;
  List<Item>? requests;
  List<Item> previousRequests = [];
  Progress? restore;
  Map<String, bool>? tutorial;

  Progress({
    this.level,
    this.day,
    this.totalScore,
    this.rating,
    this.totalFailed,
    this.totalSuccess,
    this.lifeTotalFailed,
    this.lifeTotalScore,
    this.lifeTotalSuccess,
    this.emails,
    this.requests,
    this.restore,
    this.tutorial,
    this.textOffset,
  }){
    tutorial ??= {
      "FirstPlay": true,
      "Authorization": true,
      "Data": true,
    };
  }

  static Progress createDefault() {
    int num = 0;

    return Progress(
      level: num,
      day: num,
      totalScore: 0,
      totalFailed: 0,
      totalSuccess: 0,
      rating: 0,
      emails: List.from(emailDatabase["level" + num.toString()] ?? []),
      requests: List.from(requestsOnBoard["level"  + num.toString()] ?? []),
      tutorial: {
        "FirstPlay": true,
        "Authorization": true,
        "Data": true,
      },
      restore: Progress(
        level: num,
        day: num,
        totalScore: 0,
        rating: 0,
        totalFailed: 0,
        totalSuccess: 0,
        emails: List.from(emailDatabase["level" + num.toString()] ?? []),
        requests: List.from(requestsOnBoard["level" + num.toString()] ?? []),
      )
    );
  }

  static Progress from(Progress progress) {
    return Progress(
      level: progress.level,
      day: progress.day,
      totalScore: progress.totalScore,
      totalFailed: progress.totalFailed,
      totalSuccess: progress.totalSuccess,
      rating: progress.rating,
      emails: List.from(progress.emails ?? []),
      requests: List.from(progress.requests ?? []),
      restore: Progress(
        level: progress.level,
        day: progress.day,
        totalScore: progress.totalScore,
        rating: progress.rating,
        totalFailed: progress.totalFailed,
        totalSuccess: progress.totalSuccess,
        emails: List.from(progress.emails ?? []),
        requests: List.from(progress.requests ?? []),
      )
    );
  }

  void save() {

  }

  void load() {

  }

  Progress Reset() {
    return createDefault();
  }

  int successCount() {
    int count = 0;
    requests?.forEach((element) {
      if (element.success ?? false) count++;
    });
    return count;
  }

  int finishCount() {
    int count = 0;
    requests?.forEach((element) {
      if (element.finish ?? false) count++;
    });
    return count;
  }

  int scoreCount() {
    int count = 0;
    requests?.forEach((element) {
      count += element.score ?? 0;
    });

    return count;
  }

  int totalScoreCount() {
    int count = 0;
    requests?.forEach((element) {
      if (element.finish ?? false) count += element.totalScore ?? 0;
    });

    return count;
  }

  String calRating() {
    int total = totalScoreCount();
    int score = scoreCount();

    double rate = (lifeScore ?? 0).toDouble() / (lifeTotalScore ?? 0).toDouble();
    rating = rate;
  
    if (rate > 0.95) {
      return "SS";
    } else if (rate > 0.9) {
      return "S";
    } else if (rate > 0.8) {
      return "A";
    } else if (rate > 0.7) {
      return "B";
    } else if (rate > 0.6) {
      return "C";
    } else if (rate > 0.5) {
      return "D";
    } else {
      return "F";
    }
  }
}