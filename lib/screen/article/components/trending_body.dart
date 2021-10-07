import 'package:fiton/models/news.dart';
import 'package:fiton/screen/article/components/primary_card.dart';
import 'package:fiton/screen/article/components/training_tab_view.dart';
import 'package:fiton/screen/article/detail/read_news.dart';
import 'package:fiton/screen/article/components/secondary_card.dart';
import 'package:flutter/material.dart';

import '../../../constant.dart';
import 'diet_tab_view.dart';
import 'food_tab_view.dart';

class TrendingBody extends StatelessWidget {
  const TrendingBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Container(
        child: ListView(
          children: [
            Container(
              width: double.infinity,
              height: 300,
              padding: EdgeInsets.only(left: 18),
              child: ListView.builder(
                itemCount: 5,
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  var news = TrendingList[index];
                  return InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ReadNews(news: news),
                        ),
                      );
                    },
                    child: Container(
                      margin: EdgeInsets.only(right: 12),
                      child: PrimaryCard(
                        news: news,
                      ),
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 25),
            Container(
              child: TabBar(
                labelColor: Colors.white,
                unselectedLabelColor: kGrey1,
                unselectedLabelStyle: kNonActiveTabStyle,
                indicatorSize: TabBarIndicatorSize.label,
                isScrollable: true,
                indicatorColor: Colors.white,
                labelStyle: kActiveTabStyle.copyWith(fontSize: 20.0),
                tabs: [
                  Tab(text: "Training"),
                  Tab(text: "Food"),
                  Tab(text: "Diet"),
                ],
              ),
            ),
            SizedBox(
              height: 525,
              child: TabBarView(
                children: [
                  Container(child: TrainingTabView()),
                  Container(child: FoodTabView()),
                  Container(child: DietTabView()),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
