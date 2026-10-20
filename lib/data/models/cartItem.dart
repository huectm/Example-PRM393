import 'dart:convert';
import 'product.dart';

class CartItems {
  String proId;
  int quantity;
  int price;
  bool isSelected; // Thuộc tính xác định người dùng chọn mua hay không
  CartItems CopyTo({int? price, int? quantity, bool? isSelected})
  {
    return CartItems(proId: proId,
        price: price??this.price,
       quantity: quantity??this.quantity,
      isSelected:isSelected??this.isSelected
    );
  }
  CartItems({
    required this.proId,
    required this.price,
    this.quantity = 1,
    this.isSelected = true, // Mặc định là được chọn khi thêm vào giỏ
  });

  // 1. Chuyển từ Map (JSON) sang CartItem
  factory CartItems.fromJson(Map<String, dynamic> json) {
    return CartItems(
      proId: json['proid'],
      price: json['price'],
      quantity: json['quantity'] as int? ?? 1,
      isSelected: json['isSelected'] as bool? ?? true,
    );
  }

  // 2. Chuyển từ CartItem sang Map (JSON)
  Map<String, dynamic> toJson() {
    return {
      'proid': proId,
      'price':price,
      'quantity': quantity,
      'isSelected': isSelected,
    };
  }

  // 3. Chuyển từ Chuỗi JSON (String) sang CartItem
  factory CartItems.fromJsonString(String jsonString) {
    return CartItems.fromJson(jsonDecode(jsonString) as Map<String, dynamic>);
  }

  // 4. Chuyển từ CartItem sang Chuỗi JSON (String)
  String toJsonString() {
    return jsonEncode(toJson());
  }
}
