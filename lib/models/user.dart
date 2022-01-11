class UserStore{
  final String? uid;
  final String? name;
  final String? image;
  final String? email;
  final String? gender;
  final String? weight;
  final String? height;
  final DateTime? birthday;

  UserStore({
    required this.uid, 
    required this.name, 
    required this.image,
    required this.email,
    required this.gender,
    required this.weight,
    required this.height,
    required this.birthday,
  });

  factory UserStore.fromJson(Map<String, dynamic> json, {String? uid}) => UserStore(
    uid: json["uid"],
    name: json["name"],
    image: json["image"],
    email: json["email"],
    gender: json["gender"],
    weight: json["weight"],
    height: json["height"],
    birthday: json["birthday"],
  );

  
  Map<String, dynamic> toMap() {
    return {
      "uid": uid,
      "name": name,
      "image": image,
      "email": email,
      "gender": gender,
      "weight": weight,
      "height": height,
      "birthday": birthday,
    };
  }
}