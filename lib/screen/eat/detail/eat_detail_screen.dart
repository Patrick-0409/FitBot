import 'package:fiton/constant.dart';
import 'package:fiton/models/dummy.dart';
import 'package:fiton/models/news.dart';
import 'package:fiton/screen/eat/eat_screen.dart';
import 'package:fiton/screen/homepage/home_screen.dart';
import 'package:flutter/material.dart';

import 'components/body.dart';
import 'components/circle_button.dart';

class EatDetailScreen extends StatelessWidget {
  final Dummy News;
  const EatDetailScreen({Key? key, required this.News}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(60.0),
          child: Center(
            child: SafeArea(
              child: Padding(
                padding: EdgeInsets.fromLTRB(18.0, 5.0, 18.0, 0),
                child: Row(
                  children: [
                    CircleButton(
                      icon: Icons.arrow_back_ios,
                      onTap: () => Navigator.pop(context),
                      color: kGrey2,
                    ),
                    Spacer(),
                    Text(
                      "FitBot",
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.headline5,
                    ),
                    Spacer(),
                    IconButton(
                      icon: Icon(
                        Icons.home,
                        size: 35,
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return HomeScreen();
                            },
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        body: Body(news: News),
      ),
    );
  }
}
