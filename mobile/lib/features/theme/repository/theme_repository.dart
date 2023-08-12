import 'package:flutter/material.dart';
import 'package:mobile/services/cache_helper.dart';
import 'package:mobile/utils/app_pref.dart';

abstract class ThemeRepository {
  Future<ThemeMode> getTheme();
  Future<bool> saveTheme(ThemeMode themeMode);
}

class ThemeRepositoryImpl implements ThemeRepository {
  ThemeRepositoryImpl();

  @override
  Future<ThemeMode> getTheme() async {
    return CacheHelper.getCurrentTheme();
  }

  @override
  Future<bool> saveTheme(ThemeMode themeMode) async {
    return CacheHelper.saveTheme(PreferenceKey.themeMode, themeMode);
  }
}
