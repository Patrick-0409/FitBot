class PlaceModel {
  PlaceModel({
    required this.places,
  });

  List<Place?> places;

  factory PlaceModel.fromJson(Map<String, dynamic> json) => PlaceModel(
    places: List<Place>.from(
        json["results"].map((x) => Place.fromJson(x))),
  );

}

class Place{
  List<Photo> photos;
  final String? name;
  final num? lat;
  final num? lng;
  final String? placeId;
  final num? rating;
  final num? userRatingCount;
  final String? vicinity;

  Place({required this.photos, this.name, this.rating, this.lat, this.lng, this.placeId, this.userRatingCount, this.vicinity});

  factory Place.fromJson(Map<String, dynamic> json) => Place(
    photos: json["photos"] != null ? List<Photo>.from(
        json["photos"].map((x) => Photo.fromJson(x))) : [],
    name: json["name"],
    lat: json["geometry"]["location"]["lat"],
    lng: json["geometry"]["location"]["lng"],
    placeId: json["place_id"],
    rating: json["rating"],
    userRatingCount: json["userRatingCount"],
    vicinity: json["vicinity"],
  );

}


class Photo{
  final String? photoReference;
  final String? htmlAttributions;

  Photo({required this.photoReference,required this.htmlAttributions});

  factory Photo.fromJson(Map<String, dynamic> json) => Photo(
    photoReference: json["photo_reference"] as String,
    htmlAttributions: json["html_attributions"][0] as String
  );

}