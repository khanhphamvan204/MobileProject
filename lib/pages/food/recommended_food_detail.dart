import 'package:flutter/material.dart';
import 'package:food_ordering/Utility/color.dart';
import 'package:food_ordering/Utility/dimensions.dart';
import 'package:food_ordering/widgets/app_icon.dart';
import 'package:food_ordering/widgets/big_text.dart';
import 'package:food_ordering/widgets/expandable_text_widget.dart';

class RecommendedFoodDetail extends StatelessWidget {
  const RecommendedFoodDetail({super.key});

  @override
  Widget build(BuildContext context) {
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
                    Navigator.pop(context);
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
                  color: AppColors.whiteColor,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(Dimensions.radius20),
                    topRight: Radius.circular(Dimensions.radius20),
                  ),
                ),
                child: Center(
                  child: BigText(
                    text: 'Bún bò Huế',
                    size: Dimensions.font26,
                    color: AppColors.titleColor,
                  ),
                ),
              ),
            ),
            pinned: true,
            expandedHeight: 300,
            backgroundColor: AppColors.mainColor,
            flexibleSpace: FlexibleSpaceBar(
              background: Image.asset(
                "assets/images/food1.jpg",
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
                    left: Dimensions.width20,
                    right: Dimensions.width20,
                  ),
                  child: ExpandableTextWidget(
                    text:
                        "Bún bò Huế is a Vietnamese noodle soup consisting of rice vermicelli and beef in a spicy broth. It is one of the most popular dishes in Vietnam, especially in the central region. Bún bò Huế is a Vietnamese noodle soup consisting of rice vermicelli and beef in a spicy broth. It is one of the most popular dishes in Vietnam, especially in the central region. Bún bò Huế is a Vietnamese noodle soup consisting of rice vermicelli and beef in a spicy broth. It is one of the most popular dishes in Vietnam, especially in the central region. Bún bò Huế is a Vietnamese noodle soup consisting of rice vermicelli and beef in a spicy broth. It is one of the most popular dishes in Vietnam, especially in the central region. Bún bò Huế is a Vietnamese noodle soup consisting of rice vermicelli and beef in a spicy broth. It is one of the most popular dishes in Vietnam, especially in the central region. Bún bò Huế is a Vietnamese noodle soup consisting of rice vermicelli and beef in a spicy broth. It is one of the most popular dishes in Vietnam, especially in the central region. Bún bò Huế is a Vietnamese noodle soup consisting of rice vermicelli and beef in a spicy broth. It is one of the most popular dishes in Vietnam, especially in the central region.Bún bò Huế is a Vietnamese noodle soup consisting of rice vermicelli and beef in a spicy broth. It is one of the most popular dishes in Vietnam, especially in the central region. Bún bò Huế is a Vietnamese noodle soup consisting of rice vermicelli and beef in a spicy broth. It is one of the most popular dishes in Vietnam, especially in the central region. Bún bò Huế is a Vietnamese noodle soup consisting of rice vermicelli and beef in a spicy broth. It is one of the most popular dishes in Vietnam, especially in the central region. Bún bò Huế is a Vietnamese noodle soup consisting of rice vermicelli and beef in a spicy broth. It is one of the most popular dishes in Vietnam, especially in the central region. Bún bò Huế is a Vietnamese noodle soup consisting of rice vermicelli and beef in a spicy broth. It is one of the most popular dishes in Vietnam, especially in the central region. Bún bò Huế is a Vietnamese noodle soup consisting of rice vermicelli and beef in a spicy broth. It is one of the most popular dishes in Vietnam, especially in the central region. Bún bò Huế is a Vietnamese noodle soup consisting of rice vermicelli and beef in a spicy broth. It is one of the most popular dishes in Vietnam, especially in the central region.",
                  ),
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
                ),
                BigText(
                  text:
                      "\$12.88"
                      " X "
                      "0",
                  color: AppColors.mainBlackColor,
                  size: Dimensions.font26,
                ),
                AppIcon(
                  iconSize: Dimensions.iconSize24,
                  iconColor: AppColors.whiteColor,
                  backgroundColor: AppColors.mainColor,
                  icon: Icons.add,
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
                  child: BigText(
                    text: "\$10.0 | Add to cart",
                    color: AppColors.whiteColor,
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
