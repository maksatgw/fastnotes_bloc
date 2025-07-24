import 'package:flutter/material.dart';

// Ortak bir tema değiştirme butonu widget'ı
class ChangeThemeButtonWidget extends StatelessWidget {
  const ChangeThemeButtonWidget({
    super.key,
    required this.onPressed,
    required this.themeMode,
  });
  final VoidCallback onPressed;
  final ThemeMode themeMode;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed,
      icon: themeMode == ThemeMode.light
          ? const Icon(Icons.dark_mode)
          : const Icon(Icons.light_mode),
    );
  }
}
