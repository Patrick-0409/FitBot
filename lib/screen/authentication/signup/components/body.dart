import 'package:fiton/screen/authentication/components/rounded_button.dart';
import 'package:fiton/screen/authentication/components/rounded_input_field.dart';
import 'package:fiton/screen/authentication/components/rounded_password_field.dart';
import 'package:fiton/screen/authentication/login/components/account_checker.dart';
import 'package:fiton/screen/authentication/login/components/background.dart';
import 'package:fiton/screen/authentication/login/login_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'avatar_name.dart';
import 'dob_selector.dart';
import 'gender_selector.dart';

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
            // SizedBox(height: size.height * 0.25),
            AvatarName(),
            GenderSelector(),
            SizedBox(height: size.height * 0.01),
            DobSelector(),
            SizedBox(height: size.height * 0.01),
            RoundedInputField(
              onChanged: (value) {},
            ),
            SizedBox(height: size.height * 0.01),
            RoundedPasswordField(),
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
