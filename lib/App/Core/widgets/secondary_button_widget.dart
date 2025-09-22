import 'package:civic_reporter/App/Core/Constants/color_constants.dart';
import 'package:civic_reporter/App/Core/Theme/helper/theme_helper.dart';
import 'package:civic_reporter/App/Core/Theme/riverpod/theme_provider.dart';
import 'package:civic_reporter/App/Core/services/responsive_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SecondaryButtonWidget extends ConsumerWidget {
  final String? buttonLabel;
  final IconData? buttonIcon;
  final VoidCallback buttonOnPress;
  const SecondaryButtonWidget({
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
        padding: EdgeInsets.all(ResponsiveService.w(0.025)),
        width: double.infinity,
        height: ResponsiveService.h(0.055),
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: ThemeHelper.ButtonBackground(currentTheme),
              spreadRadius: 0.5,
              blurRadius: 5,
            ),
          ],
          color: ColorConstants.primaryColorLight,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              buttonLabel ?? '',
              style: TextStyle(
                fontSize: ResponsiveService.fs(0.040),
                fontWeight: FontWeight.w500,
                color: ColorConstants.whiteColor,
              ),
            ),
            SizedBox(width: ResponsiveService.w(0.025)),

            Icon(buttonIcon, color: ColorConstants.whiteColor),
          ],
        ),
      ),
    );
  }
}

class FutureSecondaryButtonWidget extends ConsumerWidget {
  final Widget? buttonLabel;
  final IconData? buttonIcon;
  final Future<void> Function()? buttonOnPress;
  const FutureSecondaryButtonWidget({
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
        padding: EdgeInsets.all(ResponsiveService.w(0.025)),
        width: double.infinity,
        height: ResponsiveService.h(0.055),
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: ThemeHelper.ButtonBackground(currentTheme),
              spreadRadius: 0.5,
              blurRadius: 5,
            ),
          ],
          color: ColorConstants.primaryColorLight,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            buttonLabel!,
            // Text(
            //   buttonLabel ?? '',
            //   style: TextStyle(
            //     fontSize: ResponsiveService.fs(0.040),
            //     fontWeight: FontWeight.w500,
            //     color: ColorConstants.whiteColor,
            //   ),
            // ),
            SizedBox(width: ResponsiveService.w(0.025)),

            Icon(buttonIcon, color: ColorConstants.whiteColor),
          ],
        ),
      ),
    );
  }
}

// class FutureSecondaryButtonWidget extends StatelessWidget {
//   final Future<void> Function()? buttonOnPress;
//   final Widget buttonLabel; // Changed from String to Widget
//   final IconData buttonIcon;
//   const FutureSecondaryButtonWidget({
//     super.key,
//     this.buttonOnPress,
//     required this.buttonLabel,
//     required this.buttonIcon,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return ElevatedButton.icon(
//       onPressed: buttonOnPress, // Now this accepts an async function
//       icon: Icon(buttonIcon, color: ColorConstants.primaryColorDark),
//       label: buttonLabel,
//       style: ButtonStyle(
//         backgroundColor: const WidgetStatePropertyAll(
//           ColorConstants.secondaryColor,
//         ),
//         foregroundColor: const WidgetStatePropertyAll(Colors.white),
//         minimumSize: WidgetStatePropertyAll(
//           Size(ResponsiveService.w(0.02), ResponsiveService.h(0.07)),
//         ),
//         shape: WidgetStatePropertyAll(
//           RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
//         ),
//         shadowColor: const WidgetStatePropertyAll(
//           ColorConstants.primaryColorDark,
//         ),
//         elevation: const WidgetStatePropertyAll(5),
//       ),
//     );
//   }
// }
