import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;
import 'package:fiton/models/news.dart';

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
}