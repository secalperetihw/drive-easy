class GameEmail {
  String? content;
  String? title;
  String? from;
  String? to;
  String? cc;
  String? dear;
  bool? read;
  DateTime? time;

  GameEmail({
    this.content,
    this.title,
    this.from,
    this.to,
    this.cc,
    this.dear,
    this.read,
    this.time,
  });

  Map<dynamic, dynamic> toJson() {
    return {
      "content": content,
      "title": title,
      "from": from,
      "to": to,
      "cc": cc,
      "dear": dear,
      "read": read.toString(),
      "time": time.toString(),
    };
  }
}