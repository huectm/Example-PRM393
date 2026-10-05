// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_reposistory.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(productReposistory)
final productReposistoryProvider = ProductReposistoryProvider._();

final class ProductReposistoryProvider
    extends
        $FunctionalProvider<
          ProductReposistory,
          ProductReposistory,
          ProductReposistory
        >
    with $Provider<ProductReposistory> {
  ProductReposistoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'productReposistoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$productReposistoryHash();

  @$internal
  @override
  $ProviderElement<ProductReposistory> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  ProductReposistory create(Ref ref) {
    return productReposistory(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ProductReposistory value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ProductReposistory>(value),
    );
  }
}

String _$productReposistoryHash() =>
    r'b59d9153b42f9d11dcc2eef13fe6605c294f4630';
