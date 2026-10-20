import 'dart:ffi';

import 'package:example_dart/data/models/cartItem.dart';
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
part 'cartItemReposistory.g.dart';

//CartReposistoryProvider
@riverpod
CartItemRepository cartItemRepository(Ref ref)
=>CartItemRepository();

class CartItemRepository {
  List<CartItems> _cartItems=[];

  CartRepository()
  {

  }

  // 1. Lấy danh sách tất cả mặt hàng trong giỏ
  Future<List<CartItems>> getCartItems(String pid) async {
    final db=await Datahelper.instance.database;
    List<Map<String, dynamic>> carts=
    await db.query('CartItems');
    return carts.map((c)=>CartItems(
        proId: c['proId'] as String,
        price: int.parse(c['price'] as String),
        isSelected: c['isSelected'] as bool,
        quantity: int.parse(c['quantity'] as String))).toList();
  }

  // 2. Thêm sản phẩm vào giỏ hàng
  Future<void> addToCart(String proId, {int quantity = 1}) async{
   var db=await Datahelper.instance.database;
   var carts=await db.query('CartItems',where: 'proId=?',
   whereArgs: [proId]);
   var cart= carts==null?null:carts.first;


   if(cart!=null) //Update
     {
     cart!['quantity']= int.parse(cart!['quantity'] as String) +1;
       db.update('CartItems',cart);
   }
   else  //add
     {
       db.insert('CartItems', cart!);

     }

  }

  // 3. Cập nhật số lượng sản phẩm
  Future< void> updateQuantity(String proId, int quantity,) async {
    var db=await Datahelper.instance.database;
    db.update("CartItems",CartItems(proId:proId,quantity: quantity,isSelected: true).toJson(),where: 'proId=?',whereArgs: [proId]);
  }
  // 4. Chọn / Bỏ chọn mua 1 sản phẩm
  Future<void> toggleSelectItem(String proId) async{
    var db=await Datahelper.instance.database;
    db.update("CartItems",CartItems(proId:proId,quantity: quantity,isSelected: true).toJson(),where: 'proId=?',whereArgs: [proId]);
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
