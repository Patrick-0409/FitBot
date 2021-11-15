import 'package:fiton/models/dummy.dart';
import 'package:fiton/screen/eat/components/dishes_card_fav.dart';
import 'package:fiton/screen/eat/detail/components/circle_button.dart';
import 'package:fiton/screen/eat/detail/eat_detail_screen.dart';
import 'package:fiton/screen/eat/ingridients/ingridients_card_fav.dart';
import 'package:fiton/screen/homepage/home_screen.dart';
import 'package:flutter/material.dart';

import '../../../constant.dart';

class LunchScreen extends StatelessWidget {
  const LunchScreen({Key? key}) : super(key: key);

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
          child: Padding(
            padding: const EdgeInsets.only(left: 15, right: 15, top: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Lunch",
                  textAlign: TextAlign.start,
                  style: Theme.of(context)
                      .textTheme
                      .bodyText1!
                      .copyWith(fontSize: 24),
                ),
                SizedBox(height: 5),
                Container(
                  width: size.width * 0.9,
                  height: 35,
                  decoration: BoxDecoration(
                    color: kSearchBarColor.withOpacity(0.1),
                    // borderRadius: BorderRadius.circular(15),
                  ),
                  child: TextField(
                    style: TextStyle(fontSize: 13),
                    decoration: InputDecoration(
                      enabledBorder: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      hintText: "So, what do you want to eat?",
                      prefixIcon: Icon(Icons.search, color: Colors.black),
                      contentPadding: EdgeInsets.symmetric(vertical: 12),
                    ),
                  ),
                ),
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
                          // Navigator.push(
                          //   context,
                          //   MaterialPageRoute(
                          //     builder: (context) => EatDetailScreen(News: news),
                          //   ),
                          // );
                        },
                        child: IngridientsCardFav(news: news),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
