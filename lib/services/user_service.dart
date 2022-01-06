import 'package:cloud_firestore/cloud_firestore.dart';

// ignore: camel_case_types
class user_service {
  
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
                return data['urlImage'].toString();
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
                  print(querySnapshot.docs);
                  if (querySnapshot.docs.length>0) {
                      return true;
                  } else {
                      return false;
                  }
              });
    return temp;
  }
}