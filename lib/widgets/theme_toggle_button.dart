// widgets/theme_toggle_button.dart
import 'package:flutter/material.dart';
import 'package:food_ordering/Utility/color.dart';
import 'package:food_ordering/Utility/dimensions.dart';
import 'package:food_ordering/controllers/theme_controller.dart';
import 'package:get/get.dart';

class ThemeToggleButton extends StatelessWidget {
  final ThemeController themeController = Get.find(); // Lấy controller

  ThemeToggleButton({super.key});

  @override
  Widget build(BuildContext context) {
    // Sử dụng Obx để widget này tự động build lại khi isDarkMode thay đổi
    return Obx(
      () => Container(
        margin: EdgeInsets.only(
          right: Dimensions.width15,
        ), // Thêm margin nếu cần
        decoration: BoxDecoration(
          // Sử dụng màu surface từ theme hiện tại cho nền nút
          color: Theme.of(context).colorScheme.surface,
          borderRadius: BorderRadius.circular(Dimensions.radius15),
          boxShadow: [
            BoxShadow(
              // Sử dụng shadowColor từ AppColors đã cập nhật
              color: AppColors.shadowColor.withOpacity(0.1),
              blurRadius: 5,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min, // Chỉ chiếm không gian cần thiết
          children: [
            // Nút Light Mode (Sun)
            InkWell(
              // Chỉ gọi toggleTheme nếu đang ở dark mode
              onTap:
                  themeController.isDarkMode
                      ? () => themeController.toggleTheme()
                      : null,
              child: Container(
                padding: EdgeInsets.all(Dimensions.width10 / 1.5),
                decoration: BoxDecoration(
                  // Highlight nếu đang là light mode
                  color:
                      !themeController.isDarkMode
                          ? AppColors.mainColor
                          : Colors.transparent,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(Dimensions.radius15),
                    bottomLeft: Radius.circular(Dimensions.radius15),
                  ),
                ),
                child: Icon(
                  Icons.wb_sunny_rounded,
                  size: Dimensions.iconSize24 * 0.9,
                  // Đổi màu icon tùy theo trạng thái active
                  color:
                      !themeController.isDarkMode ? Colors.white : Colors.grey,
                ),
              ),
            ),
            // Nút Dark Mode (Moon)
            InkWell(
              // Chỉ gọi toggleTheme nếu đang ở light mode
              onTap:
                  !themeController.isDarkMode
                      ? () => themeController.toggleTheme()
                      : null,
              child: Container(
                padding: EdgeInsets.all(Dimensions.width10 / 1.5),
                decoration: BoxDecoration(
                  // Highlight nếu đang là dark mode
                  color:
                      themeController.isDarkMode
                          ? AppColors.mainColor
                          : Colors.transparent,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(Dimensions.radius15),
                    bottomRight: Radius.circular(Dimensions.radius15),
                  ),
                ),
                child: Icon(
                  Icons.nightlight_round,
                  size: Dimensions.iconSize24 * 0.9,
                  // Đổi màu icon tùy theo trạng thái active
                  color:
                      themeController.isDarkMode ? Colors.white : Colors.grey,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
