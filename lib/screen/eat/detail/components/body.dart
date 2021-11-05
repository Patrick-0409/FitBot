import 'package:favorite_button/favorite_button.dart';
import 'package:fiton/models/dummy.dart';
import 'package:fiton/screen/article/components/network_image_ssl.dart';
import 'package:flutter/material.dart';

import '../../../../constant.dart';

class Body extends StatelessWidget {
  final Dummy news;

  const Body({Key? key, required this.news}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 18.0),
      child: ListView(
        children: [
          SizedBox(height: 10),
          Hero(
            tag: news.image,
            child: Container(
              height: 220.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                image: DecorationImage(
                  image: NetworkImageSSL(news.image, headers: {}),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          SizedBox(height: 15.0),
          Row(
            children: [
              Container(
                padding: EdgeInsets.only(left: 5, right: 5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: KEatCardBackground,
                ),
                child: Text(
                  "40 min",
                  style: kTitleCardEat.copyWith(fontSize: 12),
                ),
              ),
              SizedBox(width: 5),
              Container(
                padding: EdgeInsets.only(left: 5, right: 5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: KEatCardCategory,
                ),
                child: Text(
                  "Seafood",
                  style: kTitleCardEat.copyWith(fontSize: 12),
                ),
              ),
              SizedBox(width: 5),
              Container(
                padding: EdgeInsets.only(left: 5, right: 5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: KEatCardCalories,
                ),
                child: Text(
                  "179 kcal",
                  style: kTitleCardEat.copyWith(fontSize: 12),
                ),
              ),
              Spacer(),
              FavoriteButton(
                iconSize: 30,
                valueChanged: () {},
              ),
              SizedBox(width: 3),
              Text(
                "179",
                style: kTitleCardEat.copyWith(fontSize: 18),
              ),
              SizedBox(width: 5),
            ],
          ),
          SizedBox(height: 10.0),
          Text(
            news.title,
            style: kTitleCardEat.copyWith(
              color: Colors.black,
              fontSize: 17,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(height: 10.0),
          Text(
            "Nutritions",
            style: kTitleCard.copyWith(
              fontSize: 15,
              fontWeight: FontWeight.normal,
            ),
          ),
          SizedBox(height: 5.0),
          Row(
            children: <Widget>[
              Container(
                width: size.width * 0.2,
                height: size.height * 0.05,
                decoration: BoxDecoration(
                  color: kBackgroundColor,
                  borderRadius: BorderRadius.circular(15.0),
                ),
              ),
              SizedBox(width: 5.0),
              Container(
                width: size.width * 0.2,
                height: size.height * 0.05,
                decoration: BoxDecoration(
                  color: kBackgroundColor,
                  borderRadius: BorderRadius.circular(15.0),
                ),
              ),
              SizedBox(width: 5.0),
              Container(
                width: size.width * 0.2,
                height: size.height * 0.05,
                decoration: BoxDecoration(
                  color: kBackgroundColor,
                  borderRadius: BorderRadius.circular(15.0),
                ),
              ),
            ],
          ),
          SizedBox(height: 20.0),
          Container(
            width: size.width,
            // height: size.height * 0.05,
            padding: EdgeInsets.only(top: 5, left: 10, right: 10, bottom: 10),
            decoration: BoxDecoration(
              color: KEatCardBackground,
              borderRadius: BorderRadius.circular(15.0),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Ingredients",
                  textAlign: TextAlign.start,
                  style: kTitleCard.copyWith(
                    color: Colors.black,
                    fontSize: 16,
                  ),
                ),
                SizedBox(height: 3),
                Text(
                  news.subtitle,
                  style: descriptionStyle.copyWith(
                      color: Colors.black, fontSize: 12),
                ),
              ],
            ),
          ),
          SizedBox(height: 15.0),
          Container(
            width: size.width,
            // height: size.height * 0.05,
            padding: EdgeInsets.only(top: 5, left: 10, right: 10, bottom: 10),
            decoration: BoxDecoration(
              color: KEatCardBackground,
              borderRadius: BorderRadius.circular(15.0),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Steps",
                  textAlign: TextAlign.start,
                  style: kTitleCard.copyWith(
                    color: Colors.black,
                    fontSize: 16,
                  ),
                ),
                SizedBox(height: 3),
                Text(
                  news.subtitle,
                  style: descriptionStyle.copyWith(
                      color: Colors.black, fontSize: 12),
                ),
              ],
            ),
          ),
          SizedBox(height: 25.0),
        ],
      ),
    );
  }
}
