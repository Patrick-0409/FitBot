import 'package:favorite_button/favorite_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fiton/models/news.dart';
import 'package:fiton/screen/article/components/network_image_ssl.dart';
import 'package:fiton/screen/article/detail/components/status.dart';
import 'package:fiton/services/news_api_manager.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:timeago/timeago.dart' as TimeAgo;
import '../../../../constant.dart';

class Body extends StatelessWidget {
  var id;
  final bool? contain;
  final String? uid;
  final String? source;
  final String? author;
  final String? title;
  final String? description;
  final String? url;
  final String? urlToImage;
  final DateTime? publishedAt;
  final String? content;


  Body({
    Key? key,
    required this.contain,
    required this.uid,
    required this.source,
    required this.author,
    required this.title,
    required this.description,
    required this.url,
    required this.urlToImage,
    required this.publishedAt,
    required this.content,
  }
  ) : id = API_Manager().getFavID(title), super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 18.0),
      child: ListView(
        children: [
          SizedBox(height: 12.0),
          Row(
            children: [
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 12.0,
                  vertical: 10.0,
                ),
                decoration: BoxDecoration(
                  color: kTagColor,
                  border: Border.all(color: kGrey3, width: 1.0),
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 5.0,
                      backgroundColor: kGrey3,
                    ),
                    SizedBox(width: 6.0),
                    Text(
                      source!,
                      style: kCategoryTitle.copyWith(color: Colors.black),
                    ),
                  ],
                ),
              ),
              SizedBox(width: 10.0),
              Spacer(),
              FavoriteButton(
                isFavorite: contain,
                iconSize: 40.0,
                valueChanged: (_isFavorite) async {
                  print('Is Favorite : $_isFavorite');
                  // if(favorite.favorited!.contains(user!.uid))
                  //   print("ada usernya");
                  if(_isFavorite)
                    await API_Manager().addFav(await API_Manager().getFavID(title));
                  else
                    await API_Manager().deleteFav(await API_Manager().getFavID(title));
                },
              ),
            ],
          ),
          SizedBox(height: 12.0),
          Text(title!, style: kTitleCard.copyWith(fontSize: 20.0)),
          SizedBox(height: 15.0),
          Hero(
            tag: title!,
            child: Container(
              height: 220.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15.0),
                image: DecorationImage(
                  image: NetworkImageSSL(urlToImage!, headers: {}),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          SizedBox(height: 15.0),
          Row(
            children: [
              Text(TimeAgo.format(publishedAt!), style: kDetailContent),
              SizedBox(width: 5.0),
              SizedBox(
                width: 10.0,
                child: Divider(
                  color: kBlack,
                  height: 1.0,
                ),
              ),
              SizedBox(width: 5.0),
              Text(
                source!,
                style: kDetailContent.copyWith(color: Colors.black),
              ),
            ],
          ),
          SizedBox(height: 15.0),
          Text(
            content!,
            style: descriptionStyle.copyWith(color: Colors.black, fontSize: 14),
          ),
          SizedBox(height: 25.0)
        ],
      ),
    );
  }
}
