import 'package:fiton/models/user.dart';
import 'package:fiton/screen/homepage/home_screen.dart';
import 'package:fiton/screen/workout/Train/components/home_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../constant.dart';
import 'components/body.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({Key? key, required this.user}) : super(key: key);

  UserStore user;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(66.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            ListTile(
              leading: HomeButton(),
              title: Text(
                "Profile",
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headline5,
              ),
              trailing: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return HomeScreen();
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
      body: Body(user: user),
    );
  }
}
