import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:lokma/helpers/constant/Colors.dart';
import 'package:lokma/helpers/constant/Routs.dart';
import 'package:lokma/models/Categories.dart';
import 'package:lokma/models/Products.dart' hide Image;
import 'package:lokma/screens/ProductInfo.dart';
import 'package:lokma/screens/Viewproducts.dart';
import 'package:lokma/services/CustomDialog.dart';

class PopularViewAll extends StatefulWidget {
  final Category category;
  PopularViewAll({this.category});
  @override
  _PopularViewAllState createState() => _PopularViewAllState();
}

class _PopularViewAllState extends State<PopularViewAll> {
  @override
  void initState() {
    super.initState();
  }

  Dio dio = Dio();
  Future<ProductsModel> _getProducts() async {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: CColors.orangeTheme,
        elevation: 0,
        centerTitle: true,
        title: Text(
          'Popular dishes',
          style: TextStyle(
            color: CColors.whiteTheme,
            fontSize: 15,
          ),
        ),
      ),
      backgroundColor: CColors.whiteTheme,
      body: FutureBuilder(
        future: _getProducts(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            Products products = snapshot.data.products;
            return Container(
              child: GridView.count(
                crossAxisCount: 2,
                scrollDirection: Axis.vertical,
                children: List.generate(
                  products.data.length,
                  (index) {
                    Product product = products.data[index];
                    return CustomProductCard(
                      product: product,
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => ProductInfo(product: product),
                          ),
                        );
                      },
                    );
                  },
                ),
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

class CustomProductCard extends StatelessWidget {
  final Product product;
  final Function onTap;
  CustomProductCard({this.product, this.onTap});
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return GestureDetector(
      onTap: onTap,
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
                height: 90,
                width: size.width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(1.0),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image(
                    height: 90,
                    width: MediaQuery.of(context).size.width,
                    image: NetworkImage(
                      Routs.domin + product.imageHeader,
                    ),
                    fit: BoxFit.cover,
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
                    product.name.toString(),
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
                    CustomStarIcon(),
                    CustomStarIcon(),
                    CustomStarIcon(),
                    CustomStarIcon(),
                    CustomStarIcon(),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
  }
}
