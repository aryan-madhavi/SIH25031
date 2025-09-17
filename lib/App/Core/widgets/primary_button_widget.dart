// import 'package:civic_reporter/App/Core/Constants/color_constants.dart';
import 'package:civic_reporter/App/Core/Theme/helper/theme_helper.dart';
import 'package:civic_reporter/App/Core/Theme/riverpod/theme_provider.dart';
import 'package:civic_reporter/App/Core/services/responsive_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PrimaryButtonWidget extends ConsumerWidget {
  final String? buttonLabel;
  final IconData? buttonIcon;
  final VoidCallback buttonOnPress;
  const PrimaryButtonWidget({
    super.key,
    this.buttonLabel,
    this.buttonIcon,
    required this.buttonOnPress,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentTheme = ref.watch(themeProvider);

    return GestureDetector(
      onTap: buttonOnPress,
      child: Container(
        width: double.infinity,
        height: ResponsiveService.h(0.055),
        decoration: BoxDecoration(
          color: ThemeHelper.ButtonBackground(currentTheme),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            width: 1,
            color: ThemeHelper.buttonBorder(currentTheme),
          ),
        ),

        child: Center(
          child: Text(
            buttonLabel ?? "",
            style: TextStyle(
              fontSize: ResponsiveService.fs(0.040),
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }
}
