import 'package:firebase_auth/firebase_auth.dart';
import 'package:fiton/constant.dart';
import 'package:fiton/screen/profile/components/weekly_bar_chart.dart';
import 'package:fiton/services/user_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'description.dart';

class Body extends StatelessWidget {
  const Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final user = FirebaseAuth.instance.currentUser!;
    return SafeArea(
      child: SingleChildScrollView(
        child: Container(
          alignment: Alignment.center,
          child: Padding(
            padding: EdgeInsets.only(left: 20, right: 20, bottom: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Container(
                      width: size.width * 0.53,
                      height: size.height * 0.10,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: kBackgroundColor,
                      ),
                      child: Padding(
                        padding: EdgeInsets.only(left: 10, top: 3, right: 1),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                FutureBuilder<String>(
                                    future: user_service().getImgUser(user.uid),
                                    builder: (BuildContext context,
                                        AsyncSnapshot<String> snapshot) {
                                      if (snapshot.hasData) {
                                        return CircleAvatar(
                                          maxRadius: 32,
                                          backgroundImage: NetworkImage(
                                              user.photoURL == null
                                                  ? snapshot.data!
                                                  : user.photoURL!),
                                        );
                                      }
                                      return CircularProgressIndicator();
                                    }),
                                Spacer(),
                                Padding(
                                  padding: EdgeInsets.only(top: 16),
                                  child: Container(
                                    width: size.width * 0.33,
                                    height: size.height * 0.07,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15),
                                      color: kGender,
                                    ),
                                    child: Column(
                                      children: [
                                        SizedBox(height: 3),
                                        FutureBuilder<String>(
                                            future: user_service()
                                                .getData(user.uid, 'firstName'),
                                            builder: (BuildContext context,
                                                AsyncSnapshot<String>
                                                    snapshot) {
                                              if (snapshot.hasData) {
                                                return Text(
                                                  snapshot.data!,
                                                  textAlign: TextAlign.start,
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodyText2!
                                                      .copyWith(
                                                          color: Colors.black,
                                                          fontSize: 15),
                                                );
                                              }
                                              return CircularProgressIndicator();
                                            }),
                                        Text(
                                          "INA",
                                          textAlign: TextAlign.start,
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyText2!
                                              .copyWith(
                                                  color: Colors.black,
                                                  fontSize: 15),
                                        ),
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    Spacer(),
                    Padding(
                      padding: EdgeInsets.only(top: 30),
                      child: Container(
                        width: size.width * 0.35,
                        height: size.height * 0.05,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: kGender,
                        ),
                        child: FutureBuilder<String>(
                            future: user_service().getData(user.uid, 'gender'),
                            builder: (BuildContext context,
                                AsyncSnapshot<String> snapshot) {
                              if (snapshot.hasData) {
                                return Text(
                                  snapshot.data!,
                                  textAlign: TextAlign.center,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText2!
                                      .copyWith(
                                          color: Colors.black, fontSize: 20),
                                );
                              }
                              return CircularProgressIndicator();
                            }),
                        // Text(
                        //   "Male",
                        //   textAlign: TextAlign.center,
                        //   style: Theme.of(context)
                        //       .textTheme
                        //       .bodyText2!
                        //       .copyWith(color: Colors.black, fontSize: 20),
                        // ),
                      ),
                    )
                  ],
                ),
                SizedBox(height: 10),
                Description(size: size),
                SizedBox(height: 10),
                Container(
                  width: size.width,
                  height: size.height * 0.49,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: kProfile,
                  ),
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        height: 20,
                        child: Text(
                          "Stats This Week",
                          textAlign: TextAlign.center,
                          style: Theme.of(context)
                              .textTheme
                              .bodyText2!
                              .copyWith(color: Colors.white, fontSize: 15),
                        ),
                      ),
                      Container(
                        width: size.width,
                        height: size.height * 0.46,
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
                                  ButtonStats(
                                    size: size,
                                    picture: SvgPicture.asset(
                                      "assets/images/sleep.svg",
                                      color: kStastC,
                                    ),
                                    text: Text(
                                      "40 hrs",
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText2!
                                          .copyWith(
                                              color: Colors.black,
                                              fontSize: 20),
                                    ),
                                  ),
                                  Spacer(),
                                  ButtonStats(
                                    size: size,
                                    picture: SvgPicture.asset(
                                      "assets/images/calories.svg",
                                      color: kStastC,
                                    ),
                                    text: Text(
                                      "40 hrs",
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText2!
                                          .copyWith(
                                              color: Colors.black,
                                              fontSize: 20),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 10),
                            Padding(
                              padding: EdgeInsets.only(left: 25, right: 25),
                              child: Row(
                                children: [
                                  ButtonStats(
                                    size: size,
                                    picture: SvgPicture.asset(
                                      "assets/images/step.svg",
                                      color: kStastC,
                                    ),
                                    text: Text(
                                      "40 hrs",
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText2!
                                          .copyWith(
                                              color: Colors.black,
                                              fontSize: 20),
                                    ),
                                  ),
                                  Spacer(),
                                  ButtonStats(
                                    size: size,
                                    picture: SvgPicture.asset(
                                      "assets/images/weight.svg",
                                      color: kStastC,
                                    ),
                                    text: Text(
                                      "40 hrs",
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText2!
                                          .copyWith(
                                              color: Colors.black,
                                              fontSize: 20),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 10),
                            Container(
                              width: size.width * 0.78,
                              height: size.height * 0.26,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: kBackgroundColor,
                              ),
                              // color: Colors.white,
                              child: WeeklyBarChart(),
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

class ButtonStats extends StatelessWidget {
  const ButtonStats({
    Key? key,
    required this.size,
    required this.picture,
    required this.text,
  }) : super(key: key);

  final Size size;
  final SvgPicture picture;
  final Text text;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      // height: size.height * 0.5,
      width: size.width * 0.35,
      child: Column(
        children: [
          AspectRatio(
            aspectRatio: 3,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white54,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: EdgeInsets.only(left: 10, right: 10),
                child: Row(
                  children: [
                    picture,
                    Spacer(),
                    text,
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
