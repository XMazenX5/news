class NewsModel{
  String? title;
  String? author;
  String? time;
  String? image;
  String? urlOf;
  NewsModel.fromJson(Map<String,dynamic> json){
    title = json['title'];
    author = json['author'];
    title = json['publishedAt'];
    image = json['urlToImage'];
    urlOf = json['url'];
  }

}