import 'package:fiton/screen/workout/Train/components/home_button.dart';
import 'package:flutter/material.dart';
import '../../../constant.dart';
import 'body_see.dart';

class SeeAllScreen extends StatelessWidget {
  const SeeAllScreen({Key? key}) : super(key: key);

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
              leading: Text(
                "FitBot",
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headline5,
              ),
              trailing: HomeButton(),
            ),
          ],
        ),
      ),
      body: BodySee(),
    );
  }
}
