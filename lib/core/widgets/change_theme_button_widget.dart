import 'package:fastnotes_bloc/core/theme/theme_cubit/theme_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// Ortak bir tema değiştirme butonu widget'ı
class ChangeThemeButtonWidget extends StatelessWidget {
  const ChangeThemeButtonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocSelector<ThemeCubit, ThemeState, ThemeMode>(
      selector: (state) => state.isDarkMode ? ThemeMode.dark : ThemeMode.light,
      builder: (context, themeMode) {
        return IconButton(
          onPressed: () => context.read<ThemeCubit>().toggleTheme(),
          icon: themeMode == ThemeMode.light
              ? const Icon(Icons.dark_mode)
              : const Icon(Icons.light_mode),
        );
      },
    );
  }
}
