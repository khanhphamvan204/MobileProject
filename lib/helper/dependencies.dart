import 'package:food_ordering/Utility/app_constants.dart';
import 'package:food_ordering/controllers/auth_controller.dart';
import 'package:food_ordering/controllers/cart_controller.dart';
import 'package:food_ordering/controllers/category_controller.dart';
import 'package:food_ordering/controllers/popular_product_controller.dart';
import 'package:food_ordering/controllers/product_controller.dart';
import 'package:food_ordering/data/api/api_client.dart';
import 'package:food_ordering/data/repository/auth_repo.dart';
import 'package:food_ordering/data/repository/cart_repo.dart';
import 'package:food_ordering/data/repository/category_repo.dart';
import 'package:food_ordering/data/repository/popular_product_repo.dart';
import 'package:food_ordering/data/repository/product_repo.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> init() async {
  final sharedPreferences = await SharedPreferences.getInstance();

  Get.lazyPut(() => sharedPreferences);
  Get.lazyPut(() => ApiClient(baseUrl: AppConstants.BASE_URL));

  Get.lazyPut(
    () => AuthRepo(apiClient: Get.find(), sharedPreferences: Get.find()),
  );
  Get.lazyPut(() => PopularProductRepo(apiClient: Get.find()));
  Get.lazyPut(() => ProductRepo(apiClient: Get.find()));
  Get.lazyPut(() => CategoryRepo(apiClient: Get.find()));
  Get.lazyPut(() => CartRepo(sharedPreferences: Get.find()), fenix: true);

  Get.lazyPut(() => AuthController(authRepo: Get.find()));
  Get.lazyPut(() => PopularProductController(popularProductRepo: Get.find()));
  Get.lazyPut(() => CategoryController(categoryRepo: Get.find()));
  Get.lazyPut(() => ProductController(productRepo: Get.find()));
  Get.put(CartController(cartRepo: Get.find()));
}
