class NewsModel {
  NewsModel({
    required this.status,
    required this.totalResults,
    required this.articles,
  });

  String? status;
  int? totalResults;
  List<Article?> articles;

  factory NewsModel.fromJson(Map<String, dynamic> json) => NewsModel(
    status: json["status"],
    totalResults: json["totalResults"],
    articles: List<Article>.from(
        json["articles"].map((x) => Article.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "totalResults": totalResults,
    "articles": List<dynamic>.from(articles.map((x) => x!.toJson())),
  };
}

class Article {

  Source? source;
  String? author;
  String? title;
  String? description;
  String? url;
  String? urlToImage;
  DateTime? publishedAt;
  String? content;

  Article({
    required this.source,
    required this.author,
    required this.title,
    required this.description,
    required this.url,
    required this.urlToImage,
    required this.publishedAt,
    required this.content,
  });

  factory Article.fromJson(Map<String, dynamic> json) => Article(
    source: Source.fromJson(json["source"]),
    author: json["author"] == null ? "null" : json["author"],
    title: json["title"],
    description: json["description"] == null ? json["content"] : json["description"],
    url: json["url"],
    urlToImage: json["urlToImage"] == null ? "https://cdn.pixabay.com/photo/2015/01/09/11/22/fitness-594143_960_720.jpg" : json["urlToImage"],
    publishedAt: DateTime.parse(json["publishedAt"]),
    content: json["content"] == null ? json["description"] : json["content"],
  );

  Map<String, dynamic> toJson() => {
    "source": source!.toJson(),
    "author": author == null ? "null" : author,
    "title": title,
    "description": description == null ? content : description,
    "url": url,
    "urlToImage": urlToImage,
    "publishedAt": publishedAt!.toIso8601String(),
    "content": content == null ? "null" : content,
  };
}

class Source {
  Source({
    required this.id,
    required this.name,
  });

  String? id;
  String? name;

  factory Source.fromJson(Map<String, dynamic> json) => Source(
    id: json["id"],
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
  };
}

class News {
  String? id;
  String? source;
  String? author;
  String? title;
  String? description;
  String? url;
  String? urlToImage;
  List<String>? favorited;
  DateTime? publishedAt;
  String? content;

  News({
    required this.id,
    required this.source,
    required this.author,
    required this.title,
    required this.description,
    required this.url,
    required this.urlToImage,
    required this.favorited,
    required this.publishedAt,
    required this.content,
  });

  factory News.fromJson(Map<String, dynamic> map, {String? id}) => News(
      publishedAt: map["publishedAt"],
      id: id,
      source: map["source"],
      author: map["author"],
      title: map["title"],
      description: map["description"],
      url: map["url"],
      urlToImage: map["urlToImage"],
      favorited: map["favorited"] == null
          ? []
          : map["favorited"].map<String>((i) => i as String).toList(),
      content: map["content"]
  );

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "source": source,
      "author": author == null ? source : author,
      "title": title,
      "description": description == null ? content : description,
      "url": url,
      "urlToImage": urlToImage,
      "favorited": favorited,
      "publishedAt": publishedAt!,
      "content": content == null ? description : content,
    };
  }
}
