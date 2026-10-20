import 'package:example_dart/data/reposistories/DataHelper.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../models/cart_item.dart';
import '../models/product.dart';
import 'dart:async';
import 'package:flutter/widgets.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
//Tên tệp trùng tên tệp với tệp hiện tại
part 'cart_repository.g.dart';

//CartReposistoryProvider
@riverpod
CartRepository cartRepository(Ref ref)
=>CartRepository();

class CartRepository {

  final List<CartItem> _cartItems = [
    CartItem(
      product: Product(
        id: "p1",
        name: "iPhone 15",
        caId: 'Ca002',
        image:
            "https://store.storeimages.cdn-apple.com/4982/as-images.apple.com/is/iphone-15-finish-select-202309-6-1inch-blue.jpeg",
        price: 999,
        discountPercent: 9,
        description: "iPhone 15 mang đến Dynamic Island, camera 48MP.",
      ),
      quantity: 1,
    ),
    CartItem(
      product: Product(
        id: "p2",
        name: "Samsung S24",
        caId: 'Ca001',
        image:
            "https://images.samsung.com/is/image/samsung/p6pim/vn/2401/gallery/vn-galaxy-s24-s921-sm-s921bzydxxv-539316492",
        price: 899,
        discountPercent: 10,
        description: "Samsung Galaxy S24 tích hợp Galaxy AI.",
      ),
      quantity: 2,
    ),
    CartItem(
      product: Product(
        id: "p3",
        name: "Samsung S24",
        caId: 'Ca001',
        image:
        "https://images.samsung.com/is/image/samsung/p6pim/vn/2401/gallery/vn-galaxy-s24-s921-sm-s921bzydxxv-539316492",
        price: 899,
        discountPercent: 10,
        description: "Samsung Galaxy S24 tích hợp Galaxy AI.",
      ),
      quantity: 2,
      isSelected: false
    ),
  ];

  // 1. Lấy danh sách tất cả mặt hàng trong giỏ
  Future<List<CartItem>> getCartItems() async {
   return _cartItems;
  }

  // 2. Thêm sản phẩm vào giỏ hàng
  Future<void> addToCart(Product product, {int quantity = 1}) async{
    final index =
        _cartItems.indexWhere((item) => item.product.id == product.id);
    if (index >= 0) {
       _cartItems[index].quantity += quantity;
      _cartItems[index].isSelected = true;
    } else {
       _cartItems.add(
          CartItem(product: product, quantity: quantity, isSelected: true));
    }
  }

  // 3. Cập nhật số lượng sản phẩm
  Future< void> updateQuantity(String productId, int quantity) async {
    final index =
        _cartItems.indexWhere((item) => item.product.id == productId);
    if (index >= 0) {
      if (quantity > 0) {
        _cartItems[index].quantity = quantity;
      } else {
        _cartItems.removeAt(index);
      }
    }
  }

  // 4. Chọn / Bỏ chọn mua 1 sản phẩm
  void toggleSelectItem(String productId) {
    final index =
        _cartItems.indexWhere((item) => item.product.id == productId);
    if (index >= 0) {
      _cartItems[index].isSelected = !_cartItems[index].isSelected;
    }
  }

  // 5. Chọn tất cả / Bỏ chọn tất cả
  void toggleSelectAll(bool isSelected) {
    for (var item in _cartItems) {
      item.isSelected = isSelected;
    }
  }

  // 6. Xóa 1 sản phẩm khỏi giỏ hàng
   Future< void> removeFromCart(String productId) async {
    _cartItems.removeWhere((item) => item.product.id == productId);
  }

  // 7. Xóa sạch giỏ hàng
  void clearCart() {
    _cartItems.clear();
  }

  // 8. Tính tổng tiền các món ĐƯỢC CHỌN
  int getTotalAmount() {
    int total = 0;
    for (var item in _cartItems) {
      if (item.isSelected) {
        total += item.totalPrice;
      }
    }
    return total;
  }

  // 9. Tính tổng số lượng các món ĐƯỢC CHỌN
  int getTotalQuantity() {
    int count = 0;
    for (var item in _cartItems) {
      if (item.isSelected) {
        count += item.quantity;
      }
    }
    return count;
  }

  // 10. Kiểm tra giỏ hàng có rỗng
  bool isEmpty() => _cartItems.isEmpty;
}
