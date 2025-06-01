// import 'package:dots_indicator/dots_indicator.dart';
// import 'package:flutter/material.dart';
// import 'package:food_ordering/Utility/app_constants.dart';
// import 'package:food_ordering/Utility/color.dart';
// import 'package:food_ordering/Utility/dimensions.dart';
// import 'package:food_ordering/controllers/category_controller.dart';
// import 'package:food_ordering/controllers/popular_product_controller.dart';
// import 'package:food_ordering/controllers/product_controller.dart';
// import 'package:food_ordering/controllers/theme_controller.dart';
// import 'package:food_ordering/models/category_model.dart';
// import 'package:food_ordering/models/products_model.dart';
// import 'package:food_ordering/routes/route_helper.dart';
// import 'package:food_ordering/widgets/app_column.dart';
// import 'package:food_ordering/widgets/big_text.dart';
// import 'package:food_ordering/widgets/small_text.dart';
// import 'package:get/get.dart';
// import 'package:cached_network_image/cached_network_image.dart';

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

//   final ThemeController themeController = Get.find<ThemeController>();
//   final ProductController productController = Get.find<ProductController>();
//   final CategoryController categoryController = Get.find<CategoryController>();

//   int? selectedCategoryId; // Store category ID (null for "Tất cả")

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
//     // WidgetsBinding.instance.addPostFrameCallback((_) {
//     //   // Kiểm tra xem widget còn tồn tại không trước khi gọi controller
//     //   if (mounted) {
//     //     print("FoodPageBody: Fetching data after first frame.");
//     //     // Gọi các hàm fetch dữ liệu ở đây
//     //     // Giả sử bạn có các controller đã được Get.find() hoặc inject
//     //     Get.find<ProductController>().getProductList();
//     //     Get.find<CategoryController>().getCategoryList();
//     //     // Nếu bạn cũng cần fetch popular products ở đây, hãy gọi nó
//     //     Get.find<PopularProductController>()
//     //         .getPopularProductList(); // Đảm bảo phương thức này tồn tại và được gọi đúng lúc
//     //   }
//     // });
//     // Fetch products and categories when the page initializes
//     productController.getProductList(); // Fetch all products initially
//     categoryController.getCategoryList();
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
//             // Slider for Popular Products
//             GetBuilder<PopularProductController>(
//               builder: (popularProducts) {
//                 return popularProducts.isLoaded
//                     ? Container(
//                       height: Dimensions.pageView,
//                       child: PageView.builder(
//                         controller: pageController,
//                         itemCount: popularProducts.popularProductList.length,
//                         itemBuilder: (context, position) {
//                           return _buildPageItem(
//                             position,
//                             popularProducts.popularProductList[position],
//                           );
//                         },
//                       ),
//                     )
//                     : CircularProgressIndicator(color: AppColors.mainColor);
//               },
//             ),
//             GetBuilder<PopularProductController>(
//               builder: (popularProducts) {
//                 return DotsIndicator(
//                   dotsCount:
//                       popularProducts.popularProductList.length <= 0
//                           ? 1
//                           : popularProducts.popularProductList.length,
//                   position: _currPageValue,
//                   decorator: DotsDecorator(
//                     activeColor: AppColors.mainColor,
//                     color: Colors.grey[300]!,
//                     size: const Size.square(9.0),
//                     activeSize: const Size(18.0, 9.0),
//                     activeShape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(5.0),
//                     ),
//                   ),
//                 );
//               },
//             ),

