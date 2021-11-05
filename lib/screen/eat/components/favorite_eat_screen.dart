import 'package:fiton/models/dummy.dart';
import 'package:fiton/screen/eat/components/dishes_card_fav.dart';
import 'package:fiton/screen/eat/detail/components/circle_button.dart';
import 'package:fiton/screen/eat/detail/eat_detail_screen.dart';
import 'package:fiton/screen/homepage/home_screen.dart';
import 'package:flutter/material.dart';

import '../../../constant.dart';
import 'dishes_card.dart';

class FavoriteEatScreen extends StatelessWidget {
  const FavoriteEatScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
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
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.only(bottom: 85),
                width: double.infinity,
                height: size.height,
                child: ListView.builder(
                  itemCount: popularList.length,
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    var news = popularList[index];
                    return InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => EatDetailScreen(News: news),
                          ),
                        );
                      },
                      child: DishesCardFav(news: news),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
