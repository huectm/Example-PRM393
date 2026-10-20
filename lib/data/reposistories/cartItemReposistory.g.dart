// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cartItemReposistory.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(cartItemRepository)
final cartItemRepositoryProvider = CartItemRepositoryProvider._();

final class CartItemRepositoryProvider
    extends
        $FunctionalProvider<
          CartItemRepository,
          CartItemRepository,
          CartItemRepository
        >
    with $Provider<CartItemRepository> {
  CartItemRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'cartItemRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$cartItemRepositoryHash();

  @$internal
  @override
  $ProviderElement<CartItemRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  CartItemRepository create(Ref ref) {
    return cartItemRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(CartItemRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<CartItemRepository>(value),
    );
  }
}

String _$cartItemRepositoryHash() =>
    r'38d5c5a20d9de9d975bf048c5ab3bd57a5cd880a';
