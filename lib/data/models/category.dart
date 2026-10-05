import 'product.dart';

class Category {
  final String id;
  final String name;
  final String? image;
  final List<Product> products;

  Category({
    required this.id,
    required this.name,
    this.image,
    List<Product>? products,
  }) : products = products ?? [];

  // Thêm một sản phẩm vào danh mục
  void addProduct(Product product) {
    products.add(product);
  }

  // Xóa sản phẩm khỏi danh mục
  void removeProduct(String productId) {
    products.removeWhere((p) => p.id == productId);
  }

  // Chuyển đổi từ JSON sang đối tượng Category
  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['id'] as String,
      name: json['name'] as String,
      image: json['image'] as String?,
      products: json['products'] != null
          ? (json['products'] as List)
              .map((item) => Product.fromJson(item as Map<String, dynamic>))
              .toList()
          : [],
    );
  }

  // Chuyển đổi từ đối tượng Category sang JSON
  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "name": name,
      "image": image,
      "products": products.map((p) => p.toJson()).toList(),
    };
  }
}
