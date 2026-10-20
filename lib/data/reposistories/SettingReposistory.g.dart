// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'SettingReposistory.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(settingreposistory)
final settingreposistoryProvider = SettingreposistoryProvider._();

final class SettingreposistoryProvider
    extends
        $FunctionalProvider<
          Settingreposistory,
          Settingreposistory,
          Settingreposistory
        >
    with $Provider<Settingreposistory> {
  SettingreposistoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'settingreposistoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$settingreposistoryHash();

  @$internal
  @override
  $ProviderElement<Settingreposistory> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  Settingreposistory create(Ref ref) {
    return settingreposistory(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(Settingreposistory value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<Settingreposistory>(value),
    );
  }
}

String _$settingreposistoryHash() =>
    r'b32f8a53e50c0d1a3c6ddd74440e215dfdd9b7d6';
