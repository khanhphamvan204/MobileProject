// import 'package:flutter/material.dart';
// import 'package:food_ordering/Utility/color.dart';
// import 'package:food_ordering/Utility/dimensions.dart';
// import 'package:food_ordering/widgets/big_text.dart';
// import 'package:food_ordering/widgets/icon_and_text_widget.dart';
// import 'package:food_ordering/widgets/small_text.dart';

// class AppColumn extends StatelessWidget {
//   final String text; // Thêm thuộc tính color nếu cần thiết

//   const AppColumn({super.key, required this.text});

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         BigText(text: text, size: Dimensions.font26),
//         SizedBox(height: Dimensions.height10),
//         Row(
//           children: [
//             Wrap(
//               children: List.generate(5, (index) {
//                 return Icon(Icons.star, color: AppColors.yellowColor, size: 15);
//               }),
//             ),
//             SizedBox(width: Dimensions.width10),
//             SmallText(text: "4.5"),
//             SizedBox(width: Dimensions.width10),
//             SmallText(text: "1287"),
//             SizedBox(width: Dimensions.width10),
//             SmallText(text: "comments"),
//           ],
//         ),
//         SizedBox(height: Dimensions.width15),
//         Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             IconAndTextWidget(
//               icon: Icons.circle_sharp,
//               text: "Normal",
//               iconColor: AppColors.iconColor1,
//             ),
//             IconAndTextWidget(
//               icon: Icons.location_on,
//               text: "1.7km",
//               iconColor: AppColors.mainColor,
//             ),
//             IconAndTextWidget(
//               icon: Icons.access_time_rounded,
//               text: "32min",
//               iconColor: AppColors.iconColor2,
//             ),
//           ],
//         ),
//       ],
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:food_ordering/Utility/color.dart';
import 'package:food_ordering/Utility/dimensions.dart';
import 'package:food_ordering/widgets/big_text.dart';
import 'package:food_ordering/widgets/icon_and_text_widget.dart';
import 'package:food_ordering/widgets/small_text.dart';
import 'package:intl/intl.dart'; // Package để định dạng tiền tệ

class AppColumn extends StatelessWidget {
  final String text;
  final Color? textColor;
  final Color? starColor;
  final Color? smallTextColor;
  final double price;

  const AppColumn({
    super.key,
    required this.text,
    this.textColor,
    this.starColor,
    this.smallTextColor,
    required this.price,
  });

  @override
  Widget build(BuildContext context) {
    // Định dạng giá với dấu phẩy và ký hiệu ₫ ở cuối
    final NumberFormat currencyFormat = NumberFormat.currency(
      locale: 'vi_VN',
      symbol: '₫',
      decimalDigits: 0,
      customPattern: '#,##0 \u00A4', // Đặt ký hiệu ₫ sau giá
    );
    final String formattedPrice = currencyFormat.format(price);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        BigText(
          text: text,
          size: Dimensions.font26,
          color: textColor ?? AppColors.blackColor,
        ),
        SizedBox(height: Dimensions.height10),
        // Hiển thị giá với icon và style đẹp
        Container(
          padding: EdgeInsets.symmetric(
            horizontal: Dimensions.width10,
            vertical: Dimensions.height5,
          ),
          decoration: BoxDecoration(
            color: Color(0xFFFEEFEF), // Nền hồng nhạt để nổi bật
            borderRadius: BorderRadius.circular(Dimensions.radius10),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.monetization_on, // Icon giá tiền
                size: Dimensions.font16,
                color: Color(0xFFC8102E), // Đồng bộ màu đỏ
              ),
              SizedBox(width: Dimensions.width5),
              Text(
                formattedPrice,
                style: TextStyle(
                  fontSize: Dimensions.font20,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFFC8102E), // Màu đỏ như yêu cầu
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: Dimensions.height15),
      ],
    );
  }
}
