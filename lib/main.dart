import 'package:example_dart/UI/OrderProduct/Views/Screen/ProductDetailPage.dart';
import 'package:example_dart/data/models/product.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'UI/OrderProduct/Views/Screen/HomePagenew.dart';
import 'data/reposistories/cart_repository.dart';
import 'data/reposistories/product_reposistory.dart';

void main() {
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final cartRepo = CartRepository();
    final productRepo = ProductReposistory();

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Product Store',
      routes:
      {
        //'/':(context){return Homepagenew();},
         '/ProductDetail': (context) {
final product =
ModalRoute.of(context)!.settings.arguments
as Product;
return Productdetailpage(product: product,);
   },},
      home: Homepagenew(

      ),
    );
  }
}
