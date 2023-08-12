import 'package:akar_icons_flutter/akar_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile/features/theme/cubit/theme_cubit.dart';

class ThemeButton extends StatelessWidget {
  const ThemeButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeState>(
      builder: (context, state) {
        return ListTile(
          title: state.themeMode == ThemeMode.light
              ? const Text('Dark')
              : const Text('Light'),
          leading: state.themeMode == ThemeMode.light
              ? const Icon(AkarIcons.moon_fill)
              : const Icon(AkarIcons.sun_fill),
          onTap: () {
            state.themeMode == ThemeMode.light
                ? context.read<ThemeCubit>().changeTheme(ThemeMode.dark)
                : context.read<ThemeCubit>().changeTheme(ThemeMode.light);
          },
        );
      },
    );
  }
}
