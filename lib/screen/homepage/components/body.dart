
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fiton/provider/google_sign_in.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Body extends StatelessWidget{
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context){
    final user = FirebaseAuth.instance.currentUser!;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('Logged In'),
        centerTitle: true,
        actions: [
          TextButton(
              child: Text('Logout',style: TextStyle(color: Colors.red),),
              onPressed: (){
                final provider = Provider.of<GoogleSignInProvider>(context, listen: false);
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
            CircleAvatar(
              radius: 40,
              backgroundImage: NetworkImage(user.photoURL!),
            ),
            SizedBox(height: 20),
            Text(
              'Hello, ' + user.displayName!,
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 20,),
            Text(
              user.email!,
              style: TextStyle(fontSize: 20),
            )
          ],
        ),
      ),
    );
  }
}