import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:food_ordering/Utility/app_constants.dart';
import 'package:food_ordering/Utility/color.dart';
import 'package:food_ordering/Utility/dimensions.dart';
import 'package:food_ordering/base/no_data_page.dart';
import 'package:food_ordering/controllers/cart_controller.dart';
import 'package:food_ordering/models/cart_model.dart';
import 'package:food_ordering/routes/route_helper.dart';
import 'package:food_ordering/widgets/app_icon.dart';
import 'package:food_ordering/widgets/big_text.dart';
import 'package:food_ordering/widgets/small_text.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:intl/intl.dart';

class CartHistory extends StatefulWidget {
  const CartHistory({super.key});

  @override
  State<CartHistory> createState() => _CartHistoryState();
}

class _CartHistoryState extends State<CartHistory> {
  @override
  Widget build(BuildContext context) {
    var getCartHistoryList =
        Get.find<CartController>().getCartHistoryList().reversed.toList();
    // Lấy danh sách đơn hàng từ CartController
    // var getCartHistoryList = Get.find<CartController>().getCartHistoryList();

    // Tạo một Map để đếm số lượng item trong mỗi đơn hàng theo thời gian
    Map<String, int> cartItemsPerOrder = Map();

    // Đếm số lượng item trong mỗi đơn hàng theo thời gian
    for (int i = 0; i < getCartHistoryList.length; i++) {
      // String time = getCartHistoryList[i].time.toString();
      if (cartItemsPerOrder.containsKey(getCartHistoryList[i].time)) {
        cartItemsPerOrder.update(
          getCartHistoryList[i].time.toString(),
          (value) => ++value,
        );
      } else {
        cartItemsPerOrder.putIfAbsent(
          getCartHistoryList[i].time.toString(),
          () => 1,
        );
      }
    }

    // Hàm chuyển số lượng item theo thời gian thành danh sách
    List<int> cartItemsPerOrderToList() {
      return cartItemsPerOrder.values.toList();
    }

    List<String> cartOrderTimeToList() {
      return cartItemsPerOrder.entries.map((entry) => entry.key).toList();
    }

    // Lấy danh sách số lượng item theo đơn hàng
    List<int> orderTimes = cartItemsPerOrderToList();

    int saveCounter = 0;

    // In ra các item theo từng đơn hàng
    for (int x = 0; x < cartItemsPerOrder.length; x++) {
      for (int y = 0; y < orderTimes[x]; y++) {
        print("inner loop y index: ${y}");
        print("My order is: ${getCartHistoryList[saveCounter++]}");
      }
    }
    var listCounter = 0;
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Container(
              height: Dimensions.height20 * 5,
              color: AppColors.mainColor,
              width: double.maxFinite,
              padding: EdgeInsets.only(top: Dimensions.height45),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  BigText(text: "Đơn hàng", color: Colors.white),
                  GestureDetector(
                    onTap: () {
                      Get.toNamed(RouteHelper.getCartPage());
                    },
                    child: AppIcon(
                      icon: Icons.shopping_cart_outlined,
                      iconColor: Colors.white,
                      backgroundColor: AppColors.mainColor,
                      iconSize: Dimensions.iconSize24,
                    ),
                  ),
                ],
              ),
            ),
            GetBuilder<CartController>(
              builder: (_cartConTroller) {
                var cartLength = _cartConTroller.getCartHistoryList();
                return cartLength.length > 0
                    ? Expanded(
                      child: Container(
                        margin: EdgeInsets.only(
                          top: Dimensions.height20,
                          left: Dimensions.width20,
                          right: Dimensions.width20,
                        ),
                        child: MediaQuery.removePadding(
                          removeTop: true,
                          context: context,
                          child: ListView(
                            children: [
                              for (int i = 0; i < cartItemsPerOrder.length; i++)
                                Container(
                                  height: Dimensions.height20 * 7,
                                  margin: EdgeInsets.only(
                                    bottom: Dimensions.height20,
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      (() {
                                        DateTime parseDate = DateFormat(
                                          "yyyy-MM-dd HH:mm:ss",
                                        ).parse(
                                          cartItemsPerOrder.keys.elementAt(i),
                                        );
                                        var inputDate = DateTime.parse(
                                          parseDate.toString(),
                                        );
                                        DateFormat dateFormat = DateFormat(
                                          "dd/MM/yyyy hh:mm a",
                                        );
                                        var outputDate = dateFormat.format(
                                          inputDate,
                                        );

                                        return BigText(
                                          text: outputDate,
                                          color: AppColors.titleColor,
                                        );
                                      })(),
                                      SizedBox(height: Dimensions.height10),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Wrap(
                                            direction: Axis.horizontal,
                                            children: List.generate(
                                              cartItemsPerOrder.values
                                                  .elementAt(i),
                                              (index) {
                                                if (listCounter <
                                                    getCartHistoryList.length) {
                                                  listCounter++;
                                                }
                                                return index <= 2
                                                    ? Container(
                                                      height:
                                                          Dimensions.height20 *
                                                          5,
                                                      width:
                                                          Dimensions.width20 *
                                                          9,
                                                      margin: EdgeInsets.only(
                                                        right:
                                                            Dimensions.width10 /
                                                            2,
                                                      ),
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                              Dimensions
                                                                  .radius10,
                                                            ),
                                                        image: DecorationImage(
                                                          fit: BoxFit.cover,
                                                          image: CachedNetworkImageProvider(
                                                            AppConstants
                                                                    .BASE_URL +
                                                                "/" +
                                                                getCartHistoryList[listCounter -
                                                                        1]
                                                                    .img!,
                                                          ),
                                                        ),
                                                      ),
                                                    )
                                                    : Container();
                                              },
                                            ),
                                          ),
                                          Container(
                                            height: Dimensions.height20 * 4,
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.end,
                                              children: [
                                                SmallText(
                                                  text: "Tổng",
                                                  color: AppColors.titleColor,
                                                ),
                                                BigText(
                                                  text:
                                                      "${cartItemsPerOrder.values.elementAt(i)} sản phẩm",
                                                  color: AppColors.titleColor,
                                                ),
                                                GestureDetector(
                                                  onTap: () {
                                                    var orderTime =
                                                        cartOrderTimeToList()[i];
                                                    Map<int, CartModel>
                                                    moreOrder = {};
                                                    for (
                                                      int j = 0;
                                                      j <
                                                          getCartHistoryList
                                                              .length;
                                                      j++
                                                    ) {
                                                      if (getCartHistoryList[j]
                                                              .time ==
                                                          orderTime) {
                                                        moreOrder.putIfAbsent(
                                                          getCartHistoryList[j]
                                                              .id!,
                                                          () => CartModel.fromJson(
                                                            jsonDecode(
                                                              jsonEncode(
                                                                (getCartHistoryList[j]),
                                                              ),
                                                            ),
                                                          ),
                                                        );
                                                      }
                                                    }
                                                    Get.find<CartController>()
                                                        .setItems = moreOrder;
                                                    Get.find<CartController>()
                                                        .addToCartList();
                                                    Get.toNamed(
                                                      RouteHelper.getCartPage(),
                                                    );
                                                  },
                                                  child: Container(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                          horizontal:
                                                              Dimensions
                                                                  .width10,
                                                          vertical:
                                                              Dimensions
                                                                  .height10 /
                                                              2,
                                                        ),
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                            Dimensions
                                                                    .radius15 /
                                                                2,
                                                          ),
                                                      border: Border.all(
                                                        width: 1,
                                                        color:
                                                            AppColors.mainColor,
                                                      ),
                                                    ),
                                                    child: SmallText(
                                                      text: "Mua lại",
                                                      color:
                                                          AppColors.mainColor,
                                                    ),
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
                            ],
                          ),
                        ),
                      ),
                    )
                    : SizedBox(
                      height: MediaQuery.of(context).size.height / 1.5,
                      child: Center(
                        child: NoDataPage(
                          text: "Bạn chưa mua đơn hàng nào",
                          imgPath: "assets/images/empty_box.png",
                        ),
                      ),
                    );
              },
            ),
          ],
        ),
      ),
    );
  }
}
