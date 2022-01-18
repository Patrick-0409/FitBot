import 'package:fiton/constant.dart';
import 'package:fiton/models/news.dart';
import 'package:flutter/material.dart';
import 'package:timeago/timeago.dart' as TimeAgo;
import 'network_image_ssl.dart';

class PrimaryCard extends StatelessWidget {
  final Article news;
  const PrimaryCard({Key? key, required this.news}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: news.title!,
      child: Container(
        width: 300,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          border: Border.all(
            color: Colors.white,
            width: 1,
          ),
          image: DecorationImage(
            image: NetworkImageSSL(news.urlToImage!, headers: {}),
            fit: BoxFit.cover,
          ),
        ),
        child: Container(
          height: 200,
          margin: EdgeInsets.only(top: 165),
          padding: EdgeInsets.only(left: 20, right: 15),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(24),
              topRight: Radius.circular(24),
              bottomLeft: Radius.circular(15),
              bottomRight: Radius.circular(15),
            ),
          ),
          child: Column(
            // crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(height: 5),
              Text(
                news.title!,
                style: kTitleCard,
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
              ),
              SizedBox(height: 5),
              Row(
                children: [
                  Icon(Icons.read_more_sharp, color: kGrey1),
                  SizedBox(width: 5),
                  Text(
                    news.source!.name!,
                    overflow: TextOverflow.ellipsis,
                    style: kDetailContent,
                  ),
                ],
              ),
              SizedBox(height: 5),
              Row(
                children: [
                  Icon(Icons.collections_bookmark),
                  SizedBox(width: 5),
                  Text(TimeAgo.format(news.publishedAt!), style: kDetailContent),
                  Spacer(),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
