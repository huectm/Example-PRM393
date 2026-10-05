import 'package:example_dart/UI/Widgets/ProductWidget1.dart';
import 'package:example_dart/data/models/product.dart';
import 'package:flutter/material.dart';

class Productdetailpage1 extends StatelessWidget {
  Product product;
  Productdetailpage1({required this.product, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(actions: [
        IconButton(onPressed: (){Navigator.pop(context);}, icon:
      Icon(Icons.home,color: Colors.blueAccent,))],),
      body: Productwidget1(product: product) ,
    );
  }
}
