import 'package:example_dart/data/models/product.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
part 'product_reposistory.g.dart';
@riverpod
ProductReposistory productReposistory(Ref ref)
=>ProductReposistory();

class ProductReposistory {
  List<Product> products = [];
  ProductReposistory() {
    // Khởi tạo danh sách sản phẩm mẫu
    products = [
      Product(
        id: "p1",
        name: "iPhone 15",
        caId: 'Ca001',
        image:
            "https://store.storeimages.cdn-apple.com/4982/as-images.apple.com/is/iphone-15-finish-select-202309-6-1inch-blue.jpeg",
        price: 999,
        discountPercent: 9,
        description:
            "iPhone 15 mang đến Dynamic Island, camera chính 48MP và cổng USB-C tiện lợi.",
      ),
      Product(
        id: "p2",
        caId: 'Ca001',
        name: "Samsung S24",
        image:
            "https://images.samsung.com/is/image/samsung/p6pim/vn/2401/gallery/vn-galaxy-s24-s921-sm-s921bzydxxv-539316492",
        price: 899,
        discountPercent: 10,
        description:
            "Samsung Galaxy S24 tích hợp Galaxy AI đột phá, màn hình 120Hz rực rỡ.",
      ),
      Product(
        id: "p3",
        caId: 'Ca002',
        name: "MacBook Air",
        image:
            "https://store.storeimages.cdn-apple.com/4982/as-images.apple.com/is/macbook-air-space-gray-select-201810",
        price: 1200,
        discountPercent: 7,
        description:
            "MacBook Air siêu mỏng nhẹ, hiệu năng mạnh mẽ với chip Apple Silicon M2.",
      ),
    ];
  }
  // 1. Lấy toàn bộ danh sách sản phẩm
  Future<List<Product>> getAllProduct() async {
    return products;
  }

 Future<List<Product>> searchProductByName(String name) async
 {
   return await products.where((p)=>
       p.name.toLowerCase().contains(name.toLowerCase())).
   toList();
 }
 Future<List<Product>> getProductByCategory(String cid) async
  {
    return await products.where((p)=>p.caId==cid).toList();
  }
  Future<int> getProductByID(String id) async
  {
    return await products.indexWhere((p)=>p.id==id);
  }
  // 3. Thêm mới sản phẩm (Báo lỗi nếu trùng ID)
  Future<void> addProduct(Product p) async {
    final i = await getProductByID(p.id);
    if (i>=0) {
      throw Exception("Sản phẩm có ID '${p.id}' đã tồn tại!");
    }
    products.add(p);
  }

  // 4. Cập nhật thông tin sản phẩm
  Future<void> updateProduct(Product p) async {
    final index = products.indexWhere((item) => item.id == p.id);
    if (index >= 0) {      products[index] = p;
    } else {
      throw Exception("Không tìm thấy sản phẩm có ID: ${p.id}");
    }
  }

  // 5. Xóa sản phẩm theo ID
  Future<void> deleteProduct(String id) async {
    final index = products.indexWhere((p) => p.id == id);
    if (index >= 0) {
      products.removeAt(index);
    } else {
      throw Exception("Không tìm thấy sản phẩm có ID: $id để xóa");
    }
  }

  // 6. Tìm kiếm sản phẩm theo từ khóa (Tên hoặc Mô tả)
  Future<List<Product>> searchProducts(String query) async {
    if (query.trim().isEmpty) return products;
    final lowerQuery = query.toLowerCase();
    return products.where((p) {
      final nameMatches = p.name.toLowerCase().contains(lowerQuery);
      final descMatches =
          p.description != null && p.description!.toLowerCase().contains(lowerQuery);
      return nameMatches || descMatches;
    }).toList();
  }

  // 8. Lấy danh sách sản phẩm có giảm giá
  Future<List<Product>> getDiscountedProducts() async {
    return products
        .where((p) => p.discountPercent != null && p.discountPercent! > 0)
        .toList();
  }

  // 9. Sắp xếp sản phẩm theo giá
  Future<List<Product>> getProductsSortedByPrice({bool ascending = true}) async {
    final sortedList = List<Product>.from(products);
    sortedList.sort((a, b) {
      final priceA = a.discountPercent != null && a.discountPercent! > 0
          ? a.price * (100 - a.discountPercent!) / 100
          : a.price;
      final priceB = b.discountPercent != null && b.discountPercent! > 0
          ? b.price * (100 - b.discountPercent!) / 100
          : b.price;
      return ascending ? priceA.compareTo(priceB) : priceB.compareTo(priceA);
    });
    return sortedList;
  }
}
