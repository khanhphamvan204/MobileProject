import 'package:flutter/material.dart';
import 'package:food_ordering/Utility/dimensions.dart';
import 'package:food_ordering/pages/home/food_page_body.dart';
import 'package:food_ordering/Utility/color.dart';
import 'package:food_ordering/widgets/big_text.dart';
import 'package:food_ordering/widgets/small_text.dart';
import 'package:food_ordering/widgets/theme_toggle_button.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:food_ordering/Utility/app_constants.dart';

class MainFoodPage extends StatefulWidget {
  const MainFoodPage({super.key});

  @override
  _MainFoodPage createState() => _MainFoodPage();
}

class _MainFoodPage extends State<MainFoodPage> {
  final CarouselSliderController _carouselController =
      CarouselSliderController();
  int _currentIndex = 0;

  final List<String> imageUrls = [
    'assets/images/banner1.webp',
    'assets/images/banner2.webp',
    'assets/images/banner3.webp',
    'assets/images/banner4.webp',
  ];

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
                      Image.asset(
                        "assets/images/logo.png",
                        width: Dimensions.height20 * 3,
                        height: Dimensions.height20 * 3,
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
                  Container(
                    alignment: Alignment.centerRight,
                    padding: EdgeInsets.symmetric(
                      vertical: Dimensions.height10,
                      horizontal: Dimensions.width20,
                    ),
                    child: ThemeToggleButton(),
                  ),
                  Center(
                    child: Container(
                      width: Dimensions.height45,
                      height: Dimensions.height45,
                      child: Icon(
                        Icons.search,
                        color: AppColors.whiteColor,
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
          // Đặt carousel và dots bên trong SingleChildScrollView
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  // Carousel
                  Stack(
                    children: [
                      CarouselSlider(
                        carouselController: _carouselController,
                        options: CarouselOptions(
                          height: 200.0,
                          autoPlay: true,
                          autoPlayInterval: Duration(seconds: 3),
                          enlargeCenterPage: true,
                          viewportFraction: 0.9,
                          aspectRatio: 2.0,
                          enableInfiniteScroll: true,
                          onPageChanged: (index, reason) {
                            setState(() {
                              _currentIndex = index;
                            });
                          },
                        ),
                        items:
                            imageUrls.map((imageUrl) {
                              return Builder(
                                builder: (BuildContext context) {
                                  return Container(
                                    margin: EdgeInsets.symmetric(
                                      horizontal: 5.0,
                                    ),
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: AppColors.mainColor,
                                        width: 2,
                                      ),
                                      borderRadius: BorderRadius.circular(
                                        Dimensions.radius15,
                                      ),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.withOpacity(0.3),
                                          blurRadius: 5,
                                          offset: Offset(0, 3),
                                        ),
                                      ],
                                    ),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(
                                        Dimensions.radius15,
                                      ),
                                      child: Image.asset(
                                        imageUrl,
                                        fit: BoxFit.cover,
                                        width: double.infinity,
                                        height: 200,
                                        errorBuilder:
                                            (context, error, stackTrace) =>
                                                Container(
                                                  color: Colors.grey[200],
                                                  child: Center(
                                                    child: Icon(
                                                      Icons.error,
                                                      color:
                                                          AppColors.mainColor,
                                                      size: 50,
                                                    ),
                                                  ),
                                                ),
                                      ),
                                    ),
                                  );
                                },
                              );
                            }).toList(),
                      ),
                      // Nút điều hướng trái
                      Positioned(
                        left: 10,
                        top: 80,
                        child: IconButton(
                          icon: Icon(
                            Icons.arrow_left,
                            color: AppColors.mainColor,
                            size: 40,
                          ),
                          onPressed: () {
                            _carouselController.previousPage();
                          },
                        ),
                      ),
                      // Nút điều hướng phải
                      Positioned(
                        right: 10,
                        top: 80,
                        child: IconButton(
                          icon: Icon(
                            Icons.arrow_right,
                            color: AppColors.mainColor,
                            size: 40,
                          ),
                          onPressed: () {
                            _carouselController.nextPage();
                          },
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: Dimensions.height10),
                  // Dots chỉ thị
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children:
                        imageUrls.asMap().entries.map((entry) {
                          int index = entry.key;
                          return Container(
                            width: _currentIndex == index ? 12.0 : 8.0,
                            height: 8.0,
                            margin: EdgeInsets.symmetric(horizontal: 4.0),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color:
                                  _currentIndex == index
                                      ? AppColors.mainColor
                                      : Colors.grey,
                            ),
                          );
                        }).toList(),
                  ),
                  SizedBox(height: Dimensions.height20),
                  BigText(
                    text: "BẠN SẼ THÍCH",
                    size: Dimensions.font26,
                    color: AppColors.blackColor,
                  ),
                  SizedBox(height: Dimensions.height20),
                  FoodPageBody(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
