import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:lokma/helpers/constant/Colors.dart';
import 'package:lokma/helpers/constant/Routs.dart';
import 'package:lokma/models/Categories.dart';
import 'package:lokma/models/Products.dart' hide Image;
import 'package:lokma/screens/ProductInfo.dart';
import 'package:lokma/screens/Viewproducts.dart';
import 'package:lokma/services/CustomDialog.dart';
import 'package:lokma/widgets/customField.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Future<List<Category>> _getData() async {
    try {
      Response response = await dio.get(
        Routs.categories,
        options: Options(
          headers: {'Accept': 'application/json'},
        ),
      );
      print(response.data.toString());
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

  Future<void> _postData() async {
    try {
      Map<String, String> data = {};

      SharedPreferences preferences = await SharedPreferences.getInstance();

      Response response = await dio.post(
        Routs.logout,
        data: data,
        options: Options(
          headers: {
            'Accept': 'application/json',
            'Authorization': 'Bearer ' + preferences.get('access_token'),
          },
        ),
      );
      if (response.statusCode == 200) {
        Navigator.pushNamed(context, '/Login');
      } else {}
      print(response.data.toString());
    } catch (e) {
      print(e.toString());
      Future.error(e);
      return showDialog(
        context: context,
        builder: (conx) => CustomDialog(
          title: 'Oh somethin went wrong!',
          body: e.toString(),
          buttonText: 'cancel',
          buttonOnPressed: () => Navigator.pop(context),
        ),
      );
    }
  }

  Future<ProductsModel> _getPopularProducts() async {
    try {
      Response response = await dio.get(
        Routs.populardishes,
        options: Options(
          headers: {'Accept': 'application/json'},
        ),
      );
      print(response.data.toString());
      if (response.statusCode == 200) {
        return ProductsModel.fromJson(response.data);
      } else {
        return ProductsModel();
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

  _launchURL() async {
    const url = Routs.therestaurantLocation;
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CColors.whiteTheme,
      appBar: AppBar(
        backgroundColor: CColors.orangeTheme,
        elevation: 0,
        centerTitle: true,
        title: Text(
          'Home',
          style: TextStyle(
            color: CColors.whiteTheme,
            fontSize: 15,
          ),
        ),
        leading: GestureDetector(
          onTap: () {
            showDialog<String>(
              context: context,
              builder: (BuildContext context) => AlertDialog(
                title: Text('Logout!'),
                content:
                    Text('Incase you logout you might lose your cart items'),
                actions: <Widget>[
                  TextButton(
                    onPressed: () => Navigator.pop(context, 'Cancel'),
                    child: Text(
                      'Cancel',
                      style: TextStyle(
                        color: CColors.orangeTheme,
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      // _postData();
                      Navigator.pushNamed(context, '/Login');
                    },
                    child: Text(
                      'Logout',
                      style: TextStyle(
                        color: CColors.orangeTheme,
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
          child: Icon(
            Icons.login_rounded,
            color: CColors.whiteTheme,
          ),
        ),
      ),
      body: ListView(
        children: [
          Container(
            height: 140,
            decoration: BoxDecoration(
              color: CColors.orangeTheme,
              borderRadius: BorderRadius.vertical(
                bottom: Radius.circular(32),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16.0,
                    vertical: 4.0,
                  ),
                  child: Text(
                    "Welcome Back!",
                    style: const TextStyle(
                      color: CColors.whiteTheme,
                      fontWeight: FontWeight.w500,
                      fontSize: 18.0,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16.0,
                    vertical: 4.0,
                  ),
                  child: Text(
                    "Find your Favorite dish",
                    style: const TextStyle(
                      color: CColors.whiteTheme,
                      fontSize: 18.0,
                      fontStyle: FontStyle.normal,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                ),
                CustomTextField(
                  hint: "Search for a Favorite Meal or Dish",
                  icon: Icons.search,
                  validator: null,
                  controller: null,
                  obscureText: false,
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Categories",
                  style: const TextStyle(
                    color: CColors.blackTheme,
                    fontWeight: FontWeight.w500,
                    fontStyle: FontStyle.normal,
                    fontSize: 16.0,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, '/ViewAll');
                  },
                  child: Text(
                    "View all",
                    style: const TextStyle(
                      color: CColors.orangeTheme,
                      fontWeight: FontWeight.w300,
                      fontStyle: FontStyle.normal,
                      fontSize: 13.0,
                    ),
                  ),
                ),
              ],
            ),
          ),
          FutureBuilder(
            future: _getData(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Container(
                  height: 80,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: snapshot.data.length,
                    itemBuilder: (context, index) {
                      Category category = snapshot.data[index];

                      return CategoriesContainer(
                        image: category.image,
                        text: category.name,
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) =>
                                  SelectedCategory(category: category),
                            ),
                          );
                        },
                      );
                    },
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
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Popular dishes",
                  style: const TextStyle(
                    color: CColors.blackTheme,
                    fontWeight: FontWeight.w500,
                    fontStyle: FontStyle.normal,
                    fontSize: 16.0,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, '/PopularViewAll');
                  },
                  child: Text(
                    "View all",
                    style: const TextStyle(
                        color: CColors.orangeTheme,
                        fontWeight: FontWeight.w300,
                        fontStyle: FontStyle.normal,
                        fontSize: 13.0),
                  ),
                ),
              ],
            ),
          ),
          FutureBuilder(
            future: _getPopularProducts(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                Products products = snapshot.data.products;
                return Container(
                  height: 170,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: products.data.length,
                    itemBuilder: (context, index) {
                      Product product = products.data[index];
                      return GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) =>
                                  ProductInfo(product: product),
                            ),
                          );
                        },
                        child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Container(
                            width: 120,
                            height: 170,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(
                                Radius.circular(10),
                              ),
                              boxShadow: [
                                BoxShadow(
                                    color: CColors.textFelidTheme,
                                    offset: Offset(0, 0),
                                    blurRadius: 6,
                                    spreadRadius: 0),
                              ],
                              color: CColors.whiteTheme,
                            ),
                            child: Column(
                              children: [
                                Container(
                                  width: 120,
                                  height: 75,
                                  decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10)),
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: Image(
                                      image: NetworkImage(
                                        Routs.domin + product.imageHeader,
                                      ),
                                      fit: BoxFit.cover,
                                      width: 85,
                                      height: 85,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 8,
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 8,
                                  ),
                                  child: Align(
                                    alignment: Alignment.topLeft,
                                    child: Text(
                                      product.name,
                                      style: TextStyle(
                                        fontSize: 12.0,
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 6,
                                  ),
                                  child: Row(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(2.0),
                                        child: Icon(
                                          Icons.star,
                                          color: Colors.amber,
                                          size: 10,
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(2.0),
                                        child: Icon(
                                          Icons.star,
                                          color: Colors.amber,
                                          size: 10,
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(2.0),
                                        child: Icon(
                                          Icons.star,
                                          color: Colors.amber,
                                          size: 10,
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(2.0),
                                        child: Icon(
                                          Icons.star,
                                          color: Colors.amber,
                                          size: 10,
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(2.0),
                                        child: Icon(
                                          Icons.star,
                                          color: Colors.amber,
                                          size: 10,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Align(
                                        alignment: Alignment.topLeft,
                                        child: Text(
                                          "\$ " + product.price.toString(),
                                          style: TextStyle(
                                            fontSize: 14,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
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
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Colors.grey.shade100,
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(32),
                    ),
                  ),
                  height: 200,
                  width: double.infinity,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        'assets/images/lokma1.svg',
                        height: 150,
                        width: 150,
                      ),
                      Text(
                        'Now enjoy the ultimate dining experience \n at our restaurant',
                        style: TextStyle(
                          fontSize: 13,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      _launchURL();
                    });
                  },
                  child: Container(
                    height: 30,
                    decoration: BoxDecoration(
                      color: CColors.orangeTheme,
                      borderRadius: BorderRadius.vertical(
                        bottom: Radius.circular(32),
                      ),
                    ),
                    child: Center(
                      child: Text(
                        'Get direction!',
                        style: TextStyle(
                          color: CColors.whiteTheme,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class CategoriesContainer extends StatelessWidget {
  final String text;
  final String image;
  final Function onTap;
  const CategoriesContainer({
    @required this.text,
    @required this.image,
    @required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          width: 80,
          height: 63,
          decoration: BoxDecoration(
            color: CColors.orangeTheme,
            borderRadius: BorderRadius.all(Radius.circular(14)),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.network(
                Routs.domin + image,
                width: 35,
                height: 35,
              ),
              Text(
                text,
                style: const TextStyle(
                  color: CColors.whiteTheme,
                  fontWeight: FontWeight.w300,
                  fontStyle: FontStyle.normal,
                  fontSize: 14.0,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
