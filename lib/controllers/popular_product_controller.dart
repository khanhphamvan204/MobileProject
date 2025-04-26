// import 'package:food_ordering/models/products_model.dart';
// import 'package:get/get.dart';
// import 'package:food_ordering/data/repository/popular_product_repo.dart';

// class PopularProductController extends GetxController {
//   final PopularProductRepo popularProductRepo;
//   PopularProductController({required this.popularProductRepo});
//   List<dynamic> _popularProductList = [];
//   List<dynamic> get popularProductList => _popularProductList;
//   Future<void> getPopularProductList() async {
//     Response response = await popularProductRepo.getPopularProductList();
//     if (response.statusCode == 200) {
//       _popularProductList = [];
//       _popularProductList.addAll(
//         Product.fromJson(response.body).products as Iterable,
//       );
//       update();
//     } else {}
//   }
// }
import 'package:food_ordering/models/products_model.dart';
import 'package:get/get.dart';
import 'package:food_ordering/data/repository/popular_product_repo.dart';

class PopularProductController extends GetxController {
  final PopularProductRepo popularProductRepo;
  PopularProductController({required this.popularProductRepo});

  List<Product> _popularProductList = [];
  List<Product> get popularProductList => _popularProductList;

  bool _isLoading = false;
  bool get isLoading => _isLoading;
  bool _isLoaded = false;
  bool get isLoaded => _isLoaded;

  Future<void> getPopularProductList() async {
    try {
      _isLoading = true;
      update();

      Response response = await popularProductRepo.getPopularProductList();
      // print('API Response: ${response.body}'); // Debug JSON
      if (response.statusCode == 200) {
        _popularProductList = [];
        if (response.body is List) {
          _popularProductList.addAll(
            (response.body as List)
                .map((json) => Product.fromJson(json))
                .toList(),
          );
          _isLoaded = true;
          // print(
          //   'Parsed Products: ${_popularProductList.length}',
          // ); // Debug số lượng
        }
        _isLoading = false;
        update();
      } else {
        _isLoading = false;
        update();
        Get.snackbar(
          'Error',
          'Failed to load products: ${response.statusCode}',
        );
      }
    } catch (e) {
      _isLoading = false;
      update();
      Get.snackbar('Error', 'An error occurred: $e');
    }
  }
}
