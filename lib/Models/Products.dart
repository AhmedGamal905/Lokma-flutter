class ProductsModel {
  ProductsModel({
    this.products,
  });

  Products products;

  factory ProductsModel.fromJson(Map<String, dynamic> json) => ProductsModel(
        products: Products.fromJson(json["products"]),
      );
}

class Products {
  Products({
    this.data,
  });

  List<Product> data;

  factory Products.fromJson(Map<String, dynamic> json) => Products(
        data: List<Product>.from(json["data"].map((x) => Product.fromJson(x))),
      );
}

class Product {
  Product({
    this.id,
    this.name,
    this.description,
    this.length,
    this.width,
    this.sale,
    this.code,
    this.price,
    this.imageHeader,
    this.favorite,
    this.outOfQuantity,
    this.images,
  });

  int id;
  String name;
  String description;
  String length;
  String width;
  int sale;
  String code;
  int price;
  String imageHeader;
  bool favorite;
  int outOfQuantity;
  List<Image> images;

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        length: json["length"],
        width: json["width"],
        sale: json["sale"],
        code: json["code"],
        price: json["price"],
        imageHeader: json["image_header"],
        favorite: json["favorite"],
        outOfQuantity: json["out_of_quantity"],
        images: List<Image>.from(json["images"].map((x) => Image.fromJson(x))),
      );
}

class Image {
  Image({
    this.image,
  });
  String image;
  factory Image.fromJson(Map<String, dynamic> json) => Image(
        image: json["image"],
      );
}
