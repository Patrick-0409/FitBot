import 'package:firebase_auth/firebase_auth.dart';
import 'package:fiton/screen/authentication/components/rounded_button.dart';
import 'package:fiton/screen/authentication/components/rounded_input_field.dart';
import 'package:fiton/screen/authentication/components/rounded_password_field.dart';
import 'package:fiton/screen/authentication/signup/signup_screen.dart';
import 'package:flutter/material.dart';

import 'account_checker.dart';
import 'background.dart';
import 'login_option.dart';
import 'or_divider.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  final _formKey = GlobalKey<FormState>();

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool loading = false;
  bool success = false;

  _logIn() async {
    setState(() {
      loading = true;
    });

    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: _emailController.text,
          password: _passwordController.text
      );

    } on FirebaseAuthException catch (e) {
      var message = '';

      switch (e.code) {
        case 'invalid-email':
          message = 'The email you entered was invalid';
          break;
        case 'user-disabled':
          message = 'The user you tried to log into is disabled';
          break;
        case 'user-not-found':
          message = 'The user you tried to log into was not found';
          break;
        case 'wrong-password':
          message = 'Incorrect password';
          break;
      }

      showDialog(context: context, builder: (context) {
        return AlertDialog(
          title: Text('Login failed'),
          content: Text(message),
          actions: [
            TextButton(onPressed: () {
              Navigator.of(context).pop();

            }, child: Text('Ok')),
          ],
        );
      });
    } finally {
      setState(() {
        success = true;
        loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Stack(
      children: <Widget>[ loading && success ?
      Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Colors.white,
        ),
        child: Center(
          child:SizedBox(
            child: CircularProgressIndicator()
          ),
        ),
      )
            :
      SingleChildScrollView(
      child: Background(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  "FitOn",
                  style: Theme.of(context).textTheme.headline1,
                ),
                SizedBox(height: size.height * 0.11),
                LoginOption(),
                OrDivider(),
                RoundedInputField(
                  onChanged: (value) => _emailController.text = value!,
                ),
                SizedBox(height: size.height * 0.02),
                RoundedPasswordField(
                  onChanged: (value) => _passwordController.text = value!,
                ),
                SizedBox(height: size.height * 0.01),
                RoundedButton(
                  text: "Login",
                  press: () {
                    _logIn();
                  },
                ),
                AccountChecker(
                  press: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return SignUpScreen();
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
    )]
    );
  }

  Future submit() async {
    print(_passwordController.text);
  }
}
