import 'package:civic_reporter/Core/Constants/color_constants.dart';
import 'package:civic_reporter/Core/Constants/string_constants.dart';
import 'package:civic_reporter/Core/Theme/riverpod/theme_provider.dart';
import 'package:civic_reporter/Core/services/responsive_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AppbarWidget extends ConsumerWidget implements PreferredSizeWidget {
  const AppbarWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    void onThemeButtonToggle() {
      ref.read(themeProvider.notifier).toggleTheme();
    }

    final Shader linearGradient = LinearGradient(
      colors: <Color>[
        ColorConstants.primaryColorLight,
        ColorConstants.primaryColorDark,
      ],
    ).createShader(Rect.fromLTWH(0.0, 0.0, 200.0, 70.0));

    final currentTheme = ref.watch(themeProvider);

    
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 2,
      //*title
      title: Text(
        StringConstants.CivicReporter,
        style: TextStyle(
          fontSize: ResponsiveService.fs(0.075),
          //color: ColorConstants.primaryColorDark,
          fontWeight: FontWeight.w700,
          foreground: Paint()..shader = linearGradient,
        ),
      ),
      automaticallyImplyLeading: false,
      actions: [
        //* Toggle Switch:
        IconButton(
          onPressed: onThemeButtonToggle,
          icon: Icon(
            currentTheme == ThemeMode.light
                ? Icons.dark_mode_outlined
                : Icons.light_mode_outlined,

            size: ResponsiveService.w(0.058),
          ),
          hoverColor: ColorConstants.secondaryColor,
        ),
        //*

        //* Menu Switch:
        IconButton(
          onPressed: () {},
          icon: Icon(Icons.menu, size: ResponsiveService.w(0.058)),
        ),
      ],
    );
  }
  
 @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
