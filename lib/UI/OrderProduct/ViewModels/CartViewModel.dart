import 'package:example_dart/data/models/cart_item.dart';
import 'package:example_dart/data/models/product.dart';
import 'package:example_dart/data/reposistories/cart_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'CartViewModel.g.dart';

@riverpod
class CartViewModel extends _$CartViewModel {
  @override
  FutureOr<List<CartItem>> build() async
  {
    final repository = ref.watch(cartRepositoryProvider);

    return await repository.getCartItems();
  }
 Future<bool> isEmpty()async
 {
   final currentCart = state.value;
   if (currentCart==null)
     return false;
   else
     return currentCart.length>0?true:false;
 }
  // Thêm sản phẩm vào giỏ hàng
  Future<void> addToCart(Product product, {int quantity = 1}) async {
    final repository = ref.read(cartRepositoryProvider);
    await repository.addToCart(product, quantity: quantity);
    //Thông báo cho view biết state thay đổi
    ref.invalidateSelf();
  }

  // Cập nhật số lượng sản phẩm
  Future<void> updateQuantity(String productId, int quantity) async {
    final repository = ref.read(cartRepositoryProvider);
    await repository.updateQuantity(productId, quantity);
    ref.invalidateSelf();
  }

  // Tăng số lượng sản phẩm thêm 1
  Future<void> increaseQuantity(String productId) async {
    final currentCart = state.value;
    if (currentCart != null) {
      final index =
          currentCart.indexWhere((item) => item.product.id == productId);
      if (index >= 0) {
        await updateQuantity(productId, currentCart[index].quantity + 1);
      }
    }
    ref.invalidateSelf();
  }

  // Giảm số lượng sản phẩm đi 1
  Future<void> decreaseQuantity(String productId) async {
    final currentCart = state.value;
    if (currentCart != null) {
      final index =
          currentCart.indexWhere((item) => item.product.id == productId);
      if (index >= 0) {
        await updateQuantity(productId, currentCart[index].quantity - 1);
      }
    }
    ref.invalidateSelf();
  }

  // Tích chọn / Bỏ chọn mua 1 sản phẩm
  Future<void> toggleSelectItem(String productId) async {
    final repository = ref.read(cartRepositoryProvider);
    repository.toggleSelectItem(productId);
    ref.invalidateSelf();
  }

  // Chọn tất cả / Bỏ chọn tất cả
  Future<void> toggleSelectAll(bool isSelected) async {
    final repository = ref.read(cartRepositoryProvider);
    repository.toggleSelectAll(isSelected);
    ref.invalidateSelf();
  }

  // Xóa 1 sản phẩm khỏi giỏ hàng
  Future<void> removeFromCart(String productId) async {
    final repository = ref.read(cartRepositoryProvider);
    await repository.removeFromCart(productId);
    ref.invalidateSelf();
  }

  // Xóa toàn bộ giỏ hàng
  Future<void> clearCart() async {
    final repository = ref.read(cartRepositoryProvider);
    repository.clearCart();
    ref.invalidateSelf();
  }
  int get totalMoney
  {
    final repository = ref.read(cartRepositoryProvider);
    return repository.getTotalAmount();
  }
  int get totalQuantity
  {
    final repository = ref.read(cartRepositoryProvider);
    return repository.getTotalQuantity();

  }
}
