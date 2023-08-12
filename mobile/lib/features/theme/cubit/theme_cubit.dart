import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:mobile/features/theme/repository/theme_repository.dart';

part 'theme_state.dart';

class ThemeCubit extends Cubit<ThemeState> {
  ThemeCubit() : super(const ThemeInitial(ThemeMode.system));

  final themeRepository = ThemeRepositoryImpl();

  Future<void> changeTheme(ThemeMode themeMode) async {
    await themeRepository.saveTheme(themeMode);
    emit(ThemeChanged(themeMode));
  }

  Future<void> getTheme() async {
    final themeMode = await themeRepository.getTheme();
    emit(ThemeChanged(themeMode));
  }
}
