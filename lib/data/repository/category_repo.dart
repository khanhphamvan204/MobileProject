import 'package:get/get.dart';
import 'package:food_ordering/data/api/api_client.dart';
import 'package:food_ordering/Utility/app_constants.dart';

class CategoryRepo extends GetxService {
  final ApiClient apiClient;

  CategoryRepo({required this.apiClient});

  Future<Response> getCategoryList() async {
    return await apiClient.getData(AppConstants.CATEGORY_URI);
  }
}
