import 'package:firebase_auth/firebase_auth.dart';
import 'package:fiton/constant.dart';
import 'package:fiton/models/dummy.dart';
import 'package:fiton/screen/article/article_screen.dart';
import 'package:fiton/screen/eat/eat_screen.dart';
import 'package:fiton/screen/homepage/components/nearby_card.dart';
import 'package:fiton/screen/homepage/components/scheduler_home.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../home_screen.dart';
import 'button_explore.dart';

class Body extends StatelessWidget {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser!;
    final size = MediaQuery.of(context).size;

    return SafeArea(
      child: SingleChildScrollView(
        child: Container(
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.only(left: 13),
                child: SchedulerHome(size: size),
              ),
              SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.only(left: 13, right: 14),
                child: Row(
                  children: <Widget>[
                    Text(
                      "Nearby",
                      textAlign: TextAlign.start,
                      style: Theme.of(context)
                          .textTheme
                          .bodyText2!
                          .copyWith(color: Colors.black),
                    ),
                    Spacer(),
                    GestureDetector(
                      onTap: () {},
                      child: Text(
                        "See All",
                        textAlign: TextAlign.start,
                        style: Theme.of(context)
                            .textTheme
                            .bodyText2!
                            .copyWith(fontSize: 15),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 5),
              Container(
                width: double.infinity,
                height: size.height * 0.14,
                child: ListView.builder(
                  itemCount: 5,
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    var news = popularList[index];
                    return InkWell(
                      onTap: () {},
                      child: Container(
                        width: 200,
                        margin: EdgeInsets.only(right: 4, left: 13),
                        child: NearbyCard(
                          news: news,
                        ),
                      ),
                    );
                  },
                ),
              ),
              SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.only(left: 13),
                child: Text(
                  "Explore",
                  textAlign: TextAlign.start,
                  style: Theme.of(context)
                      .textTheme
                      .bodyText2!
                      .copyWith(color: Colors.black),
                ),
              ),
              SizedBox(height: 10),
              Row(
                children: <Widget>[
                  ButtonExplore(
                    size: size,
                    press: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return ArticleScreen();
                          },
                        ),
                      );
                    },
                    color: kArticle,
                    text: Text(
                      "Article",
                      style: kArticleTitle,
                    ),
                    picture: SvgPicture.asset("assets/icons/search.svg"),
                  ),
                  ButtonExplore(
                    size: size,
                    press: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return ArticleScreen();
                          },
                        ),
                      );
                    },
                    color: kTrain,
                    text: Text(
                      "Train",
                      style: kTrainTitle,
                    ),
                    picture: SvgPicture.asset("assets/icons/search.svg"),
                  ),
                  ButtonExplore(
                    size: size,
                    press: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return ArticleScreen();
                          },
                        ),
                      );
                    },
                    color: kChat,
                    text: Text(
                      "Chat",
                      style: kChatTitle,
                    ),
                    picture: SvgPicture.asset("assets/icons/search.svg"),
                  ),
                  ButtonExplore(
                    size: size,
                    press: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return EatScreen();
                          },
                        ),
                      );
                    },
                    color: kTrain,
                    text: Text(
                      "Eat",
                      style: kTrainTitle,
                    ),
                    picture: SvgPicture.asset("assets/icons/search.svg"),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
