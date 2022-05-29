import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:habari/helpers/news.dart';
import 'package:habari/models/article_model.dart';
import 'package:habari/views/article_views.dart';

class NewsCaregory extends StatefulWidget {
  final String category;
  const NewsCaregory({Key? key, required this.category}) : super(key: key);

  @override
  State<NewsCaregory> createState() => _NewsCaregoryState();
}

class _NewsCaregoryState extends State<NewsCaregory> {
  List<ArticleModel> articles = <ArticleModel>[];
  bool _loading = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCategoryNews();
  }

  getCategoryNews() async {
    CategoryNewsClass newsClass = CategoryNewsClass();
    // The string
    await newsClass.getNews(widget.category);
    articles = newsClass.news;
    setState(() {
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const <Widget>[
              Text("Flutter"),
              Text(
                "News",
                style: TextStyle(color: Colors.redAccent),
              )
            ]),
        centerTitle: true,
        elevation: 0.0,
      ),
      body: _loading
          ? Center(
              child: Container(
                child: CircularProgressIndicator(),
              ),
            )
          : SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: [
                    // -------------------- Blogs -------------------- //
                    Container(
                      padding: EdgeInsets.only(top: 16),
                      child: ListView.builder(
                          itemCount: articles.length,
                          shrinkWrap: true,
                          physics: ClampingScrollPhysics(),
                          itemBuilder: (context, index) {
                            return BlogTile(
                              imageUrl: articles[index].urlToImage.toString(),
                              title: articles[index].title.toString(),
                              descr: articles[index].description.toString(),
                              url: articles[index].url.toString(),
                            );
                          }),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}

// Declare in a seperate file
class BlogTile extends StatelessWidget {
  final String imageUrl, title, descr, url;
  BlogTile({
    required this.imageUrl,
    required this.title,
    required this.descr,
    required this.url,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            CupertinoPageRoute(
                builder: (context) => ArticlesViews(blogUrl: url)));
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        child: Column(
          children: [
            ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(imageUrl)),
            Text(
              title,
              style: const TextStyle(
                  fontSize: 17,
                  color: Colors.black87,
                  fontWeight: FontWeight.w600),
            ),
            const SizedBox(
              height: 8,
            ),
            Text(
              descr,
              style: const TextStyle(color: Color.fromARGB(255, 122, 122, 122)),
            ),
          ],
        ),
      ),
    );
  }
}
