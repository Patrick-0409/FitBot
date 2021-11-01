import 'package:fiton/models/dummy.dart';
import 'package:fiton/screen/homepage/components/nearby_card_dtl.dart';
import 'package:flutter/material.dart';

class BodySee extends StatelessWidget {
  const BodySee({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView(
        children: <Widget>[
          ListView.builder(
            itemCount: recentList.length,
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            physics: ScrollPhysics(),
            itemBuilder: (context, index) {
              var recent = recentList[index];
              return InkWell(
                onTap: () {
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(
                  //     builder: (context) => ReadNewsView(news: recent),
                  //   ),
                  // );
                },
                child: Padding(
                  padding: const EdgeInsets.only(top: 5),
                  child: Container(
                    width: double.infinity,
                    height: 160.0,
                    margin:
                        EdgeInsets.symmetric(horizontal: 18.0, vertical: 8.0),
                    child: NearbyCardDtl(news: recent),
                  ),
                ),
              );
            },
          )
        ],
      ),
    );
  }
}
