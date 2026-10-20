import 'package:flutter_test/flutter_test.dart';
import 'package:example_dart/data/models/product.dart';
import 'package:example_dart/data/models/cart_item.dart';

void main() {
  group('CartItem Model Unit Tests', () {
    final sampleProduct = Product(
      id: 'p1',
      caId: 'Ca001',
      name: 'iPhone 15',
      image: 'https://example.com/iphone.jpg',
      price: 1000,
      discountPercent: 10,
    );

    test('Tính đúng đơn giá unitPrice sau khi áp dụng giảm giá', () {
      final cartItem = CartItem(product: sampleProduct, quantity: 2);
      // 1000 - 10% = 900
      expect(cartItem.unitPrice, equals(900));
    });

    test('Tính đúng tổng tiền totalPrice = unitPrice * quantity', () {
      final cartItem = CartItem(product: sampleProduct, quantity: 3);
      // 900 * 3 = 2700
      expect(cartItem.totalPrice, equals(2700));
    });

    test('Chuyển đổi toJson và từ fromJson chính xác', () {
      final cartItem = CartItem(
        product: sampleProduct,
        quantity: 5,
        isSelected: true,
      );

      final json = cartItem.toJson();
      final restoredItem = CartItem.fromJson(json);

      expect(restoredItem.product.id, equals(sampleProduct.id));
      expect(restoredItem.product.name, equals(sampleProduct.name));
      expect(restoredItem.quantity, equals(5));
      expect(restoredItem.isSelected, isTrue);
    });
  });
}
