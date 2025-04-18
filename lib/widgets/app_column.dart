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

class AppColumn extends StatelessWidget {
  final String text;
  final Color? textColor;
  final Color? starColor;
  final Color? smallTextColor;

  const AppColumn({
    super.key,
    required this.text,
    this.textColor,
    this.starColor,
    this.smallTextColor,
  });
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        BigText(
          text: text,
          size: Dimensions.font26,
          color: textColor ?? AppColors.blackColor,
        ),
        SizedBox(height: Dimensions.height10),
        Row(
          children: [
            Wrap(
              children: List.generate(5, (index) {
                return Icon(
                  Icons.star,
                  color: starColor ?? AppColors.yellowColor,
                  size: 15,
                );
              }),
            ),
            SizedBox(width: Dimensions.width10),
            SmallText(text: "4.5", color: smallTextColor),
            SizedBox(width: Dimensions.width10),
            SmallText(text: "1287", color: smallTextColor),
            SizedBox(width: Dimensions.width10),
            SmallText(text: "comments", color: smallTextColor),
          ],
        ),
        SizedBox(height: Dimensions.width15),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconAndTextWidget(
              icon: Icons.circle_sharp,
              text: "Normal",
              iconColor: AppColors.iconColor1,
            ),
            IconAndTextWidget(
              icon: Icons.location_on,
              text: "1.7km",
              iconColor: AppColors.mainColor,
            ),
            IconAndTextWidget(
              icon: Icons.access_time_rounded,
              text: "32min",
              iconColor: AppColors.iconColor2,
            ),
          ],
        ),
      ],
    );
  }
}
