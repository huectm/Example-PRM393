import 'package:example_dart/UI/OrderProduct/Views/Screen/ProductDetailPage.dart';
import 'package:flutter/material.dart';
import '../../../../data/models/product.dart';
class Productwidget extends StatelessWidget {
  Product product;
  Productwidget({required this.product, super.key});
  Widget _buildProductImage(String imagePath) {
    if (imagePath.startsWith('http://') || imagePath.startsWith('https://')) {
      return Image.network(
        imagePath,
        width: double.infinity,
        height: double.infinity,
        fit: BoxFit.fill,
        errorBuilder: (context, error, stackTrace) => _buildFallbackImage(),
      );
    } else {
      return Image.asset(
        imagePath,
        width: double.infinity,
        height: double.infinity,
        fit: BoxFit.fill,
        errorBuilder: (context, error, stackTrace) => _buildFallbackImage(),
      );
    }
  }

  Widget _buildFallbackImage() {
    return Image.asset(
      'assets/images/dog.jpeg',
      width: double.infinity,
      height: double.infinity,
      fit: BoxFit.fill,
      errorBuilder: (context, error, stackTrace) => const Icon(
        Icons.image_not_supported,
        size: 50,
        color: Colors.grey,
      ),
    );
  }

  @override

  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        width: 300,
        height: 400,
       // decoration: BoxDecoration(border: Border.all(style: BorderStyle.solid,color: Colors.indigoAccent)),
        child:Column(

        children:
        [
          Expanded(
            flex: 2,
            child: Container(
              width: 300,
              child: Stack(
                children: [
              Container(
                width: 300,
                child: _buildProductImage(product.image),

              ),

            Positioned(
              bottom: 0,
              right: 0,
              child: IconButton(onPressed: (){
                MaterialPageRoute(builder:
                    (context) => Productdetailpage(product: product));
              },
                hoverColor: Colors.amber,
                icon: Icon(Icons.add_shopping_cart_sharp),
                color: Colors.white,
                style: ButtonStyle(
                    backgroundColor: WidgetStateProperty.all(Colors.indigoAccent)),
              ),
            ),

                ],
              )
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              width: 300,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,

                children: [
                  Expanded(
                    flex: 1,
                      child: Text("Name: ${product.name}")),
                    SizedBox(width: 20,),
                  Expanded(
                    flex: 1,
                      child: Text("Price: ${product.price}")),
                  Expanded(
                     flex: 3,
                      child: SingleChildScrollView(child: Text(textAlign: TextAlign.justify, product.description??"")))
                ],
              ),),
          )
        ]
        )),
    );
        //Anh


  }
}
