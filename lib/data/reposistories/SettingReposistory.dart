import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'SettingReposistory.g.dart';

enum Language {
  VN,
  EN,
}

@riverpod
Settingreposistory settingreposistory(Ref ref) => Settingreposistory();

class Settingreposistory {
  Future<ThemeMode> getThemMode() async {
    final prefs = await SharedPreferences.getInstance();
    final darkm = prefs.getString("themMode") ?? 'light';
    return darkm == 'dark' ? ThemeMode.dark : ThemeMode.light;
  }

  Future<void> setThemMode(ThemeMode themMode) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(
        'themMode', themMode == ThemeMode.dark ? 'dark' : 'light');
  }

  Future<Language> getLanguage() async {
    final prefs = await SharedPreferences.getInstance();
    final lang = prefs.getString("language") ?? 'VN';
    return lang == 'EN' ? Language.EN : Language.VN;
  }

  Future<void> setLanguage(Language lang) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString("language", lang == Language.EN ? 'EN' : 'VN');
  }
}
