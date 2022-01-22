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

  int _recomWeight(String height, int bmi) {
    return (((int.parse(height) / 100) * (int.parse(height) / 100)) * bmi)
        .toInt();
  }

  double _getBMI(String weight, String height) {
    return ((int.parse(weight)).toDouble()) /
        ((((int.parse(height)).toDouble()) / 100) *
            (((int.parse(height)).toDouble()) / 100));
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Container(
          width: size.width * 0.45,
          height: size.height * 0.17,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: kWeight,
          ),
          child: Padding(
            padding: EdgeInsets.only(top: 6, left: 10, right: 10, bottom: 12),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(
                  "Current BMI",
                  textAlign: TextAlign.start,
                  style: Theme.of(context)
                      .textTheme
                      .bodyText2!
                      .copyWith(color: Color(0XFF96162D), fontSize: 14),
                ),
                Text(
                  _getBMI(weight, height).toStringAsFixed(1),
                  style: Theme.of(context).textTheme.bodyText2!.copyWith(
                      color: Color(0XFF96162D),
                      fontSize: 30,
                      fontWeight: FontWeight.bold),
                ),
                Spacer(),
                Row(
                  children: [
                    CommonStats(
                      svg: SvgPicture.asset("assets/images/weight.svg"),
                      text: weight + " kg",
                      color: Color(0XFF96162D),
                    ),
                    Spacer(),
                    CommonStats(
                      svg: SvgPicture.asset("assets/images/height.svg"),
                      text: height + " cm",
                      color: Color(0XFF96162D),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        Spacer(),
        GestureDetector(
          onTap: () async {
            await showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: Text('BMI Indicator'),
                content: Container(
                  width: size.width,
                  height: size.height * 0.19,
                  child: Column(
                    children: <Widget>[
                      Row(
                        children: [
                          Text(
                            "Below 18.5",
                            textAlign: TextAlign.start,
                            style: Theme.of(context)
                                .textTheme
                                .bodyText2!
                                .copyWith(
                                    color: Color(0XFF00A1E5), fontSize: 14),
                          ),
                          Spacer(),
                          Text(
                            "Underweight",
                            textAlign: TextAlign.start,
                            style: Theme.of(context)
                                .textTheme
                                .bodyText2!
                                .copyWith(
                                    color: Color(0XFF00A1E5),
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14),
                          ),
                        ],
                      ),
                      SizedBox(height: 5),
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
                                .copyWith(
                                    color: Color(0XFF19B229), fontSize: 14),
                          ),
                          Spacer(),
                          Text(
                            "Normal Weight",
                            textAlign: TextAlign.start,
                            style: Theme.of(context)
                                .textTheme
                                .bodyText2!
                                .copyWith(
                                    color: Color(0XFF19B229),
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      SizedBox(height: 5),
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
                                .copyWith(
                                    color: Color(0XFFEBC603), fontSize: 14),
                          ),
                          Spacer(),
                          Text(
                            "Overweight",
                            textAlign: TextAlign.start,
                            style: Theme.of(context)
                                .textTheme
                                .bodyText2!
                                .copyWith(
                                    color: Color(0XFFEBC603),
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      SizedBox(height: 5),
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
                                .copyWith(
                                    color: Color(0XFFFF9900), fontSize: 14),
                          ),
                          Spacer(),
                          Text(
                            "Obese",
                            textAlign: TextAlign.start,
                            style: Theme.of(context)
                                .textTheme
                                .bodyText2!
                                .copyWith(
                                    color: Color(0XFFFF9900),
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14),
                          ),
                        ],
                      ),
                      SizedBox(height: 5),
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
                                .copyWith(
                                    color: Color(0XFFCA1E1E), fontSize: 14),
                          ),
                          Spacer(),
                          Text(
                            "Extreme Obese",
                            textAlign: TextAlign.start,
                            style: Theme.of(context)
                                .textTheme
                                .bodyText2!
                                .copyWith(
                                    color: Color(0XFFCA1E1E),
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                actions: [
                  TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text('Ok'))
                ],
              ),
            );
          },
          child: Container(
            width: size.width * 0.45,
            height: size.height * 0.17,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Color(0XFFC3F2FD),
            ),
            child: Padding(
              padding: EdgeInsets.only(top: 6, left: 10, right: 10, bottom: 12),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "Recomendation BMI",
                    textAlign: TextAlign.start,
                    style: Theme.of(context)
                        .textTheme
                        .bodyText2!
                        .copyWith(color: Color(0XFF1A2A53), fontSize: 14),
                  ),
                  Text(
                    "22",
                    style: Theme.of(context).textTheme.bodyText2!.copyWith(
                        color: Color(0XFF1A2A53),
                        fontSize: 30,
                        fontWeight: FontWeight.bold),
                  ),
                  Spacer(),
                  Row(
                    children: [
                      CommonStats(
                        svg: SvgPicture.asset(
                          "assets/images/weight.svg",
                          color: Color(0XFF1A2A53),
                          width: 15,
                          height: 25,
                        ),
                        text: _recomWeight(height, 22).toString() + " kg",
                        color: Color(0XFF1A2A53),
                      ),
                      Spacer(),
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
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
