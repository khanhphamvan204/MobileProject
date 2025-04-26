// import 'package:flutter/foundation.dart'; // Không cần thiết ở đây
// import 'package:food_ordering/models/products_model.dart'; // Không dùng Product ở đây nữa
import 'package:food_ordering/models/category_model.dart'; // *** Import Category model ***
import 'package:get/get.dart';
import 'package:food_ordering/data/repository/category_repo.dart';

class CategoryController extends GetxController {
  final CategoryRepo categoryRepo;
  CategoryController({required this.categoryRepo});

  // *** Đổi thành List<Category> ***
  List<Category> _categoryList = [];
  List<Category> get categoryList => _categoryList;

  bool _isLoading = false;
  bool get isLoading => _isLoading;
  // bool _isLoaded = false; // Có thể dùng _categoryList.isNotEmpty để thay thế
  // bool get isLoaded => _isLoaded;

  // *** Đổi tên hàm thành getCategoryList ***
  Future<void> getCategoryList() async {
    // Chỉ fetch nếu list đang rỗng, tránh gọi lại không cần thiết
    if (_categoryList.isEmpty) {
      try {
        _isLoading = true;
        update(); // Thông báo bắt đầu loading

        Response response = await categoryRepo.getCategoryList();
        print('Category API Response Status: ${response.statusCode}');
        // print('Category API Response Body: ${response.body}'); // Debug JSON

        if (response.statusCode == 200) {
          _categoryList = []; // Xóa list cũ

          // API Laravel thường trả về JSON object với key 'data' khi dùng Resource Collection
          dynamic responseBody = response.body;
          List<dynamic> categoryData = [];

          if (responseBody is Map<String, dynamic> &&
              responseBody.containsKey('data')) {
            if (responseBody['data'] is List) {
              categoryData = responseBody['data'] as List;
            }
          } else if (responseBody is List) {
            // Nếu API trả về trực tiếp List (không dùng Resource Collection)
            categoryData = responseBody;
          }

          if (categoryData.isNotEmpty) {
            _categoryList.addAll(
              categoryData
                  .map(
                    (json) => Category.fromJson(json),
                  ) // *** Dùng Category.fromJson ***
                  .toList(),
            );
            print('Parsed Categories: ${_categoryList.length}');
          } else {
            print('Category data list is empty or not in expected format.');
          }
          // _isLoaded = true; // Không cần thiết nếu dùng _categoryList.isNotEmpty
        } else {
          Get.snackbar(
            'Error Loading Categories',
            'Failed: ${response.statusText ?? response.statusCode.toString()}', // Hiển thị lỗi rõ hơn
            snackPosition: SnackPosition.BOTTOM,
          );
        }
      } catch (e) {
        print("Error fetching categories: $e"); // Log lỗi chi tiết hơn
        Get.snackbar(
          'Error',
          'An error occurred while fetching categories: $e',
          snackPosition: SnackPosition.BOTTOM,
        );
      } finally {
        _isLoading = false;
        update(); // Thông báo kết thúc loading (thành công hoặc thất bại)
      }
    } else {
      print("Categories already loaded.");
      // Không cần update() nếu không có gì thay đổi
    }
  }
}
