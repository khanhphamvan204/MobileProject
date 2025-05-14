import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:food_ordering/Utility/app_constants.dart';
import 'package:food_ordering/Utility/color.dart';
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
    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   // Kiểm tra xem widget còn tồn tại không trước khi gọi controller
    //   if (mounted) {
    //     print("FoodPageBody: Fetching data after first frame.");
    //     // Gọi các hàm fetch dữ liệu ở đây
    //     // Giả sử bạn có các controller đã được Get.find() hoặc inject
    //     Get.find<ProductController>().getProductList();
    //     Get.find<CategoryController>().getCategoryList();
    //     // Nếu bạn cũng cần fetch popular products ở đây, hãy gọi nó
    //     Get.find<PopularProductController>()
    //         .getPopularProductList(); // Đảm bảo phương thức này tồn tại và được gọi đúng lúc
    //   }
    // });
    // Fetch products and categories when the page initializes
    productController.getProductList(); // Fetch all products initially
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
            // Popular Section Header
            Container(
              margin: EdgeInsets.only(left: Dimensions.width30),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  BigText(
                    text: "Danh mục sản phẩm",
                    color: AppColors.mainBlackColor,
                  ),
                  SizedBox(width: Dimensions.width10),
                  Container(
                    margin: const EdgeInsets.only(bottom: 3),
                    child: BigText(text: ".", color: AppColors.popularDotColor),
                  ),
                  SizedBox(width: Dimensions.width10),
                  Container(
                    margin: const EdgeInsets.only(bottom: 2),
                    child: SmallText(
                      text: "Chọn loại",
                      color: AppColors.textColor,
                    ),
                  ),
                ],
              ),
            ),
            // Category Filter Chips
            Container(
              height: Dimensions.height60,
              margin: EdgeInsets.only(
                left: Dimensions.width15,
                right: Dimensions.width15,
                top: Dimensions.height15,
              ),
              child:
                  categoryController.isLoading
                      ? Container(
                        decoration: BoxDecoration(
                          color: AppColors.whiteColor,
                          borderRadius: BorderRadius.circular(
                            Dimensions.radius15,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.2),
                              blurRadius: 8,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Center(
                          child: CircularProgressIndicator(
                            color: AppColors.mainColor,
                          ),
                        ),
                      )
                      : categoryController.categoryList.isEmpty
                      ? Container(
                        decoration: BoxDecoration(
                          color: AppColors.whiteColor,
                          borderRadius: BorderRadius.circular(
                            Dimensions.radius15,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.2),
                              blurRadius: 8,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: const Center(
                          child: Text("Không có danh mục nào"),
                        ),
                      )
                      : ListView(
                        scrollDirection: Axis.horizontal,
                        physics: const BouncingScrollPhysics(),
                        padding: EdgeInsets.symmetric(
                          horizontal: Dimensions.width10,
                        ),
                        children: [
                          // "Tất cả" chip
                          Padding(
                            padding: EdgeInsets.only(right: Dimensions.width10),
                            child: _buildFilterChip(null, 'Tất cả'),
                          ),
                          // Category chips
                          ...categoryController.categoryList.map(
                            (category) => Padding(
                              padding: EdgeInsets.only(
                                right: Dimensions.width10,
                              ),
                              child: _buildFilterChip(
                                category.id,
                                category.name,
                              ),
                            ),
                          ),
                        ],
                      ),
            ),
            SizedBox(height: Dimensions.height20),
            // Product List
            Obx(
              () =>
                  productController.isLoaded.value
                      ? productController.productList.isEmpty
                          ? const Center(child: Text("Không có sản phẩm nào"))
                          : ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: productController.productList.length,
                            itemBuilder: (context, index) {
                              final product =
                                  productController.productList[index];
                              return GestureDetector(
                                onTap: () {
                                  // Truyền product.id và đối tượng Product
                                  Get.toNamed(
                                    RouteHelper.getFood(product.id),
                                    arguments: product, // Truyền Product
                                  );
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
                                        ),
                                        child: CachedNetworkImage(
                                          imageUrl:
                                              AppConstants.BASE_URL +
                                              "/" +
                                              product.img,
                                          placeholder:
                                              (context, url) =>
                                                  CircularProgressIndicator(),
                                          errorWidget:
                                              (context, url, error) =>
                                                  Icon(Icons.error),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      Expanded(
                                        child: Container(
                                          height:
                                              Dimensions.listViewTextContSize,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.only(
                                              topRight: Radius.circular(
                                                Dimensions.radius20,
                                              ),
                                              bottomRight: Radius.circular(
                                                Dimensions.radius20,
                                              ),
                                            ),
                                            color: AppColors.listItemBackground,
                                            boxShadow: [
                                              BoxShadow(
                                                color: AppColors.shadowColor
                                                    .withOpacity(0.05),
                                                blurRadius: 5,
                                                offset: const Offset(2, 2),
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
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                BigText(
                                                  text: product.name,
                                                  color:
                                                      AppColors.mainBlackColor,
                                                ),
                                                SizedBox(
                                                  height: Dimensions.height5,
                                                ),
                                                SmallText(
                                                  text:
                                                      product.desc.length > 50
                                                          ? product.desc
                                                                  .substring(
                                                                    0,
                                                                    50,
                                                                  ) +
                                                              "..."
                                                          : product.desc,
                                                  color: AppColors.paraColor,
                                                ),
                                                SizedBox(
                                                  height: Dimensions.height10,
                                                ),
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
                          )
                      : CircularProgressIndicator(color: AppColors.mainColor),
            ),
          ],
        ),
      ),
    );
  }

  // Build Filter Chip
  Widget _buildFilterChip(int? categoryId, String categoryName) {
    bool isSelected = selectedCategoryId == categoryId;
    return InkWell(
      onTap: () {
        setState(() {
          selectedCategoryId = categoryId;
          productController.getProductList(categoryId: categoryId);
        });
      },
      splashColor: AppColors.mainColor.withOpacity(0.2),
      borderRadius: BorderRadius.circular(Dimensions.radius20),
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: Dimensions.width20,
          vertical: Dimensions.height15,
        ),
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
                  : null,
          color: isSelected ? null : AppColors.whiteColor,
          borderRadius: BorderRadius.circular(Dimensions.radius20),
          border: Border.all(
            color:
                isSelected
                    ? Colors.transparent
                    : AppColors.mainBlackColor.withOpacity(0.5),
            width: 1.5,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(isSelected ? 0.4 : 0.2),
              blurRadius: isSelected ? 10 : 6,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Text(
          categoryName,
          style: TextStyle(
            color: isSelected ? Colors.white : AppColors.mainBlackColor,
            fontSize: Dimensions.font20,
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
          ),
        ),
      ),
    );
  }

  // Build Page Item for Slider
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
                  // price: popularProduct.price.toDouble(),
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
