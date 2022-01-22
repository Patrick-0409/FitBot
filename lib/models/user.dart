import 'package:cloud_firestore/cloud_firestore.dart';

class UserStore{
  final String? uid;
  final String? name;
  final String? imageUrl;
  final String? email;
  final String? gender;
  final String? weight;
  final String? height;
  final int? active;
  final int? want;
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
    required this.active,
    required this.want,
    required this.difficulty,
    required this.birthday,
  });

  factory UserStore.fromJson(DocumentSnapshot snapshot) => UserStore(
    uid: snapshot["uid"],
    name: snapshot["name"],
    imageUrl: snapshot["imageUrl"] == "" ? "https://img.freepik.com/free-photo/young-fitness-man-studio_7502-5008.jpg?size=626&ext=jpg&ga=GA1.2.1278783015.1641168000" : snapshot["imageUrl"],
    email: snapshot["email"],
    gender: snapshot["gender"] == null ? "" : snapshot["gender"],
    weight: snapshot["weight"].toString(),
    height: snapshot["height"].toString(),
    active: snapshot["active"],
    want: snapshot["want"],
    difficulty: snapshot["difficulty"],
    birthday: snapshot["birthday"] == null ? null : snapshot["birthday"].toDate(),
  );

}