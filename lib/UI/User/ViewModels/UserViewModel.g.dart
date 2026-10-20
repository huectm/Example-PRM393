// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'UserViewModel.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(UserViewModel)
final userViewModelProvider = UserViewModelProvider._();

final class UserViewModelProvider
    extends $StreamNotifierProvider<UserViewModel, fb.User?> {
  UserViewModelProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'userViewModelProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$userViewModelHash();

  @$internal
  @override
  UserViewModel create() => UserViewModel();
}

String _$userViewModelHash() => r'066938e70866dcbb2bdbb2a5e5780410a0dd473f';

abstract class _$UserViewModel extends $StreamNotifier<fb.User?> {
  Stream<fb.User?> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<AsyncValue<fb.User?>, fb.User?>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<fb.User?>, fb.User?>,
              AsyncValue<fb.User?>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
