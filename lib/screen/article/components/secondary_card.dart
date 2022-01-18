import 'package:fiton/constant.dart';
import 'package:flutter/material.dart';
import 'package:timeago/timeago.dart' as TimeAgo;
import 'network_image_ssl.dart';

class SecondaryCard extends StatelessWidget {
  final String? source;
  final String? author;
  final String? title;
  final String? description;
  final String? url;
  final String? urlToImage;
  final DateTime? publishedAt;
  final String? content;
  const SecondaryCard({
    Key? key,
    required this.source,
    required this.author,
    required this.title,
    required this.description,
    required this.url,
    required this.urlToImage,
    required this.publishedAt,
    required this.content
  }) : super(key: key);

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
          Hero(
            tag: title!,
            child: Container(
              width: 90.0,
              height: 135.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12.0),
                image: DecorationImage(
                  image: NetworkImageSSL(urlToImage!, headers: {}),
                  fit: BoxFit.cover,
                ),
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
                    title!,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                    style: kTitleCard,
                  ),
                  SizedBox(height: 4.0),
                  Text(
                    description!,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                    style: kDetailContent,
                  ),
                  Spacer(),
                  Row(
                    children: [
                      Text(
                        TimeAgo.format(publishedAt!),
                        overflow: TextOverflow.ellipsis,
                        style: kDetailContent,
                      ),
                      SizedBox(width: 10.0),
                      CircleAvatar(
                        radius: 5.0,
                        backgroundColor: kGrey1,
                      ),
                      SizedBox(width: 10.0),
                      Text(
                        source!,
                        overflow: TextOverflow.ellipsis,
                        style: kDetailContent,
                      ),
                    ],
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
