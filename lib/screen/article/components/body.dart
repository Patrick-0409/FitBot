import 'package:fiton/models/news.dart';
import 'package:fiton/screen/article/components/primary_card.dart';
import 'package:fiton/screen/article/detail/read_news.dart';
import 'package:fiton/screen/article/components/secondary_card.dart';
import 'package:fiton/services/news_api_manager.dart';
import 'package:flutter/material.dart';

import '../../../constant.dart';

class Bod extends StatefulWidget {
  const Bod({Key? key}) : super(key: key);
  @override
  _BodState createState() => _BodState();
}

class _BodState extends State<Bod> {
  late Future<NewsModel> _newsModel;

  @override
  void initState() {
    _newsModel = API_Manager().getNews(trending_url);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView(
        children: [
          Container(
            width: double.infinity,
            height: 300,
            padding: EdgeInsets.only(left: 18),
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
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ReadNews(news: news!),
                            ),
                          );
                        },
                        child: Container(
                          margin: EdgeInsets.only(right: 12),
                          child: PrimaryCard(
                            news: news!,
                          ),
                        ),
                      );
                    },
                  );
              }
              return Center(child: CircularProgressIndicator());
            })
          ),
          SizedBox(height: 25),
          FutureBuilder<NewsModel>(
          future: _newsModel,
          builder: (context, snapshot) {
          if (snapshot.hasData) {
          return ListView.builder(
                  itemCount: recentList.length,
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  physics: ScrollPhysics(),
                  itemBuilder: (context, index) {
                    var recent = snapshot.data?.articles[index];
                    return InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ReadNews(news: recent!),
                          ),
                        );
                      },
                      child: Container(
                        width: double.infinity,
                        height: 150,
                        margin: EdgeInsets.symmetric(horizontal: 18, vertical: 8),
                        child: SecondaryCard(news: recent!),
                      ),
                    );
                  },
                );
          }
          return Center(child: CircularProgressIndicator());
          })
        ],
      ),
    );
  }
}
