import 'package:flutter/material.dart';
import 'package:food_ordering/Utility/color.dart';
import 'package:food_ordering/data/repository/cart_repo.dart';
import 'package:food_ordering/models/cart_model.dart';
import 'package:food_ordering/models/products_model.dart';
import 'package:get/get.dart';

class CartController extends GetxController {
  final CartRepo cartRepo;
  CartController({required this.cartRepo});
  Map<int, CartModel> _items = {};
  Map<int, CartModel> get items => _items;

  void addItem(Product product, int quantity) {
    var totalQuantity = 0;
    if (_items.containsKey(product.id)) {
      _items.update(product.id, (existingItem) {
        totalQuantity = existingItem.quantity! + quantity;
        return CartModel(
          id: existingItem.id,
          name: existingItem.name,
          img: existingItem.img,
          price: existingItem.price,
          quantity: (existingItem.quantity ?? 0) + quantity,
          isExist: true,
          time: existingItem.time,
        );
      });
      if (totalQuantity <= 0) {
        _items.remove(product.id);
      }
    } else if (quantity > 0) {
      _items.putIfAbsent(product.id, () {
        return CartModel(
          id: product.id,
          name: product.name,
          img: product.img,
          price: product.price,
          quantity: quantity,
          isExist: true,
          time: DateTime.now().toString(),
        );
      });
    } else {
      Get.snackbar(
        "Lỗi",
        "Vui lòng chọn số lượng lớn hơn 0",
        backgroundColor: AppColors.mainColor,
        colorText: AppColors.whiteColor,
      );
    }

    // Debug:
    _items.forEach((key, value) {
      print("ID: $key, Quantity: ${value.quantity}");
    });
  }

  bool existInCart(Product product) {
    if (_items.containsKey(product.id)) {
      return true;
    } else {
      return false;
    }
  }

  int getQuantity(Product product) {
    var quantity = 0;
    if (_items.containsKey(product.id)) {
      _items.forEach((key, value) {
        if (key == product.id) {
          quantity = value.quantity!;
        }
      });
    }
    return quantity;
  }

  int get totalItems {
    var totalQuantity = 0;
    _items.forEach((key, value) {
      totalQuantity += value.quantity!;
    });
    return totalQuantity;
  }

  List<CartModel> get getItems {
    return _items.entries.map((e) => e.value).toList();
  }
}
