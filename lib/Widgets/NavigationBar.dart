import 'package:flutter/material.dart';
import 'package:lokma/helpers/constant/Colors.dart';
import 'package:lokma/screens/AboutUs.dart';
import 'package:lokma/screens/Cart.dart';
import 'package:lokma/screens/Home.dart';
import 'package:lokma/screens/MyOrders.dart';

class NavigationBar extends StatefulWidget {
  @override
  _NavigationBarState createState() => _NavigationBarState();
}

class _NavigationBarState extends State<NavigationBar> {
  int _currentIndex = 0;
  final _pageOptions = [
    Home(),
    Cart(),
    OrderPage(),
    AboutUs(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: _pageOptions[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: CColors.whiteTheme,
        currentIndex: _currentIndex,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: CColors.orangeTheme,
        unselectedItemColor: CColors.textFelidHintTheme,
        iconSize: 20,
        selectedFontSize: 12,
        unselectedFontSize: 12,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_filled),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart_outlined),
            label: 'Cart',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: 'Orders',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.info_outlined),
            label: 'About Us',
          ),
        ],
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}
