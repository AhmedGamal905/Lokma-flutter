class Categories {
  List<Category> categories;

  Categories({
    this.categories,
  });

  factory Categories.fromJson(Map<String, dynamic> json) => Categories(
        categories: List<Category>.from(
            json["categories"].map((x) => Category.fromJson(x))),
      );
}

class Category {
  Category({
    this.id,
    this.name,
    this.image,
  });

  int id;
  String name;
  String image;

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        id: json["id"],
        name: json["name"],
        image: json["image"],
      );
}
