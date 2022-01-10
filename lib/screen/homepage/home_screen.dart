import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fiton/screen/authentication/login/login_screen.dart';
import 'package:fiton/screen/profile/profile_screen.dart';
import 'package:fiton/screen/workout/workout_screen.dart';
import 'package:fiton/services/notification_service.dart';
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

  @override
  void initState() {
    super.initState();

    NotificationService.init();
    listenNotification();
  }

  void listenNotification() =>
      NotificationService.onNotifications.stream.listen(onClickedNotification);

  void onClickedNotification(String? payload) =>
      Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => WorkoutScreen(payload: payload),
      ));

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
                          builder: (BuildContext context,
                              AsyncSnapshot<String> snapshot) {
                            if (snapshot.hasData) {
                              return CircleAvatar(
                                maxRadius: 25,
                                backgroundImage: NetworkImage(
                                    user.photoURL == null
                                        ? snapshot.data!
                                        : user.photoURL!),
                              );
                            }
                            return CircularProgressIndicator();
                          })),
                  title: Text(
                    "FitBot",
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.headline5,
                  ),
                  trailing: Theme(
                      data: Theme.of(context).copyWith(
                        cardColor: Color(0xFF152F42),
                      ),
                      child: new PopupMenuButton(
                        itemBuilder: (context) => [
                          PopupMenuItem(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  "Test Notification",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.w600),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                    left: 10.0,
                                  ),
                                  child: Icon(
                                    Icons.account_circle,
                                    color: Colors.white,
                                    size: 22.0,
                                  ),
                                ),
                              ],
                            ),
                            onTap: () =>
                                NotificationService.showScheduledNotification(
                              title: 'FitOn',
                              body:
                                  'Ayo semangat, kita harus olahraga bareng ya!',
                              payload: 'Fit.On',
                              scheduledDate:
                                  DateTime.now().add(Duration(seconds: 12)),
                            ),
                          ),
                          PopupMenuItem(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  "Edit Profile",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.w600),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                    left: 10.0,
                                  ),
                                  child: Icon(
                                    Icons.account_circle,
                                    color: Colors.white,
                                    size: 22.0,
                                  ),
                                ),
                              ],
                            ),
                            onTap: () {},
                          ),
                          PopupMenuItem(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  "Settings",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.w600),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                    left: 10.0,
                                  ),
                                  child: Icon(
                                    Icons.settings,
                                    color: Colors.white,
                                    size: 22.0,
                                  ),
                                ),
                              ],
                            ),
                            onTap: () {},
                          ),
                          PopupMenuItem(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  "About Us",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.w600),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                    left: 10.0,
                                  ),
                                  child: Icon(
                                    Icons.info,
                                    color: Colors.white,
                                    size: 22.0,
                                  ),
                                ),
                              ],
                            ),
                            onTap: () {},
                          ),
                          PopupMenuItem(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  "Logout",
                                  style: TextStyle(
                                      color: Colors.redAccent,
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.w600),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                    left: 10.0,
                                  ),
                                  child: Icon(
                                    Icons.logout,
                                    color: Colors.redAccent,
                                    size: 22.0,
                                  ),
                                ),
                              ],
                            ),
                            onTap: () {
                              _signOut();
                              Navigator.pop(context, "Logout");
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) {
                                    return LoginScreen();
                                  },
                                ),
                              );
                            },
                          )
                        ],
                        child: SvgPicture.asset("assets/images/menu.svg"),
                      ))),
            ],
          ),
        ),
        body: Body());
  }
}
