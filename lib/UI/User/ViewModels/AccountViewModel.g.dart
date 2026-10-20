// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'AccountViewModel.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(AccountViewModel)
final accountViewModelProvider = AccountViewModelProvider._();

final class AccountViewModelProvider
    extends $AsyncNotifierProvider<AccountViewModel, Account?> {
  AccountViewModelProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'accountViewModelProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$accountViewModelHash();

  @$internal
  @override
  AccountViewModel create() => AccountViewModel();
}

String _$accountViewModelHash() => r'2e812f197161d125358e4c277e3c1d29f5377681';

abstract class _$AccountViewModel extends $AsyncNotifier<Account?> {
  FutureOr<Account?> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<AsyncValue<Account?>, Account?>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<Account?>, Account?>,
              AsyncValue<Account?>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
