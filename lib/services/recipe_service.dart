import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fiton/models/recipe.dart';
import 'package:http/http.dart' as http;

class RecipesService {

  final CollectionReference newsCol = FirebaseFirestore.instance.collection("favoriteRecipes");
  final user = FirebaseAuth.instance.currentUser;
  
  Future<RecipeModel> getRecipes(String url) async {
    var client = http.Client();
    var recipeModel;

    try {
      var response = await client.get(Uri.parse(url));
      var jsonString = response.body;
      var jsonMap = json.decode(jsonString);
      recipeModel = RecipeModel.fromJson(jsonMap);
    } catch (e) {
      print("recipe api");
      print(e);
      return recipeModel;
    }
    return recipeModel;
  }

  Future uploadFav(String? label,
                    String? image,
                    String? cuisineType,
                    num? calories,
                    num? fat,
                    num? sugar,
                    num? protein,
                    num? totalTime,
                    List<String>? ingredientLines,
                    String? url
                    ) async {
    final ref = FirebaseFirestore.instance.collection('favoriteRecipes').doc();
    Food temp = new Food(
      id: ref.id,
      label: label,
      image: image,
      cuisineType: cuisineType,
      calories: calories,
      fat: fat,
      sugar: sugar,
      protein: calories,
      totalTime: totalTime,
      favorited: [],
      ingredientLines: ingredientLines,
      url: url,
    );

    await ref.set(temp.toMap());
  }

  Future<String> getFavID(String? label) async {
    try {
      return await newsCol
        .where("label",isEqualTo: label)
        .limit(1)
        .get()
        .then((QuerySnapshot querySnapshot) {
            if (querySnapshot.docs.length>0) {
                Map<String, dynamic> data = querySnapshot.docs[0].data()! as Map<String, dynamic>;
                return data['id'];
            } else {
                return "null";
            }
        });
    } catch (e) {
      return e.toString();
    }
  }

  Future getRecs() async {
    List itemsList = [];
    try {
    await FirebaseFirestore.instance
            .collection('favoriteRecipes')
            .get()
            .then((querySnapshot) {
                  if (querySnapshot.docs.length>0) {
                      for (var i = 0; i < querySnapshot.docs.length; i++) {
                        itemsList.add(querySnapshot.docs[i].data());
                      }
                      return itemsList;
                  } else {
                      return itemsList;
                  }
              });
    } catch (e) {
      print(e);
    }
    return itemsList;
  }

  Future getFavs() async {
    List itemsList = [];
    try {
    await FirebaseFirestore.instance
            .collection('favoriteRecipes')
            .where('favorited', arrayContains: user!.uid)
            .get()
            .then((querySnapshot) {
                  if (querySnapshot.docs.length>0) {
                      for (var i = 0; i < querySnapshot.docs.length; i++) {
                        itemsList.add(querySnapshot.docs[i].data());
                      }
                      return itemsList;
                  } else {
                      return itemsList;
                  }
              });
    } catch (e) {
      print(e);
    }
    return itemsList;
  }

  Future<int> getFav(String? id) async {
    List itemsList = [];
    try {
      await newsCol
        .where("label",isEqualTo: id)
        .limit(1)
        .get()
        .then((QuerySnapshot querySnapshot) {
          if (querySnapshot.docs.length>0) {
            Map<String, dynamic> data = querySnapshot.docs[0].data()! as Map<String, dynamic>;
            itemsList = data['favorited'];
            return 1;
          } else {
            return 0;
          }
        });
    } catch (e) {
      print(e);
      return 0;
    }
      return itemsList.length;
  }

  Future addFav(String? id) async {
    try {
        await FirebaseFirestore.instance
            .collection('favoriteRecipes')
            .doc(id)
            .update({
              'favorited':FieldValue.arrayUnion([user!.uid])
            });
    } catch (e) {
      print("error pas add "+e.toString());
    }
  }

  Future deleteFav(String? id) async {
    try {
        await FirebaseFirestore.instance
            .collection('favoriteRecipes')
            .doc(id)
            .update({
              'favorited':FieldValue.arrayRemove([user!.uid])
            });
    } catch (e) {
      print("error pas delete "+e.toString());
    }
  }

  Future<bool> checkContains(String? id) async {
    var temp = FirebaseFirestore.instance
            .collection('favoriteRecipes')
            .where('id',isEqualTo: id)
            .where('favorited', arrayContains: user!.uid)
            .get()
            .then((QuerySnapshot querySnapshot) {
                  if (querySnapshot.docs.length>0) {
                      return true;
                  } else {
                      return false;
                  }
              });
    return temp;
  }

  Future checkNews(String? label,
                    String? image,
                    String? cuisineType,
                    num? calories,
                    num? energy,
                    num? sugar,
                    num? protein,
                    num? totalTime,
                    List<String>? ingredientLines,
                    String? url
                    ) async {
    String id = await getFavID(label);
    if(id.contains("null")){
      await uploadFav(
      label,
      image,
      cuisineType,
      calories,
      energy,
      sugar,
      protein,
      totalTime,
      ingredientLines,
      url
      );
      id = await getFavID(label);
    }
    return id;
  }
}