import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../constant.dart';
import 'common_stats.dart';

class Description extends StatelessWidget {
  const Description({
    Key? key,
    required this.weight,
    required this.height,
    required this.age,
    required this.size,
  }) : super(key: key);

  final Size size;
  final String weight;
  final String height;
  final String age;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Container(
          width: size.width * 0.28,
          height: size.height * 0.25,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: kWeight,
          ),
          child: Padding(
            padding: EdgeInsets.only(top: 25, left: 15, right: 2),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                CommonStats(
                  svg: SvgPicture.asset("assets/images/weight.svg"),
                  text: weight+" kg",
                ),
                SizedBox(height: 20),
                Padding(
                  padding: EdgeInsets.only(left: 5),
                  child: CommonStats(
                    svg: SvgPicture.asset("assets/images/height.svg"),
                    text: height+" cm",
                  ),
                ),
                SizedBox(height: 20),
                CommonStats(
                  svg: SvgPicture.asset("assets/images/age.svg"),
                  text: age+" y.o",
                ),
              ],
            ),
          ),
        ),
        Spacer(),
        Container(
          width: size.width * 0.60,
          height: size.height * 0.25,
          padding: EdgeInsets.only(left: 15, top: 10, right: 15),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: kProfile,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "About Me",
                textAlign: TextAlign.start,
                style: Theme.of(context)
                    .textTheme
                    .bodyText2!
                    .copyWith(color: Colors.white, fontSize: 15),
              ),
              Text(
                "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Interdum consectetur risus curabitur at rhoncus nascetur. Felis platea sed risus nunc sollicitudin elit. Ac velit sit pellentesque ac eu pellentesque lacus sit id.",
                textAlign: TextAlign.start,
                style: Theme.of(context)
                    .textTheme
                    .bodyText2!
                    .copyWith(color: Colors.white, fontSize: 12),
              ),
            ],
          ),
        )
      ],
    );
  }
}
