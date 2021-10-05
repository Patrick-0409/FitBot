import 'package:fiton/constant.dart';
import 'package:fiton/models/news.dart';
import 'package:flutter/material.dart';

class PrimaryCard extends StatelessWidget {
  final News news;
  const PrimaryCard({Key? key, required this.news}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        border: Border.all(
          color: Colors.grey,
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 5,
                backgroundColor: Colors.grey,
              ),
              SizedBox(
                width: 10,
              ),
              Text(
                news.category,
                style: kCategoryTitle,
              ),
            ],
          ),
          SizedBox(height: 5),
          Expanded(
            child: Hero(
              tag: news.seen,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  image: DecorationImage(
                    image: NetworkImage(news.image),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 5),
          Text(
            news.title,
            style: kTitleCard,
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
          ),
          SizedBox(height: 5),
          Row(
            children: [
              Text(news.time, style: kDetailContent),
              SizedBox(width: 10),
              CircleAvatar(radius: 5, backgroundColor: kGrey1),
              SizedBox(width: 10),
              Text("${news.estimate} min read", style: kDetailContent),
            ],
          )
        ],
      ),
    );
  }
}
