import 'package:fiton/models/dummy.dart';
import 'package:fiton/models/recipe.dart';
import 'package:fiton/screen/eat/components/dishes_card.dart';
import 'package:fiton/screen/eat/detail/components/circle_button.dart';
import 'package:fiton/screen/eat/detail/eat_detail_screen.dart';
import 'package:fiton/screen/eat/ingridients/components/group_card.dart';
import 'package:fiton/screen/homepage/home_screen.dart';
import 'package:fiton/screen/workout/Train/components/home_button.dart';
import 'package:fiton/services/recipe_service.dart';
import 'package:flutter/material.dart';

import '../../../constant.dart';

class GroupScreen extends StatefulWidget {
  final String? title;
  final String? sectitle;
  final String? url;

  GroupScreen(
      {Key? key,
      required this.title,
      required this.url,
      required this.sectitle})
      : super(key: key);

  @override
  _GroupScreenState createState() => _GroupScreenState();
}

class _GroupScreenState extends State<GroupScreen> {
  late Future<RecipeModel> _recipeModel;

  @override
  void initState() {
    if (widget.url != '')
      _recipeModel = RecipesService().getRecipes(widget.url!);
    else {
      String tempTitle;
      if (widget.sectitle != '')
        tempTitle = widget.title! + ' ' + widget.sectitle!;
      else
        tempTitle = widget.title!;

      _recipeModel = RecipesService().getRecipes(
          'https://api.edamam.com/search?q=' +
              tempTitle +
              '&app_id=' +
              edamamApiId +
              '&app_key=' +
              edamamApiKey);
    }
    // print(_recipeModel);
    super.initState();
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
                    HomeButton(),
                  ],
                ),
              ),
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(left: 15, right: 15, top: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.url == ''
                      ? 'Result of ' + widget.title!
                      : widget.title!,
                  textAlign: TextAlign.start,
                  style: Theme.of(context)
                      .textTheme
                      .bodyText1!
                      .copyWith(fontSize: 24),
                ),
                SizedBox(height: 5),
                Container(
                  width: size.width,
                  height: size.height * 0.056,
                  decoration: BoxDecoration(
                    color: kSearchBarColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: TextField(
                    textInputAction: TextInputAction.go,
                    onSubmitted: (value) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            // print(value);
                            return GroupScreen(
                                title: widget.title, url: '', sectitle: value);
                          },
                        ),
                      );
                    },
                    controller: TextEditingController()
                      ..text = widget.url! == ""
                          ? widget.sectitle! == ""
                              ? widget.title!
                              : widget.sectitle!
                          : '',
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
                Container(
                  width: double.infinity,
                  height: size.height * 0.74,
                  padding: EdgeInsets.only(bottom: 10),
                  child: FutureBuilder<RecipeModel>(
                    future: _recipeModel,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return ListView.builder(
                          itemCount: snapshot.data?.recipes.length,
                          scrollDirection: Axis.vertical,
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
                              child: IngridientsCardFav(recipe: recent!),
                            );
                          },
                        );
                      }
                      return Center(child: CircularProgressIndicator());
                    },
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
