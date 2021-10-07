import 'package:firebase_auth/firebase_auth.dart';
import 'package:fiton/screen/article/article_screen.dart';
import 'package:fiton/screen/provider/google_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Body extends StatelessWidget {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser!;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('Logged In'),
        centerTitle: true,
        actions: [
          TextButton(
            child: Text(
              'Logout',
              style: TextStyle(color: Colors.red),
            ),
            onPressed: () {
              final provider =
                  Provider.of<GoogleSignInProvider>(context, listen: false);
              provider.logout();
            },
          ),
        ],
      ),
      body: Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (user.photoURL != null)
              CircleAvatar(
                maxRadius: 40,
                backgroundImage: NetworkImage(user.photoURL!),
              ),
            SizedBox(height: 20),
            if (user.displayName != null)
              Text(
                'Hello, ' + user.displayName!,
                style: TextStyle(fontSize: 36, color: Colors.black),
              ),
            SizedBox(
              height: 20,
            ),
            Text(
              user.email!,
              style: TextStyle(fontSize: 20, color: Colors.black),
            ),
            IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return ArticleScreen();
                    },
                  ),
                );
              },
              icon: Icon(
                Icons.article,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
