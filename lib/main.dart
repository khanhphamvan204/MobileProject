// import 'package:flutter/material.dart';
// import 'package:food_ordering/pages/food/popular_food_detail.dart';
// import 'package:food_ordering/pages/food/recommended_food_detail.dart';
// import 'package:get/get.dart';
// import 'package:food_ordering/pages/home/main_food_page.dart';

// void main() {
//   runApp(const MainApp());
// }

// class MainApp extends StatelessWidget {
//   const MainApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return GetMaterialApp(
//       title: "Food App",
//       debugShowCheckedModeBanner: false,
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//         scaffoldBackgroundColor: Colors.white,
//       ),
//       home: MainFoodPage(),
//     );
//   }
// }
// main.dart
import 'package:flutter/material.dart';
import 'package:food_ordering/controllers/cart_controller.dart';
import 'package:food_ordering/controllers/popular_product_controller.dart';
import 'package:food_ordering/controllers/product_controller.dart';
import 'package:food_ordering/pages/auth/sign_in_page.dart';
import 'package:food_ordering/pages/auth/sign_up_page.dart';
import 'package:food_ordering/pages/cart/cart_page.dart';
import 'package:food_ordering/pages/home/food_page_body.dart';
import 'package:food_ordering/pages/home/home_page.dart';
import 'package:food_ordering/pages/home/main_food_page.dart'; // Trang chính của bạn
import 'package:food_ordering/pages/splash/splash_page.dart';
import 'package:food_ordering/routes/route_helper.dart';
import 'package:get/get.dart';
import 'package:food_ordering/controllers/theme_controller.dart'; // Import controller
import 'package:food_ordering/helper/dependencies.dart' as dep;
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  Future<void> clearAllPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }

  // Đảm bảo Flutter binding đã sẵn sàng trước khi chạy bất cứ thứ gì async
  WidgetsFlutterBinding.ensureInitialized();
  await dep.init();
  // Khởi tạo ThemeController sử dụng Get.put()
  // await Get.putAsync(() async => ThemeController()); // Nếu cần khởi tạo bất đồng bộ
  Get.put(ThemeController()); // Khởi tạo đồng bộ
  // clearAllPreferences();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // Lấy instance của ThemeController
  final ThemeController themeController = Get.find();

  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    Get.find<PopularProductController>().getPopularProductList();
    Get.find<ProductController>().getProductList();
    Get.find<CartController>().getCartData();
    // GetMaterialApp sẽ tự động lắng nghe thay đổi theme từ Get.changeThemeMode
    return GetMaterialApp(
      title: 'Food Ordering App',
      debugShowCheckedModeBanner: false,

      // --- Định nghĩa ThemeData cho Light Mode ---
      theme: ThemeData(
        brightness: Brightness.light,
        primaryColor: Color(0xFFC8A97E), // Màu gốc mainColor
        scaffoldBackgroundColor: Colors.grey[100],
        fontFamily: "Roboto", // Chọn font chữ nếu có
        colorScheme: ColorScheme.light(
          primary: Color(0xFFC8A97E), // mainColor
          secondary: Color(0xFFfcab88), // iconColor2
          background: Colors.grey[100]!,
          surface: Colors.white, // Màu nền cho Card, Dialog,...
          onPrimary: Colors.white, // Màu chữ/icon trên nền primary
          onSecondary: Colors.black, // Màu chữ/icon trên nền secondary
          onBackground: Color(0xFF332d2b), // Màu chữ/icon trên nền background
          onSurface: Color(0xFF332d2b), // Màu chữ/icon trên nền surface
          brightness: Brightness.light,
          error: Colors.red,
          onError: Colors.white,
        ),
        // Định nghĩa thêm các thuộc tính khác như textTheme, appBarTheme... nếu cần
        textTheme: TextTheme(
          bodyLarge: TextStyle(color: Color(0xFF5c524f)), // titleColor gốc
          bodyMedium: TextStyle(color: Color(0xFF8f837f)), // paraColor gốc
          // Thêm các style khác nếu cần
        ),
      ),

      // --- Định nghĩa ThemeData cho Dark Mode ---
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: Color(0xFFD4B996), // Màu mainColor cho dark mode
        scaffoldBackgroundColor: Color(0xFF121212), // Màu nền tối chuẩn
        fontFamily: "Roboto", // Chọn font chữ nếu có
        colorScheme: ColorScheme.dark(
          primary: Color(0xFFD4B996), // mainColor dark
          secondary: Color(0xFFFFBDA1), // iconColor2 dark
          background: Color(0xFF121212),
          surface: Color(0xFF1e1e1e), // Màu nền tối hơn cho Card, Dialog,...
          onPrimary: Colors.black,
          onSecondary: Colors.black,
          onBackground: Colors.white70,
          onSurface: Colors.white, // Chữ/icon trên nền tối
          brightness: Brightness.dark,
          error: Colors.redAccent,
          onError: Colors.black,
        ),
        // Định nghĩa thêm các thuộc tính khác
        textTheme: TextTheme(
          bodyLarge: TextStyle(color: Colors.white), // Chữ chính màu trắng
          bodyMedium: TextStyle(color: Colors.white60), // Chữ phụ màu trắng mờ
          // Thêm các style khác nếu cần
        ),
      ),

      // Lấy theme mode từ controller
      themeMode: themeController.themeMode,

      // Trang bắt đầu của ứng dụng
      // home: HomePage(),
      initialRoute: RouteHelper.getSplashPage(),
      getPages: RouteHelper.routes,
    );
  }
}
