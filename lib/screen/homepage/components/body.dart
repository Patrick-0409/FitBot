import 'package:firebase_auth/firebase_auth.dart';
import 'package:fiton/constant.dart';
import 'package:fiton/models/place.dart';
import 'package:fiton/screen/article/article_screen.dart';
import 'package:fiton/screen/eat/eat_screen.dart';
import 'package:fiton/screen/homepage/components/nearby_card.dart';
import 'package:fiton/screen/homepage/components/scheduler_home.dart';
import 'package:fiton/screen/homepage/components/see_all_screen.dart';
import 'package:fiton/screen/homepage/daily_input/daily_input.dart';
import 'package:fiton/screen/workout/Train/train_screen.dart';
import 'package:fiton/screen/running/running_screen.dart';
import 'package:fiton/screen/workout/kuisoner/kuisoner_screen.dart';
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
  Position? position;

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
    super.initState();
  }

  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final user = FirebaseAuth.instance.currentUser!;
    return SafeArea(
      child: SingleChildScrollView(
        child: Container(
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.only(left: 13, right: 13),
                child: SchedulerHome(size: size),
              ),
              SizedBox(height: 5),
              Container(
                margin: EdgeInsets.symmetric(vertical: 5, horizontal: 13),
                width: size.width,
                height: size.height * 0.067,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: ElevatedButton(
                    child: Row(
                      children: [
                        Text(
                          "Daily Stats",
                          style: Theme.of(context)
                              .textTheme
                              .bodyText2!
                              .copyWith(color: Colors.white),
                        ),
                        Spacer(),
                        Icon(
                          Icons.add,
                          color: Colors.white,
                        ),
                      ],
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return DailyInput();
                          },
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                        primary: Color(0XFF39BBC3),
                        padding:
                            EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                        textStyle: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.w700)),
                  ),
                ),
              ),
              // SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.only(left: 15, right: 14),
                child: Row(
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
                              margin: EdgeInsets.only(right: 4, left: 13),
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
              Padding(
                padding: const EdgeInsets.only(left: 13),
                child: Text(
                  "Explore",
                  textAlign: TextAlign.start,
                  style: Theme.of(context)
                      .textTheme
                      .bodyText2!
                      .copyWith(color: Colors.white),
                ),
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
                    picture: SvgPicture.asset("assets/icons/search.svg"),
                  ),
                  ButtonExplore(
                    size: size,
                    press: () async {
                      bool temp = await user_service().checkContains(user.uid);
                      if (temp == true) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return KuisonerScreen();
                            },
                          ),
                        );
                      } else {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return TrainScreen(
                                  title: 'Training Menu',
                                  url: dinner_url,
                                  sectitle: '');
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
                    picture: SvgPicture.asset("assets/icons/search.svg"),
                  ),
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
                    picture: SvgPicture.asset("assets/icons/search.svg"),
                  ),
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
                    picture: SvgPicture.asset("assets/icons/search.svg"),
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
