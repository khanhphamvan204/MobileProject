// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:flutter/material.dart';
// import 'package:food_ordering/Utility/app_constants.dart';
// import 'package:food_ordering/Utility/color.dart';
// import 'package:food_ordering/Utility/currency_formatter.dart';
// import 'package:food_ordering/Utility/dimensions.dart';
// import 'package:food_ordering/base/no_data_page.dart';
// import 'package:food_ordering/controllers/cart_controller.dart';
// import 'package:food_ordering/controllers/popular_product_controller.dart';
// import 'package:food_ordering/pages/home/main_food_page.dart';
// import 'package:food_ordering/routes/route_helper.dart';
// import 'package:food_ordering/widgets/app_icon.dart';
// import 'package:food_ordering/widgets/big_text.dart';
// import 'package:food_ordering/widgets/small_text.dart';
// import 'package:get/get_state_manager/src/simple/get_state.dart';
// import 'package:get/get.dart';

// class CartPage extends StatelessWidget {
//   const CartPage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Stack(
//         children: [
//           Positioned(
//             top: Dimensions.height20 * 3,
//             left: Dimensions.width20,
//             right: Dimensions.width20,
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 GestureDetector(
//                   onTap: () {
//                     Get.back();
//                   },
//                   child: AppIcon(
//                     icon: Icons.arrow_back_ios,
//                     iconColor: AppColors.whiteColor,
//                     backgroundColor: AppColors.mainColor,
//                     iconSize: Dimensions.iconSize24,
//                   ),
//                 ),
//                 SizedBox(width: Dimensions.width20 * 5),
//                 GestureDetector(
//                   onTap: () {
//                     Get.toNamed(RouteHelper.getInitial());
//                   },

//                   child: AppIcon(
//                     icon: Icons.home_outlined,
//                     iconColor: AppColors.whiteColor,
//                     backgroundColor: AppColors.mainColor,
//                     iconSize: Dimensions.iconSize24,
//                   ),
//                 ),
//                 AppIcon(
//                   icon: Icons.shopping_cart_outlined,
//                   iconColor: AppColors.whiteColor,
//                   backgroundColor: AppColors.mainColor,
//                   iconSize: Dimensions.iconSize24,
//                 ),
//               ],
//             ),
//           ),
//           GetBuilder<CartController>(
//             builder: (_cartController) {
//               return _cartController.getItems.length > 0
//                   ? Positioned(
//                     top: Dimensions.height20 * 5,
//                     left: Dimensions.width20,
//                     right: Dimensions.width20,
//                     bottom: 0,
//                     child: Container(
//                       margin: EdgeInsets.only(top: Dimensions.height15),
//                       child: MediaQuery.removePadding(
//                         context: context,
//                         removeTop: true,
//                         child: GetBuilder<CartController>(
//                           builder: (cartController) {
//                             var _cartList = cartController.getItems;
//                             return ListView.builder(
//                               itemCount: cartController.getItems.length,
//                               itemBuilder: (_, index) {
//                                 return GestureDetector(
//                                   onTap: () {
//                                     Get.toNamed(
//                                       RouteHelper.getFood(_cartList[index].id!),
//                                       arguments: _cartList[index].product,
//                                     );
//                                   },
//                                   child: Container(
//                                     height: 100,
//                                     width: double.maxFinite,
//                                     child: Row(
//                                       children: [
//                                         Container(
//                                           width: Dimensions.height20 * 5,
//                                           height: Dimensions.height20 * 5,
//                                           margin: EdgeInsets.only(
//                                             bottom: Dimensions.height10,
//                                           ),
//                                           child: CachedNetworkImage(
//                                             imageUrl:
//                                                 AppConstants.BASE_URL +
//                                                 "/" +
//                                                 _cartList[index].img!,
//                                             placeholder:
//                                                 (context, url) =>
//                                                     CircularProgressIndicator(),
//                                             errorWidget:
//                                                 (context, url, error) =>
//                                                     Icon(Icons.error),
//                                             fit: BoxFit.cover,
//                                           ),
//                                         ),
//                                         SizedBox(width: Dimensions.width10),
//                                         Expanded(
//                                           child: Container(
//                                             height: Dimensions.height20 * 5,
//                                             child: Column(
//                                               crossAxisAlignment:
//                                                   CrossAxisAlignment.start,
//                                               mainAxisAlignment:
//                                                   MainAxisAlignment.center,
//                                               children: [
//                                                 BigText(
//                                                   text: _cartList[index].name!,
//                                                   color:
//                                                       AppColors.mainBlackColor,
//                                                 ),
//                                                 SmallText(text: "Spicy"),
//                                                 Row(
//                                                   mainAxisAlignment:
//                                                       MainAxisAlignment
//                                                           .spaceBetween,
//                                                   children: [
//                                                     BigText(
//                                                       text:
//                                                           CurrencyFormatter.formatVND(
//                                                             _cartList[index]
//                                                                 .price!
//                                                                 .toDouble(),
//                                                           ),
//                                                       color:
//                                                           AppColors.mainColor,
//                                                     ),
//                                                     Container(
//                                                       // padding: EdgeInsets.only(
//                                                       //   top: Dimensions.height10,
//                                                       //   bottom: Dimensions.height10,
//                                                       //   left: Dimensions.width10,
//                                                       //   right: Dimensions.width10,
//                                                       // ),
//                                                       decoration: BoxDecoration(
//                                                         borderRadius:
//                                                             BorderRadius.circular(
//                                                               Dimensions
//                                                                   .radius20,
//                                                             ),
//                                                         color:
//                                                             AppColors
//                                                                 .whiteColor,
//                                                       ),
//                                                       child: Row(
//                                                         children: [
//                                                           GestureDetector(
//                                                             onTap: () {
//                                                               cartController.addItem(
//                                                                 cartController
//                                                                     .getItems[index]
//                                                                     .product!,
//                                                                 -1,
//                                                               );
//                                                             },
//                                                             child: Icon(
//                                                               Icons.remove,
//                                                               color:
//                                                                   AppColors
//                                                                       .signColor,
//                                                             ),
//                                                           ),
//                                                           SizedBox(
//                                                             width:
//                                                                 Dimensions
//                                                                     .width10 /
//                                                                 2,
//                                                           ),
//                                                           BigText(
//                                                             text:
//                                                                 _cartList[index]
//                                                                     .quantity
//                                                                     .toString(),
//                                                             // popularProduct.inCartItems
//                                                             //     .toString(),
//                                                           ),
//                                                           SizedBox(
//                                                             width:
//                                                                 Dimensions
//                                                                     .width10 /
//                                                                 2,
//                                                           ),
//                                                           GestureDetector(
//                                                             onTap: () {
//                                                               cartController.addItem(
//                                                                 cartController
//                                                                     .getItems[index]
//                                                                     .product!,
//                                                                 1,
//                                                               );
//                                                             },
//                                                             child: Icon(
//                                                               Icons.add,
//                                                               color:
//                                                                   AppColors
//                                                                       .signColor,
//                                                             ),
//                                                           ),
//                                                         ],
//                                                       ),
//                                                     ),
//                                                   ],
//                                                 ),
//                                               ],
//                                             ),
//                                           ),
//                                         ),
//                                       ],
//                                     ),
//                                   ),
//                                 );
//                               },
//                             );
//                           },
//                         ),
//                       ),
//                     ),
//                   )
//                   : NoDataPage(text: "Giỏ hàng trống");
//             },
//           ),
//         ],
//       ),
//       bottomNavigationBar: GetBuilder<CartController>(
//         builder: (cartController) {
//           return Container(
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
//                     top: Dimensions.height15,
//                     bottom: Dimensions.height15,
//                     left: Dimensions.width15,
//                     right: Dimensions.width15,
//                   ),
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(Dimensions.radius15),
//                     color: AppColors.whiteColor,
//                   ),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       SizedBox(width: Dimensions.width10 / 2),
//                       // BigText(text: popularProduct.inCartItems.toString()),
//                       BigText(
//                         text: CurrencyFormatter.formatVND(
//                           cartController.totalAmount.toDouble(),
//                         ),
//                       ),
//                       SizedBox(width: Dimensions.width10 / 2),
//                     ],
//                   ),
//                 ),
//                 GestureDetector(
//                   onTap: () {
//                     cartController.addToCartHistory();
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
//                     child: GestureDetector(
//                       onTap: () {
//                         // popularProduct.addItem(product);
//                       },
//                       child: BigText(
//                         text: "Thanh toán",
//                         color: AppColors.whiteColor,
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           );
//         },
//       ),
//     );
//   }
// }

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:food_ordering/Utility/app_constants.dart';
import 'package:food_ordering/Utility/color.dart';
import 'package:food_ordering/Utility/currency_formatter.dart';
import 'package:food_ordering/Utility/dimensions.dart';
import 'package:food_ordering/base/no_data_page.dart';
import 'package:food_ordering/controllers/cart_controller.dart';
import 'package:food_ordering/controllers/popular_product_controller.dart';
import 'package:food_ordering/pages/home/main_food_page.dart';
import 'package:food_ordering/routes/route_helper.dart';
import 'package:food_ordering/widgets/app_icon.dart';
import 'package:food_ordering/widgets/big_text.dart';
import 'package:food_ordering/widgets/small_text.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:get/get.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            top: Dimensions.height20 * 3,
            left: Dimensions.width20,
            right: Dimensions.width20,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    Get.back();
                  },
                  child: AppIcon(
                    icon: Icons.arrow_back_ios,
                    iconColor: AppColors.whiteColor,
                    backgroundColor: AppColors.mainColor,
                    iconSize: Dimensions.iconSize24,
                  ),
                ),
                SizedBox(width: Dimensions.width20 * 5),
                GestureDetector(
                  onTap: () {
                    Get.toNamed(RouteHelper.getInitial());
                  },

                  child: AppIcon(
                    icon: Icons.home_outlined,
                    iconColor: AppColors.whiteColor,
                    backgroundColor: AppColors.mainColor,
                    iconSize: Dimensions.iconSize24,
                  ),
                ),
                AppIcon(
                  icon: Icons.shopping_cart_outlined,
                  iconColor: AppColors.whiteColor,
                  backgroundColor: AppColors.mainColor,
                  iconSize: Dimensions.iconSize24,
                ),
              ],
            ),
          ),
          GetBuilder<CartController>(
            builder: (_cartController) {
              return _cartController.getItems.length > 0
                  ? Positioned(
                    top: Dimensions.height20 * 5,
                    left: Dimensions.width20,
                    right: Dimensions.width20,
                    bottom: 0,
                    child: Container(
                      margin: EdgeInsets.only(top: Dimensions.height15),
                      child: MediaQuery.removePadding(
                        context: context,
                        removeTop: true,
                        child: GetBuilder<CartController>(
                          builder: (cartController) {
                            var _cartList = cartController.getItems;
                            return ListView.builder(
                              itemCount: cartController.getItems.length,
                              itemBuilder: (_, index) {
                                return GestureDetector(
                                  onTap: () {
                                    Get.toNamed(
                                      RouteHelper.getFood(_cartList[index].id!),
                                      arguments: _cartList[index].product,
                                    );
                                  },
                                  child: Container(
                                    height: 100,
                                    width: double.maxFinite,
                                    child: Row(
                                      children: [
                                        Container(
                                          width: Dimensions.height20 * 5,
                                          height: Dimensions.height20 * 5,
                                          margin: EdgeInsets.only(
                                            bottom: Dimensions.height10,
                                          ),
                                          child: CachedNetworkImage(
                                            imageUrl:
                                                AppConstants.BASE_URL +
                                                "/" +
                                                _cartList[index].img!,
                                            placeholder:
                                                (context, url) =>
                                                    CircularProgressIndicator(),
                                            errorWidget:
                                                (context, url, error) =>
                                                    Icon(Icons.error),
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                        SizedBox(width: Dimensions.width10),
                                        Expanded(
                                          child: Container(
                                            height: Dimensions.height20 * 5,
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                BigText(
                                                  text: _cartList[index].name!,
                                                  color:
                                                      AppColors.mainBlackColor,
                                                ),
                                                SmallText(text: "Spicy"),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    BigText(
                                                      text:
                                                          CurrencyFormatter.formatVND(
                                                            _cartList[index]
                                                                .price!
                                                                .toDouble(),
                                                          ),
                                                      color:
                                                          AppColors.mainColor,
                                                    ),
                                                    Container(
                                                      // padding: EdgeInsets.only(
                                                      //   top: Dimensions.height10,
                                                      //   bottom: Dimensions.height10,
                                                      //   left: Dimensions.width10,
                                                      //   right: Dimensions.width10,
                                                      // ),
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                              Dimensions
                                                                  .radius20,
                                                            ),
                                                        color:
                                                            AppColors
                                                                .whiteColor,
                                                      ),
                                                      child: Row(
                                                        children: [
                                                          GestureDetector(
                                                            onTap: () {
                                                              cartController.addItem(
                                                                cartController
                                                                    .getItems[index]
                                                                    .product!,
                                                                -1,
                                                              );
                                                            },
                                                            child: Icon(
                                                              Icons.remove,
                                                              color:
                                                                  AppColors
                                                                      .signColor,
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            width:
                                                                Dimensions
                                                                    .width10 /
                                                                2,
                                                          ),
                                                          BigText(
                                                            text:
                                                                _cartList[index]
                                                                    .quantity
                                                                    .toString(),
                                                            // popularProduct.inCartItems
                                                            //     .toString(),
                                                          ),
                                                          SizedBox(
                                                            width:
                                                                Dimensions
                                                                    .width10 /
                                                                2,
                                                          ),
                                                          GestureDetector(
                                                            onTap: () {
                                                              cartController.addItem(
                                                                cartController
                                                                    .getItems[index]
                                                                    .product!,
                                                                1,
                                                              );
                                                            },
                                                            child: Icon(
                                                              Icons.add,
                                                              color:
                                                                  AppColors
                                                                      .signColor,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                        ),
                      ),
                    ),
                  )
                  : NoDataPage(text: "Giỏ hàng trống");
            },
          ),
        ],
      ),
      bottomNavigationBar: GetBuilder<CartController>(
        builder: (cartController) {
          return Container(
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
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.1),
                  spreadRadius: 1,
                  blurRadius: 10,
                  offset: Offset(0, -2),
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Container hiển thị tổng tiền - làm đẹp hơn
                Container(
                  padding: EdgeInsets.only(
                    top: Dimensions.height15,
                    bottom: Dimensions.height15,
                    left: Dimensions.width20,
                    right: Dimensions.width20,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(Dimensions.radius15),
                    color: AppColors.whiteColor,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.1),
                        spreadRadius: 1,
                        blurRadius: 5,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.attach_money,
                        color: AppColors.mainColor,
                        size: Dimensions.iconSize16,
                      ),
                      SizedBox(width: Dimensions.width10 / 2),
                      BigText(
                        text: CurrencyFormatter.formatVND(
                          cartController.totalAmount.toDouble(),
                        ),
                        color: AppColors.mainColor,
                      ),
                    ],
                  ),
                ),
                // Nút thanh toán - làm đẹp hơn
                GestureDetector(
                  onTap: () {
                    cartController.addToCartHistory();
                  },
                  child: Container(
                    padding: EdgeInsets.only(
                      top: Dimensions.height15,
                      bottom: Dimensions.height15,
                      left: Dimensions.width20,
                      right: Dimensions.width20,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(Dimensions.radius20),
                      gradient: LinearGradient(
                        colors: [
                          AppColors.mainColor,
                          AppColors.mainColor.withOpacity(0.8),
                        ],
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.mainColor.withOpacity(0.3),
                          spreadRadius: 1,
                          blurRadius: 8,
                          offset: Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.shopping_bag_outlined,
                          color: AppColors.whiteColor,
                          size: Dimensions.iconSize16,
                        ),
                        SizedBox(width: Dimensions.width10),
                        BigText(
                          text: "Thanh toán",
                          color: AppColors.whiteColor,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
