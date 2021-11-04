import 'package:fiton/models/dummy.dart';
import 'package:fiton/models/place.dart';
import 'package:flutter/material.dart';

import '../../../constant.dart';

class NearbyCardDtl extends StatelessWidget {
  final Place place;
  NearbyCardDtl({required this.place});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15.0),
        border: Border.all(color: kGrey3, width: 1.0),
        color: Colors.white,
      ),
      child: Row(
        children: [
          Container(
            width: 160.0,
            height: 135.0,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12.0),
              image: DecorationImage(
                image: place.photos.length > 0 ? NetworkImage(
              'https://maps.googleapis.com/maps/api/place/photo?maxwidth=400&photo_reference=' +
                  place.photos[0].photo_reference! +
                  '&key=' +
                  apiKey) : NetworkImage('https://i.giphy.com/media/jAYUbVXgESSti/giphy.webp'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(width: 12.0),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 5.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    place.name!,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                    style: kTitleCard,
                  ),
                  SizedBox(height: 4.0),
                  Text(
                    'temp description',
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                    style: kDetailContent,
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
