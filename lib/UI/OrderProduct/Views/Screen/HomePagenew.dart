import 'package:example_dart/UI/OrderProduct/ViewModels/CartViewModel.dart';
import 'package:example_dart/UI/OrderProduct/ViewModels/CategoryViewModel.dart';
import 'package:example_dart/UI/OrderProduct/ViewModels/LanguageViewModel.dart';
import 'package:example_dart/UI/OrderProduct/ViewModels/ProductViewModel.dart';
import 'package:example_dart/UI/OrderProduct/ViewModels/ThemModeViewModel.dart';
import 'package:example_dart/UI/OrderProduct/Views/Screen/ProductListWidget.dart';
import 'package:example_dart/UI/User/ViewModels/AccountViewModel.dart';
import 'package:example_dart/UI/User/ViewModels/UserViewModel.dart' hide User;
import 'package:example_dart/data/models/account.dart';
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

  // Lưu thông tin người dùng đang đăng nhập từ bảng Account
  Account? currentAccount;

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
                final emailInput = userNameController.text.trim();
                final passInput = passWordController.text.trim();

                final userViewModel = ref.read(userViewModelProvider.notifier);
                final accountViewModel =
                    ref.read(accountViewModelProvider.notifier);

                // 1. Kiểm tra đăng nhập qua UserViewModel / Firebase
                final userCredential =
                    await userViewModel.Login(emailInput, passInput);

                // 2. Lấy thông tin chi tiết Account (gồm Avatar) từ bảng Account trên Firebase theo Email
                final account =
                    await accountViewModel.loginAndFetchProfile(emailInput);

                if (account != null || userCredential != null) {
                  final activeAccount = account ??
                      Account(
                        id: userCredential?.user?.uid ?? 'account1',
                        email: emailInput,
                        name: userCredential?.user?.displayName ??
                            emailInput.split('@').first,
                        avatar: userCredential?.user?.photoURL ??
                            'https://i.pravatar.cc/150?img=5',
                        phone: userCredential?.user?.phoneNumber ?? '',
                      );

                  setState(() {
                    currentAccount = activeAccount;
                  });

                  if (context.mounted) {
                    Navigator.of(context).pop();
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                            "Đăng nhập thành công! Chào mừng ${activeAccount.name}"),
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

  // Hộp thoại hiển thị thông tin chi tiết người dùng lấy từ Account
  Future<void> _showUserMenuDialog() async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          title: Column(
            children: [
              CircleAvatar(
                radius: 40,
                backgroundColor: Colors.grey.shade200,
                backgroundImage: (currentAccount?.avatar != null &&
                        currentAccount!.avatar.isNotEmpty)
                    ? NetworkImage(currentAccount!.avatar)
                    : null,
                child: (currentAccount?.avatar == null ||
                        currentAccount!.avatar.isEmpty)
                    ? Text(
                        (currentAccount?.name.isNotEmpty == true
                                ? currentAccount!.name[0]
                                : 'U')
                            .toUpperCase(),
                        style: const TextStyle(
                            fontSize: 28, fontWeight: FontWeight.bold),
                      )
                    : null,
              ),
              const SizedBox(height: 12),
              Text(
                currentAccount?.name ?? "Thông tin tài khoản",
                textAlign: TextAlign.center,
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Divider(),
              ListTile(
                dense: true,
                leading: const Icon(Icons.email, color: Color(0xFF0066CC)),
                title: const Text("Email"),
                subtitle: Text(currentAccount?.email ?? "Chưa cập nhật"),
              ),
              ListTile(
                dense: true,
                leading: const Icon(Icons.phone, color: Color(0xFF0066CC)),
                title: const Text("Số điện thoại"),
                subtitle: Text(
                    currentAccount?.phone.isNotEmpty == true
                        ? currentAccount!.phone
                        : "Chưa cập nhật"),
              ),
              ListTile(
                dense: true,
                leading:
                    const Icon(Icons.perm_identity, color: Color(0xFF0066CC)),
                title: const Text("ID Account"),
                subtitle: Text(currentAccount?.id ?? "Chưa có ID"),
              ),
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
              child: const Text('Đăng xuất',
                  style: TextStyle(color: Colors.white)),
              onPressed: () {
                ref.read(accountViewModelProvider.notifier).logout();
                setState(() {
                  currentAccount = null;
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

          // Nút Avatar: Đã đăng nhập -> Hiện Avatar từ Account, Chưa đăng nhập -> Avatar ẩn
          InkWell(
            onTap: () {
              if (currentAccount != null) {
                _showUserMenuDialog();
              } else {
                _showMyDialog();
              }
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: currentAccount != null
                  ? CircleAvatar(
                      backgroundColor: Colors.white,
                      backgroundImage: (currentAccount!.avatar.isNotEmpty)
                          ? NetworkImage(currentAccount!.avatar)
                          : null,
                      child: currentAccount!.avatar.isEmpty
                          ? Text(
                              (currentAccount!.name.isNotEmpty
                                      ? currentAccount!.name[0]
                                      : 'U')
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
            UserAccountsDrawerHeader(
              decoration: const BoxDecoration(color: Color(0xFF0066CC)),
              accountName: Text(
                currentAccount?.name ?? "Danh mục sản phẩm",
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              accountEmail: Text(
                  currentAccount?.email ?? "Chọn danh mục sản phẩm để xem"),
              currentAccountPicture: CircleAvatar(
                backgroundColor: Colors.white,
                backgroundImage: (currentAccount?.avatar != null &&
                        currentAccount!.avatar.isNotEmpty)
                    ? NetworkImage(currentAccount!.avatar)
                    : null,
                child: (currentAccount?.avatar == null ||
                        currentAccount!.avatar.isEmpty)
                    ? const Icon(Icons.category,
                        color: Color(0xFF0066CC), size: 36)
                    : null,
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
