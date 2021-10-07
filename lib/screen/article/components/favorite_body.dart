import 'package:fiton/models/news.dart';
import 'package:fiton/screen/article/components/secondary_card.dart';
import 'package:fiton/screen/article/detail/read_news.dart';
import 'package:flutter/material.dart';

class FavoriteBody extends StatelessWidget {
  const FavoriteBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
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
    );
    ;
  }
}
