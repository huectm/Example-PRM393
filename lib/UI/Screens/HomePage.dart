import 'package:example_dart/UI/Widgets/BodyWidget.dart';
import 'package:flutter/material.dart';
class Homepage extends StatelessWidget {
  const Homepage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Icon(Icons.menu),
        title: const Text("Home page"),
        actions: [IconButton(onPressed: (){},
            icon: const Icon(Icons.search))],
      ),
      body: Bodywidget());
  }
}
