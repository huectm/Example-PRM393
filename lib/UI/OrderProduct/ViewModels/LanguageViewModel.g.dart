// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'LanguageViewModel.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(LanguageViewModel)
final languageViewModelProvider = LanguageViewModelProvider._();

final class LanguageViewModelProvider
    extends $AsyncNotifierProvider<LanguageViewModel, Language> {
  LanguageViewModelProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'languageViewModelProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$languageViewModelHash();

  @$internal
  @override
  LanguageViewModel create() => LanguageViewModel();
}

String _$languageViewModelHash() => r'ffeaf94d393904584715fc7e622213d5e9a1aa79';

abstract class _$LanguageViewModel extends $AsyncNotifier<Language> {
  FutureOr<Language> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<AsyncValue<Language>, Language>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<Language>, Language>,
              AsyncValue<Language>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
