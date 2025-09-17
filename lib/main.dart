import 'package:civic_reporter/Core/Theme/dark_theme.dart';
import 'package:civic_reporter/Core/Theme/light_theme.dart';
import 'package:civic_reporter/Core/Theme/riverpod/theme_provider.dart';
import 'package:civic_reporter/presentation/home/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(ProviderScope(child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        final themeMode = ref.watch(themeProvider);
        return MaterialApp(
          title: 'Civic Reporter',

          theme: lightThemeData,
          darkTheme: darkThemeData,
          debugShowCheckedModeBanner: false,
          home: HomePage(),
          themeMode: themeMode,
        );
      },
    );
  }
}
