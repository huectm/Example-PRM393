import 'package:example_dart/UI/OrderProduct/Views/Widget/ProductWidget.dart';
import 'package:example_dart/data/models/product.dart';
import 'package:flutter/material.dart';

class Productdetailpage extends StatelessWidget {
  Product product;
  Productdetailpage({required this.product, super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        actions: [
        IconButton(onPressed: (){
          Navigator.pop(context);
        },
          icon: Icon(Icons.home))],),
      body: Productwidget(product: product,),

    );
  }
}
