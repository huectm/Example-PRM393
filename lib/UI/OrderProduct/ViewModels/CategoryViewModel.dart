import 'package:example_dart/data/models/category.dart';
import 'package:example_dart/data/reposistories/category_reposistory.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'CategoryViewModel.g.dart';

@riverpod
class Categoryviewmodel extends _$Categoryviewmodel {
  @override
  FutureOr<List<Category>> build() async {
    var caR = ref.read(categoryReposistoryProvider);
    return caR.getCategory();
  }
}
