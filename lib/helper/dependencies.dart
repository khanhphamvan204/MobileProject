import 'package:food_ordering/Utility/app_constants.dart';
import 'package:food_ordering/controllers/popular_product_controller.dart';
import 'package:food_ordering/data/api/api_client.dart';
import 'package:food_ordering/data/repository/popular_product_repo.dart';
import 'package:get/get.dart';

Future<void> init() async {
  Get.lazyPut(() => ApiClient(appBaseUrl: AppConstants.BASE_URL));

  Get.lazyPut(() => PopularProductRepo(apiClient: Get.find()));

  Get.lazyPut(() => PopularProductController(popularProductRepo: Get.find()));
}
