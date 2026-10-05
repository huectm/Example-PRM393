import 'package:example_dart/UI/OrderProduct/ViewModels/CartViewModel.dart';
import 'package:example_dart/UI/OrderProduct/ViewModels/CategoryViewModel.dart';
import 'package:example_dart/UI/OrderProduct/ViewModels/ProductViewModel.dart';
import 'package:example_dart/UI/OrderProduct/Views/Screen/ProductListWidget.dart';
import 'package:example_dart/data/reposistories/product_reposistory.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'CartWidget.dart';

class Homepagenew extends ConsumerStatefulWidget {
  const Homepagenew({
    super.key,
  });
  @override
  ConsumerState<Homepagenew> createState() => _HomepagenewState();
}
class _HomepagenewState extends ConsumerState<Homepagenew> {
  int _selectedIndex = 0;
  final List<String> _titles = ["Products", "Shopping Cart"];
  @override
  Widget build(BuildContext context) {
    final cartState=ref.watch(cartViewModelProvider);
    final cartViewModel = ref.read(cartViewModelProvider.notifier);
    final categoryState = ref.watch(categoryviewmodelProvider);
    final productViewModel=ref.read(productviewmodelProvider.notifier);

    return Scaffold(
      backgroundColor: const Color(0xFFF6F8FA),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0066CC),
        centerTitle: true,
        elevation: 0,
        actions: [
          IconButton(
            color: Colors.white,
            onPressed: () {
              setState(() {
                _selectedIndex = 1;
              });
            },
            icon: Badge(
              label: Text(cartViewModel.totalQuantity.toString()),
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

      // Menu Drawer hiển thị danh mục Category từ CategoryViewModel
      drawer: Drawer(
        child: Column(
          children: [
            Text("Danh mục sản phẩm", style: TextStyle(color: Colors.deepOrange, fontSize: 20),),
            Expanded(
              child: categoryState.when(
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (error, stack) => Center(child: Text("Lỗi: $error")),
                data: (categories) {
                  if (categories.isEmpty) {
                    return const Center(child: Text("Chưa có danh mục nào"));
                  }
                  return ListView.builder(
                    itemCount: categories.length + 1,
                    itemBuilder: (context, index) {
                      if (index == 0) {
                        return ListTile(
                          leading:
                              const Icon(Icons.apps, color: Color(0xFF0066CC)),
                          title: const Text(
                            "Tất cả sản phẩm",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          onTap: ()
                            {
                               Navigator.pop(context);
                               productViewModel.getProductByCategory(categories[index-1].id);
                              setState(() {
                                _selectedIndex=0;
                              });

                            }



                        );
                      }
                      final category = categories[index - 1];
                      return ListTile(
                        leading: category.image != null &&
                                category.image!.isNotEmpty
                            ? ClipRRect(
                                borderRadius: BorderRadius.circular(6),
                                child: Image.network(
                                  category.image!,
                                  width: 32,
                                  height: 32,
                                  fit: BoxFit.cover,
                                  errorBuilder: (_, __, ___) => const Icon(
                                    Icons.folder,
                                    color: Color(0xFF0066CC),
                                  ),
                                ),
                              )
                            : const Icon(Icons.folder,
                                color: Color(0xFF0066CC)),
                        title: Text(
                          category.name,
                          style: const TextStyle(fontWeight: FontWeight.w500),
                        ),
                        onTap: () {
                          Navigator.pop(context); // Đóng Drawer
                          setState(() {
                            _selectedIndex = 0;
                          });
                          productViewModel.getProductByCategory
                            (categories[index-1].id);

                        },
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),

      body: <Widget>[
        Productlistwidget(),
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
