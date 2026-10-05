// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ProductViewModel.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(Productviewmodel)
final productviewmodelProvider = ProductviewmodelProvider._();

final class ProductviewmodelProvider
    extends $AsyncNotifierProvider<Productviewmodel, List<Product>> {
  ProductviewmodelProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'productviewmodelProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$productviewmodelHash();

  @$internal
  @override
  Productviewmodel create() => Productviewmodel();
}

String _$productviewmodelHash() => r'1f8baf47b1a408888752db08e986ef96dd8696fc';

abstract class _$Productviewmodel extends $AsyncNotifier<List<Product>> {
  FutureOr<List<Product>> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<AsyncValue<List<Product>>, List<Product>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<List<Product>>, List<Product>>,
              AsyncValue<List<Product>>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
