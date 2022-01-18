import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fiton/screen/authentication/components/rounded_login_option.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../../../constant.dart';

class LoginOption extends StatefulWidget {
  const LoginOption({
    Key? key,
  }) : super(key: key);

  @override
  _LoginOption createState() => _LoginOption();
}

class _LoginOption extends State<LoginOption> {
  var loading = false;

  Future<bool> checkAccount(String email) async {
    bool temp = await FirebaseFirestore.instance
        .collection('users')
        .where('email', isEqualTo: email)
        .get()
        .then((QuerySnapshot querySnapshot) {
      if (querySnapshot.docs.length > 0) {
        return true;
      } else {
        return false;
      }
    });
    return temp;
  }

  void _logInWithFacebook() async {
    if (this.mounted) {
      setState(() {
        loading = true;
      });
    }

    try {
      final facebookLoginResult = await FacebookAuth.instance.login();
      final userData = await FacebookAuth.instance.getUserData();

      final facebookAuthCredential = FacebookAuthProvider.credential(
          facebookLoginResult.accessToken!.token);
      await FirebaseAuth.instance.signInWithCredential(facebookAuthCredential);

      bool temp = await checkAccount(userData['email']);

      if (!temp) {
        final user = FirebaseAuth.instance.currentUser;
        await FirebaseFirestore.instance.collection('users').doc(user!.uid).set({
          'uid': user.uid,
          'email': userData['email'],
          'imageUrl': userData['picture']['data']['url'],
          'name': userData['name'],
          'height': "",
          'difficulty': "medium",
        });
      }
    } on FirebaseAuthException catch (e) {
      var content = '';
      switch (e.code) {
        case 'account-exists-with-different-credential':
          content = 'Your Account exists with a different sign in provider';
          break;
        case 'invalid-credential':
          content = 'Unknown error has occurred';
          break;
        case 'operation-not-allowed':
          content = 'This operation is not allowed';
          break;
        case 'user-disabled':
          content = 'Your Account is disabled';
          break;
        case 'user-not-found':
          content = 'Your Account not found';
          break;
      }

      showDialog(
          context: context,
          builder: (context) => AlertDialog(
                title: Text('Log in with Facebook failed'),
                content: Text(content),
                actions: [
                  TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text('Ok'))
                ],
              ));
    } finally {
      if (this.mounted) {
        setState(() {
          loading = false;
        });
      }
    }
  }

  void _logInWithGoogle() async {
    if (this.mounted) {
      setState(() {
        loading = true;
      });
    }

    final googleSignIn = GoogleSignIn(scopes: ['email']);
    try {
      final googleSignInAccount = await googleSignIn.signIn();
      if (googleSignInAccount == null) {
        if (this.mounted) {
          setState(() {
            loading = true;
          });
        }
        return;
      }
      final googleSignInAuthentication =
          await googleSignInAccount.authentication;
      final credential = GoogleAuthProvider.credential(
          accessToken: googleSignInAuthentication.accessToken,
          idToken: googleSignInAuthentication.idToken);

      await FirebaseAuth.instance.signInWithCredential(credential);
      bool temp = await checkAccount(googleSignInAccount.email);
      final user = FirebaseAuth.instance.currentUser!;
      if (!temp) {
        await FirebaseFirestore.instance.collection('users').doc(user.uid).set({
          'uid': user.uid,
          'email': user.email,
          'imageUrl': user.photoURL,
          'name': user.displayName,
          'height': "",
          'difficulty': "medium",
        });
      }
    } on FirebaseAuthException catch (e) {
      var content = '';
      switch (e.code) {
        case 'account-exists-with-different-credential':
          content = 'Your Account exists with a different sign in provider';
          break;
        case 'invalid-credential':
          content = 'Unknown error has occurred';
          break;
        case 'operation-not-allowed':
          content = 'This operation is not allowed';
          break;
        case 'user-disabled':
          content = 'Your Account is disabled';
          break;
        case 'user-not-found':
          content = 'Your Account not found';
          break;
      }

      showDialog(
          context: context,
          builder: (context) => AlertDialog(
                title: Text('Log in with Google failed'),
                content: Text(content),
                actions: [
                  TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text('Ok'))
                ],
              ));
    } finally {
      if (this.mounted) {
        setState(() {
          loading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      // crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        if (!loading)
          RoundedLoginOption(
            text: 'WITH GOOGLE',
            img: 'google',
            press: () {
              _logInWithGoogle();
            },
            color: Colors.white,
            tcolor: Colors.black,
            height: 30,
          ),
        if (loading)
          Container(
            height: 50,
            width: 170,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: Colors.white,
            ),
            child: Center(
              child: SizedBox(
                child: CircularProgressIndicator(),
                height: 35,
                width: 35,
              ),
            ),
          ),
        SizedBox(width: 20),
        if (!loading)
          RoundedLoginOption(
            text: 'WITH FACEBOOK',
            img: 'facebook',
            press: () {
              _logInWithFacebook();
            },
            color: kFacebookColor,
            tcolor: Colors.white,
            height: 35,
          ),
        if (loading)
          Container(
            height: 50,
            width: 170,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: kFacebookColor,
            ),
            child: Center(
              child: SizedBox(
                child: CircularProgressIndicator(),
                height: 35,
                width: 35,
              ),
            ),
          )
      ],
    );
  }
}
