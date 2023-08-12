import 'package:flutter/material.dart';
import 'package:mobile/utils/app_pref.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CacheHelper {
  static late AppPreference _appPreference;
  static late SharedPreferences _sharedPreferences;

  static Future<void> init() async {
    _sharedPreferences = await SharedPreferences.getInstance();
    _appPreference = AppPreference(_sharedPreferences);
  }

  static Future<void> clear() async {
    await _appPreference.clear();
  }

  static Future<void> remove(PreferenceKey key) async {
    await _appPreference.remove(key);
  }

  static Future<bool> contains(PreferenceKey key) async {
    return _appPreference.contains(key);
  }

  static Future<ThemeMode> getCurrentTheme() async {
    await init();
    final themeMode = await _appPreference.get(
      PreferenceKey.themeMode,
      ThemeMode.system.toString(),
    );

    switch (themeMode) {
      case 'ThemeMode.system':
        return ThemeMode.system;
      case 'ThemeMode.light':
        return ThemeMode.light;
      case 'ThemeMode.dark':
        return ThemeMode.dark;
      default:
        return ThemeMode.system;
    }
  }

  static Future<bool> saveTheme(PreferenceKey key, ThemeMode themeMode) async {
    await init();
    return _appPreference.save(key, themeMode.toString());
  }

  static Future<bool> getReaderMode() async {
    await init();
    final readerMode = await _appPreference.get(
      PreferenceKey.readerMode,
      false,
    ) as bool;
    return readerMode;
  }

  static Future<bool> saveReaderMode({
    required PreferenceKey key,
    required bool readerMode,
  }) async {
    await init();
    return _appPreference.save(key, readerMode);
  }

  static Future<List<String>> getBookMarkList() async {
    await init();
    final bookMarkList = await _appPreference.get(
      PreferenceKey.bookMarkList,
      <String>[],
    ) as List<String>;
    return bookMarkList;
  }

  static Future<bool> saveBookMarkList({
    required PreferenceKey key,
    required List<String> bookMarkList,
  }) async {
    await init();
    return _appPreference.save(key, bookMarkList);
  }

  static Future<bool> containsArticle(String json) async {
    await init();
    final bookMarkList = await _appPreference.get(
      PreferenceKey.bookMarkList,
      <String>[],
    ) as List<String>;
    return bookMarkList.contains(json);
  }
}
