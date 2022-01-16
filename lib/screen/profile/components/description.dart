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
          width: size.width * 0.25,
          height: size.height * 0.24,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: kWeight,
          ),
          child: Padding(
            padding: EdgeInsets.only(top: 6, left: 10, right: 2, bottom: 12),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  "Current BMI",
                  textAlign: TextAlign.start,
                  style: Theme.of(context)
                      .textTheme
                      .bodyText2!
                      .copyWith(color: Color(0XFF96162D), fontSize: 14),
                ),
                Spacer(),
                CommonStats(
                  svg: SvgPicture.asset("assets/images/weight.svg"),
                  text: weight + " kg",
                  color: Color(0XFF96162D),
                ),
                SizedBox(height: 20),
                Padding(
                  padding: EdgeInsets.only(left: 5),
                  child: CommonStats(
                    svg: SvgPicture.asset("assets/images/height.svg"),
                    text: height + " cm",
                    color: Color(0XFF96162D),
                  ),
                ),
                SizedBox(height: 20),
                CommonStats(
                  svg: SvgPicture.asset(
                    "assets/images/body-mass-index-svgrepo-com.svg",
                    color: Color(0XFF96162D),
                    width: 15,
                    height: 25,
                  ),
                  text: height,
                  color: Color(0XFF96162D),
                ),
              ],
            ),
          ),
        ),
        Spacer(),
        Container(
          width: size.width * 0.25,
          height: size.height * 0.24,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Color(0XFFC3F2FD),
          ),
          child: Padding(
            padding: EdgeInsets.only(top: 6, left: 10, right: 2, bottom: 12),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  "Target BMI",
                  textAlign: TextAlign.start,
                  style: Theme.of(context)
                      .textTheme
                      .bodyText2!
                      .copyWith(color: Color(0XFF1A2A53), fontSize: 14),
                ),
                Spacer(),
                CommonStats(
                  svg: SvgPicture.asset(
                    "assets/images/weight.svg",
                    color: Color(0XFF1A2A53),
                    width: 15,
                    height: 25,
                  ),
                  text: weight + " kg",
                  color: Color(0XFF1A2A53),
                ),
                SizedBox(height: 20),
                Padding(
                  padding: EdgeInsets.only(left: 5),
                  child: CommonStats(
                    svg: SvgPicture.asset(
                      "assets/images/height.svg",
                      color: Color(0XFF1A2A53),
                      width: 15,
                      height: 25,
                    ),
                    text: height + " cm",
                    color: Color(0XFF1A2A53),
                  ),
                ),
                SizedBox(height: 20),
                CommonStats(
                  svg: SvgPicture.asset(
                    "assets/images/body-mass-index-svgrepo-com.svg",
                    color: Color(0XFF1A2A53),
                    width: 15,
                    height: 25,
                  ),
                  text: height,
                  color: Color(0XFF1A2A53),
                ),
              ],
            ),
          ),
        ),
        Spacer(),
        Container(
          width: size.width * 0.4,
          height: size.height * 0.24,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Color(0XFFFFFFFF),
          ),
          child: Padding(
            padding: EdgeInsets.only(top: 5, left: 3, right: 3, bottom: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(
                  "BMI Index",
                  textAlign: TextAlign.start,
                  style: Theme.of(context)
                      .textTheme
                      .bodyText2!
                      .copyWith(color: Colors.black, fontSize: 14),
                ),
                Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Spacer(),
                    Text(
                      "Below 18.5",
                      textAlign: TextAlign.start,
                      style: Theme.of(context)
                          .textTheme
                          .bodyText2!
                          .copyWith(color: Color(0XFF00A1E5), fontSize: 12),
                    ),
                    Spacer(),
                    Text(
                      "Underweight",
                      textAlign: TextAlign.start,
                      style: Theme.of(context).textTheme.bodyText2!.copyWith(
                          color: Color(0XFF00A1E5),
                          fontWeight: FontWeight.bold,
                          fontSize: 12),
                    ),
                  ],
                ),
                Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Spacer(),
                    Text(
                      "18.5 - 24.9",
                      textAlign: TextAlign.start,
                      style: Theme.of(context)
                          .textTheme
                          .bodyText2!
                          .copyWith(color: Color(0XFF19B229), fontSize: 12),
                    ),
                    Spacer(),
                    Text(
                      "Normal Weight",
                      textAlign: TextAlign.start,
                      style: Theme.of(context).textTheme.bodyText2!.copyWith(
                          color: Color(0XFF19B229),
                          fontSize: 12,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "25.0 - 29.0",
                      textAlign: TextAlign.start,
                      style: Theme.of(context)
                          .textTheme
                          .bodyText2!
                          .copyWith(color: Color(0XFFEBC603), fontSize: 12),
                    ),
                    Spacer(),
                    Text(
                      "Overweight",
                      textAlign: TextAlign.start,
                      style: Theme.of(context).textTheme.bodyText2!.copyWith(
                          color: Color(0XFFEBC603),
                          fontSize: 12,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Spacer(),
                    Text(
                      "30.0 - 34.9",
                      textAlign: TextAlign.start,
                      style: Theme.of(context)
                          .textTheme
                          .bodyText2!
                          .copyWith(color: Color(0XFFFF9900), fontSize: 12),
                    ),
                    Spacer(),
                    Text(
                      "Obese",
                      textAlign: TextAlign.start,
                      style: Theme.of(context).textTheme.bodyText2!.copyWith(
                          color: Color(0XFFFF9900),
                          fontWeight: FontWeight.bold,
                          fontSize: 12),
                    ),
                  ],
                ),
                Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Spacer(),
                    Text(
                      "Above 35",
                      textAlign: TextAlign.start,
                      style: Theme.of(context)
                          .textTheme
                          .bodyText2!
                          .copyWith(color: Color(0XFFCA1E1E), fontSize: 12),
                    ),
                    Spacer(),
                    Text(
                      "Extreme Obese",
                      textAlign: TextAlign.start,
                      style: Theme.of(context).textTheme.bodyText2!.copyWith(
                          color: Color(0XFFCA1E1E),
                          fontSize: 12,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
