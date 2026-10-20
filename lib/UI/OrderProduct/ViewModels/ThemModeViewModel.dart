import 'package:example_dart/data/reposistories/SettingReposistory.dart';
import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'ThemModeViewModel.g.dart';

@riverpod
class ThemModeViewModel extends _$ThemModeViewModel {
  @override
  FutureOr<ThemeMode> build() async {
    final settingRe = ref.read(settingreposistoryProvider);
    return await settingRe.getThemMode();
  }

  Future<void> setThemMode(ThemeMode themMode) async {
    final settingRe = ref.read(settingreposistoryProvider);
    await settingRe.setThemMode(themMode);
    ref.invalidateSelf();
  }
}
