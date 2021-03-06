import 'package:fiton/constant.dart';
import 'package:fiton/models/place.dart';
import 'package:flutter/material.dart';

class NearbyCard extends StatelessWidget {
  final Place place;
  const NearbyCard({Key? key, required this.place}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // print(place.lat);
    return Container(
      // width: 300,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        border: Border.all(
          color: Colors.white,
          width: 1,
        ),
        image: DecorationImage(
          image: place.photos.length > 0 ? NetworkImage(
              'https://maps.googleapis.com/maps/api/place/photo?maxwidth=400&photo_reference=' +
                  place.photos[0].photoReference! +
                  '&key=' +
                  apiKey) : NetworkImage('https://i.giphy.com/media/jAYUbVXgESSti/giphy.webp'),
          fit: BoxFit.cover,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(height: 65),
          Padding(
            padding: EdgeInsets.only(left: 12, right: 20),
            child: Container(
              padding: EdgeInsets.only(left: 7, right: 7, top: 3, bottom: 3),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Text(
                place.name!,
                style: kDistanceTitle.copyWith(color: Colors.black),
                textAlign: TextAlign.start,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
