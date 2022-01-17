class Movement {

  String? id;
  String name;
  String gifUrl;
  int times;

  Movement({
    this.id, 
    required this.name, 
    required this.gifUrl, 
    required this.times, 
  });

  Map<String, dynamic> toMap(String id) {
    Map<String, dynamic> map = {
      'id': id,
      'name': this.name,
      'gifUrl': this.gifUrl,
      'times': this.times,
    };

    return map;
  }

  static Movement fromMap(Map<String, dynamic> map) {
    return Movement(
      id: map['id'],
      name: map['name'],
      gifUrl: map['gifUrl'],
      times: map['times'],
    );
  }
}
