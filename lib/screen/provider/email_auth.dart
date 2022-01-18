import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';


class EmailSignInProvider extends ChangeNotifier {

  final CollectionReference userCollection = FirebaseFirestore.instance.collection('users');

  UploadTask? task;
  bool? _isLoading;
  bool? _isLogin;
  String? _weight;
  String? _height;
  int? _active;
  int? _want;
  String? _userEmail;
  String? _userPassword;
  String? _firstName;
  String? _lastName;
  String? _basename;
  String? _gender;
  String? _imageUrl;
  FirebaseAuthException? _message;
  DateTime? _dob;

  EmailSignInProvider() {
    _isLoading = false;
    _isLogin = true;
    _userEmail = '';
    _userPassword = '';
    _firstName = '';
    _lastName = '';
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


  String get weight => _weight!;

  set weight(String value) {
    _weight = value;
    notifyListeners();
  }

  String get height => _height!;

  set height(String value) {
    _height = value;
    notifyListeners();
  }



  int get active => _active!;

  set active(int value) {
    _active = value;
    notifyListeners();
  }

  int get want => _want!;

  set want(int value) {
    _want = value;
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

  String get imageUrl => _imageUrl!;

  set imageUrl(String value) {
    _imageUrl = value;
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

  Future save(String uid) async {
    try {
        await FirebaseFirestore.instance
            .collection('users')
            .doc(uid)
            .update({
              'birthday':dob,
              'gender':gender,
              'weight':weight,
              'height':height,
              'active':active,
              'want':want,
            });
    } catch (e) {
      print("error pas save "+e.toString());
    }
  }

  Future<bool> register() async {
    UserCredential? result;
    try {

      result = await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: userEmail,
          password: userPassword
      );
      _message = null;
    } on FirebaseAuthException catch (err) {
      isLoading = false;
      _message = err;
      return false;
    }

    try{
      User? user = result.user;

      await userCollection.doc(user!.uid).set({
        'uid': user.uid,
        'name': firstName+lastName,
        'email': userEmail,
        'imageUrl': imageUrl,
        'height': "",
      });
      return true;
    }catch (err) {
      isLoading = false;
      return false;
    }
  }


}
