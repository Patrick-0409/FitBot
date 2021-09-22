import 'package:fiton/constant.dart';
import 'package:fiton/screen/authentication/login/login_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'FitOn',
      theme: ThemeData(
        textTheme: TextTheme(
          headline1: TextStyle(
            fontSize: 64,
            fontWeight: FontWeight.w800,
            fontFamily: 'Roboto',
            color: kHeaderColor,
          ),
          headline5: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.w700,
            fontFamily: 'Roboto',
          ),
          bodyText1: TextStyle(
            fontSize: 13.0,
            fontWeight: FontWeight.w700,
            fontFamily: 'Roboto',
          ),
        ),
        fontFamily: 'Poppins',
      ),
      home: LoginScreen(),
    );
  }
}
