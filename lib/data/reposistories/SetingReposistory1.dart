import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'SettingReposistory.dart';

part 'SetingReposistory1.g.dart';

@riverpod
Setingreposistory1 setingreposistory1(Ref ref) => Setingreposistory1();

class Setingreposistory1 {
  Future<Language> getLanguage() async {
    final prefs = await SharedPreferences.getInstance();
    final lang = prefs.getString("language");
    return lang == "EN" ? Language.EN : Language.VN;
  }

  Future<ThemeMode> getThemMode() async {
    final prefs = await SharedPreferences.getInstance();
    final them = prefs.getString("ThemMode");
    return them == "dark" ? ThemeMode.dark : ThemeMode.light;
  }

  Future<void> setThemMode(ThemeMode them) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(
        "ThemMode", them == ThemeMode.dark ? "dark" : "light");
  }

  Future<void> setLanguage(Language lang) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString("language", lang == Language.EN ? "EN" : "VN");
  }
}
