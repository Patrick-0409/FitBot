class Daily {

  String? id;
  DateTime date;
  String sleep;
  String wake;
  int weight;
  String user;
  List<String>? breakfast = [];
  List<String>? lunch = [];
  List<String>? dinner = [];

  Daily({
    this.id, 
    required this.date, 
    required this.sleep, 
    required this.wake, 
    required this.weight,
    required this.user,
    this.breakfast, 
    this.lunch,
    this.dinner
  });

  Map<String, dynamic> toMap(String id) {
    Map<String, dynamic> map = {
      'id': id,
      'date': this.date,
      'sleep': this.sleep,
      'wake': this.wake,
      'weight': this.weight,
      'user': this.user,
      'breakfast': [],
      'lunch': [],
      'dinner': []
    };
    return map;
  }

  static Daily fromMap(Map<String, dynamic> map) {
    return Daily(
      id: map['id'],
      date: map['date'].toDate(),
      sleep: map['sleep'],
      wake: map['wake'],
      weight: map['weight'],
      user: map['user']
    );
  }
}
