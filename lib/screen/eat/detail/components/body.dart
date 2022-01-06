import 'package:favorite_button/favorite_button.dart';
import 'package:fiton/screen/article/components/network_image_ssl.dart';
import 'package:fiton/screen/eat/detail/components/button_nutrision.dart';
import 'package:fiton/services/recipe_service.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../constant.dart';


class Body extends StatefulWidget {
  var id;
  final bool? contain;
  final String? label;
  final String? image;
  final String? cuisineType;
  final num? calories;
  final num? fat;
  final num? sugar;
  final num? protein;
  final num? totalTime;
  final List<String>? ingredientLines;
  final String? url;

  Body({
    Key? key,
    required this.contain,
    required this.label,
    required this.image,
    required this.calories,
    required this.fat,
    required this.sugar,
    required this.protein,
    required this.totalTime,
    required this.cuisineType,
    required this.ingredientLines,
    required this.url,
  }) : super(key: key);
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  var tempFav = TextEditingController();
  @override
  void initState() {
    RecipesService().getFav(widget.label).then((value) => {
          setState(() {
            tempFav.text = value.toString();
          }),
        });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 18.0),
      child: ListView(
        children: [
          SizedBox(height: 10),
          Hero(
            tag: widget.image.toString(),
            child: Container(
              height: 220.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                image: DecorationImage(
                  image: NetworkImageSSL(widget.image!, headers: {}),
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
                  widget.totalTime!.toInt().toString() + " min",
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
                  widget.cuisineType!,
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
                  widget.calories!.toInt().toString() + " kcal",
                  style: kTitleCardEat.copyWith(fontSize: 12),
                ),
              ),
              Spacer(),
              FavoriteButton(
                isFavorite: widget.contain,
                iconSize: 30,
                valueChanged: (_isFavorite) async {
                  if (_isFavorite)
                    await RecipesService()
                        .addFav(await RecipesService().getFavID(widget.label));
                  else
                    await RecipesService().deleteFav(
                        await RecipesService().getFavID(widget.label));
                  RecipesService().getFav(widget.label).then((value) => {
                        setState(() {
                          tempFav.text = value.toString();
                        }),
                      });
                },
              ),
              SizedBox(width: 3),
              Text(
                tempFav.text,
                style: kTitleCardEat.copyWith(fontSize: 18),
              ),
              SizedBox(width: 5),
            ],
          ),
          SizedBox(height: 10.0),
          Text(
            widget.label!,
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
              ButtonNutrision(name:"Fat", quantity: widget.fat!, size: size),
              SizedBox(width: 7.0),
              ButtonNutrision(name:"Sugar", quantity: widget.sugar!, size: size),
              SizedBox(width: 7.0),
              ButtonNutrision(name:"Protein", quantity: widget.protein!, size: size),
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
                for (int i = 0; i < widget.ingredientLines!.length; i++)
                  Text(
                    widget.ingredientLines![i],
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
              color: kBackgroundColor,
              borderRadius: BorderRadius.circular(15.0),
            ),
            child: GestureDetector(
              onTap: () => _launchURL(widget.url!),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "See Full Steps",
                    textAlign: TextAlign.center,
                    style: kTitleCard.copyWith(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                  // SizedBox(height: 3),
                  // Text(
                  //   widget.url!,
                  //   style: descriptionStyle.copyWith(
                  //       color: Colors.black, fontSize: 12),
                  // ),
                ],
              ),
            ),
          ),
          SizedBox(height: 25.0),
        ],
      ),
    );
  }
}

void _launchURL(String url) async {
    await canLaunch(url) ? await launch(url) : throw 'Could not launch $url';
}
