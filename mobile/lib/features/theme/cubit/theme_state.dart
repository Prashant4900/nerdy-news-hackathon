part of 'theme_cubit.dart';

abstract class ThemeState extends Equatable {
  const ThemeState(this.themeMode);

  final ThemeMode themeMode;

  @override
  List<Object> get props => [themeMode];
}

class ThemeInitial extends ThemeState {
  const ThemeInitial(super.themeMode);

  @override
  List<Object> get props => [themeMode];
}

class ThemeChanged extends ThemeState {
  const ThemeChanged(super.themeMode);

  @override
  List<Object> get props => [themeMode];
}
