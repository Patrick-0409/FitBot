import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fiton/screen/authentication/login/login_screen.dart';
import 'package:fiton/screen/profile/profile_screen.dart';
import 'package:fiton/services/user_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../constant.dart';
import 'components/body.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  Future<void> _signOut() async {
    await firebaseAuth.signOut();
  }

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser!;
    // final image = getUser(user.uid).then((value) => value);
    // print('asdasd '+getUrl(user.uid));
    return Scaffold(
        backgroundColor: kBackgroundColor,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(66.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              ListTile(
                leading: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return ProfileScreen();
                        },
                      ),
                    );
                  },
                  child: FutureBuilder<String>(
                    future: user_service().getImgUser(user.uid),
                    builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
                      if (snapshot.hasData) {
                        return CircleAvatar(
                          maxRadius: 25,
                          backgroundImage: NetworkImage(user.photoURL == null ? snapshot.data! : user.photoURL!),
                        );
                      }
                      return CircularProgressIndicator();
                    }
                  )
                  // CircleAvatar(
                  //   maxRadius: 25,
                  //   backgroundImage: NetworkImage(user.photoURL == null ? 'https://assets-a1.kompasiana.com/items/album/2018/10/30/fitness-5bd7f1a06ddcae12ff37c1b5.jpg' : user.photoURL!),
                  // ),
                ),
                title: Text(
                  "FitBot",
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.headline5,
                ),
                trailing: GestureDetector(
                  onTap: () {
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
                  child: SvgPicture.asset("assets/images/menu.svg"),
                ),
              ),
            ],
          ),
        ),
        body: Body());
  }
}
