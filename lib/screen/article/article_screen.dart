import 'package:fiton/constant.dart';
import 'package:fiton/screen/authentication/login/login_screen.dart';
import 'package:fiton/screen/homepage/home_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'components/favorite_body.dart';
import 'components/trending_body.dart';

class ArticleScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: kBackgroundColor,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(100.0),
          child: Padding(
            padding: EdgeInsets.only(top: 11),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ListTile(
                  title: Text(
                    "FitOn",
                    textAlign: TextAlign.start,
                    style: Theme.of(context).textTheme.headline5,
                  ),
                  trailing: IconButton(
                    icon: Icon(
                      Icons.home,
                      color: Colors.black,
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
                ),
                TabBar(
                  labelColor: Colors.white,
                  unselectedLabelColor: kGrey1,
                  unselectedLabelStyle: kNonActiveTabStyle,
                  // indicatorSize: TabBarIndicatorSize.label,
                  // isScrollable: true,
                  indicatorColor: Colors.white,
                  labelStyle: kActiveTabStyle.copyWith(fontSize: 20.0),
                  tabs: [
                    Tab(text: "Trending"),
                    Tab(text: "Favorite"),
                  ],
                ),
              ],
            ),
          ),
        ),
        body: TabBarView(
          children: [
            Container(child: TrendingBody()),
            Container(child: FavoriteBody()),
          ],
        ),
      ),
    );
  }
}
