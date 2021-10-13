import 'package:favorite_button/favorite_button.dart';
import 'package:fiton/constant.dart';
import 'package:fiton/models/news.dart';
import 'package:flutter/material.dart';

class NearbyCard extends StatelessWidget {
  final News news;
  const NearbyCard({Key? key, required this.news}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      // width: 300,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        border: Border.all(
          color: Colors.white,
          width: 1,
        ),
        image: DecorationImage(
          image: NetworkImage(news.image),
          fit: BoxFit.cover,
        ),
      ),
      child: Column(
        // crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(height: 65),
          Padding(
            padding: EdgeInsets.only(left: 15),
            child: Text(
              news.title,
              style: kDistanceTitle,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
          ),
        ],
      ),
    );
  }
}
