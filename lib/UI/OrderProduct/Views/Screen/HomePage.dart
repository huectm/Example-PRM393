/*
import 'package:example_dart/UI/OrderProduct/Views/Screen/ProductListWidget.dart';
import 'package:example_dart/data/reposistories/cart_repository.dart';
import 'package:flutter/material.dart';
import '../../../../data/models/product.dart';
import 'CartWidget.dart';

class Homepage extends StatefulWidget {
  final List<Product> products;
  final CartRepository cartRe;

  const Homepage({
    required this.cartRe,
    required this.products,
    super.key,
  });

  @override
  State<Homepage> createState() =>
      _HomepagenewState(products: products, cartRe: cartRe);
}

class _HomepagenewState extends State<Homepage> {
  int _selectedIndex = 0;
  final List<String> _titles = ["Products", "Shopping Cart"];
  final List<Product> products;
  final CartRepository cartRe;

  _HomepagenewState({required this.products, required this.cartRe});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F8FA),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0066CC),
        centerTitle: true,
        elevation: 0,
        actions: [
          IconButton(
            color: Colors.white,
            onPressed: () {},
            icon: Badge(
              label: Text(cartRe.getTotalQuantity().toString()),
              child: const Icon(Icons.shopping_cart),
            ),
          )
        ],
        title: Text(
          _titles[_selectedIndex < _titles.length ? _selectedIndex : 0],
          style: const TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: <Widget>[
        Productlistwidget(products: widget.products),
        const Cartwidget(),
      ][_selectedIndex],

      // Bottom Navigation Bar
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        selectedItemColor: const Color(0xFF0066CC),
        unselectedItemColor: Colors.grey[600],
        selectedFontSize: 12,
        unselectedFontSize: 12,
        type: BottomNavigationBarType.fixed,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: "Cart",
          ),
        ],
      ),
    );
  }
}
*/