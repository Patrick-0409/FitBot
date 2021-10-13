import 'package:firebase_auth/firebase_auth.dart';
import 'package:fiton/screen/article/article_screen.dart';
import 'package:fiton/screen/authentication/login/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../constant.dart';
import 'components/body.dart';

class HomeScreen extends StatelessWidget {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  Future<void> _signOut() async {
    await firebaseAuth.signOut();
  }

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser!;

    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(66.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            ListTile(
              leading: CircleAvatar(
                maxRadius: 25,
                backgroundImage: NetworkImage(user.photoURL!),
              ),
              title: Text(
                "FitOn",
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headline5,
              ),
              trailing: IconButton(
                icon: Icon(
                  Icons.apps_sharp,
                  color: Colors.white,
                  size: 35,
                ),
                onPressed: () {
                  _signOut();
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
            ),
          ],
        ),
      ),
      body: Body(),
    );
  }
}
