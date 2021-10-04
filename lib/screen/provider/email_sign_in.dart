import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';


class EmailSignInProvider extends ChangeNotifier {

  final CollectionReference userCollection = FirebaseFirestore.instance.collection('users');

  bool? _isLoading;
  bool? _isLogin;
  String? _userEmail;
  String? _userPassword;
  String? _firstName;
  String? _lastName;
  String? _gender;
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

  DateTime get dob => _dob!;

  set dob(DateTime value) {
    _dob = value;
    notifyListeners();
  }

  Future<bool> login() async {
    try {
      isLoading = true;

      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: userEmail,
        password: userPassword,
      );

      isLoading = false;
      return true;
    } catch (err) {
      print(err);
      isLoading = false;
      return false;
    }
  }

  Future<bool> register() async {
    try {
      isLoading = true;

      UserCredential result = await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: userEmail,
          password: userPassword
      );

      User user = result.user;

      await userCollection.doc(user.uid).set({
        'uid': user.uid,
        'firstName': firstName,
        'lastName': lastName,
        'gender': gender,
        'birthday': dob,
      });

      isLoading = false;
      return true;
    } catch (err) {
      print(err);
      isLoading = false;
      return false;
    }
  }
}
