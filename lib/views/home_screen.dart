import 'package:flutter/material.dart';
import 'package:habari/helpers/data.dart';
import 'package:habari/models/category_model.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  List<CategoryModel> categories = <CategoryModel>[];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    categories = getCategories();
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
      body: Container(
        child: Column(
          children: [
            Container(
              height: 70,
              child: ListView.builder(
                shrinkWrap: true, //To remove renderbox not laid out
                scrollDirection: Axis.horizontal,
                itemCount: categories.length,
                itemBuilder: (context, index){
                  return CategoryTile(
                    imageUrl: categories[index].imageUrl,
                    CategoryName: categories[index].categoryName,
                    );
                }),
            )
          ],
        ),
      ),
    );
  }
}

class CategoryTile extends StatelessWidget {
  
  final imageUrl, CategoryName;
  CategoryTile({this.imageUrl, this.CategoryName});
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: <Widget>[
          Image.network(imageUrl, width: 120, height: 60, fit: BoxFit.cover,),
          Container()
        ],
      ) ,
    );
  }
}