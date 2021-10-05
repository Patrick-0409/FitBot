import 'package:fiton/screen/authentication/components/rounded_button.dart';
import 'package:fiton/screen/authentication/components/rounded_input_field.dart';
import 'package:fiton/screen/authentication/components/rounded_password_field.dart';
import 'package:fiton/screen/authentication/signup/signup_screen.dart';
import 'package:fiton/screen/provider/email_sign_in.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SingleChildScrollView(
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
                  onChanged: (value) {},
                ),
                // buildEmailField(),
                SizedBox(height: size.height * 0.02),
                RoundedPasswordField(),
                SizedBox(height: size.height * 0.01),
                RoundedButton(
                  text: "Login",
                  press: () {
                    submit();
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
    );
  }

  Future submit() async {
    final provider = Provider.of<EmailSignInProvider>(context, listen: false);

    final isValid = _formKey.currentState!.validate();
    FocusScope.of(context).unfocus();

    if (isValid) {
      _formKey.currentState!.save();

      final isSuccess = await provider.login();
      if (isSuccess) {
        new Future.delayed(const Duration(seconds: 1), () {
          if (mounted) {
            Navigator.of(context).pop();
          }
        });
      } else {
        if (mounted) {
          showAlertDialog(context);
        }
      }
    }
  }

  showAlertDialog(BuildContext context) {
    // Create button
    Widget okButton = FlatButton(
      child: Text("OK"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );

    // Create AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Login Failed"),
      content: Text("Please enter correct email and password!"),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
