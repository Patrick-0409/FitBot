import 'package:firebase_auth/firebase_auth.dart';
import 'package:fiton/screen/homepage/home_screen.dart';
import 'package:fiton/screen/provider/email_auth.dart';
import 'package:fiton/screen/provider/google_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'components/body.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Scaffold(
        body: SafeArea(
          child: StreamBuilder(
              stream: FirebaseAuth.instance.authStateChanges(),
              builder: (context, snapshot) {
                final provider = Provider.of<GoogleSignInProvider>(context);

                if (provider.isSigningIn) {
                  return buildLoading();
                } else if (snapshot.hasData) {
                  return HomeScreen();
                } else {
                  return Body();
                }
              }),
        ),
      );

  Widget buildLoading() => Stack(
        fit: StackFit.expand,
        children: [
          Center(child: CircularProgressIndicator()),
        ],
      );
}
