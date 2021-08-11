import 'package:lokma/Models/Products.dart';

class PreviousOrders {
  PreviousOrders({
    this.orders,
  });

  Orders orders;

  factory PreviousOrders.fromJson(Map<String, dynamic> json) => PreviousOrders(
        orders: Orders.fromJson(json["orders"]),
      );
}

class Orders {
  Orders({
    this.data,
    this.total,
    this.perPage,
    this.currentPage,
    this.lastPage,
    this.basePageUrl,
    this.nextPageUrl,
    this.prevPageUrl,
  });

  List<Order> data;
  int total;
  int perPage;
  int currentPage;
  int lastPage;
  String basePageUrl;
  dynamic nextPageUrl;
  dynamic prevPageUrl;

  factory Orders.fromJson(Map<String, dynamic> json) => Orders(
        data: List<Order>.from(json["data"].map((x) => Order.fromJson(x))),
        total: json["total"],
        perPage: json["per_page"],
        currentPage: json["current_page"],
        lastPage: json["last_page"],
        basePageUrl: json["base_page_url"],
        nextPageUrl: json["next_page_url"],
        prevPageUrl: json["prev_page_url"],
      );
}

class Order {
  Order({
    this.id,
    this.userId,
    this.totalPrice,
    this.finalTotalPrice,
    this.deliveryDate,
    this.deliveryTime,
    this.status,
    this.statusPayment,
    this.note,
    this.district,
    this.reciverPhone,
    this.reciverName,
    this.cardDescription,
    this.rate,
    this.comment,
    this.latitude,
    this.longitude,
    this.address,
    this.typePayment,
    this.createdAt,
    this.updatedAt,
    this.couponId,
    this.deliveryCost,
    this.tax,
    this.products,
  });

  int id;
  int userId;
  double totalPrice;
  double finalTotalPrice;
  DateTime deliveryDate;
  String deliveryTime;
  Status status;
  dynamic statusPayment;
  String note;
  String district;
  String reciverPhone;
  String reciverName;
  String cardDescription;
  double rate;
  String comment;
  double latitude;
  double longitude;
  String address;
  TypePayment typePayment;
  DateTime createdAt;
  DateTime updatedAt;
  dynamic couponId;
  double deliveryCost;
  double tax;
  List<Product> products;

  factory Order.fromJson(Map<String, dynamic> json) => Order(
        id: json["id"] == null ? null : json["id"],
        userId: json["user_id"] == null ? null : json["user_id"],
        totalPrice:
            json["total_price"] == null ? null : json["total_price"].toDouble(),
        finalTotalPrice: json["final_total_price"] == null
            ? null
            : json["final_total_price"].toDouble(),
        deliveryDate: json["delivery_date"] == null
            ? null
            : DateTime.parse(json["delivery_date"]),
        deliveryTime:
            json["delivery_time"] == null ? null : json["delivery_time"],
        status: json["status"] == null ? null : Status.fromJson(json["status"]),
        statusPayment: json["status_payment"],
        note: json["note"] == null ? null : json["note"],
        district: json["district"] == null ? null : json["district"],
        reciverPhone:
            json["reciver_phone"] == null ? null : json["reciver_phone"],
        reciverName: json["reciver_name"] == null ? null : json["reciver_name"],
        cardDescription:
            json["card_description"] == null ? null : json["card_description"],
        rate: json["rate"] == null ? null : json["rate"].toDouble(),
        comment: json["comment"] == null ? null : json["comment"],
        latitude: json["latitude"] == null ? null : json["latitude"].toDouble(),
        longitude:
            json["longitude"] == null ? null : json["longitude"].toDouble(),
        address: json["address"] == null ? null : json["address"],
        typePayment: json["type_payment"] == null
            ? null
            : TypePayment.fromJson(json["type_payment"]),
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        deliveryCost: json["delivery_cost"] == null
            ? null
            : json["delivery_cost"].toDouble(),
        tax: json["tax"] == null ? null : json["tax"].toDouble(),
        products: json["products"] == null
            ? null
            : List<Product>.from(
                json["products"].map((x) => Product.fromJson(x))),
      );
}

class Status {
  Status({
    this.index,
    this.status,
  });

  int index;
  String status;

  factory Status.fromJson(Map<String, dynamic> json) => Status(
        index: json["index"],
        status: json["status"],
      );
}

class TypePayment {
  TypePayment({
    this.index,
    this.typePayment,
  });

  int index;
  String typePayment;

  factory TypePayment.fromJson(Map<String, dynamic> json) => TypePayment(
        index: json["index"] == null ? null : json["index"],
        typePayment: json["type_payment"] == null ? null : json["type_payment"],
      );
}
