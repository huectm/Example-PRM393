import 'package:example_dart/UI/Screens/HomePage1.dart';
import 'package:example_dart/UI/OrderProduct/Views/Widget/ProductWidget.dart';
import 'package:example_dart/UI/Widgets/ProductWidget1.dart';
import 'package:example_dart/data/models/product.dart';
import 'package:flutter/material.dart';
class Bodywidget extends StatelessWidget {
   Bodywidget({super.key});
   final List<Product> products=[
   new Product(id: "Pd001",caId: 'Ca001' ,name: "Ô tô", image: 'assets/images/dog.jpeg', price: 20),
     new Product(id: "Pd002", caId: 'Ca001',name: "Xe máy", image: 'assets/images/dog.jpeg', price: 30),
     new Product(id: "Pd003",caId: 'Ca002', description: "Annotations are a mechanism for a modeler to provide additional text information for the reader of a BPMN Diagram (see the figure to the right). In this example, the annotations are used to explain the BPMN elements:",name: "Xe đạp", image: 'assets/images/dog.jpeg', price: 30),
   ];

  @override
  Widget build(BuildContext context) {
   return GridView.count(crossAxisCount: 2,
     children: products.map((p)=>
         Productwidget(product:p)).toList(),
   );
  }
}