//             SizedBox(height: Dimensions.height30),
//             // Popular Section Header
//             Container(
//               margin: EdgeInsets.only(left: Dimensions.width30),
//               child: Row(
//                 crossAxisAlignment: CrossAxisAlignment.end,
//                 children: [
//                   BigText(
//                     text: "Danh mục sản phẩm",
//                     color: AppColors.mainBlackColor,
//                   ),
//                   SizedBox(width: Dimensions.width10),
//                   Container(
//                     margin: const EdgeInsets.only(bottom: 3),
//                     child: BigText(text: ".", color: AppColors.popularDotColor),
//                   ),
//                   SizedBox(width: Dimensions.width10),
//                   Container(
//                     margin: const EdgeInsets.only(bottom: 2),
//                     child: SmallText(
//                       text: "Chọn loại",
//                       color: AppColors.textColor,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             // Category Filter Chips
//             Container(
//               height: Dimensions.height60,
//               margin: EdgeInsets.only(
//                 left: Dimensions.width15,
//                 right: Dimensions.width15,
//                 top: Dimensions.height15,
//               ),
//               child:
//                   categoryController.isLoading
//                       ? Container(
//                         decoration: BoxDecoration(
//                           color: AppColors.whiteColor,
//                           borderRadius: BorderRadius.circular(
//                             Dimensions.radius15,
//                           ),
//                           boxShadow: [
//                             BoxShadow(
//                               color: Colors.grey.withOpacity(0.2),
//                               blurRadius: 8,
//                               offset: const Offset(0, 2),
//                             ),
//                           ],
//                         ),
//                         child: Center(
//                           child: CircularProgressIndicator(
//                             color: AppColors.mainColor,
//                           ),
//                         ),
//                       )
//                       : categoryController.categoryList.isEmpty
//                       ? Container(
//                         decoration: BoxDecoration(
//                           color: AppColors.whiteColor,
//                           borderRadius: BorderRadius.circular(
//                             Dimensions.radius15,
//                           ),
//                           boxShadow: [
//                             BoxShadow(
//                               color: Colors.grey.withOpacity(0.2),
//                               blurRadius: 8,
//                               offset: const Offset(0, 2),
//                             ),
//                           ],
//                         ),
//                         child: const Center(
//                           child: Text("Không có danh mục nào"),
//                         ),
//                       )
//                       : ListView(
//                         scrollDirection: Axis.horizontal,
//                         physics: const BouncingScrollPhysics(),
//                         padding: EdgeInsets.symmetric(
//                           horizontal: Dimensions.width10,
//                         ),
//                         children: [
//                           // "Tất cả" chip
//                           Padding(
//                             padding: EdgeInsets.only(right: Dimensions.width10),
//                             child: _buildFilterChip(null, 'Tất cả'),
//                           ),
//                           // Category chips
//                           ...categoryController.categoryList.map(
//                             (category) => Padding(
//                               padding: EdgeInsets.only(
//                                 right: Dimensions.width10,
//                               ),
//                               child: _buildFilterChip(
//                                 category.id,
//                                 category.name,
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//             ),
//             SizedBox(height: Dimensions.height20),
//             // Product List
//             Obx(
//               () =>
//                   productController.isLoaded.value
//                       ? productController.productList.isEmpty
//                           ? const Center(child: Text("Không có sản phẩm nào"))
//                           : ListView.builder(
//                             physics: const NeverScrollableScrollPhysics(),
//                             shrinkWrap: true,
//                             itemCount: productController.productList.length,
//                             itemBuilder: (context, index) {
//                               final product =
//                                   productController.productList[index];
//                               return GestureDetector(
//                                 onTap: () {
//                                   // Truyền product.id và đối tượng Product
//                                   Get.toNamed(
//                                     RouteHelper.getFood(product.id),
//                                     arguments: product, // Truyền Product
//                                   );
//                                 },
//                                 child: Container(
//                                   margin: EdgeInsets.only(
//                                     left: Dimensions.width20,
//                                     right: Dimensions.width20,
//                                     bottom: Dimensions.height10,
//                                   ),
//                                   child: Row(
//                                     children: [
//                                       Container(
//                                         width: Dimensions.listViewImgSize,
//                                         height: Dimensions.listViewImgSize,
//                                         decoration: BoxDecoration(
//                                           borderRadius: BorderRadius.circular(
//                                             Dimensions.radius20,
//                                           ),
//                                           color: Colors.white38,
//                                         ),
//                                         child: CachedNetworkImage(
//                                           imageUrl:
//                                               AppConstants.BASE_URL +
//                                               "/" +
//                                               product.img,
//                                           placeholder:
//                                               (context, url) =>
//                                                   CircularProgressIndicator(),
//                                           errorWidget:
//                                               (context, url, error) =>
//                                                   Icon(Icons.error),
//                                           fit: BoxFit.cover,
//                                         ),
//                                       ),
//                                       Expanded(
//                                         child: Container(
//                                           height:
//                                               Dimensions.listViewTextContSize,
//                                           decoration: BoxDecoration(
//                                             borderRadius: BorderRadius.only(
//                                               topRight: Radius.circular(
//                                                 Dimensions.radius20,
//                                               ),
//                                               bottomRight: Radius.circular(
//                                                 Dimensions.radius20,
//                                               ),
//                                             ),
//                                             color: AppColors.listItemBackground,
//                                             boxShadow: [
//                                               BoxShadow(
//                                                 color: AppColors.shadowColor
//                                                     .withOpacity(0.05),
//                                                 blurRadius: 5,
//                                                 offset: const Offset(2, 2),
//                                               ),
//                                             ],
//                                           ),
//                                           child: Padding(
//                                             padding: EdgeInsets.only(
//                                               left: Dimensions.width10,
//                                               right: Dimensions.width10,
//                                               top: Dimensions.height10,
//                                               bottom: Dimensions.height10,
//                                             ),
//                                             child: Column(
//                                               crossAxisAlignment:
//                                                   CrossAxisAlignment.start,
//                                               mainAxisAlignment:
//                                                   MainAxisAlignment.center,
//                                               children: [
//                                                 BigText(
//                                                   text: product.name,
//                                                   color:
//                                                       AppColors.mainBlackColor,
//                                                 ),
//                                                 SizedBox(
//                                                   height: Dimensions.height5,
//                                                 ),
//                                                 SmallText(
//                                                   text:
//                                                       product.desc.length > 50
//                                                           ? product.desc
//                                                                   .substring(
//                                                                     0,
//                                                                     50,
//                                                                   ) +
//                                                               "..."
//                                                           : product.desc,
//                                                   color: AppColors.paraColor,
//                                                 ),
//                                                 SizedBox(
//                                                   height: Dimensions.height10,
//                                                 ),
//                                               ],
//                                             ),
//                                           ),
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                               );
//                             },
//                           )
//                       : CircularProgressIndicator(color: AppColors.mainColor),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   // Build Filter Chip
//   Widget _buildFilterChip(int? categoryId, String categoryName) {
//     bool isSelected = selectedCategoryId == categoryId;
//     return InkWell(
//       onTap: () {
//         setState(() {
//           selectedCategoryId = categoryId;
//           productController.getProductList(categoryId: categoryId);
//         });
//       },
//       splashColor: AppColors.mainColor.withOpacity(0.2),
//       borderRadius: BorderRadius.circular(Dimensions.radius20),
//       child: Container(
//         padding: EdgeInsets.symmetric(
//           horizontal: Dimensions.width20,
//           vertical: Dimensions.height15,
//         ),
//         decoration: BoxDecoration(
//           gradient:
//               isSelected
//                   ? LinearGradient(
//                     colors: [
//                       AppColors.mainColor,
//                       AppColors.mainColor.withOpacity(0.8),
//                     ],
//                     begin: Alignment.topLeft,
//                     end: Alignment.bottomRight,
//                   )
//                   : null,
//           color: isSelected ? null : AppColors.whiteColor,
//           borderRadius: BorderRadius.circular(Dimensions.radius20),
//           border: Border.all(
//             color:
//                 isSelected
//                     ? Colors.transparent
//                     : AppColors.mainBlackColor.withOpacity(0.5),
//             width: 1.5,
//           ),
//           boxShadow: [
//             BoxShadow(
//               color: Colors.grey.withOpacity(isSelected ? 0.4 : 0.2),
//               blurRadius: isSelected ? 10 : 6,
//               offset: const Offset(0, 3),
//             ),
//           ],
//         ),
//         child: Text(
//           categoryName,
//           style: TextStyle(
//             color: isSelected ? Colors.white : AppColors.mainBlackColor,
//             fontSize: Dimensions.font20,
//             fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
//           ),
//         ),
//       ),
//     );
//   }

