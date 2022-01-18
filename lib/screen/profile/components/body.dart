import 'package:fiton/constant.dart';
import 'package:fiton/models/user.dart';
import 'package:fiton/screen/profile/components/button_stats.dart';
import 'package:fiton/screen/profile/components/weekly_bar_chart.dart';
import 'package:fiton/services/daily_service.dart';
import 'package:fiton/services/runs_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'description.dart';

class Body extends StatefulWidget {
  Body({Key? key, required this.user}) : super(key: key);

  UserStore user;
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  int choose = 0;

  void initState() {
    super.initState();
    choose = 1;
  }

  int getAge(DateTime birthday) {
    return int.parse(DateFormat.y('en_US').format(DateTime.now())) -
        int.parse(DateFormat.y('en_US').format(birthday));
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    String capitalize(String s) => s[0].toUpperCase() + s.substring(1);
    return SafeArea(
      child: SingleChildScrollView(
        child: Container(
          alignment: Alignment.center,
          child: Padding(
            padding: EdgeInsets.only(left: 15, right: 15, bottom: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Container(
                      width: size.width * 0.9,
                      height: size.height * 0.10,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: kBackgroundColor,
                      ),
                      child: Padding(
                        padding: EdgeInsets.only(left: 0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                CircleAvatar(
                                  maxRadius: 32,
                                  backgroundImage: NetworkImage(widget
                                              .user.imageUrl ==
                                          null
                                      ? "https://i.giphy.com/media/jAYUbVXgESSti/giphy.webp"
                                      : widget.user.imageUrl!),
                                ),
                                SizedBox(width: 15),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      widget.user.name!,
                                      textAlign: TextAlign.start,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText2!
                                          .copyWith(
                                              color: Colors.white,
                                              fontSize: 24),
                                    ),
                                    Row(
                                      children: [
                                        Container(
                                          width: size.width * 0.18,
                                          height: size.height * 0.04,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            color: kGender,
                                          ),
                                          child: Column(
                                            children: [
                                              Text(
                                                capitalize(widget.user.gender!),
                                                textAlign: TextAlign.center,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyText2!
                                                    .copyWith(
                                                      color: Colors.black,
                                                      fontSize: 18,
                                                    ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        SizedBox(width: 10),
                                        Container(
                                          width: size.width * 0.18,
                                          height: size.height * 0.04,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            color: Color(0XFF39BBC3),
                                          ),
                                          child: Column(
                                            children: [
                                              Text(
                                                getAge(widget.user.birthday!)
                                                        .toString() +
                                                    " y.o",
                                                textAlign: TextAlign.center,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyText2!
                                                    .copyWith(
                                                        color: Colors.black,
                                                        fontSize: 18),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Description(
                    size: size,
                    weight: widget.user.weight!,
                    height: widget.user.height!,
                    age: (int.parse(
                                DateFormat.y('en_US').format(DateTime.now())) -
                            int.parse(DateFormat.y('en_US')
                                .format(widget.user.birthday!)))
                        .toString()),
                SizedBox(height: 10),
                Container(
                  width: size.width,
                  height: size.height * 0.557,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: kProfile,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 10, top: 2),
                          child: Text(
                            "Stats This Week",
                            style: Theme.of(context)
                                .textTheme
                                .bodyText2!
                                .copyWith(color: Colors.white, fontSize: 17),
                          ),
                        ),
                      ),
                      SizedBox(height: 4),
                      Container(
                        width: size.width,
                        height: size.height * 0.51,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: kPip,
                        ),
                        child: Column(
                          children: <Widget>[
                            Padding(
                              padding:
                                  EdgeInsets.only(left: 25, right: 25, top: 10),
                              child: Row(
                                children: [
                                  FutureBuilder<double>(
                                    future: DailyService().getSleepAvg(),
                                    builder: (BuildContext context,
                                        AsyncSnapshot<double> snapshot) {
                                      if (snapshot.hasData) {
                                        return ButtonStats(
                                          size: size,
                                          picture: SvgPicture.asset(
                                            "assets/images/sleep.svg",
                                            color: kStastC,
                                          ),
                                          text: Text(
                                            snapshot.data!.toStringAsFixed(1) +
                                                " hrs",
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyText2!
                                                .copyWith(
                                                  color: Colors.black,
                                                  fontSize: 20,
                                                ),
                                          ),
                                          press: () {
                                            setState(() {
                                              choose = 0;
                                            });
                                            choose = 1;
                                          },
                                        );
                                      }
                                      return CircularProgressIndicator();
                                    },
                                  ),
                                  Spacer(),
                                  FutureBuilder<double>(
                                    future: DailyService().getWeightAvg(),
                                    builder: (BuildContext context,
                                        AsyncSnapshot<double> snapshot) {
                                      if (snapshot.hasData) {
                                        return ButtonStats(
                                          size: size,
                                          picture: SvgPicture.asset(
                                            "assets/images/weight.svg",
                                            color: kStastC,
                                          ),
                                          text: Text(
                                            snapshot.data!.toStringAsFixed(1) +
                                                " kg",
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyText2!
                                                .copyWith(
                                                    color: Colors.black,
                                                    fontSize: 20),
                                          ),
                                          press: () {
                                            setState(() {
                                              choose = 0;
                                            });
                                            choose = 2;
                                          },
                                        );
                                      }
                                      return CircularProgressIndicator();
                                    },
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 10),
                            Padding(
                              padding: EdgeInsets.only(left: 25, right: 25),
                              child: Row(
                                children: [
                                  FutureBuilder<double>(
                                    future: RunsService().getRunAvg(),
                                    builder: (BuildContext context,
                                        AsyncSnapshot<double> snapshot) {
                                      if (snapshot.hasData) {
                                        return ButtonStats(
                                          size: size,
                                          picture: SvgPicture.asset(
                                            "assets/images/step.svg",
                                            color: kStastC,
                                          ),
                                          text: Text(
                                            snapshot.data!.toStringAsFixed(1) +
                                                " km",
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyText2!
                                                .copyWith(
                                                    color: Colors.black,
                                                    fontSize: 20),
                                          ),
                                          press: () {
                                            setState(() {
                                              choose = 0;
                                            });
                                            choose = 3;
                                          },
                                        );
                                      }
                                      return CircularProgressIndicator();
                                    },
                                  ),
                                  Spacer(),
                                  FutureBuilder<double>(
                                    future: RunsService().getCalorieAvg(),
                                    builder: (BuildContext context,
                                        AsyncSnapshot<double> snapshot) {
                                      if (snapshot.hasData) {
                                        return ButtonStats(
                                          size: size,
                                          picture: SvgPicture.asset(
                                            "assets/images/calories.svg",
                                            color: kStastC,
                                          ),
                                          text: Text(
                                            snapshot.data!.toStringAsFixed(1) +
                                                " cal",
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyText2!
                                                .copyWith(
                                                    color: Colors.black,
                                                    fontSize: 20),
                                          ),
                                          press: () {
                                            setState(() {
                                              choose = 0;
                                            });
                                            choose = 4;
                                          },
                                        );
                                      }
                                      return CircularProgressIndicator();
                                    },
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 10),
                            Container(
                              width: size.width * 0.78,
                              height: size.height * 0.3,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: WeeklyBarChart(choose: choose),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
