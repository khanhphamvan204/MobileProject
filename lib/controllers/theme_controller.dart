// theme_controller.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeController extends GetxController {
  // Sử dụng .obs để biến này có thể được theo dõi bởi GetX
  final _isDarkMode = false.obs;
  static const String _themeKey =
      'isDarkMode'; // Key để lưu vào SharedPreferences

  // Getter để lấy giá trị hiện tại
  bool get isDarkMode => _isDarkMode.value;

  // Getter để cung cấp ThemeMode cho GetMaterialApp
  ThemeMode get themeMode =>
      _isDarkMode.value ? ThemeMode.dark : ThemeMode.light;

  @override
  void onInit() {
    super.onInit();
    _loadThemeFromPrefs(); // Tải theme đã lưu khi controller khởi tạo
  }

  // Tải trạng thái theme từ SharedPreferences
  Future<void> _loadThemeFromPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    // Lấy giá trị đã lưu, nếu không có thì mặc định là false (light mode)
    _isDarkMode.value = prefs.getBool(_themeKey) ?? false;
    // Cập nhật theme của ứng dụng ngay lập tức
    Get.changeThemeMode(themeMode);
  }

  // Lưu trạng thái theme vào SharedPreferences
  Future<void> _saveThemeToPrefs(bool isDark) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool(_themeKey, isDark);
  }

  // Hàm để chuyển đổi theme
  void toggleTheme() {
    _isDarkMode.value = !_isDarkMode.value; // Đảo ngược trạng thái
    _saveThemeToPrefs(_isDarkMode.value); // Lưu trạng thái mới
    Get.changeThemeMode(
      themeMode,
    ); // Yêu cầu GetX thay đổi theme của MaterialApp
    update(); // Thông báo cho các widget đang lắng nghe (ví dụ: GetBuilder, Obx) cập nhật
  }
}
