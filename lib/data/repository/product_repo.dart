// import 'package:get/get.dart';
// import 'package:food_ordering/data/api/api_client.dart';
// import 'package:food_ordering/Utility/app_constants.dart';

// class ProductRepo extends GetxService {
//   final ApiClient apiClient;

//   ProductRepo({required this.apiClient});

//   Future<Response> getProductList() async {
//     // Gọi API tại endpoint http://10.0.2.2:8000/products/popular cho emulator
//     return await apiClient.getData(AppConstants.PRODUCT_URI);
//   }
// }
import 'package:food_ordering/data/api/api_client.dart';
import 'package:food_ordering/Utility/app_constants.dart';
import 'package:get/get.dart';

class ProductRepo extends GetxService {
  final ApiClient apiClient;
  ProductRepo({required this.apiClient});

  Future<Response> getProductList({int? categoryId}) async {
    // Xây dựng URI động
    String uri = AppConstants.PRODUCT_URI;
    if (categoryId != null) {
      // Thêm query parameter vào URI nếu có categoryId
      uri += '?category_id=$categoryId';
    }
    print("Fetching products from URI: $uri"); // Debug URI
    return await apiClient.getData(uri);
  }

  Future<Response> getProductById(int id) async {
    String uri =
        '${AppConstants.PRODUCT_URI}/$id'; // Giả sử endpoint là /api/products/:id
    return await apiClient.getData(uri);
  }
}
