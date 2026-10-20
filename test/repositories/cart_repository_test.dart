import 'package:flutter_test/flutter_test.dart';
import 'package:example_dart/data/models/product.dart';
import 'package:example_dart/data/reposistories/cart_repository.dart';

void main() {
  group('CartRepository Unit Tests', () {
    late CartRepository cartRepo;
    late Product product1;
    late Product product2;

    setUp(() {
      cartRepo = CartRepository();
      cartRepo.clearCart();

      product1 = Product(
        id: 'p1',
        caId: 'Ca001',
        name: 'iPhone 15',
        image: 'https://example.com/iphone.jpg',
        price: 1000,
        discountPercent: 10, // Price after discount = 900
      );

      product2 = Product(
        id: 'p2',
        caId: 'Ca002',
        name: 'Samsung S24',
        image: 'https://example.com/s24.jpg',
        price: 800,
        discountPercent: 0, // Price = 800
      );
    });

    test('Thêm sản phẩm mới vào giỏ hàng', () async {
      await cartRepo.addToCart(product1, quantity: 2);
      final items = await cartRepo.getCartItems();

      expect(items.length, equals(1));
      expect(items.first.product.id, equals('p1'));
      expect(items.first.quantity, equals(2));
    });

    test('Tăng số lượng khi thêm cùng sản phẩm vào giỏ hàng', () async {
      await cartRepo.addToCart(product1, quantity: 1);
      await cartRepo.addToCart(product1, quantity: 2);

      final items = await cartRepo.getCartItems();
      expect(items.length, equals(1));
      expect(items.first.quantity, equals(3));
    });

    test('Tính đúng tổng số tiền và số lượng các sản phẩm được chọn', () async {
      await cartRepo.addToCart(product1, quantity: 2); // 900 * 2 = 1800
      await cartRepo.addToCart(product2, quantity: 1); // 800 * 1 = 800

      expect(cartRepo.getTotalQuantity(), equals(3));
      expect(cartRepo.getTotalAmount(), equals(2600));

      // Bỏ chọn sản phẩm 2
      cartRepo.toggleSelectItem('p2');

      expect(cartRepo.getTotalQuantity(), equals(2));
      expect(cartRepo.getTotalAmount(), equals(1800));
    });

    test('Xóa sản phẩm khỏi giỏ hàng', () async {
      await cartRepo.addToCart(product1);
      await cartRepo.addToCart(product2);

      await cartRepo.removeFromCart('p1');

      final items = await cartRepo.getCartItems();
      expect(items.length, equals(1));
      expect(items.first.product.id, equals('p2'));
    });
  });
}
