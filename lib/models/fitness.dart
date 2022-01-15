class Fitness {

  String? id;
  String name;
  String imageUrl;
  int minute;
  var easy = [];
  var medium = [];
  var hard = [];
  List<String> movement = [];

  Fitness({
    this.id, 
    required this.name, 
    required this.imageUrl, 
    required this.minute, 
    required this.easy, 
    required this.medium,
    required this.hard,
    required this.movement
  });

  Map<String, dynamic> toMap(String id) {
    Map<String, dynamic> map = {
      'id': id,
      'name': this.name,
      'imageUrl': this.imageUrl,
      'minute': this.minute,
      'easy': this.easy,
      'medium': this.medium,
      'hard': this.hard,
      'movement': this.movement
    };

    return map;
  }

  static Fitness fromMap(Map<String, dynamic> map) {
    return Fitness(
      id: map['id'],
      name: map['name'],
      imageUrl: map['imageUrl'],
      minute: map['minute'],
      easy: map['easy'],
      medium: map['medium'],
      hard: map['hard'],
      movement: map['movement'].cast<String>()
    );
  }
}
