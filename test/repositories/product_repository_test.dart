import 'package:flutter_test/flutter_test.dart';
import 'package:example_dart/data/reposistories/product_reposistory.dart';

void main() {
  group('ProductRepository Unit Tests', () {
    late ProductReposistory productRepo;

    setUp(() {
      productRepo = ProductReposistory();
    });

    test('Lấy danh sách tất cả sản phẩm', () async {
      final products = await productRepo.getAllProduct();
      expect(products.isNotEmpty, isTrue);
    });

    test('Tìm sản phẩm theo ID', () async {
      final index = await productRepo.getProductByID('p1');
      expect(index >= 0, isTrue);
    });

    test('Tìm kiếm sản phẩm theo từ khóa', () async {
      final results = await productRepo.searchProducts('iPhone');
      expect(results.length, equals(1));
      expect(results.first.name, contains('iPhone'));
    });

    test('Sắp xếp sản phẩm theo giá tăng dần', () async {
      final sortedProducts =
          await productRepo.getProductsSortedByPrice(ascending: true);
      expect(sortedProducts.first.price <= sortedProducts.last.price, isTrue);
    });
  });
}
