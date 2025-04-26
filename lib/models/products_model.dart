// class Product {
//   int? _totalSize;
//   int? _typeId;
//   int? _offset;
//   List<ProductModel>? _products;
//   List<ProductModel>? get products => _products;

//   Product({
//     required totalSize,
//     required typeId,
//     required offset,
//     required products,
//   }) {
//     this._totalSize = totalSize;
//     this._typeId = typeId;
//     this._offset = offset;
//     this._products = products;
//   }
//   Product.fromJson(Map<String, dynamic> json) {
//     _totalSize = json['total_size'];
//     _typeId = json['type_id'];
//     _offset = json['offset'];
//     if (json['products'] != null) {
//       _products = <ProductModel>[];
//       if (json['products'] != null) {
//         _products = <ProductModel>[];
//         json['products'].forEach((v) {
//           _products!.add(ProductModel.fromJson(v));
//         });
//       }
//     }
//   }

//   get v => null;
// }

// class ProductModel {
//   int? id;
//   String? name;
//   String? desc;
//   int? price;
//   // int? stars;
//   String? img;
//   // String? location;
//   String? createdAt;
//   String? updatedAt;
//   int? categoryId;

//   ProductModel({
//     this.id,
//     this.name,
//     this.desc,
//     this.price,
//     // this.stars,
//     this.img,
//     // this.location,
//     this.createdAt,
//     this.updatedAt,
//     this.categoryId,
//   });
//   ProductModel.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     name = json['name'];
//     desc = json['desc'];
//     price = json['price'];
//     // stars = json['stars'];
//     img = json['img'];
//     // location = json['location'];
//     createdAt = json['created_at'];
//     updatedAt = json['updated_at'];
//     categoryId = json['category_id'];
//   }
// }
class Product {
  int id;
  String img;
  String name;
  String desc;
  int price;
  int categoryId;
  String createdAt;
  String updatedAt;

  Product({
    required this.id,
    required this.img,
    required this.name,
    required this.desc,
    required this.price,
    required this.categoryId,
    required this.createdAt,
    required this.updatedAt,
  });

  // Factory method để chuyển từ JSON sang đối tượng Product
  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'] as int,
      img: json['img'] as String,
      name: json['name'] as String,
      desc: json['desc'] as String,
      price: json['price'] as int,
      categoryId: json['category_id'] as int,
      createdAt: json['created_at'] as String,
      updatedAt: json['updated_at'] as String,
    );
  }

  // Chuyển đối tượng Product thành JSON (nếu cần)
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'img': img,
      'name': name,
      'desc': desc,
      'price': price,
      'category_id': categoryId,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }
}
