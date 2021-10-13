import 'package:favorite_button/favorite_button.dart';
import 'package:fiton/models/news.dart';
import 'package:fiton/screen/article/detail/components/status.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../../../constant.dart';

class Body extends StatelessWidget {
  const Body({
    Key? key,
    required this.news,
  }) : super(key: key);

  final Article news;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 18.0),
      child: ListView(
        children: [
          SizedBox(height: 12.0),
          Row(
            children: [
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 12.0,
                  vertical: 10.0,
                ),
                decoration: BoxDecoration(
                  color: kTagColor,
                  border: Border.all(color: kGrey3, width: 1.0),
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 5.0,
                      backgroundColor: kGrey3,
                    ),
                    SizedBox(width: 6.0),
                    Text(
                      news.source!.name!,
                      style: kCategoryTitle.copyWith(color: Colors.black),
                    ),
                  ],
                ),
              ),
              SizedBox(width: 10.0),
              Spacer(),
              FavoriteButton(
                isFavorite: false,
                iconSize: 40.0,
                valueChanged: (_isFavorite) {
                  print('Is Favorite : $_isFavorite');
                },
              ),
            ],
          ),
          SizedBox(height: 12.0),
          Text(news.title!, style: kTitleCard.copyWith(fontSize: 20.0)),
          SizedBox(height: 15.0),
          Hero(
            tag: news.title!,
            child: Container(
              height: 220.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15.0),
                image: DecorationImage(
                  image: NetworkImage(news.urlToImage!),
                  fit: BoxFit.fill,
                ),
              ),
            ),
          ),
          SizedBox(height: 15.0),
          Row(
            children: [
              Text(news.publishedAt.toString(), style: kDetailContent),
              SizedBox(width: 5.0),
              SizedBox(
                width: 10.0,
                child: Divider(
                  color: kBlack,
                  height: 1.0,
                ),
              ),
              SizedBox(width: 5.0),
              Text(
                news.source!.name!,
                style: kDetailContent.copyWith(color: Colors.black),
              ),
            ],
          ),
          SizedBox(height: 15.0),
          Text(
            news.content!,
            style: descriptionStyle.copyWith(color: Colors.black, fontSize: 14),
          ),
          SizedBox(height: 25.0)
        ],
      ),
    );
  }
}
