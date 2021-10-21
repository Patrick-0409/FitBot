import 'package:fiton/models/news.dart';
import 'package:fiton/screen/article/components/primary_card.dart';
import 'package:fiton/screen/article/components/training_tab_view.dart';
import 'package:fiton/screen/article/detail/read_news.dart';
import 'package:fiton/screen/article/components/secondary_card.dart';
import 'package:flutter/material.dart';

import '../../../constant.dart';
import 'diet_tab_view.dart';
import 'food_tab_view.dart';
import '../../../services/news_api_manager.dart';

class TrendingBody extends StatefulWidget {
  const TrendingBody({Key? key}) : super(key: key);
  @override
  _TrendingBodyState createState() => _TrendingBodyState();
}

class _TrendingBodyState extends State<TrendingBody> {
  late Future<NewsModel> _newsModel;

  @override
  void initState() {
    _newsModel = API_Manager().getNews(trending_url);
    super.initState();
  }

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
              child: FutureBuilder<NewsModel>(
                future: _newsModel,
                builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                    itemCount: snapshot.data?.articles.length,
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      var news = snapshot.data?.articles[index];
                      return InkWell(
                        onTap: () async {
                          bool temp = await API_Manager().checkContains(await API_Manager().checkNews(
                                                news!.source!.name,
                                                news.author,
                                                news.title,
                                                news.description,
                                                news.url,
                                                news.urlToImage,
                                                news.publishedAt!,
                                                news.content
                                                ));
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ReadNews(contain: temp, 
                                                        source: news.source!.name,
                                                        author: news.author,
                                                        title: news.title,
                                                        description: news.description,
                                                        url: news.url,
                                                        urlToImage: news.urlToImage,
                                                        publishedAt: news.publishedAt!,
                                                        content: news.content,
                              ),
                            ),
                          );
                        },
                        child: Container(
                          margin: EdgeInsets.only(right: 4, left: 10),
                          child: PrimaryCard(
                            news: news!,
                          ),
                        ),
                      );
                    },
                  );
                }
                  return Center(child: CircularProgressIndicator());
              }),
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
