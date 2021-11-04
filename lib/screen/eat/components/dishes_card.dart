import 'package:fiton/models/dummy.dart';
import 'package:fiton/screen/article/components/network_image_ssl.dart';
import 'package:flutter/material.dart';

import '../../../constant.dart';

class DishesCard extends StatelessWidget {
  final Dummy news;
  const DishesCard({Key? key, required this.news}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 20),
      child: Container(
        width: 300,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImageSSL(news.image, headers: {}),
            fit: BoxFit.cover,
          ),
          borderRadius: BorderRadius.circular(15),
          border: Border.all(
            color: Colors.white,
            width: 1,
          ),
        ),
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color(0XFF343434).withOpacity(0.4),
                    Color(0XFF343434).withOpacity(0.15)
                  ],
                ),
              ),
            ),
            Padding(
              padding:
                  EdgeInsets.only(left: 15, top: 8, right: 150, bottom: 100),
              child: Text.rich(
                TextSpan(
                  style: TextStyle(color: Colors.white),
                  children: [
                    TextSpan(
                      text: news.title,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 15, top: 135),
              child: Row(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.only(left: 5, right: 5),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Colors.white,
                    ),
                    child: Text(
                      "40 min",
                      style: kTitleCardEat,
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
                      style: kTitleCardEat,
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
                      style: kTitleCardEat,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
