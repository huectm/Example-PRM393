import 'package:example_dart/data/models/product.dart';
import 'package:example_dart/data/reposistories/product_reposistory.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

part 'ProductViewModel.g.dart';
@riverpod
class Productviewmodel extends _$Productviewmodel
{
  @override
  FutureOr< List<Product>> build()async
  {
    var productRe =ref.watch(productReposistoryProvider);
    return productRe.getAllProduct();
  }
  Future<bool> addProduct(Product p)async
  {
    try {
      await ref.read(productReposistoryProvider).addProduct(p);
      ref.invalidateSelf();
      return true;
    }
    catch (e)
    {   return false;  }
  }
  Future<void> searchProduct(String name) async
  {
    if (name.trim().isEmpty) {
      ref.invalidateSelf();
      return;    }
    state = await AsyncValue.guard(() async {
      return ref
          .read(productReposistoryProvider)
          .searchProductByName(name);
    });
  }

  Future<void> getProductByCategory(String cid) async {
    if (cid.trim().isEmpty) {
      ref.invalidateSelf();
      return;
    } else {
      state = await AsyncValue.guard(() async {
        return ref
            .read(productReposistoryProvider)
            .getProductByCategory(cid);
      });
    }
  }

  Future<bool> editProduct(Product p) async
  {
    try{
      ref.read(productReposistoryProvider).updateProduct(p);
      ref.invalidateSelf();
      return true;
    }
    catch(e){return false;}

  }
  Future <bool> deleteProduct(String prid)async
  {
    try
    {
      await ref.read(productReposistoryProvider).deleteProduct(prid);
      ref.invalidateSelf();
      return true;
    }
    catch(e)
    {
      return false;
    }

  }
}


