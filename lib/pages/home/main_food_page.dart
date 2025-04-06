import 'package:flutter/material.dart';
import 'package:food_ordering/Utility/dimensions.dart';
import 'package:food_ordering/pages/home/food_page_body.dart';
import 'package:food_ordering/Utility/color.dart';
import 'package:food_ordering/widgets/big_text.dart';
import 'package:food_ordering/widgets/small_text.dart';

class MainFoodPage extends StatefulWidget {
  const MainFoodPage({super.key});

  @override
  _MainFoodPage createState() => _MainFoodPage();
}

class _MainFoodPage extends State<MainFoodPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            child: Container(
              margin: EdgeInsets.only(
                top: Dimensions.height45,
                bottom: Dimensions.radius15,
              ),
              padding: EdgeInsets.only(
                left: Dimensions.width20,
                right: Dimensions.width20,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      Text(
                        "Feliciano",
                        style: TextStyle(
                          fontSize: Dimensions.font26,
                          fontFamily: "GreatVibes",
                          color: AppColors.mainColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Row(
                        children: [
                          SmallText(
                            text: "Hồ Chí Minh",
                            color: AppColors.textColor,
                          ),
                          Icon(
                            Icons.arrow_drop_down_rounded,
                            color: AppColors.textColor,
                          ),
                        ],
                      ),
                    ],
                  ),
                  Center(
                    child: Container(
                      width: Dimensions.height45,
                      height: Dimensions.height45,
                      child: Icon(
                        Icons.search,
                        color: Colors.white,
                        size: Dimensions.iconSize24,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(
                          Dimensions.radius15,
                        ),
                        color: AppColors.mainColor,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(child: SingleChildScrollView(child: FoodPageBody())),
        ],
      ),
    );
  }
}