//   // Build Page Item for Slider
//   Widget _buildPageItem(int index, Product popularProduct) {
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
//                   image: NetworkImage(
//                     AppConstants.BASE_URL + "/" + popularProduct.img,
//                   ),
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
//                     offset: const Offset(0, 5),
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
//                   text: popularProduct.name,
//                   textColor: AppColors.titleColor,
//                   starColor: AppColors.mainColor,
//                   smallTextColor: AppColors.paraColor,
//                   // price: popularProduct.price.toDouble(),
//                   price: popularProduct.price.toDouble(),
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
import 'package:food_ordering/Utility/app_constants.dart';
import 'package:food_ordering/Utility/color.dart';
import 'package:food_ordering/Utility/currency_formatter.dart';
import 'package:food_ordering/Utility/dimensions.dart';
import 'package:food_ordering/controllers/category_controller.dart';
import 'package:food_ordering/controllers/popular_product_controller.dart';
import 'package:food_ordering/controllers/product_controller.dart';
import 'package:food_ordering/controllers/theme_controller.dart';
import 'package:food_ordering/models/category_model.dart';
import 'package:food_ordering/models/products_model.dart';
import 'package:food_ordering/routes/route_helper.dart';
import 'package:food_ordering/widgets/app_column.dart';
import 'package:food_ordering/widgets/big_text.dart';
import 'package:food_ordering/widgets/small_text.dart';
import 'package:get/get.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

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

  final ThemeController themeController = Get.find<ThemeController>();
  final ProductController productController = Get.find<ProductController>();
  final CategoryController categoryController = Get.find<CategoryController>();

  int? selectedCategoryId; // Store category ID (null for "Tất cả")

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
    productController.getProductList();
    categoryController.getCategoryList();
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Container(
        child: Column(
          children: [
            // Slider for Popular Products
            GetBuilder<PopularProductController>(
              builder: (popularProducts) {
                return popularProducts.isLoaded
                    ? Container(
                      height: Dimensions.pageView,
                      child: PageView.builder(
                        controller: pageController,
                        itemCount: popularProducts.popularProductList.length,
                        itemBuilder: (context, position) {
                          return _buildPageItem(
                            position,
                            popularProducts.popularProductList[position],
                          );
                        },
                      ),
                    )
                    : CircularProgressIndicator(color: AppColors.mainColor);
              },
            ),
            GetBuilder<PopularProductController>(
              builder: (popularProducts) {
                return DotsIndicator(
                  dotsCount:
                      popularProducts.popularProductList.length <= 0
                          ? 1
                          : popularProducts.popularProductList.length,
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
                );
              },
            ),

            SizedBox(height: Dimensions.height30),

            // Enhanced Category Section Header
            Container(
              margin: EdgeInsets.symmetric(horizontal: Dimensions.width20),
              child: Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(Dimensions.width10),
                    decoration: BoxDecoration(
                      color: AppColors.mainColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(Dimensions.radius15),
                    ),
                    child: Icon(
                      Icons.restaurant_menu,
                      color: AppColors.mainColor,
                      size: Dimensions.iconSize24,
                    ),
                  ),
                  SizedBox(width: Dimensions.width15),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        BigText(
                          text: "Danh mục sản phẩm",
                          color: AppColors.mainBlackColor,
                          size: Dimensions.font26,
                        ),
                        SizedBox(height: Dimensions.height5),
                        SmallText(
                          text: "Khám phá các món ăn yêu thích",
                          color: AppColors.textColor,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: Dimensions.height20),

            // Enhanced Category Filter Grid
            Container(
              margin: EdgeInsets.symmetric(horizontal: Dimensions.width20),
              child:
                  categoryController.isLoading
                      ? _buildLoadingGrid()
                      : categoryController.categoryList.isEmpty
                      ? _buildEmptyState()
                      : _buildCategoryGrid(),
            ),

            SizedBox(height: Dimensions.height30),

            // Enhanced Product List Header
            Container(
              margin: EdgeInsets.symmetric(horizontal: Dimensions.width20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      BigText(
                        text:
                            selectedCategoryId == null
                                ? "Tất cả sản phẩm"
                                : "Sản phẩm theo danh mục",
                        color: AppColors.mainBlackColor,
                        size: Dimensions.font20,
                      ),
                      SizedBox(height: Dimensions.height5),
                      SmallText(
                        text:
                            "${productController.productList.length} sản phẩm",
                        color: AppColors.textColor,
                      ),
                    ],
                  ),
                  Container(
                    padding: EdgeInsets.all(Dimensions.width10),
                    decoration: BoxDecoration(
                      color: AppColors.mainColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(Dimensions.radius15),
                    ),
                    child: Icon(
                      Icons.tune,
                      color: AppColors.mainColor,
                      size: Dimensions.iconSize20,
                    ),
                  ),
                ],
              ),
            ),

            // Enhanced Product List
            Obx(
              () =>
                  productController.isLoaded.value
                      ? productController.productList.isEmpty
                          ? _buildEmptyProductState()
                          : ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: productController.productList.length,
                            itemBuilder: (context, index) {
                              final product =
                                  productController.productList[index];
                              return _buildEnhancedProductCard(product, index);
                            },
                          )
                      : _buildProductLoadingState(),
            ),
          ],
        ),
      ),
    );
  }

  // Enhanced Category Grid
  Widget _buildCategoryGrid() {
    List<Widget> categoryItems = [];

    // Add "Tất cả" category
    categoryItems.add(_buildEnhancedCategoryCard(null, 'Tất cả', Icons.apps));

    // Add other categories
    for (var category in categoryController.categoryList) {
      categoryItems.add(
        _buildEnhancedCategoryCard(
          category.id,
          category.name,
          _getCategoryIcon(category.name),
        ),
      );
    }

    return Container(
      height: 120,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        padding: EdgeInsets.symmetric(horizontal: Dimensions.width10),
        itemCount: categoryItems.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.only(right: Dimensions.width15),
            child: categoryItems[index],
          );
        },
      ),
    );
  }

  // Enhanced Category Card
  Widget _buildEnhancedCategoryCard(
    int? categoryId,
    String categoryName,
    IconData icon,
  ) {
    bool isSelected = selectedCategoryId == categoryId;

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedCategoryId = categoryId;
          productController.getProductList(categoryId: categoryId);
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        width: 100,
        padding: EdgeInsets.all(Dimensions.width15),
        decoration: BoxDecoration(
          gradient:
              isSelected
                  ? LinearGradient(
                    colors: [
                      AppColors.mainColor,
                      AppColors.mainColor.withOpacity(0.8),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  )
                  : LinearGradient(
                    colors: [Colors.white, Colors.grey[50]!],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
          borderRadius: BorderRadius.circular(Dimensions.radius20),
          border: Border.all(
            color:
                isSelected
                    ? Colors.transparent
                    : AppColors.mainColor.withOpacity(0.2),
            width: 2,
          ),
          boxShadow: [
            BoxShadow(
              color:
                  isSelected
                      ? AppColors.mainColor.withOpacity(0.3)
                      : Colors.grey.withOpacity(0.15),
              blurRadius: isSelected ? 15 : 8,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.all(Dimensions.width12),
              decoration: BoxDecoration(
                color:
                    isSelected
                        ? Colors.white.withOpacity(0.2)
                        : AppColors.mainColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(Dimensions.radius15),
              ),
              child: Icon(
                icon,
                color: isSelected ? Colors.white : AppColors.mainColor,
                size: Dimensions.iconSize24,
              ),
            ),
            SizedBox(height: Dimensions.height10),
            Text(
              categoryName,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: isSelected ? Colors.white : AppColors.mainBlackColor,
                fontSize: Dimensions.font14,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }

  // Enhanced Product Card
  Widget _buildEnhancedProductCard(Product product, int index) {
    return GestureDetector(
      onTap: () {
        Get.toNamed(RouteHelper.getFood(product.id), arguments: product);
      },
      child: Container(
        margin: EdgeInsets.only(
          left: Dimensions.width20,
          right: Dimensions.width20,
          bottom: Dimensions.height15,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(Dimensions.radius20),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Row(
          children: [
            // Enhanced Image Container
            Container(
              width: Dimensions.listViewImgSize,
              height: Dimensions.listViewImgSize,
              margin: EdgeInsets.all(Dimensions.width10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(Dimensions.radius15),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.mainColor.withOpacity(0.1),
                    blurRadius: 8,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(Dimensions.radius15),
                child: CachedNetworkImage(
                  imageUrl: AppConstants.BASE_URL + "/" + product.img,
                  placeholder:
                      (context, url) => Container(
                        color: Colors.grey[200],
                        child: Center(
                          child: CircularProgressIndicator(
                            color: AppColors.mainColor,
                          ),
                        ),
                      ),
                  errorWidget:
                      (context, url, error) => Container(
                        color: Colors.grey[200],
                        child: Icon(
                          Icons.restaurant,
                          color: AppColors.mainColor,
                          size: Dimensions.iconSize24,
                        ),
                      ),
                  fit: BoxFit.cover,
                ),
              ),
            ),

            // Enhanced Content Container
            Expanded(
              child: Container(
                padding: EdgeInsets.all(Dimensions.width15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: BigText(
                            text: product.name,
                            color: AppColors.mainBlackColor,
                            size: Dimensions.font18,
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: Dimensions.width8,
                            vertical: Dimensions.height5,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.mainColor.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(
                              Dimensions.radius10,
                            ),
                          ),
                          // child: Row(
                          //   mainAxisSize: MainAxisSize.min,
                          //   children: [
                          //     Icon(
                          //       Icons.star,
                          //       color: AppColors.mainColor,
                          //       size: Dimensions.iconSize16,
                          //     ),
                          //     SizedBox(width: Dimensions.width5),
                          //     SmallText(
                          //       text: "4.5",
                          //       color: AppColors.mainColor,
                          //     ),
                          //   ],
                          // ),
                        ),
                      ],
                    ),

                    SizedBox(height: Dimensions.height8),

                    SmallText(
                      text:
                          product.desc.length > 60
                              ? product.desc.substring(0, 60) + "..."
                              : product.desc,
                      color: AppColors.paraColor,
                      height: 1.4,
                    ),

                    SizedBox(height: Dimensions.height15),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: Dimensions.width12,
                            vertical: Dimensions.height8,
                          ),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                AppColors.mainColor,
                                AppColors.mainColor.withOpacity(0.8),
                              ],
                            ),
                            borderRadius: BorderRadius.circular(
                              Dimensions.radius15,
                            ),
                          ),
                          child: Text(
                            CurrencyFormatter.formatVND(
                              product.price.toDouble(),
                            ),
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: Dimensions.font16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.all(Dimensions.width8),
                          decoration: BoxDecoration(
                            color: AppColors.mainColor.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(
                              Dimensions.radius10,
                            ),
                          ),
                          child: Icon(
                            Icons.add_shopping_cart,
                            color: AppColors.mainColor,
                            size: Dimensions.iconSize20,
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
  }

  // Helper methods for different states
  Widget _buildLoadingGrid() {
    return Container(
      height: 120,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 5,
        itemBuilder: (context, index) {
          return Container(
            width: 100,
            margin: EdgeInsets.only(right: Dimensions.width15),
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(Dimensions.radius20),
            ),
            child: Center(
              child: CircularProgressIndicator(color: AppColors.mainColor),
            ),
          );
        },
      ),
    );
  }

  Widget _buildEmptyState() {
    return Container(
      height: 120,
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(Dimensions.radius20),
        border: Border.all(color: Colors.grey[300]!),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.category_outlined,
              color: Colors.grey[400],
              size: Dimensions.iconSize24,
            ),
            SizedBox(height: Dimensions.height10),
            SmallText(text: "Không có danh mục nào", color: Colors.grey[600]!),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyProductState() {
    return Container(
      padding: EdgeInsets.all(Dimensions.width30),
      child: Column(
        children: [
          Icon(Icons.restaurant_outlined, color: Colors.grey[400], size: 60),
          SizedBox(height: Dimensions.height20),
          BigText(text: "Không có sản phẩm nào", color: Colors.grey[600]!),
          SizedBox(height: Dimensions.height10),
          SmallText(
            text: "Hãy thử chọn danh mục khác",
            color: Colors.grey[500]!,
          ),
        ],
      ),
    );
  }

  Widget _buildProductLoadingState() {
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: 5,
      itemBuilder: (context, index) {
        return Container(
          margin: EdgeInsets.only(
            left: Dimensions.width20,
            right: Dimensions.width20,
            bottom: Dimensions.height15,
          ),
          height: Dimensions.listViewImgSize + Dimensions.width20,
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(Dimensions.radius20),
          ),
        );
      },
    );
  }

  // Get appropriate icon for category
  IconData _getCategoryIcon(String categoryName) {
    String name = categoryName.toLowerCase();
    if (name.contains('pizza')) return FontAwesomeIcons.pizzaSlice;
    if (name.contains('món khai vị')) return FontAwesomeIcons.plateWheat;
    if (name.contains('gà')) return FontAwesomeIcons.drumstickBite;
    if (name.contains('thức uống')) return FontAwesomeIcons.cocktail;
    return Icons.restaurant;
  }

  // Build Page Item for Slider (unchanged)
  Widget _buildPageItem(int index, Product popularProduct) {
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
                  image: NetworkImage(
                    AppConstants.BASE_URL + "/" + popularProduct.img,
                  ),
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
                    offset: const Offset(0, 5),
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
                  text: popularProduct.name,
                  textColor: AppColors.titleColor,
                  starColor: AppColors.mainColor,
                  smallTextColor: AppColors.paraColor,
                  price: popularProduct.price.toDouble(),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
