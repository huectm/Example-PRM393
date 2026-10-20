// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'UserReposistory.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(userreposistory)
final userreposistoryProvider = UserreposistoryProvider._();

final class UserreposistoryProvider
    extends
        $FunctionalProvider<Userreposistory, Userreposistory, Userreposistory>
    with $Provider<Userreposistory> {
  UserreposistoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'userreposistoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$userreposistoryHash();

  @$internal
  @override
  $ProviderElement<Userreposistory> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  Userreposistory create(Ref ref) {
    return userreposistory(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(Userreposistory value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<Userreposistory>(value),
    );
  }
}

String _$userreposistoryHash() => r'a13f17b7b56032be9d5eea41a141815e4963f2c2';
