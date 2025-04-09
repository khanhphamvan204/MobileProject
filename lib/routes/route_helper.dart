import 'package:food_ordering/pages/food/popular_food_detail.dart';
import 'package:food_ordering/pages/food/recommended_food_detail.dart';
import 'package:food_ordering/pages/home/main_food_page.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/get_navigation.dart';

class RouteHelper {
  static const String initial = '/';
  static const String popularFood = '/popular-food';
  static String getInitial() => '$initial';
  static String getPopularFood(int pageId) => '$popularFood?pageId=$pageId';
  static const String recommendedFood = '/recommended-food';
  static String getRecommendedFood() => '$recommendedFood';
  static const String cart = '/cart';
  static const String splash = '/splash';
  static const String signIn = '/sign-in';
  static const String signUp = '/sign-up';
  static const String forgotPassword = '/forgot-password';
  static const String resetPassword = '/reset-password';
  static const String orderDetails = '/order-details';

  static List<GetPage> routes = [
    GetPage(name: initial, page: () => MainFoodPage()),
    GetPage(
      name: popularFood,
      page: () {
        var pageId = Get.parameters['pageId'];
        return PopularFoodDetail(pageId: int.parse(pageId!));
      },
      transition: Transition.fadeIn,
    ),
    GetPage(name: recommendedFood, page: () => RecommendedFoodDetail()),
    // GetPage(name: cart, page: () => CartScreen()),
    // GetPage(name: signIn, page: () => SignInScreen()),
    // GetPage(name: signUp, page: () => SignUpScreen()),
    // GetPage(name: forgotPassword, page: () => ForgotPasswordScreen()),
    // GetPage(name: resetPassword, page: () => ResetPasswordScreen()),
    // GetPage(name: orderDetails, page: () => OrderDetailsScreen()),
  ];
  // Add more routes as needed
}
