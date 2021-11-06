import 'package:flutter/material.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

class RatingBar extends StatefulWidget {
  RatingBar({Key? key}) : super(key: key);

  @override
  _RatingBarState createState() => _RatingBarState();
}

class _RatingBarState extends State<RatingBar> {
  double ratingVal = 3;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SmoothStarRating(
          size: 25,
          color: Colors.amber,
          borderColor: Colors.amber,
          isReadOnly: true,
          starCount: 5,
          rating: ratingVal,
          halfFilledIconData: Icons.star_half,
        )
      ],
    );
  }
}
