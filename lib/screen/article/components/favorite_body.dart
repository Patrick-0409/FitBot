
import 'package:fiton/screen/article/components/secondary_card.dart';
import 'package:fiton/screen/article/detail/read_news.dart';
import 'package:fiton/services/news_api_manager.dart';
import 'package:flutter/material.dart';

class FavoriteBody extends StatefulWidget {
  const FavoriteBody({Key? key}) : super(key: key);
  @override
  _FavoriteBodyState createState() => _FavoriteBodyState();
}

class _FavoriteBodyState extends State<FavoriteBody> {
  List userProfilesList = [];
  
  @override
  void initState(){
    fetchNewsList();
    super.initState();
  }

  fetchNewsList() async {
      userProfilesList = await API_Manager().getFav();
      return userProfilesList;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
          future: fetchNewsList(),
          builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: userProfilesList.length,
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              physics: ScrollPhysics(),
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () async {
                    bool temp = await API_Manager().checkContains(await API_Manager().checkNews(
                                                userProfilesList[index]['source'].toString(),
                                                userProfilesList[index]['author'].toString(),
                                                userProfilesList[index]['title'].toString(),
                                                userProfilesList[index]['description'].toString(),
                                                userProfilesList[index]['url'].toString(),
                                                userProfilesList[index]['urlToImage'].toString(),
                                                userProfilesList[index]['publishedAt'].toDate(),
                                                userProfilesList[index]['content'].toString(),
                                                ));
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ReadNews(
                                                contain: temp,
                                                source: userProfilesList[index]['source'].toString(),
                                                author: userProfilesList[index]['author'].toString(),
                                                title: userProfilesList[index]['title'].toString(),
                                                description: userProfilesList[index]['description'].toString(),
                                                url: userProfilesList[index]['url'].toString(),
                                                urlToImage: userProfilesList[index]['urlToImage'].toString(),
                                                publishedAt: userProfilesList[index]['publishedAt'].toDate(),
                                                content: userProfilesList[index]['content'].toString(),
                                              ),
                      ),
                    );
                  },
                  child: Container(
                    width: double.infinity,
                    height: 150,
                    margin: EdgeInsets.symmetric(horizontal: 18, vertical: 8),
                    child: SecondaryCard(
                      source: userProfilesList[index]['source'].toString(),
                      author: userProfilesList[index]['author'].toString(),
                      title: userProfilesList[index]['title'].toString(),
                      description: userProfilesList[index]['description'].toString(),
                      url: userProfilesList[index]['url'].toString(),
                      urlToImage: userProfilesList[index]['urlToImage'].toString(),
                      publishedAt: userProfilesList[index]['publishedAt'].toDate(),
                      content: userProfilesList[index]['content'].toString(),
                    ),
                  ),
                );
              },
            );
          }
          return Center(child: CircularProgressIndicator());
        }
    );
  }
}
