import 'package:example_dart/data/models/product.dart';
import 'package:example_dart/data/reposistories/product_reposistory.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'ProductViewModel1.g.dart';
@riverpod
class Productviewmodel1 extends _$Productviewmodel1
{
  @override
  Future<List<Product>> build() async
  {
    return await ref.read(productReposistoryProvider).
    getAllProduct();
  }
  Future<void> getByCategory(String cid) async
  {
    if (cid.trim().isEmpty)
      {
        ref.invalidateSelf();
      }
    else
      {
        state=await AsyncValue.guard(()async{return
           ref.read(productReposistoryProvider).
           getProductByCategory(cid);
        });
      }
  }

  Future<void> searchByName(String name) async
  {
    if (name.trim().isEmpty)
      {
         ref.invalidateSelf();
      }
    else
      {
        state=AsyncValue.loading();
        state=await AsyncValue.guard(() async
        { return ref.read(productReposistoryProvider)
            .searchProductByName(name);});
      }

  }

}