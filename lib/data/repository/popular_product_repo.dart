import 'package:get/get.dart';
import 'package:food_ordering/data/api/api_client.dart';
import 'package:food_ordering/Utility/app_constants.dart';

class PopularProductRepo extends GetxService {
  final ApiClient apiClient;

  PopularProductRepo({required this.apiClient});

  Future<Response> getPopularProductList() async {
    // Gọi API tại endpoint http://10.0.2.2:8000/products/popular cho emulator
    return await apiClient.getData(AppConstants.POPULAR_PRODUCT_URI);
  }
}
