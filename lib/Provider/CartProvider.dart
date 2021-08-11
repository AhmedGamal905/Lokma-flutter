import 'package:flutter/cupertino.dart';
import 'package:lokma/models/Item.dart';

class CartProvider extends ChangeNotifier {
  List<Item> _items = [];
  double _totalPrice = 0.0;
  int get count => _items.length;
  double get totalPrice => _totalPrice;
  List<Item> get cartItems => _items;

  void add(Item item) {
    _items.firstWhere(
      (itemOld) {
        if (itemOld.product.id == item.product.id) {
          itemOld.quantity += 1;
          return true;
        }
        return false;
      },
      orElse: () {
        _items.add(item);
        return;
      },
    );
    _totalPrice += item.product.price;

    notifyListeners();
  }

  void remove(Item item) {
    _totalPrice -= (item.product.price * item.quantity);
    _items.remove(item);

    notifyListeners();
  }

  void empty() {
    _totalPrice = 0.0;
    _items = [];
    notifyListeners();
  }

  void descrement(Item item) {
    _totalPrice -= item.product.price;
    item.quantity -= 1;
    if (item.quantity == 0) {
      _items.remove(item);
    }
    notifyListeners();
  }

  void increment(Item item) {
    _totalPrice += item.product.price;
    item.quantity += 1;
    notifyListeners();
  }
}
