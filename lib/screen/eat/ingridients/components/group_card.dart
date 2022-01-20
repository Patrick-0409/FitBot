import 'package:fiton/constant.dart';
import 'package:fiton/models/recipe.dart';
import 'package:fiton/screen/article/components/network_image_ssl.dart';
import 'package:flutter/material.dart';


class IngridientsCardFav extends StatelessWidget {
  final Recipe recipe;
  const IngridientsCardFav({Key? key, required this.recipe}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Container(
        width: 300,
        height: size.height * 0.24,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImageSSL(recipe.image!, headers: {}),
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
                      text: recipe.label,
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
                      recipe.totalTime!.toInt().toString()+" min",
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
                      recipe.cuisineType!,
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
                      recipe.calories!.toInt().toString() + " kcal",
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