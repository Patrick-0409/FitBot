import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:fiton/screen/provider/firebase_api.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';


class EmailSignInProvider extends ChangeNotifier {

  final CollectionReference userCollection = FirebaseFirestore.instance.collection('users');

  UploadTask? task;
  bool? _isLoading;
  bool? _isLogin;
  String? _userEmail;
  String? _userPassword;
  String? _firstName;
  String? _lastName;
  String? _basename;
  String? _gender;
  String? _urlImage;
  FirebaseAuthException? _message;
  File? _image;
  DateTime? _dob;

  EmailSignInProvider() {
    _isLoading = false;
    _isLogin = true;
    _userEmail = '';
    _userPassword = '';
    _firstName = '';
    _lastName = '';
    _gender = '';
    _dob = DateTime.now();
  }

  bool get isLoading => _isLoading!;

  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  bool get isLogin => _isLogin!;

  set isLogin(bool value) {
    _isLogin = value;
    notifyListeners();
  }

  String get userEmail => _userEmail!;

  set userEmail(String value) {
    _userEmail = value;
    notifyListeners();
  }

  String get userPassword => _userPassword!;

  set userPassword(String value) {
    _userPassword = value;
    notifyListeners();
  }

  String get firstName => _firstName!;

  set firstName(String value) {
    _firstName = value;
    notifyListeners();
  }

  String get lastName => _lastName!;

  set lastName(String value) {
    _lastName = value;
    notifyListeners();
  }

  String get gender => _gender!;

  set gender(String value) {
    _gender = value;
    notifyListeners();
  }

  String get basename => _basename!;

  set basename(String value) {
    _basename = value;
    notifyListeners();
  }

  File get image => _image!;

  set image(File value) {
    _image = value;
    notifyListeners();
  }

  String get urlImage => _urlImage!;

  set urlImage(String value) {
    _urlImage = value;
    notifyListeners();
  }

  FirebaseAuthException get message => _message!;

  set message(FirebaseAuthException value) {
    _message = value;
    notifyListeners();
  }

  DateTime get dob => _dob!;

  set dob(DateTime value) {
    _dob = value;
    notifyListeners();
  }

  Future<bool> register() async {
    User? user;
    UserCredential? result;
    try {
      // isLoading = true;

      result = await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: userEmail,
          password: userPassword
      );
      _message = null;
      // isLoading = false;
    } on FirebaseAuthException catch (err) {
      print(err);
      isLoading = false;
      _message = err;
      print(userEmail);
      print(userPassword);
      print(err);
      return false;
    }

    try{
      user = result.user;
      if(user!=null && _image!=null){
        await uploadImage(user.uid);
      }
    } catch (err) {
      print("upload image");
      print(err);
      isLoading = false;
    }

    try{
      User? user = result.user;

      await userCollection.doc(user!.uid).set({
        'uid': user.uid,
        'firstName': firstName,
        'lastName': lastName,
        'gender': _gender,
        'urlImage': _image!=null ? urlImage : "",
        'birthday': dob,
      });
      // isLoading = false;
      return true;
    }catch (err) {
      print("upload info");
      print(err);
      isLoading = false;
      return false;
    }
  }

  Future uploadImage(String uid) async{
    if(_image==null) return;
    try{
      // isLoading = true;
      final imageName = _basename;
      final destination = 'profiles/$imageName';
      task = FirebaseApi.uploadFile(destination, image);
      if(task == null) return;
      final snapshot = await task!.whenComplete(() => {});
      _urlImage = await snapshot.ref.getDownloadURL();
      // isLoading = false;
    }catch(err){
      print(err);
      isLoading = false;
      return false;
    }
  }
}
