import 'package:flutter/material.dart';
import 'package:lokma/Helpers/Constant/Routs.dart';
import 'package:lokma/helpers/constant/Colors.dart';
import 'package:lokma/Provider/CartProvider.dart';
import 'package:lokma/services/CustomDialog.dart';
import 'package:lokma/widgets/customButton.dart';
import 'package:provider/provider.dart';

class Cart extends StatefulWidget {
  @override
  _CartState createState() => _CartState();
}

class _CartState extends State<Cart> {
  @override
  Widget build(BuildContext context) {
    return Consumer<CartProvider>(
      builder: (context, cartModel, child) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: CColors.orangeTheme,
            elevation: 0,
            centerTitle: true,
            automaticallyImplyLeading: false,
            title: Text(
              'My Cart',
              style: TextStyle(
                color: CColors.whiteTheme,
                fontSize: 15,
              ),
            ),
          ),
          body: Column(
            children: [
              Container(
                height: MediaQuery.of(context).size.height - 310,
                child: cartModel.cartItems.length == 0
                    ? Center(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text("Cart is empty"),
                        ),
                      )
                    : ListView.builder(
                        shrinkWrap: true,
                        itemCount: cartModel.cartItems.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16.0,
                              vertical: 8.0,
                            ),
                            child: Container(
                              height: 100,
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
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      height: 75,
                                      width: 75,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10)),
                                      ),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(10),
                                        child: Image(
                                          image: NetworkImage(
                                            Routs.domin +
                                                cartModel.cartItems[index]
                                                    .product.imageHeader,
                                          ),
                                          fit: BoxFit.cover,
                                          width: 75,
                                          height: 75,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          cartModel
                                              .cartItems[index].product.name
                                              .toString(),
                                          style: TextStyle(fontSize: 15.0),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(
                                            "\$ " +
                                                cartModel.cartItems[index]
                                                    .product.price
                                                    .toString(),
                                            style: const TextStyle(
                                              color: CColors.orangeTheme,
                                              fontSize: 15.0,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            cartModel.remove(
                                                cartModel.cartItems[index]);
                                          },
                                          child: Icon(
                                            Icons.cancel,
                                            color: CColors.orangeTheme,
                                            size: 24,
                                          ),
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            GestureDetector(
                                              onTap: () {
                                                cartModel.descrement(
                                                    cartModel.cartItems[index]);
                                              },
                                              child: Container(
                                                child: Text(
                                                  '-',
                                                  style: TextStyle(
                                                    color: CColors.orangeTheme,
                                                    fontSize: 30.0,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Text(
                                                cartModel
                                                    .cartItems[index].quantity
                                                    .toString(),
                                                style: const TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 18.0),
                                              ),
                                            ),
                                            GestureDetector(
                                              onTap: () {
                                                cartModel.increment(
                                                    cartModel.cartItems[index]);
                                              },
                                              child: Container(
                                                child: Text(
                                                  '+',
                                                  style: TextStyle(
                                                    color: CColors.orangeTheme,
                                                    fontSize: 30.0,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          );
                        },
                      ),
              ),
              Expanded(
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    height: 170,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.vertical(
                                top: Radius.circular(20),
                              ),
                            ),
                            height: 110,
                            width: double.infinity,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "Subtotal",
                                        style: TextStyle(
                                          color: CColors.textFelidHintTheme,
                                          fontSize: 15.0,
                                        ),
                                      ),
                                      Text(
                                        "\$ " + cartModel.totalPrice.toString(),
                                        style: TextStyle(
                                          color: CColors.textFelidHintTheme,
                                          fontSize: 15.0,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "Delivery",
                                        style: TextStyle(
                                          color: CColors.textFelidHintTheme,
                                          fontSize: 15.0,
                                        ),
                                      ),
                                      Text(
                                        "\$ " +
                                            ((cartModel.totalPrice) * 0.05)
                                                .toInt()
                                                .toString(),
                                        style: TextStyle(
                                          color: CColors.textFelidHintTheme,
                                          fontSize: 15.0,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "Total",
                                        style: TextStyle(
                                          color: CColors.blackTheme,
                                          fontSize: 15.0,
                                        ),
                                      ),
                                      Text(
                                        ("\$ " +
                                            ((cartModel.totalPrice) +
                                                    ((cartModel.totalPrice) *
                                                        0.05))
                                                .toString()),
                                        style: TextStyle(
                                          color: CColors.blackTheme,
                                          fontSize: 15.0,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          CustomButton(
                              text: "Check Out!",
                              onTap: () {
                                if (cartModel.cartItems.isEmpty) {
                                  return showDialog(
                                    context: context,
                                    builder: (conx) => CustomDialog(
                                      title: "Cart is empty!",
                                      body:
                                          "Add some food to the cart to check out",
                                      buttonText: 'cancel',
                                      buttonOnPressed: () {
                                        Navigator.pop(context);
                                      },
                                    ),
                                  );
                                } else {
                                  Navigator.pushNamed(context, '/StoreOrder');
                                }
                              }),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
