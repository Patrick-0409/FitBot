import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fiton/models/user.dart';

class UserService {
  final CollectionReference usersCollection = FirebaseFirestore.instance.collection('users');
  final user = FirebaseAuth.instance.currentUser;

  Future<UserStore> getUser(String uid) async {
    return UserStore.fromJson(await usersCollection.doc(uid).get());
  }

  Future setDifficulty(String difficulty) async{
    await FirebaseFirestore.instance.collection('users').doc(user?.uid).update(
      {
        'difficulty': difficulty,
      },
    );
  }

  Future<String> getImgUser(String uid) async {
    var url = "0";
    url = await FirebaseFirestore.instance
            .collection('users')
            .limit(1)
            .where('uid',isEqualTo: uid)
            .get()
            .then((QuerySnapshot querySnapshot) {
              if (querySnapshot.docs.length>0) {
                Map<String, dynamic> data = querySnapshot.docs[0].data()! as Map<String, dynamic>;
                return data['imageUrl'].toString();
              }
              return '0';
            });
    return url;
  }

  Future<String> getData(String uid, String dt) async {
    var url = "0";
    url = await FirebaseFirestore.instance
            .collection('users')
            .limit(1)
            .where('uid',isEqualTo: uid)
            .get()
            .then((QuerySnapshot querySnapshot) {
              if (querySnapshot.docs.length>0) {
                Map<String, dynamic> data = querySnapshot.docs[0].data()! as Map<String, dynamic>;
                return data['$dt'].toString();
              }
              return '0';
            });
    return url;
  }

  Future<bool> checkContains(String? uid) async {
    var temp = FirebaseFirestore.instance
            .collection('users')
            .where('uid', isEqualTo: uid)
            .where('height', isEqualTo: "")
            .get()
            .then((QuerySnapshot querySnapshot) {
                  if (querySnapshot.docs.length>0) {
                      return true;
                  } else {
                      return false;
                  }
              });
    return temp;
  }
}