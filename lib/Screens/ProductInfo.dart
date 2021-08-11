import 'package:flutter/material.dart';
import 'package:lokma/Helpers/Constant/Routs.dart';
import 'package:lokma/helpers/constant/Colors.dart';
import 'package:lokma/Provider/CartProvider.dart';
import 'package:lokma/models/Item.dart';
import 'package:lokma/models/Products.dart' hide Image;
import 'package:lokma/widgets/customButton.dart';
import 'package:provider/provider.dart';

class ProductInfo extends StatefulWidget {
  final Product product;
  ProductInfo({this.product});
  @override
  _ProductInfoState createState() => _ProductInfoState();
}

class _ProductInfoState extends State<ProductInfo> {
  @override
  Widget build(BuildContext context) {
    return Consumer<CartProvider>(
      builder: (context, cartModel, child) {
        return Scaffold(
          backgroundColor: CColors.whiteTheme,
          appBar: AppBar(
            backgroundColor: CColors.orangeTheme,
            elevation: 0,
            centerTitle: true,
            title: Text(
              'Info',
              style: TextStyle(
                color: CColors.whiteTheme,
                fontSize: 15,
              ),
            ),
          ),
          body: ListView(
            children: [
              Container(
                height: 250,
                width: MediaQuery.of(context).size.width,
                child: Image(
                  height: 250,
                  width: MediaQuery.of(context).size.width,
                  image: NetworkImage(
                    Routs.domin + widget.product.imageHeader,
                  ),
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  widget.product.name,
                  style: TextStyle(
                    fontSize: 20.0,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  widget.product.description,
                  style: TextStyle(
                    fontSize: 14.0,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "\$ " + widget.product.price.toString(),
                  style: TextStyle(
                    fontSize: 15,
                  ),
                ),
              ),
              SizedBox(
                height: 50,
              ),
              CustomButton(
                text: 'Add to basket',
                onTap: () {
                  cartModel.add(
                    Item(product: widget.product, quantity: 1),
                  );
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
