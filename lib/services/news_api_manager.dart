import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;
import 'package:fiton/models/news.dart';

// ignore: camel_case_types
class API_Manager {
  
  final CollectionReference newsCol = FirebaseFirestore.instance.collection("articles");
  final user = FirebaseAuth.instance.currentUser;
  
  Future<NewsModel> getNews(String url) async {
    var client = http.Client();
    var newsModel;

    try {
      var response = await client.get(Uri.parse(url));
      if (response.statusCode == 200) {
        var jsonString = response.body;
        var jsonMap = json.decode(jsonString);
        newsModel = NewsModel.fromJson(jsonMap);
      }
    } catch (e) {
      print("news api");
      print(e);
      return newsModel;
    }
    return newsModel;
  }

  Future uploadFav(String? source,
                    String? author,
                    String? title,
                    String? description,
                    String? url,
                    String? urlToImage,
                    DateTime? publishedAt,
                    String? content) async {
    final ref = FirebaseFirestore.instance.collection('articles').doc();
    News temp = new News(
      id: ref.id,
      source: source!,
      author: author,
      title: title,
      description: description,
      url: url,
      urlToImage: urlToImage,
      favorited: [],
      publishedAt: publishedAt,
      content: content,
    );

    await ref.set(temp.toMap());
  }
  
  Future<String> getFavID(String? title) async {
    try {
      return await newsCol
        .where("title",isEqualTo: title)
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

  Future<bool> checkContains(String? id) async {
    var temp = FirebaseFirestore.instance
            .collection('articles')
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

  Future getFav() async {
    List itemsList = [];
    try {
    await FirebaseFirestore.instance
            .collection('articles')
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
  
  Future addFav(String? id) async {
    try {
        await FirebaseFirestore.instance
            .collection('articles')
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
            .collection('articles')
            .doc(id)
            .update({
              'favorited':FieldValue.arrayRemove([user!.uid])
            });
    } catch (e) {
      print("error pas delete "+e.toString());
    }
  }

  Future checkNews(String? source,
                    String? author,
                    String? title,
                    String? description,
                    String? url,
                    String? urlToImage,
                    DateTime? publishedAt,
                    String? content) async {
    String id = await getFavID(title);
    if(id.contains("null")){
      await uploadFav(
        source,
        author,
        title,
        description,
        url,
        urlToImage,
        publishedAt,
        content,
      );
      id = await getFavID(title);
    }
    return id;
  }
}