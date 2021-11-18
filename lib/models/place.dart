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
  final String? place_id;
  final num? rating;
  final num? userRatingCount;
  final String? vicinity;

  Place({required this.photos, this.name, this.rating, this.lat, this.lng, this.place_id, this.userRatingCount, this.vicinity});

  factory Place.fromJson(Map<String, dynamic> json) => Place(
    photos: json["photos"] != null ? List<Photo>.from(
        json["photos"].map((x) => Photo.fromJson(x))) : [],
    name: json["name"],
    lat: json["geometry"]["location"]["lat"],
    lng: json["geometry"]["location"]["lng"],
    place_id: json["place_id"],
    rating: json["rating"],
    userRatingCount: json["userRatingCount"],
    vicinity: json["vicinity"],
  );

}


class Photo{
  final String? photo_reference;
  final String? html_attributions;

  Photo({required this.photo_reference,required this.html_attributions});

  factory Photo.fromJson(Map<String, dynamic> json) => Photo(
    photo_reference: json["photo_reference"] as String,
    html_attributions: json["html_attributions"][0] as String
  );

}