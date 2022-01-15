import 'package:cloud_firestore/cloud_firestore.dart';

class UserStore{
  final String? uid;
  final String? name;
  final String? imageUrl;
  final String? email;
  final String? gender;
  final String? weight;
  final String? height;
  final String? difficulty;
  final DateTime? birthday;

  UserStore({
    required this.uid, 
    required this.name, 
    required this.imageUrl,
    required this.email,
    required this.gender,
    required this.weight,
    required this.height,
    required this.difficulty,
    required this.birthday,
  });

  factory UserStore.fromJson(DocumentSnapshot snapshot) => UserStore(
    uid: snapshot["uid"],
    name: snapshot["name"],
    imageUrl: snapshot["imageUrl"],
    email: snapshot["email"],
    gender: snapshot["gender"],
    weight: snapshot["weight"],
    height: snapshot["height"],
    difficulty: snapshot["difficulty"],
    birthday: snapshot["birthday"].toDate(),
  );

  
  Map<String, dynamic> toMap() {
    return {
      "uid": uid,
      "name": name,
      "image": imageUrl,
      "email": email,
      "gender": gender,
      "weight": weight,
      "height": height,
      "birthday": birthday,
    };
  }
}