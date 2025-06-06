import 'package:food_ordering/models/products_model.dart';

class CartModel {
  int? id;
  String? img;
  String? name;
  int? price;
  int? quantity;
  bool? isExist;
  String? time;
  Product? product;

  CartModel({
    required this.id,
    required this.img,
    required this.name,
    required this.price,
    required this.quantity,
    required this.isExist,
    required this.time,
    this.product,
  });

  // Factory method để chuyển từ JSON sang đối tượng CartModel
  CartModel.fromJson(Map<String, dynamic> json) {
    id = json['id'] as int?;
    img = json['img'] as String?;
    name = json['name'] as String?;
    price = json['price'] as int?;
    quantity = json['quantity'] as int?;
    isExist = json['isExist'] as bool?;
    time = json['time'] as String?;
    product =
        json['product'] != null ? Product.fromJson(json['product']) : null;
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'img': img,
      'name': name,
      'price': price,
      'quantity': quantity,
      'isExist': isExist,
      'time': time,
      'product': product?.toJson(),
    };
  }
}
