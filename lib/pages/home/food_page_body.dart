// import 'package:dots_indicator/dots_indicator.dart';
// import 'package:flutter/material.dart';
// import 'package:food_ordering/Utility/color.dart';
// import 'package:food_ordering/Utility/dimensions.dart';
// import 'package:food_ordering/controllers/theme_controller.dart';
// import 'package:food_ordering/pages/food/popular_food_detail.dart';
// import 'package:food_ordering/routes/route_helper.dart';
// import 'package:food_ordering/widgets/app_column.dart';
// import 'package:food_ordering/widgets/big_text.dart';
// import 'package:food_ordering/widgets/icon_and_text_widget.dart';
// import 'package:food_ordering/widgets/small_text.dart';
// import 'package:food_ordering/widgets/theme_toggle_button.dart';
// import 'package:get/get.dart';

// class FoodPageBody extends StatefulWidget {
//   const FoodPageBody({super.key});

//   @override
//   _FoodPageBodyState createState() => _FoodPageBodyState();
// }

// class _FoodPageBodyState extends State<FoodPageBody> {
//   PageController pageController = PageController(viewportFraction: 0.85);
//   var _currPageValue = 0.0;
//   final double _scaleFactor = 0.8;
//   final double _height = Dimensions.pageViewContainer;

//   final ThemeController themeController = Get.find();

//   final List<Map<String, String>> foodItems = [
//     {
//       'name': 'Phở Bò',
//       'description':
//           'Phở Bò - một món ăn truyền thống nổi tiếng của Việt Nam, được chế biến từ nước dùng thơm ngon hầm từ xương bò trong nhiều giờ, kết hợp với bánh phở mềm mịn, thịt bò tươi thái mỏng, và các loại rau thơm như húng quế, ngò gai, cùng chút chanh và ớt để tăng hương vị. Đây là món ăn không chỉ mang đậm nét văn hóa ẩm thực Việt mà còn được yêu thích trên toàn thế giới nhờ sự hòa quyện tinh tế giữa các nguyên liệu.',
//       'image': 'assets/images/food1.jpg',
//     },
//     {
//       'name': 'Bún Chả',
//       'description':
//           'Bún Chả là đặc sản Hà Nội với sự kết hợp hoàn hảo giữa chả nướng thơm lừng được làm từ thịt heo xay ướp gia vị đậm đà, nướng trên than hoa tạo mùi hương quyến rũ, ăn kèm với bún tươi mềm mại và nước mắm chua ngọt pha chế khéo léo. Đi cùng là rau sống tươi mát và chút dưa góp giòn tan, tạo nên một trải nghiệm ẩm thực vừa dân dã vừa tinh tế, khiến thực khách nhớ mãi không quên.',
//       'image': 'assets/images/food2.jpg',
//     },
//     {
//       'name': 'Bánh Mì',
//       'description':
//           'Bánh Mì Việt Nam là một biểu tượng ẩm thực đường phố, nổi bật với lớp vỏ bánh giòn rụm bên ngoài, mềm bên trong, được kẹp đầy ắp nhân thịt heo quay, pate béo ngậy, dưa leo, rau mùi, cà rốt ngâm chua, và một chút tương ớt cay nồng. Sự kết hợp giữa phong cách Pháp và hương vị Việt tạo nên một món ăn vừa quen thuộc vừa độc đáo, được lòng cả người dân địa phương lẫn du khách quốc tế.',
//       'image': 'assets/images/food3.jpg',
//     },
//     {
//       'name': 'Gỏi Cuốn',
//       'description':
//           'Gỏi Cuốn, hay còn gọi là nem cuốn, là món ăn nhẹ lành mạnh với bánh tráng mỏng dai được cuốn quanh nhân tôm luộc, thịt heo, bún tươi, rau sống và các loại thảo mộc như húng quế, rau diếp. Món ăn này thường được chấm với nước mắm pha hoặc tương đậu phộng béo ngậy, mang đến hương vị tươi mát, nhẹ nhàng nhưng đầy đủ chất dinh dưỡng, rất phù hợp cho những ngày hè oi bức hay bữa ăn nhẹ trong ngày.',
//       'image': 'assets/images/food4.jpg',
//     },
//     {
//       'name': 'Cơm Tấm',
//       'description':
//           'Cơm Tấm là đặc sản miền Nam, đặc biệt nổi tiếng ở Sài Gòn, được làm từ những hạt gạo tấm nhỏ, thơm, dẻo, ăn kèm với sườn nướng thấm đẫm gia vị, trứng ốp la béo ngậy, chả trứng mềm mịn, và các loại topping như mỡ hành, dưa chua. Điểm nhấn là chén nước mắm ngọt thanh, hơi cay, rưới lên cơm, tạo nên một món ăn dân dã nhưng đầy đủ hương vị, làm hài lòng mọi thực khách khó tính nhất.',
//       'image': 'assets/images/food5.jpg',
//     },
//   ];

