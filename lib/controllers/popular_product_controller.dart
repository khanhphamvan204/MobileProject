// import 'package:food_ordering/models/products_model.dart';
// import 'package:get/get.dart';
// import 'package:food_ordering/data/repository/popular_product_repo.dart';

// class PopularProductController extends GetxController {
//   final PopularProductRepo popularProductRepo;
//   PopularProductController({required this.popularProductRepo});
//   List<dynamic> _popularProductList = [];
//   List<dynamic> get popularProductList => _popularProductList;
//   Future<void> getPopularProductList() async {
//     Response response = await popularProductRepo.getPopularProductList();
//     if (response.statusCode == 200) {
//       _popularProductList = [];
//       _popularProductList.addAll(
//         Product.fromJson(response.body).products as Iterable,
//       );
//       update();
//     } else {}
//   }
// }
import 'dart:math';

import 'package:food_ordering/Utility/color.dart';
import 'package:food_ordering/controllers/cart_controller.dart';
import 'package:food_ordering/models/cart_model.dart';
import 'package:food_ordering/models/products_model.dart';
import 'package:get/get.dart';
import 'package:food_ordering/data/repository/popular_product_repo.dart';
import 'package:flutter/material.dart';

class PopularProductController extends GetxController {
  final PopularProductRepo popularProductRepo;
  PopularProductController({required this.popularProductRepo});

  List<Product> _popularProductList = [];
  List<Product> get popularProductList => _popularProductList;
  late CartController _cart;

  bool _isLoading = false;
  bool get isLoading => _isLoading;
  bool _isLoaded = false;
  bool get isLoaded => _isLoaded;

  int _quantity = 0;
  int get quantity => _quantity;
  int _inCartItems = 0;
  int get inCartItems => _inCartItems + _quantity;

  Future<void> getPopularProductList() async {
    try {
      _isLoading = true;
      update();

      Response response = await popularProductRepo.getPopularProductList();
      // print('API Response: ${response.body}'); // Debug JSON
      if (response.statusCode == 200) {
        _popularProductList = [];
        if (response.body is List) {
          _popularProductList.addAll(
            (response.body as List)
                .map((json) => Product.fromJson(json))
                .toList(),
          );
          _isLoaded = true;
          // print(
          //   'Parsed Products: ${_popularProductList.length}',
          // ); // Debug số lượng
        }
        _isLoading = false;
        update();
      } else {
        _isLoading = false;
        update();
        Get.snackbar(
          'Error',
          'Failed to load products: ${response.statusCode}',
        );
      }
    } catch (e) {
      _isLoading = false;
      update();
      Get.snackbar('Error', 'An error occurred: $e');
    }
  }

  void setQuantity(bool isIncrement) {
    if (isIncrement) {
      _quantity = checkQuantity(_quantity + 1);
    } else {
      _quantity = checkQuantity(_quantity - 1);
    }
    update();
  }

  checkQuantity(int quantity) {
    if ((_inCartItems + quantity) < 0) {
      Get.snackbar(
        'Lỗi',
        'Bạn không chọn số lượng âm!',
        backgroundColor: AppColors.mainColor,
        colorText: AppColors.whiteColor,
      );
      if (_inCartItems > 0) {
        _quantity = -_inCartItems;
        return _quantity;
      }
      return 0;
      // } else if (_inCartItems + quantity > 20) {
      //   Get.snackbar(
      //     'Lỗi',
      //     'Bạn không thể chọn số lượng >20!',
      //     backgroundColor: AppColors.mainColor,
      //     colorText: AppColors.whiteColor,
      //   );
      //   return 20;
    } else {
      return quantity;
    }
  }

  void initProduct(Product product, CartController cart) {
    _quantity = 0;
    _inCartItems = 0;
    _cart = cart;
    var exist = false;
    exist = _cart.existInCart(product);
    if (exist) {
      _inCartItems = _cart.getQuantity(product);
    }
    print("the quantity in the cart is " + _inCartItems.toString());
  }

  void addItem(Product product) {
    _cart.addItem(product, _quantity);
    _quantity = 0;
    _inCartItems = _cart.getQuantity(product);
    // Get.snackbar(
    //   'Thông báo',
    //   'Đã thêm ${product!.name} vào giỏ hàng',
    //   backgroundColor: AppColors.mainColor,
    //   colorText: AppColors.whiteColor,
    // );
    update();
  }

  int get totalItems {
    return _cart.totalItems;
  }

  List<CartModel> get getItems {
    return _cart.getItems;
  }
}
