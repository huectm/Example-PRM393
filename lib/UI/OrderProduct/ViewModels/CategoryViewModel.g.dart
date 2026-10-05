// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'CategoryViewModel.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(Categoryviewmodel)
final categoryviewmodelProvider = CategoryviewmodelProvider._();

final class CategoryviewmodelProvider
    extends $AsyncNotifierProvider<Categoryviewmodel, List<Category>> {
  CategoryviewmodelProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'categoryviewmodelProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$categoryviewmodelHash();

  @$internal
  @override
  Categoryviewmodel create() => Categoryviewmodel();
}

String _$categoryviewmodelHash() => r'616aa916de78fd7f859c1709a03e70e89c21a1f6';

abstract class _$Categoryviewmodel extends $AsyncNotifier<List<Category>> {
  FutureOr<List<Category>> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<AsyncValue<List<Category>>, List<Category>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<List<Category>>, List<Category>>,
              AsyncValue<List<Category>>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
