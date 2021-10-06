import 'package:fiton/models/news.dart';
import 'package:flutter/material.dart';

import '../../../../constant.dart';

class Body extends StatelessWidget {
  const Body({
    Key? key,
    required this.news,
  }) : super(key: key);

  final News news;

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
                      news.category,
                      style: kCategoryTitle.copyWith(color: Colors.black),
                    ),
                  ],
                ),
              ),
              SizedBox(width: 10.0),
              Status(
                icon: Icons.remove_red_eye,
                total: news.seen,
              ),
              SizedBox(width: 15.0),
              Status(
                icon: Icons.favorite_border,
                total: news.favorite,
              ),
            ],
          ),
          SizedBox(height: 12.0),
          Text(news.title, style: kTitleCard.copyWith(fontSize: 20.0)),
          SizedBox(height: 15.0),
          Hero(
            tag: news.seen,
            child: Container(
              height: 220.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15.0),
                image: DecorationImage(
                  image: NetworkImage(news.image),
                  fit: BoxFit.fill,
                ),
              ),
            ),
          ),
          SizedBox(height: 15.0),
          Row(
            children: [
              Text(news.time, style: kDetailContent),
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
                news.author,
                style: kDetailContent.copyWith(color: Colors.black),
              ),
            ],
          ),
          SizedBox(height: 15.0),
          Text(
            news.content,
            style: descriptionStyle.copyWith(color: Colors.black, fontSize: 14),
          ),
          SizedBox(height: 25.0)
        ],
      ),
    );
  }
}

class Status extends StatelessWidget {
  final IconData icon;
  final String total;
  Status({required this.icon, required this.total});
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, color: kGrey2),
        SizedBox(width: 4.0),
        Text(total, style: kDetailContent),
      ],
    );
  }
}
