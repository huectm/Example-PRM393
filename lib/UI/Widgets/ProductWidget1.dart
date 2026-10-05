import 'package:example_dart/UI/Screens/ProductDetailPage1.dart';
import 'package:example_dart/UI/Widgets/MyWidget.dart';
import 'package:example_dart/data/models/product.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
class ButtonLike extends StatefulWidget {
  const ButtonLike({super.key});
  @override
  State<ButtonLike> createState() => _ButtonLikeState();
}

class _ButtonLikeState extends State<ButtonLike> {
  int x=0;
  void ChangeLike()
  {
    setState(() {
      x=x==0?1:x==1?2:0;
    });
  }
  @override
  Widget build(BuildContext context) {
    return IconButton(onPressed: ChangeLike,
        icon: Icon(x==2?Icons.start:Icons.star),
        color: x==0?Colors.grey:Colors.yellow);
  }
}


class Productwidget1 extends StatelessWidget {
  final Product product;
  const Productwidget1({required this.product, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      height: 500,
      child: Column(
        //Sắp xếp giao diện theo chiều dọc
        children:
        [
          //Ảnh của sản phẩm
          Expanded(flex: 1,
              child: Container(
                width: 300,
                child: Stack(

                  children: [
                    Container( //Ảnh sản phẩm
                      width: 300,

                    child: Image.asset(fit:BoxFit.fill , product.image),
                  ),
                  //Button trên ảnh của sản phẩm
                    Align(
                      alignment: Alignment.bottomRight,
                      child: IconButton(
                        color: Colors.white,
                          style: ButtonStyle(backgroundColor:WidgetStateProperty.all(Colors.blueAccent) ),
                          onPressed: (){
                          Navigator.push(context, MaterialPageRoute(
                              builder: (context)=>
                              Productdetailpage1(product: product)));
                         },
                          icon: Icon(Icons.shopping_cart)),
                    )
                  ]
                ),
              )
          ),

          Expanded(
            flex: 1
          ,
            child: Container(
              width: 300,
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      LikeStarButton(),
                      Expanded(flex: 1, child: Text("Name: ${product.name}")),

                      Expanded(flex: 1,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [

                            Text("Price: "),
                            Text('Old: ${product.price}',style: TextStyle(color: Colors.blue),),
                            Text('Sale: ${product.price*0.9}',style: TextStyle(color: Colors.red,fontSize: 16),),

                          ],
                        ),

                      ),

                      Expanded(flex:3,child: SingleChildScrollView(
                          child: Text(textAlign: TextAlign.justify,
                              product.description??"")))
                    ],
                  ),
                ),
              ),
            ),
          ),

        ],
      ),
    );
  }
}
