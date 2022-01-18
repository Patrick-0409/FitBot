import 'package:fiton/models/place.dart';
import 'package:fiton/screen/homepage/components/nearby_card_dtl.dart';
import 'package:fiton/services/geolocator_service.dart';
import 'package:fiton/services/places_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:geolocator/geolocator.dart';
import 'package:url_launcher/url_launcher.dart';

class BodySee extends StatefulWidget {
  const BodySee({Key? key}) : super(key: key);
  @override
  _BodySeeState createState() => _BodySeeState();
}

class _BodySeeState extends State<BodySee> {
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

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      child: ListView(
        children: <Widget>[
          FutureBuilder<PlaceModel>(
              future: _placeModel,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                    itemCount: snapshot.data?.places.length,
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    physics: ScrollPhysics(),
                    itemBuilder: (context, index) {
                      var place = snapshot.data?.places[index];
                      return InkWell(
                        onTap: () {
                          _launchURL(
                              'https://www.google.com/maps/search/?api=1&query=' +
                                  place!.lat!.toString() +
                                  '%2C' +
                                  place.lng!.toString() +
                                  '&query_place_id=' +
                                  place.place_id!);
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(top: 5),
                          child: Container(
                            width: double.infinity,
                            height: size.height * 0.2,
                            margin: EdgeInsets.symmetric(
                                horizontal: 18.0, vertical: 8.0),
                            child: NearbyCardDtl(
                              place: place!,
                            ),
                          ),
                        ),
                      );
                    },
                  );
                }
                return Center(child: CircularProgressIndicator());
              })
        ],
      ),
    );
  }
}

void _launchURL(String value) async {
  await canLaunch(value)
      ? await launch(value)
      : throw 'Could not launch $value';
}
