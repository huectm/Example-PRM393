// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ProductViewModel1.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(Productviewmodel1)
final productviewmodel1Provider = Productviewmodel1Provider._();

final class Productviewmodel1Provider
    extends $AsyncNotifierProvider<Productviewmodel1, List<Product>> {
  Productviewmodel1Provider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'productviewmodel1Provider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$productviewmodel1Hash();

  @$internal
  @override
  Productviewmodel1 create() => Productviewmodel1();
}

String _$productviewmodel1Hash() => r'bdb3daf0be4b83dd866c927033bbeee0503c68b4';

abstract class _$Productviewmodel1 extends $AsyncNotifier<List<Product>> {
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
