class Schedule{
  String? id;
  String? title;
  String? location;
  int? isCompleted;
  String? date;
  String? startTime;
  String? endTime;
  int? color;
  int? remind;
  String? uid;

  Schedule({
    this.id, 
    this.title, 
    this.location, 
    this.isCompleted, 
    this.date,
    this.startTime,
    this.endTime,
    this.color,
    this.remind,
    this.uid,
  });

  Map<String, dynamic> toMap(String id) {
    return {
      "id": id,
      "title": this.title,
      "location": this.location,
      "isCompleted": this.isCompleted,
      "date": this.date,
      "startTime": this.startTime,
      "endTime": this.endTime,
      "color": this.color,
      "remind": this.remind,
      "uid": this.uid,
    };
  }

  factory Schedule.fromMap(Map<String, dynamic> map) => Schedule(
    id: map["id"],
    title: map["title"],
    location: map["location"],
    isCompleted: map["isCompleted"],
    date: map["date"],
    startTime: map["startTime"],
    endTime: map["endTime"],
    color: map["color"],
    remind: map["remind"],
    uid: map["uid"],
  );
}