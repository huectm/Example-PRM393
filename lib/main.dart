import 'package:example_dart/UI/OrderProduct/ViewModels/ThemModeViewModel.dart';
import 'package:example_dart/UI/OrderProduct/Views/Screen/ProductDetailPage.dart';
import 'package:example_dart/data/models/product.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'UI/OrderProduct/Views/Screen/HomePagenew.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:example_dart/firebase_options.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeModeAsync = ref.watch(themModeViewModelProvider);
    final themeMode = themeModeAsync.value ?? ThemeMode.light;

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Product Store',
      themeMode: themeMode,
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      routes: {
        '/ProductDetail': (context) {
          final product =
              ModalRoute.of(context)!.settings.arguments as Product;
          return Productdetailpage(
            product: product,
          );
        },
      },
      home: const Homepagenew(),
    );
  }
}
