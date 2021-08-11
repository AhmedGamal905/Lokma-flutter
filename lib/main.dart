import 'package:flutter/material.dart';
import 'package:lokma/widgets/navigationBar.dart';
import 'package:provider/provider.dart';
import 'package:lokma/Provider/CartProvider.dart';
import 'package:lokma/screens/auth/ForgotPassword.dart';
import 'package:lokma/screens/auth/Verification.dart';
import 'package:lokma/screens/auth/Login.dart';
import 'package:lokma/screens/auth/SignUp.dart';
import 'package:lokma/screens/CategoriesViewAll.dart';
import 'package:lokma/screens/PopularViewAll.dart';
import 'package:lokma/screens/Viewproducts.dart';
import 'package:lokma/screens/ProductInfo.dart';
import 'package:lokma/screens/Cart.dart';
import 'package:lokma/screens/Home.dart';
import 'package:lokma/screens/StoreOrder.dart';

main() {
  runApp(ChangeNotifierProvider(
    create: (context) => CartProvider(),
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        backgroundColor: Colors.white,
        fontFamily: 'SFProText',
      ),
      home: Login(),
      routes: {
        '/Home': (context) => Home(),
        '/Cart': (context) => Cart(),
        '/Login': (context) => Login(),
        '/SignUp': (context) => SignUp(),
        '/StoreOrder': (context) => StoreOrder(),
        '/Verificate': (context) => Verificate(),
        '/ProductInfo': (context) => ProductInfo(),
        '/ViewAll': (context) => CategoriesViewAll(),
        '/NavigationBar': (context) => NavigationBar(),
        '/ForgotPassword': (context) => ForgotPassword(),
        '/PopularViewAll': (context) => PopularViewAll(),
        '/SelectedCategory': (context) => SelectedCategory(),
      },
    );
  }
}
