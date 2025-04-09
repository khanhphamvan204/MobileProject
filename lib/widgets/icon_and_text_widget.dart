// import 'package:flutter/material.dart';
// import 'package:food_ordering/Utility/dimensions.dart';
// import 'package:food_ordering/widgets/small_text.dart';

// class IconAndTextWidget extends StatelessWidget {
//   final IconData icon;
//   final String text;
//   final Color iconColor;

//   const IconAndTextWidget({
//     super.key,
//     required this.icon,
//     required this.text,
//     required this.iconColor,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       children: [
//         Icon(icon, color: iconColor, size: Dimensions.iconSize24),
//         const SizedBox(width: 5),
//         SmallText(text: text),
//       ],
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:food_ordering/Utility/dimensions.dart';
import 'package:food_ordering/widgets/small_text.dart';
// Có thể bạn sẽ cần import AppColors nếu muốn đặt màu mặc định ở đây,
// nhưng tốt hơn là để SmallText tự xử lý màu mặc định dựa trên theme.
// import 'package:food_ordering/Utility/color.dart';

class IconAndTextWidget extends StatelessWidget {
  final IconData icon;
  final String text;
  final Color iconColor;
  final Color? textColor; // <-- 1. Thêm thuộc tính textColor (nullable)

  const IconAndTextWidget({
    super.key, // Sử dụng super.key cho Flutter hiện đại
    required this.icon,
    required this.text,
    required this.iconColor,
    this.textColor, // <-- 2. Thêm vào constructor (là tham số tùy chọn)
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, color: iconColor, size: Dimensions.iconSize24),
        const SizedBox(width: 5),
        SmallText(
          text: text,
          color: textColor, // <-- 3. Truyền textColor vào SmallText
          // Nếu textColor là null (không được cung cấp khi gọi IconAndTextWidget),
          // thì SmallText nên tự sử dụng màu mặc định của nó (lý tưởng là màu theo theme)
        ),
      ],
    );
  }
}
