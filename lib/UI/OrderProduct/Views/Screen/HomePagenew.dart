import 'package:example_dart/UI/OrderProduct/ViewModels/CartViewModel.dart';
import 'package:example_dart/UI/OrderProduct/ViewModels/CategoryViewModel.dart';
import 'package:example_dart/UI/OrderProduct/ViewModels/LanguageViewModel.dart';
import 'package:example_dart/UI/OrderProduct/ViewModels/ProductViewModel.dart';
import 'package:example_dart/UI/OrderProduct/ViewModels/ThemModeViewModel.dart';
import 'package:example_dart/UI/OrderProduct/Views/Screen/ProductListWidget.dart';
import 'package:example_dart/UI/User/ViewModels/UserViewModel.dart';
import 'package:example_dart/data/models/User.dart';
import 'package:example_dart/data/reposistories/SettingReposistory.dart';
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

  // GlobalKey định vị biểu tượng giỏ hàng trên AppBar
  final GlobalKey _cartIconKey = GlobalKey();

  // Lưu thông tin người dùng đang đăng nhập (null là chưa đăng nhập)
  User? currentUser;

  // Hộp thoại Đăng nhập
  Future<void> _showMyDialog() async {
    final formKey = GlobalKey<FormState>();
    final userNameController = TextEditingController();
    final passWordController = TextEditingController();

    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Đăng nhập hệ thống'),
          content: Form(
            key: formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  controller: userNameController,
                  validator: (value) {
                    final t = value?.trim() ?? '';
                    if (t.isEmpty) {
                      return 'Vui lòng nhập Email / Tên đăng nhập';
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                    labelText: "Email / Username",
                    prefixIcon: Icon(Icons.person),
                  ),
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: passWordController,
                  obscureText: true,
                  validator: (value) {
                    final t = value?.trim() ?? '';
                    if (t.isEmpty) {
                      return 'Vui lòng nhập Mật khẩu';
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                    labelText: "Mật khẩu",
                    prefixIcon: Icon(Icons.lock),
                  ),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Hủy'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF0066CC),
              ),
              child: const Text(
                'Đăng nhập',
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () async {
                final valid = formKey.currentState!.validate();
                if (!valid) return;

                formKey.currentState!.save();
                final userViewModel = ref.read(userViewModelProvider.notifier);

                // Gọi hàm đăng nhập thu được UserCredential
                final userCredential = await userViewModel.Login(
                  userNameController.text.trim(),
                  passWordController.text.trim(),
                );

                if (userCredential != null && userCredential.user != null) {
                  final fbUser = userCredential.user!;
                  final appUser = User(
                    id: fbUser.uid,
                    name: fbUser.displayName ?? fbUser.email?.split('@').first,
                    Email: fbUser.email ?? userNameController.text.trim(),
                    Password: passWordController.text.trim(),
                    avatar: fbUser.photoURL,
                    phone: fbUser.phoneNumber,
                  );

                  setState(() {
                    currentUser = appUser;
                  });
                  if (context.mounted) {
                    Navigator.of(context).pop();
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                            "Đăng nhập thành công! Chào mừng ${appUser.name ?? appUser.Email}"),
                        backgroundColor: Colors.green,
                        duration: const Duration(seconds: 2),
                      ),
                    );
                  }
                } else {
                  if (context.mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Sai tên đăng nhập hoặc mật khẩu!"),
                        duration: Duration(seconds: 2),
                        backgroundColor: Colors.red,
                      ),
                    );
                  }
                }
              },
            ),
          ],
        );
      },
    );
  }

  // Hộp thoại tùy chọn tài khoản người dùng
  Future<void> _showUserMenuDialog() async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Xin chào, ${currentUser?.name ?? currentUser?.Email}"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Email: ${currentUser?.Email}"),
              if (currentUser?.phone != null)
                Text("Số điện thoại: ${currentUser?.phone}"),
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Đóng'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
              child: const Text('Đăng xuất', style: TextStyle(color: Colors.white)),
              onPressed: () {
                setState(() {
                  currentUser = null;
                });
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text("Đã đăng xuất!"),
                    duration: Duration(seconds: 2),
                  ),
                );
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final cartViewModel = ref.read(cartViewModelProvider.notifier);
    final categoryState = ref.watch(categoryviewmodelProvider);
    final productViewModel = ref.read(productviewmodelProvider.notifier);

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: const Color(0xFF0066CC),
        centerTitle: true,
        elevation: 0,
        actions: [
          // Widget PopupMenuButton gắn trực tiếp vào vị trí nút Setting ở góc phải
          PopupMenuButton<void>(
            icon: const Icon(Icons.settings, color: Colors.white),
            tooltip: "Cài đặt",
            offset: const Offset(0, 48), // Hiện bên dưới nút Cài đặt ở góc phải
            elevation: 8,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            itemBuilder: (BuildContext context) {
              return [
                const PopupMenuItem<void>(
                  enabled: false,
                  child: Text(
                    "Cài đặt hệ thống",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                      color: Color(0xFF0066CC),
                    ),
                  ),
                ),
                const PopupMenuDivider(),

                // 1. Nút gạt Chế độ tối (ThemeMode)
                PopupMenuItem<void>(
                  enabled: false,
                  child: Consumer(
                    builder: (context, ref, child) {
                      final themeMode =
                          ref.watch(themModeViewModelProvider).value ??
                              ThemeMode.light;
                      final isDark = themeMode == ThemeMode.dark;

                      return SizedBox(
                        width: 210,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Icon(
                                  isDark ? Icons.dark_mode : Icons.light_mode,
                                  color: isDark ? Colors.amber : Colors.blue,
                                  size: 20,
                                ),
                                const SizedBox(width: 8),
                                const Text(
                                  "Chế độ tối",
                                  style: TextStyle(
                                    color: Colors.black87,
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                            Switch(
                              value: isDark,
                              activeColor: Colors.amber,
                              onChanged: (bool value) {
                                ref
                                    .read(themModeViewModelProvider.notifier)
                                    .setThemMode(value
                                        ? ThemeMode.dark
                                        : ThemeMode.light);
                              },
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),

                // 2. Nút gạt Ngôn ngữ (Language)
                PopupMenuItem<void>(
                  enabled: false,
                  child: Consumer(
                    builder: (context, ref, child) {
                      final language =
                          ref.watch(languageViewModelProvider).value ??
                              Language.VN;
                      final isEnglish = language == Language.EN;

                      return SizedBox(
                        width: 210,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                const Icon(Icons.language,
                                    color: Colors.green, size: 20),
                                const SizedBox(width: 8),
                                Text(
                                  isEnglish ? "Language" : "Ngôn ngữ",
                                  style: const TextStyle(
                                    color: Colors.black87,
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Text(
                                  isEnglish ? "EN" : "VN",
                                  style: const TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey,
                                  ),
                                ),
                                Switch(
                                  value: isEnglish,
                                  activeColor: Colors.green,
                                  onChanged: (bool value) {
                                    ref
                                        .read(
                                            languageViewModelProvider.notifier)
                                        .setLanguage(value
                                            ? Language.EN
                                            : Language.VN);
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ];
            },
          ),

          // Nút Avatar đăng nhập/đăng xuất
          InkWell(
            onTap: () {
              if (currentUser != null) {
                _showUserMenuDialog();
              } else {
                _showMyDialog();
              }
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: currentUser != null
                  ? CircleAvatar(
                      backgroundColor: Colors.white,
                      backgroundImage: (currentUser!.avatar != null &&
                              currentUser!.avatar!.isNotEmpty)
                          ? NetworkImage(currentUser!.avatar!)
                          : null,
                      child: currentUser!.avatar == null
                          ? Text(
                              (currentUser!.name ?? currentUser!.Email)[0]
                                  .toUpperCase(),
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold),
                            )
                          : null,
                    )
                  : CircleAvatar(
                      backgroundColor: Colors.grey.shade300,
                      child: const Icon(
                        Icons.person_outline,
                        color: Colors.black54,
                      ),
                    ),
            ),
          ),

          // Biểu tượng giỏ hàng trên AppBar
          IconButton(
            key: _cartIconKey,
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

      // Menu Drawer
      drawer: Drawer(
        child: Column(
          children: [
            const UserAccountsDrawerHeader(
              decoration: BoxDecoration(color: Color(0xFF0066CC)),
              accountName: Text(
                "Danh mục sản phẩm",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              accountEmail: Text("Chọn danh mục để xem"),
              currentAccountPicture: CircleAvatar(
                backgroundColor: Colors.white,
                child: Icon(Icons.category, color: Color(0xFF0066CC), size: 36),
              ),
            ),
            Expanded(
              child: categoryState.when(
                loading: () =>
                    const Center(child: CircularProgressIndicator()),
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
                          onTap: () {
                            Navigator.pop(context);
                            setState(() {
                              _selectedIndex = 0;
                            });
                          },
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
                          Navigator.pop(context);
                          setState(() {
                            _selectedIndex = 0;
                          });
                          productViewModel.getProductByCategory(category.id);
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
        Productlistwidget(cartIconKey: _cartIconKey),
        const Cartwidget(),
      ][_selectedIndex],

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
