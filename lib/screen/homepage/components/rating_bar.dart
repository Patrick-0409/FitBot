import 'package:fiton/models/place.dart';
import 'package:flutter/material.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

class RatingBar extends StatefulWidget {
  final Place place;
  RatingBar({Key? key, required this.place}) : super(key: key);

  @override
  _RatingBarState createState() => _RatingBarState();
}

class _RatingBarState extends State<RatingBar> {
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
          rating: widget.place.rating?.toDouble(),
          halfFilledIconData: Icons.star_half,
        )
      ],
    );
  }
}
