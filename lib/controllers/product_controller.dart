// import 'package:food_ordering/models/products_model.dart';
// import 'package:get/get.dart';
// import 'package:food_ordering/data/repository/product_repo.dart';

// class ProductController extends GetxController {
//   final ProductRepo productRepo;
//   ProductController({required this.productRepo});

//   List<Product> _productList = [];
//   List<Product> get productList => _productList;

//   bool _isLoading = false;
//   bool get isLoading => _isLoading;
//   bool _isLoaded = false;
//   bool get isLoaded => _isLoaded;

//   Future<void> getProductList() async {
//     try {
//       _isLoading = true;
//       update();

//       Response response = await productRepo.getProductList();
//       // print('API Response: ${response.body}'); // Debug JSON
//       if (response.statusCode == 200) {
//         _productList = [];
//         if (response.body is List) {
//           _productList.addAll(
//             (response.body as List)
//                 .map((json) => Product.fromJson(json))
//                 .toList(),
//           );
//           _isLoaded = true;
//           // print('Parsed Products: ${_productList.length}'); // Debug số lượng
//         }
//         _isLoading = false;
//         update();
//       } else {
//         _isLoading = false;
//         update();
//         Get.snackbar(
//           'Error',
//           'Failed to load products: ${response.statusCode}',
//         );
//       }
//     } catch (e) {
//       _isLoading = false;
//       update();
//       Get.snackbar('Error', 'An error occurred: $e');
//     }
//   }
// }
// import 'package:food_ordering/models/products_model.dart';
// import 'package:get/get.dart';
// import 'package:food_ordering/data/repository/product_repo.dart';

// class ProductController extends GetxController {
//   final ProductRepo productRepo;
//   ProductController({required this.productRepo});

//   List<Product> _productList = [];
//   List<Product> get productList => _productList;

//   bool _isLoading = false;
//   bool get isLoading => _isLoading;
//    bool _isLoaded = false;
//   bool get isLoaded => _isLoaded;

//   // *** Sửa hàm để nhận categoryId ***
//   Future<void> getProductList({int? categoryId}) async {
//     // Thêm tham số optional
//     try {
//       _isLoading = true;
//       update(); // Bắt đầu loading

//       Response response = await productRepo.getProductList(
//         categoryId: categoryId,
//       );
//       print(
//         'Product API Response Status (Category: $categoryId): ${response.statusCode}',
//       );

//       if (response.statusCode == 200) {
//         _productList = []; // Xóa list cũ trước khi thêm mới

//         dynamic responseBody = response.body;
//         List<dynamic> productData = [];

//         // Nếu có phân trang Laravel ('data' key)
//         if (responseBody is Map<String, dynamic> &&
//             responseBody.containsKey('data')) {
//           if (responseBody['data'] is List) {
//             productData = responseBody['data'] as List;
//           }
//         } else if (responseBody is List) {
//           // Nếu API trả về trực tiếp List
//           productData = responseBody;
//         }

//         if (productData.isNotEmpty) {
//           _productList.addAll(
//             productData.map((json) => Product.fromJson(json)).toList(),
//           );
//           print(
//             'Parsed Products (Category: $categoryId): ${_productList.length}',
//           );
//         } else {
//           print('Product data list is empty or not in expected format.');
//           // Không cần báo lỗi ở đây, UI sẽ hiển thị danh sách rỗng
//         }
//         _isLoaded = true;
//       } else {
//         // _isLoaded = false; // Reset nếu lỗi
//         _productList = []; // Xóa list nếu lỗi
//         Get.snackbar(
//           'Error Loading Products',
//           'Failed: ${response.statusText ?? response.statusCode.toString()}',
//           snackPosition: SnackPosition.BOTTOM,
//         );
//       }
//     } catch (e) {
//       print("Error fetching products: $e");
//       // _isLoaded = false; // Reset nếu lỗi
//       _productList = []; // Xóa list nếu lỗi
//       Get.snackbar(
//         'Error',
//         'An error occurred while fetching products: $e',
//         snackPosition: SnackPosition.BOTTOM,
//       );
//     } finally {
//       _isLoading = false;
//       update(); // Kết thúc loading, cập nhật UI
//     }
//   }
// }
import 'package:get/get.dart';
import 'package:food_ordering/data/repository/product_repo.dart';
import 'package:food_ordering/models/products_model.dart';

class ProductController extends GetxController {
  final ProductRepo productRepo;

  ProductController({required this.productRepo});

  var productList = <Product>[].obs;
  var isLoaded = false.obs;

  // Future<void> getProductList({int? categoryId}) async {
  //   try {
  //     isLoaded.value = false;
  //     final response = await productRepo.getProductList(categoryId: categoryId);
  //     if (response.statusCode == 200) {
  //       dynamic responseBody = response.body;
  //       List<dynamic> productData = [];

  //       if (responseBody is Map<String, dynamic> &&
  //           responseBody.containsKey('data')) {
  //         productData = responseBody['data'];
  //       } else if (responseBody is List) {
  //         productData = responseBody;
  //       }

  //       productList.value =
  //           productData.map((json) => Product.fromJson(json)).toList();
  //       isLoaded.value = true;
  //     } else {
  //       Get.snackbar('Lỗi', 'Không thể  tải sản phẩm: ${response.statusText}');
  //     }
  //   } catch (e) {
  //     Get.snackbar('Lỗi', 'Có lỗi xảy ra: $e');
  //   } finally {
  //     isLoaded.value = true;
  //   }
  // }
  Future<void> getProductList({int? categoryId}) async {
    try {
      // isLoaded.value = false;
      print("Bắt đầu gọi API getProductList, categoryId: $categoryId");
      final response = await productRepo.getProductList(categoryId: categoryId);
      print("API Status: ${response.statusCode}, Body: ${response.body}");

      if (response.statusCode == 200) {
        dynamic responseBody = response.body;
        List<dynamic> productData = [];
        print("Response Body Type: ${responseBody.runtimeType}");

        if (responseBody is Map<String, dynamic> &&
            responseBody.containsKey('data')) {
          productData = responseBody['data'];
          print("Dữ liệu từ key 'data': $productData");
        } else if (responseBody is List) {
          productData = responseBody;
          print("Dữ liệu là List: $productData");
        } else {
          print("Định dạng dữ liệu không mong đợi: $responseBody");
        }

        productList.value =
            productData.map((json) => Product.fromJson(json)).toList();
        print("Số sản phẩm đã parse: ${productList.length}");
        isLoaded.value = true;
      } else {
        print("API thất bại: ${response.statusCode} - ${response.statusText}");
        Get.snackbar('Lỗi', 'Không thể tải sản phẩm: ${response.statusText}');
      }
    } catch (e, stackTrace) {
      print("Lỗi trong getProductList: $e");
      print("StackTrace: $stackTrace");
      Get.snackbar('Lỗi', 'Có lỗi xảy ra: $e');
    } finally {
      isLoaded.value = true;
      print("Hoàn tất getProductList, isLoaded: ${isLoaded.value}");
    }
  }

  // Hàm mới để lấy sản phẩm theo ID
  Future<Product?> getProductById(int id) async {
    try {
      final response = await productRepo.getProductById(id);
      if (response.statusCode == 200) {
        return Product.fromJson(response.body);
      } else {
        Get.snackbar('Lỗi', 'Không tìm thấy sản phẩm: ${response.statusText}');
        return null;
      }
    } catch (e) {
      Get.snackbar('Lỗi', 'Có lỗi khi tải sản phẩm: $e');
      return null;
    }
  }
}
