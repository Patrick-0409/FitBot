
import 'package:fiton/screen/eat/components/dishes_card_fav.dart';
import 'package:fiton/screen/eat/detail/components/circle_button.dart';
import 'package:fiton/screen/eat/detail/eat_detail_screen.dart';
import 'package:fiton/screen/homepage/home_screen.dart';
import 'package:fiton/services/recipe_service.dart';
import 'package:flutter/material.dart';
import '../../../constant.dart';

class FavoriteEatScreen extends StatefulWidget {
  const FavoriteEatScreen({Key? key}) : super(key: key);
  @override
  _FavoriteEatScreenState createState() => _FavoriteEatScreenState();
}

class _FavoriteEatScreenState extends State<FavoriteEatScreen> {
  List userProfilesList = [];

  @override
  void initState(){
    fetchRecipesList();
    super.initState();
  }

  fetchRecipesList() async {
      userProfilesList = await RecipesService().getFavs();
      return userProfilesList;
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(60.0),
          child: Center(
            child: SafeArea(
              child: Padding(
                padding: EdgeInsets.fromLTRB(18.0, 5.0, 18.0, 0),
                child: Row(
                  children: [
                    CircleButton(
                      icon: Icons.arrow_back_ios,
                      onTap: () => Navigator.pop(context),
                      color: kGrey2,
                    ),
                    Spacer(),
                    Text(
                      "FitBot",
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.headline5,
                    ),
                    Spacer(),
                    IconButton(
                      icon: Icon(
                        Icons.home,
                        size: 35,
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return HomeScreen();
                            },
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.only(bottom: 85),
                width: double.infinity,
                height: size.height,
                child: FutureBuilder(
                  future: fetchRecipesList(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                        return ListView.builder(
                        itemCount: userProfilesList.length,
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () async {
                              bool temp = await RecipesService().checkContains(await RecipesService().checkNews(
                                    userProfilesList[index]['label'].toString(),
                                    userProfilesList[index]['image'].toString(),
                                    userProfilesList[index]['cuisineType'].toString(),
                                    userProfilesList[index]['calories'],
                                    userProfilesList[index]['fat'],
                                    userProfilesList[index]['sugar'],
                                    userProfilesList[index]['protein'],
                                    userProfilesList[index]['totalTime'],
                                    userProfilesList[index]['ingredientLines'].cast<String>(),
                                    userProfilesList[index]['url'].toString(),
                              ));
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => EatDetailScreen(
                                    contain: temp,
                                    label: userProfilesList[index]['label'].toString(),
                                    image: userProfilesList[index]['image'].toString(),
                                    cuisineType: userProfilesList[index]['cuisineType'].toString(),
                                    calories: userProfilesList[index]['calories'],
                                    fat: userProfilesList[index]['fat'],
                                    sugar: userProfilesList[index]['sugar'],
                                    protein: userProfilesList[index]['protein'],
                                    totalTime: userProfilesList[index]['totalTime'],
                                    ingredientLines: userProfilesList[index]['ingredientLines'].cast<String>(),
                                    url: userProfilesList[index]['url'].toString(),
                                  ),
                                ),
                              );
                            },
                            child: DishesCardFav(
                              label: userProfilesList[index]['label'].toString(),
                              image: userProfilesList[index]['image'].toString(),
                              cuisineType: userProfilesList[index]['cuisineType'].toString(),
                              calories: userProfilesList[index]['calories'],
                              totalTime: userProfilesList[index]['totalTime'],
                              ingredientLines: userProfilesList[index]['ingredientLines'].cast<String>(),
                              url: userProfilesList[index]['url'].toString(),
                            ),
                          );
                        },
                      );
                    }
                  return Center(child: CircularProgressIndicator());
                  }
                )
              ),
            ],
          ),
        ),
      ),
    );
  }
}
