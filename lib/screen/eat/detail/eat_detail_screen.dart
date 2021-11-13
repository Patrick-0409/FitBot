import 'package:fiton/constant.dart';
import 'package:fiton/screen/homepage/home_screen.dart';
import 'package:flutter/material.dart';

import 'components/body.dart';
import 'components/circle_button.dart';

class EatDetailScreen extends StatelessWidget {
  final bool? contain;
  final String? label;
  final String? image;
  final String? cuisineType;
  final num? calories;
  final num? totalTime;
  final List<String>? ingredientLines;
  final String? url;

  const EatDetailScreen({
    required this.contain,
    required this.label, 
    required this.image, 
    required this.calories, 
    required this.totalTime, 
    required this.cuisineType, 
    required this.ingredientLines, 
    required this.url
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(60.0),
          child: Center(
            child: SafeArea(
              child: Padding(
                padding: EdgeInsets.fromLTRB(18.0, 5.0, 18.0, 0),
                child: Row(
                  children: [
                    CircleButton(
                      icon: Icons.arrow_back_ios,
                      onTap: () => Navigator.pop(context),
                      color: kGrey2,
                    ),
                    Spacer(),
                    Text(
                      "FitBot",
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.headline5,
                    ),
                    Spacer(),
                    IconButton(
                      icon: Icon(
                        Icons.home,
                        size: 35,
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return HomeScreen();
                            },
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        body: Body(
          contain: contain,
          label: label,
          image: image,
          cuisineType: cuisineType,
          calories: calories,
          totalTime: totalTime,
          ingredientLines: ingredientLines,
          url: url,
        ),
      ),
    );
  }
}
