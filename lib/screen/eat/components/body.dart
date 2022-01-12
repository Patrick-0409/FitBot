import 'package:fiton/constant.dart';
import 'package:fiton/models/recipe.dart';
import 'package:fiton/screen/eat/components/button_dishes.dart';
import 'package:fiton/screen/eat/components/button_time_based.dart';
import 'package:fiton/screen/eat/components/dishes_card.dart';
import 'package:fiton/screen/eat/components/recommended_card.dart';
import 'package:fiton/screen/eat/detail/eat_detail_screen.dart';
import 'package:fiton/screen/eat/ingridients/group_screen.dart';
import 'package:fiton/services/recipe_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  late Future<RecipeModel> _recipeModel;
  List userProfilesList = [];

  @override
  void initState() {
    fetchRecipesList();
    _recipeModel = RecipesService().getRecipes(deli_url);
    super.initState();
  }

  fetchRecipesList() async {
    userProfilesList = await RecipesService().getRecs();
    return userProfilesList;
  }

  @override
  Widget build(BuildContext context) {
    final Size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.only(left: 15),
      child: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                "Dishes",
                textAlign: TextAlign.start,
                style: Theme.of(context)
                    .textTheme
                    .bodyText1!
                    .copyWith(fontSize: 24),
              ),
              SizedBox(height: 1),
              Text(
                "Lunch Time!",
                textAlign: TextAlign.start,
                style: Theme.of(context)
                    .textTheme
                    .bodyText1!
                    .copyWith(fontWeight: FontWeight.w600),
              ),
              SizedBox(height: 10),
              Container(
                width: Size.width * 0.9,
                height: 35,
                decoration: BoxDecoration(
                  color: kSearchBarColor.withOpacity(0.1),
                  // borderRadius: BorderRadius.circular(15),
                ),
                child: TextField(
                  textInputAction: TextInputAction.go,
                  onSubmitted: (value) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          print(value);
                          return GroupScreen(
                              title: value, url: '', sectitle: '');
                        },
                      ),
                    );
                  },
                  style: TextStyle(fontSize: 13),
                  decoration: InputDecoration(
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    hintText: "So, what do you want to eat?",
                    prefixIcon: Icon(Icons.search, color: Colors.black),
                    contentPadding: EdgeInsets.symmetric(vertical: 12),
                  ),
                ),
              ),
              SizedBox(height: 15),
              Container(
                  width: double.infinity,
                  height: 162,
                  child: FutureBuilder(
                      future: fetchRecipesList(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return ListView.builder(
                            itemCount: userProfilesList.length > 5 ? 5 : userProfilesList.length,
                            scrollDirection: Axis.horizontal,
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              return InkWell(
                                onTap: () async {
                                  bool temp = await RecipesService().checkContains(
                                  await RecipesService().checkFood(
                                userProfilesList[index]['label'].toString(),
                                userProfilesList[index]['image'].toString(),
                                userProfilesList[index]['cuisineType']
                                    .toString(),
                                userProfilesList[index]['calories'],
                                userProfilesList[index]['fat'],
                                userProfilesList[index]['sugar'],
                                userProfilesList[index]['protein'],
                                userProfilesList[index]['totalTime'],
                                userProfilesList[index]['ingredientLines']
                                    .cast<String>(),
                                userProfilesList[index]['url'].toString(),
                              ));
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => EatDetailScreen(
                                    contain: temp,
                                    label: userProfilesList[index]['label']
                                        .toString(),
                                    image: userProfilesList[index]['image']
                                        .toString(),
                                    cuisineType: userProfilesList[index]
                                            ['cuisineType']
                                        .toString(),
                                    calories: userProfilesList[index]
                                        ['calories'],
                                    fat: userProfilesList[index]['fat'],
                                    sugar: userProfilesList[index]['sugar'],
                                    protein: userProfilesList[index]['protein'],
                                    totalTime: userProfilesList[index]
                                        ['totalTime'],
                                    ingredientLines: userProfilesList[index]
                                            ['ingredientLines']
                                        .cast<String>(),
                                    url: userProfilesList[index]['url']
                                        .toString(),
                                  ),
                                ),
                              );
                                },
                                child: DishesCard(
                              label:
                                  userProfilesList[index]['label'].toString(),
                              image:
                                  userProfilesList[index]['image'].toString(),
                              cuisineType: userProfilesList[index]
                                      ['cuisineType']
                                  .toString(),
                              calories: userProfilesList[index]['calories'],
                              totalTime: userProfilesList[index]['totalTime'],
                                ),
                              );
                            },
                          );
                        }
                        return Center(child: CircularProgressIndicator());
                      })),
              SizedBox(height: 13),
              Text(
                "Main ingridients",
                textAlign: TextAlign.start,
                style: Theme.of(context)
                    .textTheme
                    .bodyText1!
                    .copyWith(fontWeight: FontWeight.w600),
              ),
              SizedBox(height: 5),
              Row(
                children: <Widget>[
                  ButtonDishes(
                    size: Size,
                    press: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return GroupScreen(
                                title: 'Chicken', url: chic_url, sectitle: '');
                          },
                        ),
                      );
                    },
                    color: kBackgroundColor,
                    text: Text(
                      "Chicken",
                      style: TextStyle(color: Colors.white, fontSize: 15),
                    ),
                    picture: SvgPicture.asset("assets/icons/chicken.svg",
                        height: 40, width: 40, fit: BoxFit.scaleDown),
                  ),
                  SizedBox(width: 10),
                  ButtonDishes(
                    size: Size,
                    press: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return GroupScreen(
                                title: 'Beef', url: beef_url, sectitle: '');
                          },
                        ),
                      );
                    },
                    color: kBackgroundColor,
                    text: Text(
                      "Beef",
                      style: TextStyle(color: Colors.white, fontSize: 15),
                    ),
                    picture: SvgPicture.asset("assets/icons/beef.svg",
                        height: 40, width: 40, fit: BoxFit.scaleDown),
                  ),
                  SizedBox(width: 10),
                  ButtonDishes(
                    size: Size,
                    press: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return GroupScreen(
                                title: 'Salad', url: salad_url, sectitle: '');
                          },
                        ),
                      );
                    },
                    color: kBackgroundColor,
                    text: Text(
                      "Salad",
                      style: TextStyle(color: Colors.white, fontSize: 15),
                    ),
                    picture: SvgPicture.asset("assets/icons/salad.svg",
                        height: 40, width: 40, fit: BoxFit.scaleDown),
                  ),
                  SizedBox(width: 10),
                  ButtonDishes(
                    size: Size,
                    press: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return GroupScreen(
                                title: 'Seafood', url: sea_url, sectitle: '');
                          },
                        ),
                      );
                    },
                    color: kBackgroundColor,
                    text: Text(
                      "Seafood",
                      style: TextStyle(color: Colors.white, fontSize: 15),
                    ),
                    picture: SvgPicture.asset("assets/icons/fish.svg",
                        height: 40, width: 40, fit: BoxFit.scaleDown),
                  ),
                ],
              ),
              SizedBox(height: 10),
              Text(
                "Recommended",
                textAlign: TextAlign.start,
                style: Theme.of(context)
                    .textTheme
                    .bodyText1!
                    .copyWith(fontWeight: FontWeight.w600),
              ),
              SizedBox(height: 5),
              Container(
                  width: double.infinity,
                  height: 210,
                  child: FutureBuilder<RecipeModel>(
                      future: _recipeModel,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return ListView.builder(
                            itemCount: snapshot.data?.recipes.length,
                            scrollDirection: Axis.horizontal,
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              var recent = snapshot.data?.recipes[index];
                              return InkWell(
                                onTap: () async {
                                  bool temp = await RecipesService()
                                      .checkContains(await RecipesService()
                                          .checkFood(
                                              recent!.label,
                                              recent.image,
                                              recent.cuisineType,
                                              recent.calories,
                                              recent.fat,
                                              recent.sugar,
                                              recent.protein,
                                              recent.totalTime,
                                              recent.ingredientLines,
                                              recent.url));
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => EatDetailScreen(
                                        contain: temp,
                                        label: recent.label,
                                        image: recent.image,
                                        cuisineType: recent.cuisineType,
                                        calories: recent.calories,
                                        fat: recent.fat,
                                        sugar: recent.sugar,
                                        protein: recent.protein,
                                        totalTime: recent.totalTime,
                                        ingredientLines: recent.ingredientLines,
                                        url: recent.url,
                                      ),
                                    ),
                                  );
                                },
                                child: RecommendedCard(recipe: recent!),
                              );
                            },
                          );
                        }
                        return Center(child: CircularProgressIndicator());
                      })),
              SizedBox(height: 10),
              Text(
                "Time-Based",
                textAlign: TextAlign.start,
                style: Theme.of(context)
                    .textTheme
                    .bodyText1!
                    .copyWith(fontWeight: FontWeight.w600),
              ),
              SizedBox(height: 5),
              Row(
                children: <Widget>[
                  ButtonTimeBased(
                    size: Size,
                    press: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return GroupScreen(
                                title: 'Breakfast',
                                url: breakfast_url,
                                sectitle: '');
                          },
                        ),
                      );
                    },
                    color: kBackgroundColor,
                    text: Text(
                      "Breakfast",
                      style: TextStyle(color: Colors.white, fontSize: 15),
                    ),
                    picture: SvgPicture.asset("assets/icons/search.svg"),
                  ),
                  SizedBox(width: 20),
                  ButtonTimeBased(
                    size: Size,
                    press: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return GroupScreen(
                                title: 'Lunch', url: lunch_url, sectitle: '');
                          },
                        ),
                      );
                    },
                    color: kBackgroundColor,
                    text: Text(
                      "Lunch",
                      style: TextStyle(color: Colors.white, fontSize: 15),
                    ),
                    picture: SvgPicture.asset("assets/icons/search.svg"),
                  ),
                  SizedBox(width: 20),
                  ButtonTimeBased(
                    size: Size,
                    press: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return GroupScreen(
                                title: 'Dinner', url: dinner_url, sectitle: '');
                          },
                        ),
                      );
                    },
                    color: kBackgroundColor,
                    text: Text(
                      "Dinner",
                      style: TextStyle(color: Colors.white, fontSize: 15),
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
