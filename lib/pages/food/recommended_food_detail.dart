// // import 'package:flutter/material.dart';
// // import 'package:food_ordering/Utility/app_constants.dart';
// // import 'package:food_ordering/Utility/color.dart';
// // import 'package:food_ordering/Utility/dimensions.dart';
// // import 'package:food_ordering/controllers/product_controller.dart';
// // import 'package:food_ordering/widgets/app_icon.dart';
// // import 'package:food_ordering/widgets/big_text.dart';
// // import 'package:food_ordering/widgets/expandable_text_widget.dart';
// // import 'package:get/get.dart';

// // class RecommendedFoodDetail extends StatelessWidget {
// //   final int pageId;
// //   const RecommendedFoodDetail({super.key, required this.pageId});

// //   @override
// //   Widget build(BuildContext context) {
// //     var product = Get.find<ProductController>().productList[pageId];
// //     return Scaffold(
// //       backgroundColor: AppColors.whiteColor,
// //       body: CustomScrollView(
// //         slivers: [
// //           SliverAppBar(
// //             automaticallyImplyLeading: false,
// //             toolbarHeight: 70,
// //             title: Row(
// //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //               children: [
// //                 GestureDetector(
// //                   onTap: () {
// //                     Navigator.pop(context);
// //                   },
// //                   child: AppIcon(icon: Icons.arrow_back_ios),
// //                 ),
// //                 AppIcon(icon: Icons.shopping_cart_outlined),
// //               ],
// //             ),
// //             bottom: PreferredSize(
// //               preferredSize: Size.fromHeight(20),
// //               child: Container(
// //                 width: double.infinity,
// //                 padding: EdgeInsets.only(top: 5, bottom: 10),
// //                 decoration: BoxDecoration(
// //                   color: const Color.fromARGB(255, 215, 215, 215),
// //                   borderRadius: BorderRadius.only(
// //                     topLeft: Radius.circular(Dimensions.radius20),
// //                     topRight: Radius.circular(Dimensions.radius20),
// //                   ),
// //                 ),
// //                 child: Center(
// //                   child: Text(
// //                     product.name,
// //                     style: TextStyle(
// //                       fontSize: Dimensions.font26,
// //                       fontWeight: FontWeight.bold,
// //                       color: AppColors.mainColor,
// //                     ),
// //                   ),
// //                 ),
// //               ),
// //             ),
// //             pinned: true,
// //             expandedHeight: 300,
// //             backgroundColor: AppColors.mainColor,
// //             flexibleSpace: FlexibleSpaceBar(
// //               background: Image.network(
// //                 AppConstants.BASE_URL + "/" + product.img,
// //                 fit: BoxFit.cover,
// //                 width: double.infinity,
// //               ),
// //             ),
// //           ),
// //           SliverToBoxAdapter(
// //             child: Column(
// //               children: [
// //                 Container(
// //                   margin: EdgeInsets.only(
// //                     top: Dimensions.height20,
// //                     left: Dimensions.width20,
// //                     right: Dimensions.width20,
// //                   ),
// //                   child: ExpandableTextWidget(text: product.desc),
// //                 ),
// //               ],
// //             ),
// //           ),
// //         ],
// //       ),
// //       bottomNavigationBar: Column(
// //         mainAxisSize: MainAxisSize.min,
// //         children: [
// //           Container(
// //             decoration: BoxDecoration(),
// //             padding: EdgeInsets.only(
// //               left: Dimensions.width20 * 2.5,
// //               right: Dimensions.width20 * 2.5,
// //               top: Dimensions.height10,
// //               bottom: Dimensions.height10,
// //             ),
// //             child: Row(
// //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //               children: [
// //                 AppIcon(
// //                   iconSize: Dimensions.iconSize24,
// //                   iconColor: AppColors.whiteColor,
// //                   backgroundColor: AppColors.mainColor,
// //                   icon: Icons.remove,
// //                 ),
// //                 BigText(
// //                   text: "${product.price} X 0",

