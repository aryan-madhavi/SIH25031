import 'package:flutter/material.dart';
import 'package:flutter_riverpod/legacy.dart';

class ThemeProvider extends StateNotifier<ThemeMode> {
  ThemeProvider() : super(ThemeMode.light);

  void toggleTheme() {
    if (state == ThemeMode.light) {
      state = ThemeMode.dark;
    } else {
      state = ThemeMode.light;
    }
  }
}

final themeProvider = StateNotifierProvider.autoDispose(
  (ref) => ThemeProvider(),
);
