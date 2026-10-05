import 'package:example_dart/UI/Widgets/BodyWidget.dart';
import 'package:example_dart/UI/Widgets/BodyWidget1.dart';
import 'package:flutter/material.dart';

class Homepage1 extends StatefulWidget {
  const Homepage1({super.key});

  @override
  State<Homepage1> createState() => _Homepage1State();
}

class _Homepage1State extends State<Homepage1> {
  var curValue=false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(child: ListView(
        children: [DrawerHeader(child: Text("Menu"))],
      )),
        appBar: AppBar(
          backgroundColor: curValue?Colors.blueAccent:Colors.green,
          leading: const Icon(Icons.menu),
          title: const Text("Home page"),
          actions:
            [ Switch(value:curValue , onChanged: (bool value){
              setState(() {
                curValue=value;
              });
               } )
            ],
        ),
        body: Bodywidget1());
  }
}
