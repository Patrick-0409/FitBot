
class RecipeModel {
  RecipeModel({
    required this.recipes,
  });

  List<Recipe?> recipes;

  factory RecipeModel.fromJson(Map<String, dynamic> json) => RecipeModel(
    recipes: List<Recipe>.from(
        json["hits"].map((x) => Recipe.fromJson(x))),
  );

}

class Recipe{
  final String? label;
  final String? image;
  final String? cuisineType;
  final num? calories;
  final num? fat;
  final num? sugar;
  final num? protein;
  final num? totalTime;
  final List<String>? ingredientLines;
  final String? url;

  Recipe({this.label, this.image, this.calories, this.fat, this.sugar, this.protein, this.totalTime, this.cuisineType, this.ingredientLines, this.url});

  factory Recipe.fromJson(Map<String, dynamic> json) => Recipe(
    label: json['recipe']["label"],
    image: json['recipe']["image"],
    cuisineType: json['recipe']["cuisineType"][0],
    calories: json['recipe']["calories"],
    fat: json['recipe']["totalNutrients"]['FAT']['quantity'],
    sugar: json['recipe']["totalNutrients"]['SUGAR']['quantity'],
    protein: json['recipe']["totalNutrients"]['PROCNT']['quantity'],
    totalTime: json['recipe']["totalTime"],
    ingredientLines: json['recipe']["ingredientLines"].cast<String>(),
    url: json['recipe']["url"],
  );
}

class Food{
  final String? id;
  final String? label;
  final String? image;
  final String? cuisineType;
  final num? calories;
  final num? fat;
  final num? sugar;
  final num? protein;
  final num? totalTime;
  final List<String>? favorited;
  final List<String>? ingredientLines;
  final String? url;

  Food({
    required this.id, 
    required this.label, 
    required this.image, 
    required this.calories, 
    required this.fat, 
    required this.sugar, 
    required this.protein, 
    required this.totalTime, 
    required this.favorited,
    required this.cuisineType, 
    required this.ingredientLines, 
    required this.url
  });

  factory Food.fromJson(Map<String, dynamic> json, {String? id}) => Food(
    id: json["id"],
    label: json["label"],
    image: json["image"],
    cuisineType: json["cuisineType"][0],
    calories: json["calories"],
    fat: json['fat'],
    sugar: json['sugar'],
    protein: json['protein'],
    totalTime: json["totalTime"],
    favorited: json["favorited"],
    ingredientLines: json["ingredientLines"].cast<String>(),
    url: json["url"],
  );

  
  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "label": label,
      "image": image,
      "cuisineType": cuisineType,
      "calories": calories,
      "fat": fat,
      "sugar": sugar,
      "protein": protein,
      "totalTime": totalTime,
      "favorited": favorited,
      "ingredientLines": ingredientLines,
      "url": url,
    };
  }
}