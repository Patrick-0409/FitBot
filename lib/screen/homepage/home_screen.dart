import 'package:firebase_auth/firebase_auth.dart';
import 'package:fiton/screen/Chatbot/chatbot_screen.dart';
import 'package:fiton/screen/authentication/login/login_screen.dart';
import 'package:fiton/screen/profile/profile_screen.dart';
import 'package:fiton/screen/scheduler/scheduler_screen.dart';
import 'package:fiton/screen/workout/Train/feedback_screen.dart';
import 'package:fiton/screen/workout/kuisoner/kuisoner_screen.dart';
import 'package:fiton/services/notification_service.dart';
import 'package:fiton/services/schedule_service.dart';
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
    SchedulesService().setNotifSchedules();
  }

  void listenNotification() =>
      NotificationService.onNotifications.stream.listen(onClickedNotification);

  void onClickedNotification(String? payload) {}

  Future<void> _signOut() async {
    await firebaseAuth.signOut();
  }

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser!;
    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(56.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            ListTile(
              leading: GestureDetector(
                  onTap: () async {
                    bool temp = await UserService().checkContains(user.uid);
                    if (temp == true) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return KuisonerScreen();
                          },
                        ),
                      ).then((value) async {
                        final userstore = await UserService().getUser(user.uid);
                        if (value == true)
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return ProfileScreen(user: userstore);
                              },
                            ),
                          );
                      });
                    } else {
                      final userstore = await UserService().getUser(user.uid);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return ProfileScreen(user: userstore);
                          },
                        ),
                      );
                    }
                  },
                  child: FutureBuilder<String>(
                      future: UserService().getImgUser(user.uid),
                      builder: (BuildContext context,
                          AsyncSnapshot<String> snapshot) {
                        if (snapshot.hasData) {
                          return CircleAvatar(
                            maxRadius: 25,
                            backgroundImage: NetworkImage(user.photoURL == null
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
                  onSelected: (result) {
                    if (result == 1) {
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
                    }
                  },
                  itemBuilder: (context) => [
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
                      value: 1,
                    )
                  ],
                  child: SvgPicture.asset("assets/images/menu.svg"),
                ),
              ),
            ),
          ],
        ),
      ),
      body: Body(),
    );
  }
}
