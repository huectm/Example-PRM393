// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ThemModeViewModel.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(ThemModeViewModel)
final themModeViewModelProvider = ThemModeViewModelProvider._();

final class ThemModeViewModelProvider
    extends $AsyncNotifierProvider<ThemModeViewModel, ThemeMode> {
  ThemModeViewModelProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'themModeViewModelProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$themModeViewModelHash();

  @$internal
  @override
  ThemModeViewModel create() => ThemModeViewModel();
}

String _$themModeViewModelHash() => r'548e88558d5e79160a0fa358bb52621779581ec4';

abstract class _$ThemModeViewModel extends $AsyncNotifier<ThemeMode> {
  FutureOr<ThemeMode> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<AsyncValue<ThemeMode>, ThemeMode>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<ThemeMode>, ThemeMode>,
              AsyncValue<ThemeMode>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
