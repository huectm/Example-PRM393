import 'package:example_dart/data/models/category.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'category_reposistory.g.dart';

@riverpod
CategoryReposistory categoryReposistory(Ref ref) => CategoryReposistory();

class CategoryReposistory {
  Future<List<Category>> getCategory() async {
    List<Category> l = [
      Category(
          id: "Ca001",
          name: "Phone",
          image:
              'https://crdms.images.consumerreports.org/f_auto,w_600/prod/products/cr/models/399694-smartphones-apple-iphone-11-10008711.png'),
      Category(
          id: "Ca002",
          name: "Laptop",
          image:
              'https://anphat.com.vn/media/product/53456_laptop_hp_victus_15_fa2732tx_b85lppa__2_.jpg')
    ];
    return l;
  }
}
