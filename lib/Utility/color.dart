// import 'dart:ui';

// class AppColors {
//   static final Color textColor = Color(0xFFccc7c5);
//   static final Color mainColor = Color(0xFFC8A97E);
//   static final Color iconColor1 = Color(0xFFffd28d);
//   static final Color iconColor2 = Color(0xFFfcab88);
//   static final Color paraColor = Color(0xFF8f837f);
//   static final Color buttonBackgroundColor = Color(0xFFf7f6f4);
//   static final Color signColor = Color(0xFFa9a29f);
//   static final Color titleColor = Color(0xFF5c524f);
//   static final Color mainBlackColor = Color(0xFF332d2b);
//   static final Color yellowColor = Color(0xFFffd379);
// }
// Utility/color.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/theme_controller.dart'; // Đảm bảo đường dẫn đúng

class AppColors {
  // Lấy instance của ThemeController đã được khởi tạo (ở main.dart)
  static final ThemeController _themeController = Get.find<ThemeController>();

  // --- Các màu sẽ thay đổi theo theme ---
  static Color get textColor =>
      _themeController.isDarkMode ? Colors.white70 : Color(0xFFccc7c5);
  static Color get whiteColor =>
      _themeController.isDarkMode ? Colors.black : Colors.white;
  static Color get blackColor =>
      _themeController.isDarkMode ? Colors.white : Colors.black;
  static Color get mainColor =>
      _themeController.isDarkMode
          ? Color(0xFFD4B996)
          : Color(0xFFC8A97E); // Có thể điều chỉnh màu dark mode
  static Color get iconColor1 =>
      _themeController.isDarkMode ? Color(0xFFFFE0A6) : Color(0xFFffd28d);
  static Color get iconColor2 =>
      _themeController.isDarkMode ? Color(0xFFFFBDA1) : Color(0xFFfcab88);
  static Color get paraColor =>
      _themeController.isDarkMode ? Colors.white60 : Color(0xFF8f837f);
  static Color get buttonBackgroundColor =>
      _themeController.isDarkMode ? Color(0xFF424242) : Color(0xFFf7f6f4);
  static Color get signColor =>
      _themeController.isDarkMode ? Colors.white54 : Color(0xFFa9a29f);
  static Color get titleColor =>
      _themeController.isDarkMode ? Colors.white : Color(0xFF5c524f);
  static Color get mainBlackColor =>
      _themeController.isDarkMode
          ? Colors.white
          : Color(0xFF332d2b); // Thường là màu chữ trắng trong dark mode
  static Color get yellowColor =>
      _themeController.isDarkMode ? Color(0xFFFFE599) : Color(0xFFffd379);

  // --- Thêm các màu cho background và các element khác trong dark mode ---
  static Color get pageBackground =>
      _themeController.isDarkMode
          ? Color(0xFF121212)
          : Colors.grey[100] ?? Colors.white; // Màu nền chung
  static Color get listItemBackground =>
      _themeController.isDarkMode
          ? Color(0xFF1e1e1e)
          : Colors.white; // Màu nền item trong list
  static Color get cardBackground =>
      _themeController.isDarkMode
          ? Color(0xFF2a2a2a)
          : Colors.white; // Màu nền card (PageView item info)
  static Color get shadowColor =>
      _themeController.isDarkMode
          ? Colors.black.withOpacity(0.4)
          : Color(0xFFe8e8e8);
  static Color get popularDotColor =>
      _themeController.isDarkMode ? Colors.grey[600]! : Colors.black26;
  static Color get pageViewContainerColor1 =>
      _themeController.isDarkMode
          ? Color(0xFF005b73)
          : Color(0xFF69c5df); // Màu nền container pageview (even)
  static Color get pageViewContainerColor2 =>
      _themeController.isDarkMode
          ? Color(0xFF4a4e8c)
          : Color(0xFF9294cc); // Màu nền container pageview (odd)
}
