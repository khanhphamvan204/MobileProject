import 'package:flutter/material.dart';
import 'package:food_ordering/Utility/color.dart';
import 'package:food_ordering/Utility/dimensions.dart';
import 'package:food_ordering/widgets/app_column.dart';
import 'package:food_ordering/widgets/app_icon.dart';
import 'package:food_ordering/widgets/big_text.dart';
import 'package:food_ordering/widgets/expandable_text_widget.dart';
import 'package:food_ordering/widgets/icon_and_text_widget.dart';
import 'package:food_ordering/widgets/small_text.dart';

class PopularFoodDetail extends StatelessWidget {
  const PopularFoodDetail({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // Background Image
          Positioned(
            left: 0,
            right: 0,
            child: Container(
              width: double.infinity,
              height: Dimensions.popularFoodImgSize,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/images/food1.jpg"),
                  fit: BoxFit.cover,
                ),
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
                AppIcon(icon: Icons.arrow_back_ios),
                AppIcon(icon: Icons.shopping_cart_outlined),
              ],
            ),
          ),
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
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(Dimensions.radius20),
                  topRight: Radius.circular(Dimensions.radius20),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppColumn(text: "Bún bò Huế"),
                  SizedBox(height: Dimensions.height20),
                  BigText(text: "Introduce"),
                  SizedBox(height: Dimensions.height10),
                  Expanded(
                    child: SingleChildScrollView(
                      child: ExpandableTextWidget(
                        text:
                            "Bún bò Huế is a Vietnamese noodle soup consisting of rice vermicelli and beef in a spicy broth. It is one of the most popular dishes in Vietnam, especially in the central region. Bún bò Huế is a Vietnamese noodle soup consisting of rice vermicelli and beef in a spicy broth. It is one of the most popular dishes in Vietnam, especially in the central region. Bún bò Huế is a Vietnamese noodle soup consisting of rice vermicelli and beef in a spicy broth. It is one of the most popular dishes in Vietnam, especially in the central region. Bún bò Huế is a Vietnamese noodle soup consisting of rice vermicelli and beef in a spicy broth. It is one of the most popular dishes in Vietnam, especially in the central region. Bún bò Huế is a Vietnamese noodle soup consisting of rice vermicelli and beef in a spicy broth. It is one of the most popular dishes in Vietnam, especially in the central region. Bún bò Huế is a Vietnamese noodle soup consisting of rice vermicelli and beef in a spicy broth. It is one of the most popular dishes in Vietnam, especially in the central region. Bún bò Huế is a Vietnamese noodle soup consisting of rice vermicelli and beef in a spicy broth. It is one of the most popular dishes in Vietnam, especially in the central region.",
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Food Details
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
                color: Colors.white,
              ),
              child: Row(
                children: [
                  Icon(Icons.remove, color: AppColors.signColor),
                  SizedBox(width: Dimensions.width10 / 2),
                  BigText(text: "0"),
                  SizedBox(width: Dimensions.width10 / 2),
                  Icon(Icons.add, color: AppColors.signColor),
                ],
              ),
            ),
            Container(
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
              child: BigText(text: "\$10.0 | Add to cart", color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
