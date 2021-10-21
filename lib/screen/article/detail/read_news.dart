import 'package:firebase_auth/firebase_auth.dart';
import 'package:fiton/models/news.dart';
import 'package:fiton/screen/homepage/home_screen.dart';
import 'package:flutter/material.dart';

import '../../../constant.dart';
import 'components/body.dart';
import 'components/circle_button.dart';

class ReadNews extends StatelessWidget {
  final bool? contain;
  final String? source;
  final String? author;
  final String? title;
  final String? description;
  final String? url;
  final String? urlToImage;
  final DateTime? publishedAt;
  final String? content;
  final user = FirebaseAuth.instance.currentUser;
  ReadNews({
    required this.contain,
    required this.source,
    required this.author,
    required this.title,
    required this.description,
    required this.url,
    required this.urlToImage,
    required this.publishedAt,
    required this.content
  });
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(65.0),
        child: Center(
          child: SafeArea(
            child: Padding(
              padding: EdgeInsets.fromLTRB(18.0, 15.0, 18.0, 0),
              child: Row(
                children: [
                  CircleButton(
                    icon: Icons.arrow_back_ios,
                    onTap: () => Navigator.pop(context),
                  ),
                  Spacer(),
                  Text(
                    "FitOn",
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.headline5,
                  ),
                  // CircleButton(
                  //   icon: Icons.share,
                  //   onTap: () {},
                  // ),
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
        source: source!,
        author: author,
        title: title,
        description: description,
        url: url,
        urlToImage: urlToImage,
        publishedAt: publishedAt!,
        content: content,
        uid: user!.uid,
      ),
    );
  }
}
