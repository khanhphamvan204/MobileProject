// import 'package:flutter/material.dart';
// import 'package:food_ordering/Utility/app_constants.dart';
// import 'package:food_ordering/Utility/color.dart';
// import 'package:food_ordering/Utility/dimensions.dart';
// import 'package:food_ordering/controllers/product_controller.dart';
// import 'package:food_ordering/widgets/app_icon.dart';
// import 'package:food_ordering/widgets/big_text.dart';
// import 'package:food_ordering/widgets/expandable_text_widget.dart';
// import 'package:get/get.dart';

// class RecommendedFoodDetail extends StatelessWidget {
//   final int pageId;
//   const RecommendedFoodDetail({super.key, required this.pageId});

//   @override
//   Widget build(BuildContext context) {
//     var product = Get.find<ProductController>().productList[pageId];
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
//                     Navigator.pop(context);
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
//                   child: Text(
//                     product.name,
//                     style: TextStyle(
//                       fontSize: Dimensions.font26,
//                       fontWeight: FontWeight.bold,
//                       color: AppColors.mainColor,
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//             pinned: true,
//             expandedHeight: 300,
//             backgroundColor: AppColors.mainColor,
//             flexibleSpace: FlexibleSpaceBar(
//               background: Image.network(
//                 AppConstants.BASE_URL + "/" + product.img,
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
//                   child: ExpandableTextWidget(text: product.desc),
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
//             decoration: BoxDecoration(),
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
//                 ),
//                 BigText(
//                   text: "${product.price} X 0",

//                   color: AppColors.mainBlackColor,
//                   size: Dimensions.font26,
//                 ),
//                 AppIcon(
//                   iconSize: Dimensions.iconSize24,
//                   iconColor: AppColors.whiteColor,
//                   backgroundColor: AppColors.mainColor,
//                   icon: Icons.add,
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
//                   ),
//                 ),
//                 Container(
//                   padding: EdgeInsets.only(
//                     top: Dimensions.height15,
//                     bottom: Dimensions.height15,
//                     left: Dimensions.width15,
//                     right: Dimensions.width15,
//                   ),
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(Dimensions.radius20),
//                     color: AppColors.mainColor,
//                   ),
//                   child: BigText(
//                     text: "\ ${product.price} | Thêm vào giỏ hàng",
//                     color: AppColors.whiteColor,
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

import 'package:flutter/material.dart';
import 'package:food_ordering/Utility/app_constants.dart';
import 'package:food_ordering/Utility/color.dart';
import 'package:food_ordering/Utility/currency_formatter.dart';
import 'package:food_ordering/Utility/dimensions.dart';
import 'package:food_ordering/controllers/product_controller.dart';
import 'package:food_ordering/models/products_model.dart';
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
  Product? _product;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    if (widget.product != null) {
      _product = widget.product;
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
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            automaticallyImplyLeading: false,
            toolbarHeight: 70,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    Get.back();
                  },
                  child: AppIcon(icon: Icons.arrow_back_ios),
                ),
                AppIcon(icon: Icons.shopping_cart_outlined),
              ],
            ),
            bottom: PreferredSize(
              preferredSize: Size.fromHeight(20),
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.only(top: 5, bottom: 10),
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 215, 215, 215),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(Dimensions.radius20),
                    topRight: Radius.circular(Dimensions.radius20),
                  ),
                ),
                child: Center(
                  child: BigText(
                    text: _product!.name,
                    size: Dimensions.font26,
                    color: AppColors.mainColor,
                  ),
                ),
              ),
            ),
            pinned: true,
            expandedHeight: 300,
            backgroundColor: AppColors.mainColor,
            flexibleSpace: FlexibleSpaceBar(
              background: Image.network(
                AppConstants.BASE_URL + "/" + _product!.img,
                fit: BoxFit.cover,
                width: double.infinity,
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.only(
                    top: Dimensions.height20,
                    left: Dimensions.width20,
                    right: Dimensions.width20,
                  ),
                  child: ExpandableTextWidget(text: _product!.desc),
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: EdgeInsets.only(
              left: Dimensions.width20 * 2.5,
              right: Dimensions.width20 * 2.5,
              top: Dimensions.height10,
              bottom: Dimensions.height10,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AppIcon(
                  iconSize: Dimensions.iconSize24,
                  iconColor: AppColors.whiteColor,
                  backgroundColor: AppColors.mainColor,
                  icon: Icons.remove,
                  // TODO: Thêm logic giảm số lượng
                ),
                BigText(
                  text:
                      "${CurrencyFormatter.formatVND(_product!.price.toDouble())} X 0",
                  color: AppColors.mainBlackColor,
                  size: Dimensions.font26,
                ),
                AppIcon(
                  iconSize: Dimensions.iconSize24,
                  iconColor: AppColors.whiteColor,
                  backgroundColor: AppColors.mainColor,
                  icon: Icons.add,
                  // TODO: Thêm logic tăng số lượng
                ),
              ],
            ),
          ),
          Container(
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
                    top: Dimensions.height10,
                    bottom: Dimensions.height10,
                    left: Dimensions.width20,
                    right: Dimensions.width20,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(Dimensions.radius10),
                    color: AppColors.whiteColor,
                  ),
                  child: Icon(
                    Icons.favorite,
                    color: Colors.red,
                    size: Dimensions.iconSize24,
                    // TODO: Thêm logic yêu thích
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    // TODO: Thêm logic thêm vào giỏ hàng
                    Get.snackbar(
                      'Thông báo',
                      'Đã thêm ${_product!.name} vào giỏ hàng',
                    );
                  },
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
                      text:
                          "${CurrencyFormatter.formatVND(_product!.price.toDouble())} | Thêm vào giỏ hàng",
                      color: AppColors.whiteColor,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
