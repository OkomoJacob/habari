import 'dart:convert';
import 'package:habari/models/article_model.dart';
import 'package:habari/utils/main_url.dart';
import 'package:http/http.dart' as http;

class News {
  List<ArticleModel> news = [];

  Future<void> getNews() async {
    String url = "https://newsapi.org/v2/everything?q=tesla&from=2022-04-27&sortBy=publishedAt&apiKey=a262f7dccba14a8498b0ca61dbebdb26";
    var response = await http.get(Uri.parse(url));
    var jsonData = jsonDecode(response.body);
    // Json API request status code == 200?
    if (jsonData['status'] == "ok") {
      jsonData["articles"].forEach((element) {
        // Only display articles with both image and descriptions
        if (element["urlToImage"] != null && element['description'] != null) {
          ArticleModel articleModel = ArticleModel(
              title: element['title'],
              author: element['author'],
              description: element['description'],
              url: element["url"],
              urlToImage: element["urlToImage"],
              // publishedAt: element["publishedAt"],
              content: element["content"]);

          // Update the newsList with the updated article model
          news.add(articleModel);
        }
      });
    }
  }
}
