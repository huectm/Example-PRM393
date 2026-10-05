import 'dart:convert';
import 'product.dart';

class CartItem {
  final Product product;
  int quantity;
  bool isSelected; // Thuộc tính xác định người dùng chọn mua hay không

  CartItem({
    required this.product,
    this.quantity = 1,
    this.isSelected = true, // Mặc định là được chọn khi thêm vào giỏ
  });

  // 1. Chuyển từ Map (JSON) sang CartItem
  factory CartItem.fromJson(Map<String, dynamic> json) {
    return CartItem(
      product: Product.fromJson(json['product'] as Map<String, dynamic>),
      quantity: json['quantity'] as int? ?? 1,
      isSelected: json['isSelected'] as bool? ?? true,
    );
  }

  // 2. Chuyển từ CartItem sang Map (JSON)
  Map<String, dynamic> toJson() {
    return {
      'product': product.toJson(),
      'quantity': quantity,
      'isSelected': isSelected,
    };
  }

  // 3. Chuyển từ Chuỗi JSON (String) sang CartItem
  factory CartItem.fromJsonString(String jsonString) {
    return CartItem.fromJson(jsonDecode(jsonString) as Map<String, dynamic>);
  }

  // 4. Chuyển từ CartItem sang Chuỗi JSON (String)
  String toJsonString() {
    return jsonEncode(toJson());
  }

  // Giá đã sau khi giảm (nếu có)
  int get unitPrice {
    if (product.discountPercent != null && product.discountPercent! > 0) {
      return (product.price * (100 - product.discountPercent!) / 100).toInt();
    }
    return product.price.toInt();
  }
  // Tổng tiền của món này = Giá x Số lượng
  int get totalPrice => unitPrice * quantity;
}
