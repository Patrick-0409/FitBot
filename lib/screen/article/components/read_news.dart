import 'package:fiton/models/news.dart';
import 'package:fiton/screen/homepage/home_screen.dart';
import 'package:flutter/material.dart';

import '../../../constant.dart';
import 'circle_button.dart';

class ReadNews extends StatelessWidget {
  final News news;
  ReadNews({required this.news});
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
                    icon: Icon(Icons.home),
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
      body: Container(
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
                        news.category,
                        style: kCategoryTitle.copyWith(color: Colors.black),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 10.0),
                Status(
                  icon: Icons.remove_red_eye,
                  total: news.seen,
                ),
                SizedBox(width: 15.0),
                Status(
                  icon: Icons.favorite_border,
                  total: news.favorite,
                ),
              ],
            ),
            SizedBox(height: 12.0),
            Text(news.title, style: kTitleCard.copyWith(fontSize: 20.0)),
            SizedBox(height: 15.0),
            Hero(
              tag: news.seen,
              child: Container(
                height: 220.0,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15.0),
                  image: DecorationImage(
                    image: NetworkImage(news.image),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
            ),
            SizedBox(height: 15.0),
            Row(
              children: [
                Text(news.time, style: kDetailContent),
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
                  news.author,
                  style: kDetailContent.copyWith(color: Colors.black),
                ),
              ],
            ),
            SizedBox(height: 15.0),
            Text(
              news.content,
              style:
                  descriptionStyle.copyWith(color: Colors.black, fontSize: 14),
            ),
            SizedBox(height: 25.0)
          ],
        ),
      ),
    );
  }
}

class Status extends StatelessWidget {
  final IconData icon;
  final String total;
  Status({required this.icon, required this.total});
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, color: kGrey2),
        SizedBox(width: 4.0),
        Text(total, style: kDetailContent),
      ],
    );
  }
}
