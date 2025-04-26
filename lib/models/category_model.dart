class Category {
  int id;
  String name;
  String desc;
  String createdAt;
  String updatedAt;

  Category({
    required this.id,
    required this.name,
    required this.desc,
    required this.createdAt,
    required this.updatedAt,
  });

  // Factory method để chuyển từ JSON sang đối tượng Category
  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['id'] as int,
      name: json['name'] as String,
      desc: json['desc'] as String,
      createdAt: json['created_at'] as String,
      updatedAt: json['updated_at'] as String,
    );
  }

  // Chuyển đối tượng Category thành JSON (nếu cần)
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'desc': desc,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }
}
