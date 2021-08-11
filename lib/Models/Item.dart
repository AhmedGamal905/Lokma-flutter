import 'package:lokma/models/Products.dart';

class Item {
  Product product;
  int quantity;
  Item({
    this.product,
    this.quantity,
  });

  Map<String, dynamic> toJson() {
    return {
      'quantity': quantity,
      'product_id': product.id,
    };
  }
}
