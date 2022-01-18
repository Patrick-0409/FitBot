import 'package:fiton/models/news.dart';
import 'package:fiton/screen/article/components/primary_card.dart';
import 'package:fiton/screen/article/detail/read_news.dart';
import 'package:fiton/screen/article/components/secondary_card.dart';
import 'package:fiton/services/news_api_manager.dart';
import 'package:flutter/material.dart';

import '../../../constant.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
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
                              builder: (context) => ReadNews(
                                contain: temp,     
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
                  itemCount: snapshot.data?.articles.length,
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  physics: ScrollPhysics(),
                  itemBuilder: (context, index) {
                    var recent = snapshot.data?.articles[index];
                    return InkWell(
                      onTap: () async {
                        bool temp = await API_Manager().checkContains(await API_Manager().checkNews(
                                                recent!.source!.name,
                                                recent.author,
                                                recent.title,
                                                recent.description,
                                                recent.url,
                                                recent.urlToImage,
                                                recent.publishedAt!,
                                                recent.content
                                                ));
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ReadNews(contain: temp,   
                                                        source: recent.source!.name,
                                                        author: recent.author,
                                                        title: recent.title,
                                                        description: recent.description,
                                                        url: recent.url,
                                                        urlToImage: recent.urlToImage,
                                                        publishedAt: recent.publishedAt!,
                                                        content: recent.content,
                            ),
                          ),
                        );
                      },
                      child: Container(
                        width: double.infinity,
                        height: 150,
                        margin: EdgeInsets.symmetric(horizontal: 18, vertical: 8),
                        child: SecondaryCard(
                          source: recent!.source!.name,
                          author: recent.author,
                          title: recent.title,
                          description: recent.description,
                          url: recent.url,
                          urlToImage: recent.urlToImage,
                          publishedAt: recent.publishedAt!,
                          content: recent.content,
                        ),
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
