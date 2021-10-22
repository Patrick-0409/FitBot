import 'package:firebase_auth/firebase_auth.dart';
import 'package:fiton/screen/authentication/components/rounded_button.dart';
import 'package:fiton/screen/authentication/components/rounded_input_field.dart';
import 'package:fiton/screen/authentication/components/rounded_password_field.dart';
import 'package:fiton/screen/authentication/login/components/account_checker.dart';
import 'package:fiton/screen/authentication/login/components/background.dart';
import 'package:fiton/screen/authentication/login/login_screen.dart';
import 'package:fiton/screen/provider/email_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'avatar_name.dart';
import 'dob_selector.dart';
import 'gender_selector.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<EmailSignInProvider>(context);
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: SingleChildScrollView(
        child: Background(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  "FitBot",
                  style: Theme.of(context).textTheme.headline1,
                ),
                // SizedBox(height: size.height * 0.25),
                AvatarName(),
                GenderSelector(),
                SizedBox(height: size.height * 0.01),
                DobSelector(),
                SizedBox(height: size.height * 0.01),
                RoundedInputField(),
                SizedBox(height: size.height * 0.01),
                RoundedPasswordField(),
                SizedBox(height: size.height * 0.01),
                RoundedButton(
                  text: "Sign Up",
                  press: () {
                    submit();
                  },
                ),
                AccountChecker(
                  login: false,
                  press: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return LoginScreen();
                        },
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _handleSignUpError(FirebaseAuthException e) {
    String messageToDisplay;
    switch (e.code) {
      case 'email-already-in-use':
        messageToDisplay = 'This email is already in use';
        break;
      case 'invalid-email':
        messageToDisplay = 'The email you ented is invalid';
        break;
      case 'operation-not-allowed':
        messageToDisplay = 'This operation is not allowed';
        break;
      case 'weak-password':
        messageToDisplay = 'The password you entered is too weak';
        break;
      default:
        messageToDisplay = 'An unknown error occurred';
        break;
    }

    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text('Sign up failed'),
              content: Text(messageToDisplay),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text('Ok'))
              ],
            ));
  }

  Future submit() async {
    final provider = Provider.of<EmailSignInProvider>(context, listen: false);

    final isValid = _formKey.currentState!.validate();
    FocusScope.of(context).unfocus();

    if (isValid) {
      _formKey.currentState!.save();

      final isSuccess = await provider.register();
      if (isSuccess) {
        new Future.delayed(const Duration(seconds: 1), () {
          if (mounted) {
            Navigator.of(context).pop();
          }
        });
      } else {
        if (mounted) {
          _handleSignUpError(provider.message);
          // showAlertDialog(context);
        }
      }
    }
  }

  showAlertDialog(BuildContext context) {
    Widget okButton = FlatButton(
      child: Text("OK"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );

    AlertDialog alert = AlertDialog(
      title: Text("Register failed"),
      content: Text("content"),
      actions: [
        okButton,
      ],
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
