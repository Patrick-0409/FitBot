import 'package:fiton/screen/authentication/components/rounded_button.dart';
import 'package:fiton/screen/authentication/components/rounded_input_field.dart';
import 'package:fiton/screen/authentication/components/rounded_password_field.dart';
import 'package:fiton/screen/authentication/login/components/account_checker.dart';
import 'package:fiton/screen/authentication/login/components/background.dart';
import 'package:fiton/screen/authentication/login/login_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Background(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "FitOn",
              style: Theme.of(context).textTheme.headline1,
            ),
            SizedBox(height: size.height * 0.25),
            RoundedInputField(
              onChanged: (value) {},
            ),
            SizedBox(height: size.height * 0.02),
            RoundedPasswordField(
              onChanged: (value) {},
            ),
            SizedBox(height: size.height * 0.01),
            RoundedButton(
              text: "Sign Up",
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
    );
  }
}
