import 'package:firebase_auth/firebase_auth.dart';
import 'package:fiton/constant.dart';
import 'package:fiton/models/place.dart';
import 'package:fiton/models/user.dart';
import 'package:fiton/screen/article/article_screen.dart';
import 'package:fiton/screen/eat/detail/eat_detail_screen.dart';
import 'package:fiton/screen/eat/eat_screen.dart';
import 'package:fiton/screen/homepage/components/nearby_card.dart';
import 'package:fiton/screen/homepage/components/scheduler_home.dart';
import 'package:fiton/screen/homepage/components/see_all_screen.dart';
import 'package:fiton/screen/homepage/daily_input/daily_input.dart';
import 'package:fiton/screen/homepage/eating%20diary/eating_kuisoner.dart';
import 'package:fiton/screen/homepage/eating%20diary/input_eat_menu.dart';
import 'package:fiton/screen/workout/Train/train_screen.dart';
import 'package:fiton/screen/running/running_screen.dart';
import 'package:fiton/screen/workout/kuisoner/kuisoner_screen.dart';
import 'package:fiton/services/daily_service.dart';
import 'package:fiton/services/geolocator_service.dart';
import 'package:fiton/services/places_services.dart';
import 'package:fiton/services/user_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geolocator/geolocator.dart';
import 'package:url_launcher/url_launcher.dart';
import 'button_explore.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  Future<PlaceModel>? _placeModel;
  final user = FirebaseAuth.instance.currentUser!;
  Position? position;
  UserStore? userstore;

  Future<Position?> getPosition() async {
    position = await GeoLocatorService().getLocation();
    return position;
  }

  @override
  void initState() {
    getPosition().then((value) => {
          setState(() {
            _placeModel =
                PlacesService().getPlaces(value!.latitude, value.longitude);
          }),
        });
    _fetchUser();
    super.initState();
  }

  _fetchUser() async {
    userstore = await UserService().getUser(user.uid);
  }

  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  Future<bool> get checkDatabase async {
    return DailyService().checkDaily();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return SafeArea(
      child: SingleChildScrollView(
        child: Container(
          alignment: Alignment.center,
          margin: EdgeInsets.only(bottom: 10, left: 13, right: 13),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 5),
                child: Text(
                  "Good morning,\nMichael",
                  style: Theme.of(context)
                      .textTheme
                      .bodyText2!
                      .copyWith(color: Colors.white, fontSize: 18),
                ),
              ),
              SizedBox(height: 5),
              Container(
                width: size.width,
                height: size.height * 0.14,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(14),
                ),
                padding: EdgeInsets.only(left: 10, right: 5, top: 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "1,928",
                          style: Theme.of(context)
                              .textTheme
                              .bodyText2!
                              .copyWith(color: Color(0XFF1A9F1F), fontSize: 22),
                        ),
                        Text(
                          "Remaining\nCalorie",
                          textAlign: TextAlign.center,
                          style: Theme.of(context)
                              .textTheme
                              .bodyText2!
                              .copyWith(color: Colors.black87, fontSize: 14),
                        ),
                      ],
                    ),
                    Spacer(),
                    SizedBox(
                      height: size.height * 0.11,
                      width: size.width * 0.005,
                      child: DecoratedBox(
                        decoration: const BoxDecoration(color: Colors.black54),
                      ),
                    ),
                    Spacer(),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 15),
                      child: GestureDetector(
                        onTap: () {},
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 40),
                              child: Image.asset(
                                "assets/icons/warning.png",
                                color: Colors.red,
                              ),
                            ),
                            Image.asset(
                              "assets/icons/checklist.png",
                              color: Colors.black,
                            ),
                            Text(
                              "Daily Stats",
                              textAlign: TextAlign.center,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText2!
                                  .copyWith(color: Colors.black, fontSize: 14),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Spacer(),
                    SizedBox(
                      height: size.height * 0.09,
                      width: size.width * 0.005,
                      child: DecoratedBox(
                        decoration: const BoxDecoration(color: Colors.black54),
                      ),
                    ),
                    Spacer(),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 15),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return InputEatMenu();
                              },
                            ),
                          );
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 40),
                              child: Image.asset(
                                "assets/icons/warning.png",
                                color: Colors.red,
                              ),
                            ),
                            Image.asset(
                              "assets/icons/schedule.png",
                              color: Colors.black,
                            ),
                            Text(
                              "Eating Diary",
                              textAlign: TextAlign.center,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText2!
                                  .copyWith(color: Colors.black, fontSize: 14),
                            ),
                            // Spacer(),
                          ],
                        ),
                      ),
                    ),
                    Spacer(),
                    SizedBox(
                      height: size.height * 0.09,
                      width: size.width * 0.005,
                      child: DecoratedBox(
                        decoration: const BoxDecoration(color: Colors.black54),
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
                                                color: Color(0XFF00A1E5),
                                                fontSize: 14),
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      // Spacer(),
                                      Text(
                                        "18.5 - 24.9",
                                        textAlign: TextAlign.start,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText2!
                                            .copyWith(
                                                color: Color(0XFF19B229),
                                                fontSize: 14),
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        "25.0 - 29.0",
                                        textAlign: TextAlign.start,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText2!
                                            .copyWith(
                                                color: Color(0XFFEBC603),
                                                fontSize: 14),
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      // Spacer(),
                                      Text(
                                        "30.0 - 34.9",
                                        textAlign: TextAlign.start,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText2!
                                            .copyWith(
                                                color: Color(0XFFFF9900),
                                                fontSize: 14),
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      // Spacer(),
                                      Text(
                                        "Above 35",
                                        textAlign: TextAlign.start,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText2!
                                            .copyWith(
                                                color: Color(0XFFCA1E1E),
                                                fontSize: 14),
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
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.asset(
                            "assets/icons/information.png",
                            color: Colors.black,
                          ),
                          Text(
                            "Information",
                            textAlign: TextAlign.center,
                            style: Theme.of(context)
                                .textTheme
                                .bodyText2!
                                .copyWith(color: Colors.black, fontSize: 14),
                          ),
                        ],
                      ),
                    ),
                    Spacer(),
                  ],
                ),
              ),
              SizedBox(height: 10),
              SchedulerHome(
                size: size,
              ),
              SizedBox(height: 5),
              // FutureBuilder(
              //   future: checkDatabase,
              //   builder: (context, snapshot) {
              //     if (snapshot.hasData) {
              //       if (snapshot.data == false) {
              //         return Container(
              //           margin:
              //               EdgeInsets.symmetric(vertical: 5, horizontal: 13),
              //           width: size.width,
              //           height: size.height * 0.067,
              //           child: ClipRRect(
              //             borderRadius: BorderRadius.circular(14),
              //             child: ElevatedButton(
              //               child: Row(
              //                 children: [
              //                   Text(
              //                     "Daily Stats",
              //                     style: Theme.of(context)
              //                         .textTheme
              //                         .bodyText2!
              //                         .copyWith(color: Colors.white),
              //                   ),
              //                   Spacer(),
              //                   Icon(
              //                     Icons.add,
              //                     color: Colors.white,
              //                   ),
              //                 ],
              //               ),
              //               onPressed: () {
              //                 Navigator.push(
              //                   context,
              //                   MaterialPageRoute(
              //                     builder: (context) {
              //                       return DailyInput();
              //                     },
              //                   ),
              //                 );
              //               },
              //               style: ElevatedButton.styleFrom(
              //                   primary: Colors.red.shade400,
              //                   padding: EdgeInsets.symmetric(
              //                       horizontal: 15, vertical: 5),
              //                   textStyle: TextStyle(
              //                       color: Colors.white,
              //                       fontSize: 20,
              //                       fontWeight: FontWeight.w700)),
              //             ),
              //           ),
              //         );
              //       }
              //     }
              //     return SizedBox(height: 10);
              //   },
              // ),
              Row(
                children: <Widget>[
                  Text(
                    "Nearby",
                    textAlign: TextAlign.start,
                    style: Theme.of(context)
                        .textTheme
                        .bodyText2!
                        .copyWith(color: Colors.white),
                  ),
                  Spacer(),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return SeeAllScreen();
                          },
                        ),
                      );
                    },
                    child: Text(
                      "See All",
                      textAlign: TextAlign.start,
                      style: Theme.of(context)
                          .textTheme
                          .bodyText2!
                          .copyWith(fontSize: 15),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 5),
              Container(
                width: size.width * 0.97,
                height: size.height * 0.14,
                child: FutureBuilder<PlaceModel>(
                  future: _placeModel,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return ListView.builder(
                        itemCount: (snapshot.data?.places.length != null)
                            ? ((snapshot.data!.places.length > 5)
                                ? 5
                                : snapshot.data?.places.length)
                            : 0,
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          var place = snapshot.data?.places[index];
                          return InkWell(
                            onTap: () => _launchURL(
                                'https://www.google.com/maps/search/?api=1&query=' +
                                    place!.lat!.toString() +
                                    '%2C' +
                                    place.lng!.toString() +
                                    '&query_place_id=' +
                                    place.place_id!),
                            child: Container(
                              width: 200,
                              margin: EdgeInsets.only(right: 13),
                              child: NearbyCard(
                                place: place!,
                              ),
                            ),
                          );
                        },
                      );
                    }
                    return Center(child: CircularProgressIndicator());
                  },
                ),
              ),
              SizedBox(height: 5),
              Text(
                "Explore",
                textAlign: TextAlign.start,
                style: Theme.of(context)
                    .textTheme
                    .bodyText2!
                    .copyWith(color: Colors.white),
              ),
              SizedBox(height: 5),
              Row(
                children: <Widget>[
                  ButtonExplore(
                    size: size,
                    press: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return ArticleScreen();
                          },
                        ),
                      );
                    },
                    color: kArticle,
                    text: Text(
                      "Article",
                      style: kArticleTitle,
                    ),
                  ),
                  Spacer(),
                  ButtonExplore(
                    size: size,
                    press: () async {
                      bool temp = await UserService().checkContains(user.uid);
                      if (temp == true) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return KuisonerScreen();
                            },
                          ),
                        ).then((value) {
                          if (value == true)
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) {
                                  return TrainScreen(
                                    user: userstore!,
                                  );
                                },
                              ),
                            );
                        });
                      } else {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return TrainScreen(
                                user: userstore!,
                              );
                            },
                          ),
                        );
                      }
                    },
                    color: kTrain,
                    text: Text(
                      "Train",
                      style: kTrainTitle,
                    ),
                  ),
                  Spacer(),
                  ButtonExplore(
                    size: size,
                    press: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return RunningScreen();
                          },
                        ),
                      );
                    },
                    color: kChat,
                    text: Text(
                      "Run",
                      style: kChatTitle,
                    ),
                  ),
                  Spacer(),
                  ButtonExplore(
                    size: size,
                    press: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return EatScreen();
                          },
                        ),
                      );
                    },
                    color: kTrain,
                    text: Text(
                      "Eat",
                      style: kTrainTitle,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

void _launchURL(String value) async {
  await canLaunch(value)
      ? await launch(value)
      : throw 'Could not launch $value';
}
