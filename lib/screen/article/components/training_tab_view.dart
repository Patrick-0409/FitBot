import 'package:fiton/constant.dart';
import 'package:fiton/models/news.dart';
import 'package:fiton/screen/article/components/secondary_card.dart';
import 'package:fiton/screen/article/detail/read_news.dart';
import 'package:fiton/services/news_api_manager.dart';
import 'package:flutter/material.dart';

class TrainingTabView extends StatefulWidget {
  const TrainingTabView({Key? key}) : super(key: key);

  @override
  _TrainingTabViewState createState() => _TrainingTabViewState();
}

class _TrainingTabViewState extends State<TrainingTabView> {
  late Future<NewsModel> _newsModel;
  @override
  void initState() {
    _newsModel = API_Manager().getNews(training_url);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<NewsModel>(
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
        }
    );
  }
}