// //                   color: AppColors.mainBlackColor,
// //                   size: Dimensions.font26,
// //                 ),
// //                 AppIcon(
// //                   iconSize: Dimensions.iconSize24,
// //                   iconColor: AppColors.whiteColor,
// //                   backgroundColor: AppColors.mainColor,
// //                   icon: Icons.add,
// //                 ),
// //               ],
// //             ),
// //           ),
// //           Container(
// //             height: Dimensions.bottomHeightBar,
// //             padding: EdgeInsets.only(
// //               top: Dimensions.height30,
// //               bottom: Dimensions.height30,
// //               left: Dimensions.width20,
// //               right: Dimensions.width20,
// //             ),
// //             decoration: BoxDecoration(
// //               color: AppColors.buttonBackgroundColor,
// //               borderRadius: BorderRadius.only(
// //                 topLeft: Radius.circular(Dimensions.radius20 * 2),
// //                 topRight: Radius.circular(Dimensions.radius20 * 2),
// //               ),
// //             ),
// //             child: Row(
// //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //               children: [
// //                 Container(
// //                   padding: EdgeInsets.only(
// //                     top: Dimensions.height10,
// //                     bottom: Dimensions.height10,
// //                     left: Dimensions.width20,
// //                     right: Dimensions.width20,
// //                   ),
// //                   decoration: BoxDecoration(
// //                     borderRadius: BorderRadius.circular(Dimensions.radius10),
// //                     color: AppColors.whiteColor,
// //                   ),
// //                   child: Icon(
// //                     Icons.favorite,
// //                     color: Colors.red,
// //                     size: Dimensions.iconSize24,
// //                   ),
// //                 ),
// //                 Container(
// //                   padding: EdgeInsets.only(
// //                     top: Dimensions.height15,
// //                     bottom: Dimensions.height15,
// //                     left: Dimensions.width15,
// //                     right: Dimensions.width15,
// //                   ),
// //                   decoration: BoxDecoration(
// //                     borderRadius: BorderRadius.circular(Dimensions.radius20),
// //                     color: AppColors.mainColor,
// //                   ),
// //                   child: BigText(
// //                     text: "\ ${product.price} | Thêm vào giỏ hàng",
// //                     color: AppColors.whiteColor,
// //                   ),
// //                 ),
// //               ],
// //             ),
// //           ),
// //         ],
// //       ),
// //     );
// //   }
// // }

// import 'package:flutter/material.dart';
// import 'package:food_ordering/Utility/app_constants.dart';
// import 'package:food_ordering/Utility/color.dart';
// import 'package:food_ordering/Utility/currency_formatter.dart';
// import 'package:food_ordering/Utility/dimensions.dart';
// import 'package:food_ordering/controllers/product_controller.dart';
// import 'package:food_ordering/models/products_model.dart';
// import 'package:food_ordering/widgets/app_icon.dart';
// import 'package:food_ordering/widgets/big_text.dart';
// import 'package:food_ordering/widgets/expandable_text_widget.dart';
// import 'package:get/get.dart';

// class RecommendedFoodDetail extends StatefulWidget {
//   final int productId;
//   final Product? product;

//   const RecommendedFoodDetail({
//     super.key,
//     required this.productId,
//     this.product,
//   });

//   @override
//   _RecommendedFoodDetailState createState() => _RecommendedFoodDetailState();
// }

// class _RecommendedFoodDetailState extends State<RecommendedFoodDetail> {
//   final ProductController productController = Get.find<ProductController>();
//   Product? _product;
//   bool _isLoading = false;

//   @override
//   void initState() {
//     super.initState();
//     if (widget.product != null) {
//       _product = widget.product;
//     } else {
//       _fetchProduct();
//     }
//   }

