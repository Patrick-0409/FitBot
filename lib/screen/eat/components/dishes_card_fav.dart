import 'package:fiton/screen/article/components/network_image_ssl.dart';
import 'package:flutter/material.dart';

import '../../../constant.dart';

class DishesCardFav extends StatelessWidget {
  final String? label;
  final String? image;
  final String? cuisineType;
  final num? calories;
  final num? totalTime;
  const DishesCardFav({
    Key? key, 
    required this.label, 
    required this.image, 
    required this.calories, 
    required this.totalTime, 
    required this.cuisineType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.only(left: 15, right: 15, top: 10),
      child: Container(
        width: 300,
        height: size.height * 0.24,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImageSSL(image!, headers: {}),
            fit: BoxFit.cover,
          ),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: Colors.white,
            width: 1,
          ),
        ),
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
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
                      text: label,
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
