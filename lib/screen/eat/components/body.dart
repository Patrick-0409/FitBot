import 'package:fiton/constant.dart';
import 'package:fiton/models/dummy.dart';
import 'package:fiton/screen/article/components/trending_body.dart';
import 'package:fiton/screen/eat/components/dishes_card.dart';
import 'package:flutter/material.dart';

class Body extends StatelessWidget {
  const Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.only(left: 15),
      child: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                "Dishes",
                textAlign: TextAlign.start,
                style: Theme.of(context)
                    .textTheme
                    .bodyText1!
                    .copyWith(fontSize: 24),
              ),
              SizedBox(height: 1),
              Text(
                "Lunch Time!",
                textAlign: TextAlign.start,
                style: Theme.of(context)
                    .textTheme
                    .bodyText1!
                    .copyWith(fontWeight: FontWeight.w600),
              ),
              SizedBox(height: 10),
              Container(
                width: Size.width * 0.9,
                height: 35,
                decoration: BoxDecoration(
                  color: kSearchBarColor.withOpacity(0.1),
                  // borderRadius: BorderRadius.circular(15),
                ),
                child: TextField(
                  style: TextStyle(fontSize: 13),
                  decoration: InputDecoration(
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    hintText: "So, what do you want to eat?",
                    prefixIcon: Icon(Icons.search, color: Colors.black),
                    contentPadding: EdgeInsets.symmetric(vertical: 12),
                  ),
                ),
              ),
              SizedBox(height: 15),
              Container(
                width: double.infinity,
                height: 162,
                child: ListView.builder(
                  itemCount: 5,
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    var news = popularList[index];
                    return InkWell(
                      onTap: () {},
                      child: DishesCard(news: news),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
