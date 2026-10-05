import 'package:example_dart/UI/OrderProduct/ViewModels/CartViewModel.dart';
import 'package:example_dart/UI/OrderProduct/ViewModels/ProductViewModel.dart';
import 'package:example_dart/UI/OrderProduct/Views/Screen/ProductDetailPage.dart';
import 'package:example_dart/data/models/product.dart';
import 'package:example_dart/UI/OrderProduct/Views/Widget/ProductCardWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Productlistwidget extends ConsumerWidget{

  var _searchController=TextEditingController();
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final wit=MediaQuery.of(context).size.width;
    final cardViewModel=ref.read(cartViewModelProvider.notifier);
    final productViewModel=ref.read(productviewmodelProvider.notifier);
    final products=ref.watch(productviewmodelProvider).value;

    return Container(
      child: Column(
      children: [
      Padding(    // Thanh tìm kiếm
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
          child: TextField(
            controller: _searchController,
            onChanged: (value)
            {
               productViewModel.searchProduct(value);
            },
            decoration: InputDecoration(
              hintText: "Search products...",
              hintStyle: const TextStyle(color: Colors.grey, fontSize: 15),
              prefixIcon: const Icon(Icons.search, color: Colors.grey),
              fillColor: Colors.white,
              filled: true,
              contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 16),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(25),
                borderSide: BorderSide(color: Colors.grey.shade300, width: 1),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(25),
                borderSide: const BorderSide(color: Color(0xFF0066CC), width: 1.5),
              ),
            ),
          ),
        ),

        // Danh sách sản phẩm
        Expanded(
          child: products!.length<=0? const Center(
            child: Text(
              "No products found",
              style: TextStyle(color: Colors.grey, fontSize: 16),
            ),
          ) :LayoutBuilder(builder: (context,c)=>
           GridView.count(crossAxisCount: c.maxWidth<500?1:c.maxWidth<900?2:3,
            mainAxisExtent: 166,
            children:
              products.map((p)=>
                  ProductCardWidget(product: p,
                      onTap: ()
                      {
                        Navigator.pushNamed(context,
                            "/ProductDetail",
                            arguments: p);
                      },
                      addCart:()
                      {
                        cardViewModel.addToCart(p);
                      }
                  )).toList(),


          ),
          )

        ),
      ],
    ),);
  }
}