//   @override
//   void initState() {
//     super.initState();
//     pageController.addListener(() {
//       if (mounted) {
//         setState(() {
//           _currPageValue = pageController.page!;
//         });
//       }
//     });
//   }

//   @override
//   void dispose() {
//     pageController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Obx(
//       () => Container(
//         child: Column(
//           children: [
//             Container(
//               height: Dimensions.pageView,
//               child: PageView.builder(
//                 controller: pageController,
//                 itemCount: foodItems.length,
//                 itemBuilder: (context, position) {
//                   return _buildPageItem(position);
//                 },
//               ),
//             ),
//             DotsIndicator(
//               dotsCount: foodItems.length,
//               position: _currPageValue,
//               decorator: DotsDecorator(
//                 activeColor: AppColors.mainColor,
//                 color: Colors.grey[300]!,
//                 size: const Size.square(9.0),
//                 activeSize: const Size(18.0, 9.0),
//                 activeShape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(5.0),
//                 ),
//               ),
//             ),
//             SizedBox(height: Dimensions.height30),
//             Container(
//               margin: EdgeInsets.only(left: Dimensions.width30),
//               child: Row(
//                 crossAxisAlignment: CrossAxisAlignment.end,
//                 children: [
//                   BigText(text: "Popular", color: AppColors.mainBlackColor),
//                   SizedBox(width: Dimensions.width10),
//                   Container(
//                     margin: EdgeInsets.only(bottom: 3),
//                     child: BigText(text: ".", color: AppColors.popularDotColor),
//                   ),
//                   SizedBox(width: Dimensions.width10),
//                   Container(
//                     margin: EdgeInsets.only(bottom: 2),
//                     child: SmallText(
//                       text: "Food Pairing",
//                       color: AppColors.textColor,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             ListView.builder(
//               physics: NeverScrollableScrollPhysics(),
//               shrinkWrap: true,
//               itemCount: foodItems.length,
//               itemBuilder: (context, index) {
//                 final foodItem = foodItems[index];
//                 return GestureDetector(
//                   onTap: () {
//                     Get.toNamed(RouteHelper.getRecommendedFood());
//                   },
//                   child: Container(
//                     margin: EdgeInsets.only(
//                       left: Dimensions.width20,
//                       right: Dimensions.width20,
//                       bottom: Dimensions.height10,
//                     ),
//                     child: Row(
//                       children: [
//                         Container(
//                           width: Dimensions.listViewImgSize,
//                           height: Dimensions.listViewImgSize,
//                           decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(
//                               Dimensions.radius20,
//                             ),
//                             color: Colors.white38,
//                             image: DecorationImage(
//                               fit: BoxFit.cover,
//                               image: AssetImage(foodItem['image']!),
//                             ),
//                           ),
//                         ),
//                         Expanded(
//                           child: Container(
//                             height: Dimensions.listViewTextContSize,
//                             decoration: BoxDecoration(
//                               borderRadius: BorderRadius.only(
//                                 topRight: Radius.circular(Dimensions.radius20),
//                                 bottomRight: Radius.circular(
//                                   Dimensions.radius20,
//                                 ),
//                               ),
//                               color: AppColors.listItemBackground,
//                               boxShadow: [
//                                 BoxShadow(
//                                   color: AppColors.shadowColor.withOpacity(
//                                     0.05,
//                                   ),
//                                   blurRadius: 5,
//                                   offset: Offset(2, 2),
//                                 ),
//                               ],
//                             ),
//                             child: Padding(
//                               padding: EdgeInsets.only(
//                                 left: Dimensions.width10,
//                                 right: Dimensions.width10,
//                                 top: Dimensions.height10,
//                                 bottom: Dimensions.height10,
//                               ),
//                               child: Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 mainAxisAlignment: MainAxisAlignment.center,
//                                 children: [
//                                   BigText(
//                                     text: foodItem['name']!,
//                                     color: AppColors.mainBlackColor,
//                                   ),
//                                   SizedBox(height: Dimensions.height5),
//                                   SmallText(
//                                     text:
//                                         foodItem['description']!.substring(
//                                           0,
//                                           50,
//                                         ) +
//                                         "...",
//                                     color: AppColors.paraColor,
//                                   ),
//                                   SizedBox(height: Dimensions.height10),
//                                 ],
//                               ),
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 );
//               },
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildPageItem(int index) {
//     final foodItem = foodItems[index];

//     Matrix4 matrix = Matrix4.identity();
//     if (index == _currPageValue.floor()) {
//       var currScale = 1 - (_currPageValue - index) * (1 - _scaleFactor);
//       var currTrans = _height * (1 - currScale) / 2;
//       matrix = Matrix4.diagonal3Values(1, currScale, 1)
//         ..setTranslationRaw(0, currTrans, 0);
//     } else if (index == _currPageValue.floor() + 1) {
//       var currScale =
//           _scaleFactor + (_currPageValue - index + 1) * (1 - _scaleFactor);
//       var currTrans = _height * (1 - currScale) / 2;
//       matrix = Matrix4.diagonal3Values(1, currScale, 1)
//         ..setTranslationRaw(0, currTrans, 0);
//     } else if (index == _currPageValue.floor() - 1) {
//       var currScale = 1 - (_currPageValue - index) * (1 - _scaleFactor);
//       var currTrans = _height * (1 - currScale) / 2;
//       matrix = Matrix4.diagonal3Values(1, currScale, 1)
//         ..setTranslationRaw(0, currTrans, 0);
//     } else {
//       var currScale = 0.8;
//       matrix = Matrix4.diagonal3Values(1, currScale, 1)
//         ..setTranslationRaw(0, _height * (1 - _scaleFactor) / 2, 0);
//     }

//     return Transform(
//       transform: matrix,
//       child: Stack(
//         children: [
//           GestureDetector(
//             onTap: () {
//               Get.toNamed(RouteHelper.getPopularFood(index));
//             },
//             child: Container(
//               height: Dimensions.pageViewContainer,
//               margin: EdgeInsets.only(
//                 left: Dimensions.width10,
//                 right: Dimensions.width10,
//               ),
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(Dimensions.radius30),
//                 color:
//                     index.isEven
//                         ? AppColors.pageViewContainerColor1
//                         : AppColors.pageViewContainerColor2,
//                 image: DecorationImage(
//                   fit: BoxFit.cover,
//                   image: AssetImage(foodItem['image']!),
//                 ),
//               ),
//             ),
//           ),
//           Align(
//             alignment: Alignment.bottomCenter,
//             child: Container(
//               height: Dimensions.pageViewTextContainer,
//               margin: EdgeInsets.only(
//                 left: Dimensions.width30,
//                 right: Dimensions.width30,
//                 bottom: Dimensions.height30,
//               ),
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(Dimensions.radius20),
//                 color: AppColors.cardBackground,
//                 boxShadow: [
//                   BoxShadow(
//                     color: AppColors.shadowColor,
//                     blurRadius: 5.0,
//                     offset: Offset(0, 5),
//                   ),
//                 ],
//               ),
//               child: Container(
//                 padding: EdgeInsets.only(
//                   top: Dimensions.height15,
//                   left: Dimensions.width15,
//                   right: Dimensions.width15,
//                 ),
//                 child: AppColumn(
//                   text: foodItem['name']!,
//                   textColor: AppColors.titleColor,
//                   starColor: AppColors.mainColor,
//                   smallTextColor: AppColors.paraColor,
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:food_ordering/Utility/color.dart';
import 'package:food_ordering/Utility/dimensions.dart';
import 'package:food_ordering/controllers/theme_controller.dart';
import 'package:food_ordering/pages/food/popular_food_detail.dart';
import 'package:food_ordering/routes/route_helper.dart';
import 'package:food_ordering/widgets/app_column.dart';
import 'package:food_ordering/widgets/big_text.dart';
import 'package:food_ordering/widgets/icon_and_text_widget.dart';
import 'package:food_ordering/widgets/small_text.dart';
import 'package:food_ordering/widgets/theme_toggle_button.dart';
import 'package:get/get.dart';

class FoodPageBody extends StatefulWidget {
  const FoodPageBody({super.key});

  @override
  _FoodPageBodyState createState() => _FoodPageBodyState();
}

class _FoodPageBodyState extends State<FoodPageBody> {
  PageController pageController = PageController(viewportFraction: 0.85);
  var _currPageValue = 0.0;
  final double _scaleFactor = 0.8;
  final double _height = Dimensions.pageViewContainer;

  final ThemeController themeController = Get.find();

  // Danh sách món ăn với category để lọc
  final List<Map<String, String>> foodItems = [
    {
      'name': 'Phở Bò',
      'description':
          'Phở Bò - một món ăn truyền thống nổi tiếng của Việt Nam, được chế biến từ nước dùng thơm ngon hầm từ xương bò trong nhiều giờ, kết hợp với bánh phở mềm mịn, thịt bò tươi thái mỏng, và các loại rau thơm như húng quế, ngò gai, cùng chút chanh và ớt để tăng hương vị. Đây là món ăn không chỉ mang đậm nét văn hóa ẩm thực Việt mà còn được yêu thích trên toàn thế giới nhờ sự hòa quyện tinh tế giữa các nguyên liệu.',
      'image': 'assets/images/food1.jpg',
      'category': 'Món nước',
    },
    {
      'name': 'Bún Chả',
      'description':
          'Bún Chả là đặc sản Hà Nội với sự kết hợp hoàn hảo giữa chả nướng thơm lừng được làm từ thịt heo xay ướp gia vị đậm đà, nướng trên than hoa tạo mùi hương quyến rũ, ăn kèm với bún tươi mềm mại và nước mắm chua ngọt pha chế khéo léo. Đi cùng là rau sống tươi mát và chút dưa góp giòn tan, tạo nên một trải nghiệm ẩm thực vừa dân dã vừa tinh tế, khiến thực khách nhớ mãi không quên.',
      'image': 'assets/images/food2.jpg',
      'category': 'Món khô',
    },
    {
      'name': 'Bánh Mì',
      'description':
          'Bánh Mì Việt Nam là một biểu tượng ẩm thực đường phố, nổi bật với lớp vỏ bánh giòn rụm bên ngoài, mềm bên trong, được kẹp đầy ắp nhân thịt heo quay, pate béo ngậy, dưa leo, rau mùi, cà rốt ngâm chua, và một chút tương ớt cay nồng. Sự kết hợp giữa phong cách Pháp và hương vị Việt tạo nên một món ăn vừa quen thuộc vừa độc đáo, được lòng cả người dân địa phương lẫn du khách quốc tế.',
      'image': 'assets/images/food3.jpg',
      'category': 'Ăn nhẹ',
    },
    {
      'name': 'Gỏi Cuốn',
      'description':
          'Gỏi Cuốn, hay còn gọi là nem cuốn, là món ăn nhẹ lành mạnh với bánh tráng mỏng dai được cuốn quanh nhân tôm luộc, thịt heo, bún tươi, rau sống và các loại thảo mộc như húng quế, rau diếp. Món ăn này thường được chấm với nước mắm pha hoặc tương đậu phộng béo ngậy, mang đến hương vị tươi mát, nhẹ nhàng nhưng đầy đủ chất dinh dưỡng, rất phù hợp cho những ngày hè oi bức hay bữa ăn nhẹ trong ngày.',
      'image': 'assets/images/food4.jpg',
      'category': 'Ăn nhẹ',
    },
    {
      'name': 'Cơm Tấm',
      'description':
          'Cơm Tấm là đặc sản miền Nam, đặc biệt nổi tiếng ở Sài Gòn, được làm từ những hạt gạo tấm nhỏ, thơm, dẻo, ăn kèm với sườn nướng thấm đẫm gia vị, trứng ốp la béo ngậy, chả trứng mềm mịn, và các loại topping như mỡ hành, dưa chua. Điểm nhấn là chén nước mắm ngọt thanh, hơi cay, rưới lên cơm, tạo nên một món ăn dân dã nhưng đầy đủ hương vị, làm hài lòng mọi thực khách khó tính nhất.',
      'image': 'assets/images/food5.jpg',
      'category': 'Món khô',
    },
  ];

  String selectedCategory = 'Tất cả'; // Biến để lưu category được chọn

  @override
  void initState() {
    super.initState();
    pageController.addListener(() {
      if (mounted) {
        setState(() {
          _currPageValue = pageController.page!;
        });
      }
    });
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Lọc danh sách món ăn dựa trên category được chọn
    List<Map<String, String>> filteredFoodItems =
        selectedCategory == 'Tất cả'
            ? foodItems
            : foodItems
                .where((item) => item['category'] == selectedCategory)
                .toList();

    return Obx(
      () => Container(
        child: Column(
          children: [
            Container(
              height: Dimensions.pageView,
              child: PageView.builder(
                controller: pageController,
                itemCount: foodItems.length,
                itemBuilder: (context, position) {
                  return _buildPageItem(position);
                },
              ),
            ),
            DotsIndicator(
              dotsCount: foodItems.length,
              position: _currPageValue,
              decorator: DotsDecorator(
                activeColor: AppColors.mainColor,
                color: Colors.grey[300]!,
                size: const Size.square(9.0),
                activeSize: const Size(18.0, 9.0),
                activeShape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.0),
                ),
              ),
            ),
            SizedBox(height: Dimensions.height30),
            Container(
              margin: EdgeInsets.only(left: Dimensions.width30),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  BigText(text: "Popular", color: AppColors.mainBlackColor),
                  SizedBox(width: Dimensions.width10),
                  Container(
                    margin: EdgeInsets.only(bottom: 3),
                    child: BigText(text: ".", color: AppColors.popularDotColor),
                  ),
                  SizedBox(width: Dimensions.width10),
                  Container(
                    margin: EdgeInsets.only(bottom: 2),
                    child: SmallText(
                      text: "Food Pairing",
                      color: AppColors.textColor,
                    ),
                  ),
                ],
              ),
            ),
            // Giao diện lọc món ăn
            Container(
              height: Dimensions.height45,
              margin: EdgeInsets.only(
                left: Dimensions.width20,
                right: Dimensions.width20,
                top: Dimensions.height10,
              ),
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  _buildFilterChip('Tất cả'),
                  SizedBox(width: Dimensions.width10),
                  _buildFilterChip('Món nước'),
                  SizedBox(width: Dimensions.width10),
                  _buildFilterChip('Món khô'),
                  SizedBox(width: Dimensions.width10),
                  _buildFilterChip('Ăn nhẹ'),
                ],
              ),
            ),
            SizedBox(height: Dimensions.height20),
            ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: filteredFoodItems.length,
              itemBuilder: (context, index) {
                final foodItem = filteredFoodItems[index];
                return GestureDetector(
                  onTap: () {
                    Get.toNamed(RouteHelper.getRecommendedFood());
                  },
                  child: Container(
                    margin: EdgeInsets.only(
                      left: Dimensions.width20,
                      right: Dimensions.width20,
                      bottom: Dimensions.height10,
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: Dimensions.listViewImgSize,
                          height: Dimensions.listViewImgSize,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                              Dimensions.radius20,
                            ),
                            color: Colors.white38,
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: AssetImage(foodItem['image']!),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            height: Dimensions.listViewTextContSize,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                topRight: Radius.circular(Dimensions.radius20),
                                bottomRight: Radius.circular(
                                  Dimensions.radius20,
                                ),
                              ),
                              color: AppColors.listItemBackground,
                              boxShadow: [
                                BoxShadow(
                                  color: AppColors.shadowColor.withOpacity(
                                    0.05,
                                  ),
                                  blurRadius: 5,
                                  offset: Offset(2, 2),
                                ),
                              ],
                            ),
                            child: Padding(
                              padding: EdgeInsets.only(
                                left: Dimensions.width10,
                                right: Dimensions.width10,
                                top: Dimensions.height10,
                                bottom: Dimensions.height10,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  BigText(
                                    text: foodItem['name']!,
                                    color: AppColors.mainBlackColor,
                                  ),
                                  SizedBox(height: Dimensions.height5),
                                  SmallText(
                                    text:
                                        foodItem['description']!.substring(
                                          0,
                                          50,
                                        ) +
                                        "...",
                                    color: AppColors.paraColor,
                                  ),
                                  SizedBox(height: Dimensions.height10),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
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

  // Hàm tạo chip lọc
  Widget _buildFilterChip(String category) {
    bool isSelected = selectedCategory == category;
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedCategory = category;
        });
      },
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: Dimensions.width15,
          vertical: Dimensions.height10,
        ),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.mainColor : AppColors.whiteColor,
          borderRadius: BorderRadius.circular(Dimensions.radius15),
          border: Border.all(
            color: isSelected ? AppColors.mainColor : AppColors.mainBlackColor,
            width: 1,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              blurRadius: 5,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Text(
          category,
          style: TextStyle(
            color: isSelected ? Colors.white : AppColors.mainBlackColor,
            fontSize: Dimensions.font16,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }

  Widget _buildPageItem(int index) {
    final foodItem = foodItems[index];

    Matrix4 matrix = Matrix4.identity();
    if (index == _currPageValue.floor()) {
      var currScale = 1 - (_currPageValue - index) * (1 - _scaleFactor);
      var currTrans = _height * (1 - currScale) / 2;
      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, currTrans, 0);
    } else if (index == _currPageValue.floor() + 1) {
      var currScale =
          _scaleFactor + (_currPageValue - index + 1) * (1 - _scaleFactor);
      var currTrans = _height * (1 - currScale) / 2;
      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, currTrans, 0);
    } else if (index == _currPageValue.floor() - 1) {
      var currScale = 1 - (_currPageValue - index) * (1 - _scaleFactor);
      var currTrans = _height * (1 - currScale) / 2;
      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, currTrans, 0);
    } else {
      var currScale = 0.8;
      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, _height * (1 - _scaleFactor) / 2, 0);
    }

    return Transform(
      transform: matrix,
      child: Stack(
        children: [
          GestureDetector(
            onTap: () {
              Get.toNamed(RouteHelper.getPopularFood(index));
            },
            child: Container(
              height: Dimensions.pageViewContainer,
              margin: EdgeInsets.only(
                left: Dimensions.width10,
                right: Dimensions.width10,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(Dimensions.radius30),
                color:
                    index.isEven
                        ? AppColors.pageViewContainerColor1
                        : AppColors.pageViewContainerColor2,
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage(foodItem['image']!),
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: Dimensions.pageViewTextContainer,
              margin: EdgeInsets.only(
                left: Dimensions.width30,
                right: Dimensions.width30,
                bottom: Dimensions.height30,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(Dimensions.radius20),
                color: AppColors.cardBackground,
                boxShadow: [
                  BoxShadow(
                    color: AppColors.shadowColor,
                    blurRadius: 5.0,
                    offset: Offset(0, 5),
                  ),
                ],
              ),
              child: Container(
                padding: EdgeInsets.only(
                  top: Dimensions.height15,
                  left: Dimensions.width15,
                  right: Dimensions.width15,
                ),
                child: AppColumn(
                  text: foodItem['name']!,
                  textColor: AppColors.titleColor,
                  starColor: AppColors.mainColor,
                  smallTextColor: AppColors.paraColor,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