//   Future<void> _fetchProduct() async {
//     setState(() {
//       _isLoading = true;
//     });
//     try {
//       final product = await productController.getProductById(widget.productId);
//       if (product != null) {
//         setState(() {
//           _product = product;
//         });
//       } else {
//         Get.snackbar('Lỗi', 'Không tìm thấy sản phẩm');
//       }
//     } catch (e) {
//       Get.snackbar('Lỗi', 'Không thể tải sản phẩm: $e');
//     } finally {
//       setState(() {
//         _isLoading = false;
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     if (_isLoading) {
//       return Scaffold(
//         body: Center(
//           child: CircularProgressIndicator(color: AppColors.mainColor),
//         ),
//       );
//     }

//     if (_product == null) {
//       return Scaffold(body: Center(child: Text('Sản phẩm không tồn tại')));
//     }

//     return Scaffold(
//       backgroundColor: AppColors.whiteColor,
//       body: CustomScrollView(
//         slivers: [
//           SliverAppBar(
//             automaticallyImplyLeading: false,
//             toolbarHeight: 70,
//             title: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 GestureDetector(
//                   onTap: () {
//                     Get.back();
//                   },
//                   child: AppIcon(icon: Icons.arrow_back_ios),
//                 ),
//                 AppIcon(icon: Icons.shopping_cart_outlined),
//               ],
//             ),
//             bottom: PreferredSize(
//               preferredSize: Size.fromHeight(20),
//               child: Container(
//                 width: double.infinity,
//                 padding: EdgeInsets.only(top: 5, bottom: 10),
//                 decoration: BoxDecoration(
//                   color: const Color.fromARGB(255, 215, 215, 215),
//                   borderRadius: BorderRadius.only(
//                     topLeft: Radius.circular(Dimensions.radius20),
//                     topRight: Radius.circular(Dimensions.radius20),
//                   ),
//                 ),
//                 child: Center(
//                   child: BigText(
//                     text: _product!.name,
//                     size: Dimensions.font26,
//                     color: AppColors.mainColor,
//                   ),
//                 ),
//               ),
//             ),
//             pinned: true,
//             expandedHeight: 300,
//             backgroundColor: AppColors.mainColor,
//             flexibleSpace: FlexibleSpaceBar(
//               background: Image.network(
//                 AppConstants.BASE_URL + "/" + _product!.img,
//                 fit: BoxFit.cover,
//                 width: double.infinity,
//               ),
//             ),
//           ),
//           SliverToBoxAdapter(
//             child: Column(
//               children: [
//                 Container(
//                   margin: EdgeInsets.only(
//                     top: Dimensions.height20,
//                     left: Dimensions.width20,
//                     right: Dimensions.width20,
//                   ),
//                   child: ExpandableTextWidget(text: _product!.desc),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//       bottomNavigationBar: Column(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           Container(
//             padding: EdgeInsets.only(
//               left: Dimensions.width20 * 2.5,
//               right: Dimensions.width20 * 2.5,
//               top: Dimensions.height10,
//               bottom: Dimensions.height10,
//             ),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 AppIcon(
//                   iconSize: Dimensions.iconSize24,
//                   iconColor: AppColors.whiteColor,
//                   backgroundColor: AppColors.mainColor,
//                   icon: Icons.remove,
//                   // TODO: Thêm logic giảm số lượng
//                 ),
//                 BigText(
//                   text:
//                       "${CurrencyFormatter.formatVND(_product!.price.toDouble())} X 0",
//                   color: AppColors.mainBlackColor,
//                   size: Dimensions.font26,
//                 ),
//                 AppIcon(
//                   iconSize: Dimensions.iconSize24,
//                   iconColor: AppColors.whiteColor,
//                   backgroundColor: AppColors.mainColor,
//                   icon: Icons.add,
//                   // TODO: Thêm logic tăng số lượng
//                 ),
//               ],
//             ),
//           ),
//           Container(
//             height: Dimensions.bottomHeightBar,
//             padding: EdgeInsets.only(
//               top: Dimensions.height30,
//               bottom: Dimensions.height30,
//               left: Dimensions.width20,
//               right: Dimensions.width20,
//             ),
//             decoration: BoxDecoration(
//               color: AppColors.buttonBackgroundColor,
//               borderRadius: BorderRadius.only(
//                 topLeft: Radius.circular(Dimensions.radius20 * 2),
//                 topRight: Radius.circular(Dimensions.radius20 * 2),
//               ),
//             ),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Container(
//                   padding: EdgeInsets.only(
//                     top: Dimensions.height10,
//                     bottom: Dimensions.height10,
//                     left: Dimensions.width20,
//                     right: Dimensions.width20,
//                   ),
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(Dimensions.radius10),
//                     color: AppColors.whiteColor,
//                   ),
//                   child: Icon(
//                     Icons.favorite,
//                     color: Colors.red,
//                     size: Dimensions.iconSize24,
//                     // TODO: Thêm logic yêu thích
//                   ),
//                 ),
//                 GestureDetector(
//                   onTap: () {
//                     // TODO: Thêm logic thêm vào giỏ hàng
//                     Get.snackbar(
//                       'Thông báo',
//                       'Đã thêm ${_product!.name} vào giỏ hàng',
//                     );
//                   },
//                   child: Container(
//                     padding: EdgeInsets.only(
//                       top: Dimensions.height15,
//                       bottom: Dimensions.height15,
//                       left: Dimensions.width15,
//                       right: Dimensions.width15,
//                     ),
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(Dimensions.radius20),
//                       color: AppColors.mainColor,
//                     ),
//                     child: BigText(
//                       text:
//                           "${CurrencyFormatter.formatVND(_product!.price.toDouble())} | Thêm vào giỏ hàng",
//                       color: AppColors.whiteColor,
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
// import 'package:cached_network_image/cached_network_image.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:food_ordering/Utility/app_constants.dart';
import 'package:food_ordering/Utility/color.dart';
import 'package:food_ordering/Utility/dimensions.dart';
import 'package:food_ordering/controllers/cart_controller.dart';
import 'package:food_ordering/controllers/product_controller.dart';
import 'package:food_ordering/models/products_model.dart';
import 'package:food_ordering/pages/cart/cart_page.dart';
import 'package:food_ordering/routes/route_helper.dart';
import 'package:food_ordering/widgets/app_column.dart';
import 'package:food_ordering/widgets/app_icon.dart';
import 'package:food_ordering/widgets/big_text.dart';
import 'package:food_ordering/widgets/expandable_text_widget.dart';
import 'package:get/get.dart';

class RecommendedFoodDetail extends StatefulWidget {
  final int productId;
  final Product? product;

  const RecommendedFoodDetail({
    super.key,
    required this.productId,
    this.product,
  });

  @override
  _RecommendedFoodDetailState createState() => _RecommendedFoodDetailState();
}

class _RecommendedFoodDetailState extends State<RecommendedFoodDetail> {
  final ProductController productController = Get.find<ProductController>();
  final CartController cartController = Get.find<CartController>();
  Product? _product;
  bool _isLoading = false;
  int _quantity = 0;
  int _inCartItems = 0;

  @override
  void initState() {
    super.initState();
    if (widget.product != null) {
      _product = widget.product;
      _initProduct();
    } else {
      _fetchProduct();
    }
  }

  Future<void> _fetchProduct() async {
    setState(() {
      _isLoading = true;
    });
    try {
      final product = await productController.getProductById(widget.productId);
      if (product != null) {
        setState(() {
          _product = product;
          _initProduct();
        });
      } else {
        Get.snackbar('Lỗi', 'Không tìm thấy sản phẩm');
      }
    } catch (e) {
      Get.snackbar('Lỗi', 'Không thể tải sản phẩm: $e');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _initProduct() {
    _quantity = 0;
    _inCartItems = 0;
    bool exist = cartController.existInCart(_product!);
    if (exist) {
      _inCartItems = cartController.getQuantity(_product!);
    }
  }

  void _setQuantity(bool isIncrement) {
    setState(() {
      if (isIncrement) {
        _quantity = _checkQuantity(_quantity + 1);
      } else {
        _quantity = _checkQuantity(_quantity - 1);
      }
    });
  }

  int _checkQuantity(int quantity) {
    if (_inCartItems + quantity < 0) {
      Get.snackbar(
        'Lỗi',
        'Bạn không thể chọn số lượng âm!',
        backgroundColor: AppColors.mainColor,
        colorText: AppColors.whiteColor,
      );
      if (_inCartItems > 0) {
        _quantity = -_inCartItems;
        return _quantity;
      }
      return 0;
    } else {
      return quantity;
    }
  }

  void _addItemToCart() {
    bool exist = cartController.existInCart(_product!);
    cartController.addItem(_product!, _quantity);
    setState(() {
      _quantity = 0;
      _inCartItems = cartController.getQuantity(_product!);
    });
    if (exist) {
      Get.snackbar(
        'Thông báo',
        'Đã cập nhật ${_product!.name} trong giỏ hàng',
        backgroundColor: Colors.green,
        colorText: AppColors.whiteColor,
      );
    } else {
      Get.snackbar(
        'Thông báo',
        'Đã thêm ${_product!.name} vào giỏ hàng',
        backgroundColor: Colors.green,
        colorText: AppColors.whiteColor,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return Scaffold(
        body: Center(
          child: CircularProgressIndicator(color: AppColors.mainColor),
        ),
      );
    }

    if (_product == null) {
      return Scaffold(body: Center(child: Text('Sản phẩm không tồn tại')));
    }

    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      body: Stack(
        children: [
          // Background Image
          Positioned(
            left: 0,
            right: 0,
            child: Container(
              width: double.infinity,
              height: Dimensions.popularFoodImgSize,
              child: CachedNetworkImage(
                imageUrl: AppConstants.BASE_URL + "/" + _product!.img,
                placeholder: (context, url) => CircularProgressIndicator(),
                errorWidget: (context, url, error) => Icon(Icons.error),
                fit: BoxFit.cover,
              ),
            ),
          ),
          // App Bar
          Positioned(
            top: Dimensions.height45,
            left: Dimensions.width20,
            right: Dimensions.width20,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    Get.back();
                  },
                  child: AppIcon(icon: Icons.arrow_back_ios),
                ),
                GetBuilder<CartController>(
                  builder: (controller) {
                    int totalItems = controller.totalItems;
                    return GestureDetector(
                      onTap: () {
                        Get.toNamed(RouteHelper.getCartPage());
                      },
                      child: Stack(
                        children: [
                          GestureDetector(
                            onTap: () {
                              Get.to(() => CartPage());
                            },
                            child: AppIcon(icon: Icons.shopping_cart_outlined),
                          ),
                          if (totalItems >= 1)
                            Positioned(
                              right: 0,
                              top: 0,
                              child: AppIcon(
                                icon: Icons.circle,
                                iconColor: Colors.transparent,
                                size: Dimensions.iconSize20,
                                backgroundColor: AppColors.mainColor,
                              ),
                            ),
                          if (totalItems >= 1)
                            Positioned(
                              right: 5,
                              top: -3,
                              child: BigText(
                                text: totalItems.toString(),
                                size: Dimensions.font16,
                                color: AppColors.whiteColor,
                              ),
                            ),
                        ],
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
          // Food Details
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            top: Dimensions.popularFoodImgSize - 20,
            child: Container(
              padding: EdgeInsets.only(
                left: Dimensions.width20,
                right: Dimensions.width20,
                top: Dimensions.height20,
              ),
              decoration: BoxDecoration(
                color: AppColors.whiteColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(Dimensions.radius20),
                  topRight: Radius.circular(Dimensions.radius20),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppColumn(
                    text: _product!.name,
                    price: _product!.price.toDouble(),
                  ),
                  SizedBox(height: Dimensions.height20),
                  BigText(text: "Giới thiệu"),
                  SizedBox(height: Dimensions.height10),
                  Expanded(
                    child: SingleChildScrollView(
                      child: ExpandableTextWidget(text: _product!.desc),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        height: Dimensions.bottomHeightBar,
        padding: EdgeInsets.only(
          top: Dimensions.height30,
          bottom: Dimensions.height30,
          left: Dimensions.width20,
          right: Dimensions.width20,
        ),
        decoration: BoxDecoration(
          color: AppColors.buttonBackgroundColor,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(Dimensions.radius20 * 2),
            topRight: Radius.circular(Dimensions.radius20 * 2),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              padding: EdgeInsets.only(
                top: Dimensions.height15,
                bottom: Dimensions.height15,
                left: Dimensions.width15,
                right: Dimensions.width15,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(Dimensions.radius20),
                color: AppColors.whiteColor,
              ),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () => _setQuantity(false),
                    child: Icon(Icons.remove, color: AppColors.signColor),
                  ),
                  SizedBox(width: Dimensions.width10 / 2),
                  BigText(text: (_inCartItems + _quantity).toString()),
                  SizedBox(width: Dimensions.width10 / 2),
                  GestureDetector(
                    onTap: () => _setQuantity(true),
                    child: Icon(Icons.add, color: AppColors.signColor),
                  ),
                ],
              ),
            ),
            GestureDetector(
              onTap: _addItemToCart,
              child: Container(
                padding: EdgeInsets.only(
                  top: Dimensions.height15,
                  bottom: Dimensions.height15,
                  left: Dimensions.width15,
                  right: Dimensions.width15,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(Dimensions.radius20),
                  color: AppColors.mainColor,
                ),
                child: BigText(
                  text: "Thêm vào giỏ hàng",
                  color: AppColors.whiteColor,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
