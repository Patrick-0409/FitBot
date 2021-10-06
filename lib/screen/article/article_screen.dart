import 'package:fiton/constant.dart';
import 'package:fiton/screen/authentication/login/login_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'components/body.dart';

class ArticleScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(85.0),
        child: Padding(
          padding: EdgeInsets.only(top: 11),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListTile(
                title: Text(
                  "FitOn",
                  style: Theme.of(context).textTheme.headline5,
                ),
                trailing: IconButton(
                    icon: Icon(
                      Icons.home,
                      color: Colors.black,
                      size: 35,
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return LoginScreen();
                          },
                        ),
                      );
                    }),
              ),
              Padding(
                padding: EdgeInsets.only(left: 17),
                child: Text(
                  "Trending",
                  style: Theme.of(context).textTheme.bodyText2,
                ),
              ),
              // Align(
              //   alignment: Alignment.topLeft,
              //   child: TabBar(
              //     labelColor: Colors.white,
              //     // unselectedLabelColor: Colors.black54,
              //     // indicatorSize: TabBarIndicatorSize.label,
              //     indicatorColor: Colors.,
              //     isScrollable: true,
              //     labelStyle: TextStyle(fontSize: 20),
              //     tabs: [
              //       Tab(text: "Trending"),
              //     ],
              //   ),
              // )
            ],
          ),
        ),
      ),
      body: Body(),
    );
  }
}
