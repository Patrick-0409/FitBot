import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../homepage/home_screen.dart';
import 'components/body.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Scaffold(
    body: StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot){
        if(snapshot.connectionState == ConnectionState.waiting){
          return Center(child: CircularProgressIndicator());
        }
        else if(snapshot.hasData){
          return HomeScreen();
        }
        else if(snapshot.hasError){
          return Center(child: Text('Something Went Wrong!'),);
        }
        else{
          return Body();
        }
      },
    ),
  );
}
