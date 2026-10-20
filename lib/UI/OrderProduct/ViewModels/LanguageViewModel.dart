import 'package:example_dart/data/reposistories/SettingReposistory.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'LanguageViewModel.g.dart';

@riverpod
class LanguageViewModel extends _$LanguageViewModel {
  @override
  FutureOr<Language> build() async {
    final settingRe = ref.read(settingreposistoryProvider);
    return await settingRe.getLanguage();
  }

  Future<void> setLanguage(Language lang) async {
    final settingRe = ref.read(settingreposistoryProvider);
    await settingRe.setLanguage(lang);
    ref.invalidateSelf();
  }
}
