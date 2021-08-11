import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:lokma/helpers/constant/Colors.dart';
import 'package:lokma/helpers/constant/Routs.dart';
import 'package:lokma/models/Categories.dart';
import 'package:lokma/screens/Viewproducts.dart';
import 'package:lokma/screens/Home.dart';
import 'package:lokma/services/CustomDialog.dart';

class CategoriesViewAll extends StatefulWidget {
  @override
  _CategoriesViewAllState createState() => _CategoriesViewAllState();
}

class _CategoriesViewAllState extends State<CategoriesViewAll> {
  Future<List<Category>> _getData() async {
    try {
      Response response = await dio.get(
        Routs.categories,
        options: Options(
          headers: {'Accept': 'application/json'},
        ),
      );
      if (response.statusCode == 200) {
        return Categories.fromJson(response.data).categories;
      } else {
        return <Category>[];
      }
    } catch (e) {
      print(e.toString());
      Future.error(e);
      return showDialog(
        context: context,
        builder: (conx) => CustomDialog(
          title: 'Oh somethin went wrong!',
          body: e.toString(),
          buttonText: 'cancel',
          buttonOnPressed: () {
            Navigator.pop(context);
          },
        ),
      );
    }
  }

  Dio dio = Dio();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: CColors.orangeTheme,
        elevation: 0,
        centerTitle: true,
        title: Text(
          'All categories',
          style: TextStyle(
            color: CColors.whiteTheme,
            fontSize: 15,
          ),
        ),
      ),
      body: FutureBuilder(
        future: _getData(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Container(
              height: double.infinity,
              child: GridView.count(
                crossAxisCount: 3,
                scrollDirection: Axis.vertical,
                children: List.generate(8, (index) {
                  Category category = snapshot.data[index];
                  return CategoriesContainer(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) =>
                              SelectedCategory(category: category),
                        ),
                      );
                    },
                    image: category.image,
                    text: category.name,
                  );
                }),
              ),
            );
          } else {
            return Center(
              child: CircularProgressIndicator(
                color: CColors.orangeTheme,
              ),
            );
          }
        },
      ),
    );
  }
}
