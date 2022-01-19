class Schedule{
  String? id;
  String? title;
  String? location;
  int? isCompleted;
  String? startDate;
  String? endDate;
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
    this.startDate,
    this.endDate,
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
      "startDate": this.startDate,
      "endDate": this.endDate,
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
    startDate: map["startDate"],
    endDate: map["endDate"],
    startTime: map["startTime"],
    endTime: map["endTime"],
    color: map["color"],
    remind: map["remind"],
    uid: map["uid"],
  );
}