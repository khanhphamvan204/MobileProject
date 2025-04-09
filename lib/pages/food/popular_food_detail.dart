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
  final int pageId;
  const PopularFoodDetail({super.key, required this.pageId});

  @override
  Widget build(BuildContext context) {
    var product =
        [
          {
            'name': 'Phở Bò',
            'description':
                'Phở Bò - một món ăn truyền thống nổi tiếng của Việt Nam, được chế biến từ nước dùng thơm ngon hầm từ xương bò trong nhiều giờ, kết hợp với bánh phở mềm mịn, thịt bò tươi thái mỏng, và các loại rau thơm như húng quế, ngò gai, cùng chút chanh và ớt để tăng hương vị. Đây là món ăn không chỉ mang đậm nét văn hóa ẩm thực Việt mà còn được yêu thích trên toàn thế giới nhờ sự hòa quyện tinh tế giữa các nguyên liệu.',
            'image': 'assets/images/food1.jpg',
          },
          {
            'name': 'Bún Chả',
            'description':
                'Bún Chả là đặc sản Hà Nội với sự kết hợp hoàn hảo giữa chả nướng thơm lừng được làm từ thịt heo xay ướp gia vị đậm đà, nướng trên than hoa tạo mùi hương quyến rũ, ăn kèm với bún tươi mềm mại và nước mắm chua ngọt pha chế khéo léo. Đi cùng là rau sống tươi mát và chút dưa góp giòn tan, tạo nên một trải nghiệm ẩm thực vừa dân dã vừa tinh tế, khiến thực khách nhớ mãi không quên.',
            'image': 'assets/images/food2.jpg',
          },
          {
            'name': 'Bánh Mì',
            'description':
                'Bánh Mì Việt Nam là một biểu tượng ẩm thực đường phố, nổi bật với lớp vỏ bánh giòn rụm bên ngoài, mềm bên trong, được kẹp đầy ắp nhân thịt heo quay, pate béo ngậy, dưa leo, rau mùi, cà rốt ngâm chua, và một chút tương ớt cay nồng. Sự kết hợp giữa phong cách Pháp và hương vị Việt tạo nên một món ăn vừa quen thuộc vừa độc đáo, được lòng cả người dân địa phương lẫn du khách quốc tế.',
            'image': 'assets/images/food3.jpg',
          },
          {
            'name': 'Gỏi Cuốn',
            'description':
                'Gỏi Cuốn, hay còn gọi là nem cuốn, là món ăn nhẹ lành mạnh với bánh tráng mỏng dai được cuốn quanh nhân tôm luộc, thịt heo, bún tươi, rau sống và các loại thảo mộc như húng quế, rau diếp. Món ăn này thường được chấm với nước mắm pha hoặc tương đậu phộng béo ngậy, mang đến hương vị tươi mát, nhẹ nhàng nhưng đầy đủ chất dinh dưỡng, rất phù hợp cho những ngày hè oi bức hay bữa ăn nhẹ trong ngày.',
            'image': 'assets/images/food4.jpg',
          },
          {
            'name': 'Cơm Tấm',
            'description':
                'Cơm Tấm là đặc sản miền Nam, đặc biệt nổi tiếng ở Sài Gòn, được làm từ những hạt gạo tấm nhỏ, thơm, dẻo, ăn kèm với sườn nướng thấm đẫm gia vị, trứng ốp la béo ngậy, chả trứng mềm mịn, và các loại topping như mỡ hành, dưa chua. Điểm nhấn là chén nước mắm ngọt thanh, hơi cay, rưới lên cơm, tạo nên một món ăn dân dã nhưng đầy đủ hương vị, làm hài lòng mọi thực khách khó tính nhất.',
            'image': 'assets/images/food5.jpg',
          },
        ][pageId];
    print('Product: $product');
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
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
                GestureDetector(
                  onTap: () {
                    // Handle back button tap
                    Navigator.pop(context);
                  },
                  child: AppIcon(icon: Icons.arrow_back_ios),
                ),
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
                color: AppColors.whiteColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(Dimensions.radius20),
                  topRight: Radius.circular(Dimensions.radius20),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppColumn(text: product["name"] as String),
                  SizedBox(height: Dimensions.height20),
                  BigText(text: "Introduce"),
                  SizedBox(height: Dimensions.height10),
                  Expanded(
                    child: SingleChildScrollView(
                      child: ExpandableTextWidget(
                        text: product["description"] as String,
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
                color: AppColors.whiteColor,
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
              child: BigText(
                text: "\$10.0 | Add to cart",
                color: AppColors.whiteColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
