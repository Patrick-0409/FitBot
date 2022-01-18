import 'dart:convert';

class Entry {
  int? id;
  DateTime date;
  String duration;
  double speed;
  double distance;
  String user;

  Entry(
      {this.id,
      required this.date,
      required this.duration,
      required this.speed,
      required this.distance,
      required this.user});

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      'date': date,
      'duration': duration,
      'speed': speed,
      'distance': distance,
      'user': user
    };

    if (id != null) {
      map['id'] = id;
    }

    return map;
  }

  static Entry fromMap(Map<String, dynamic> map) {
    return Entry(
        id: map['id'],
        date: map['date'].toDate(),
        duration: map['duration'],
        speed: map['speed'].toDouble(),
        distance: map['distance'].toDouble(),
        user: map['user']);
  }
}
