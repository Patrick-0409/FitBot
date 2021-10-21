import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:fiton/models/news.dart';

class FirebaseApi{

  static UploadTask? uploadFile(String destination, File file){
    try{
      final ref = FirebaseStorage.instance.ref(destination);
      return ref.putFile(file);
    } on FirebaseException catch (e) {
      print("error api");
      print(e);
      return null;
    }
  }
}