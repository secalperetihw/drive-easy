import 'package:drive_easy/classes/game/email.dart';
import 'package:drive_easy/classes/game/item.dart';
import 'package:drive_easy/static/emails.dart';
import 'package:drive_easy/static/requestsOnBoard.dart';

class Progress {
  int? level;
  int? day;
  double? totalScore;
  double? rating;
  int? totalSuccess;
  int? totalFailed;
  List<GameEmail>? emails;
  List<Item>? requests;
  Progress? restore;
  Map<String, bool>? tutorial;

  Progress({
    this.level,
    this.day,
    this.totalScore,
    this.rating,
    this.totalFailed,
    this.totalSuccess,
    this.emails,
    this.requests,
    this.restore,
    this.tutorial,
  }){
    tutorial ??= {
      "FirstPlay": true,
      "Authentication": true,
      "Data": true,
    };
  }

  static Progress createDefault() {
    return Progress(
      level: 0,
      day: 0,
      totalScore: 0,
      totalFailed: 0,
      totalSuccess: 0,
      rating: 0,
      emails: List.from(emailDatabase["level0"] ?? []),
      requests: List.from(requestsOnBoard["level0"] ?? []),
      tutorial: {
        "FirstPlay": true,
        "Authentication": true,
        "Data": true,
      },
      restore: Progress(
        level: 0,
        day: 0,
        totalScore: 0,
        rating: 0,
        totalFailed: 0,
        totalSuccess: 0,
        emails: List.from(emailDatabase["level0"] ?? []),
        requests: List.from(requestsOnBoard["level0"] ?? []),
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
}