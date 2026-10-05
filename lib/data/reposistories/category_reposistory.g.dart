// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'category_reposistory.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(categoryReposistory)
final categoryReposistoryProvider = CategoryReposistoryProvider._();

final class CategoryReposistoryProvider
    extends
        $FunctionalProvider<
          CategoryReposistory,
          CategoryReposistory,
          CategoryReposistory
        >
    with $Provider<CategoryReposistory> {
  CategoryReposistoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'categoryReposistoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$categoryReposistoryHash();

  @$internal
  @override
  $ProviderElement<CategoryReposistory> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  CategoryReposistory create(Ref ref) {
    return categoryReposistory(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(CategoryReposistory value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<CategoryReposistory>(value),
    );
  }
}

String _$categoryReposistoryHash() =>
    r'55e7fc6dc1806d41c09c8c523f4c0c54ce58ea78';
