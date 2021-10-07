import 'package:fiton/models/news.dart';
import 'package:fiton/screen/article/components/primary_card.dart';
import 'package:fiton/screen/article/detail/read_news.dart';
import 'package:fiton/screen/article/components/secondary_card.dart';
import 'package:flutter/material.dart';

class Body extends StatelessWidget {
  const Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
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
          ListView.builder(
            itemCount: recentList.length,
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            physics: ScrollPhysics(),
            itemBuilder: (context, index) {
              var recent = recentList[index];
              return InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ReadNews(news: recent),
                    ),
                  );
                },
                child: Container(
                  width: double.infinity,
                  height: 150,
                  margin: EdgeInsets.symmetric(horizontal: 18, vertical: 8),
                  child: SecondaryCard(news: recent),
                ),
              );
            },
          )
        ],
      ),
    );
  }
}
