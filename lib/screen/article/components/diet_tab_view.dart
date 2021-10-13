import 'package:fiton/models/news.dart';
import 'package:fiton/screen/article/components/secondary_card.dart';
import 'package:fiton/screen/article/detail/read_news.dart';
import 'package:fiton/services/news_api_manager.dart';
import 'package:flutter/material.dart';

import '../../../constant.dart';

class DietTabView extends StatefulWidget {
  const DietTabView({Key? key}) : super(key: key);
  @override
  _DietTabViewState createState() => _DietTabViewState();
}

class _DietTabViewState extends State<DietTabView> {
  late Future<NewsModel> _newsModel;
  @override
  void initState() {
    _newsModel = API_Manager().getNews(diet_url);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<NewsModel>(
        future: _newsModel,
        builder: (context, snapshot) {
        if (snapshot.hasData) {
          return ListView.builder(
            itemCount: PopularList.length,
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
      }
    );
  }
}
