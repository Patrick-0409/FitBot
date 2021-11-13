import 'dart:convert';

import 'package:fiton/models/place.dart';
import 'package:fiton/constant.dart';
import 'package:http/http.dart' as http;

class PlacesService {

  Future<PlaceModel> getPlaces(double lat, double lng) async {
    var tempUri = 'https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=$lat,$lng&type=gym&rankby=distance&key=$apiKey';
    var client = http.Client();
    var placeModel;
    try {
      var response = await client.get(Uri.parse(tempUri));
      var jsonString = response.body;
      var jsonMap = json.decode(jsonString);
      placeModel = PlaceModel.fromJson(jsonMap);
      // print(placeModel);
    } catch (e) {
      print("places api");
      print(e);
      return placeModel;
    }
    return placeModel;
  }
}