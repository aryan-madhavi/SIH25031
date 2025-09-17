import 'package:civic_reporter/Core/Constants/color_constants.dart';
import 'package:civic_reporter/Core/Theme/helper/theme_helper.dart';
import 'package:civic_reporter/Core/Theme/riverpod/theme_provider.dart';
import 'package:civic_reporter/Core/services/responsive_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeReportWidget extends ConsumerWidget {
  final IconData? icon;
  final String? title;
  final String? subtitle;
  const HomeReportWidget(this.icon, this.title, this.subtitle, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentTheme = ref.watch(themeProvider);

    return Container(
      padding: EdgeInsets.all(ResponsiveService.w(0.05)),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          width: 1,
          color: ThemeHelper.buttonBorder(currentTheme),
        ),
        //color: ThemeHelper.ButtonBackground(currentTheme),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          //* Icon
          Icon(icon, color: ColorConstants.primaryColorLight, size: ResponsiveService.w(0.07),),

          SizedBox(width: ResponsiveService.w(0.025)),

          //* Text content
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// Title
                Text(
                  title ?? "NA",
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: ResponsiveService.fs(0.038),
                    fontWeight: FontWeight.w500,
                  ),
                ),

                SizedBox(height: ResponsiveService.h(0.003)),

                /// Subtitle
                Text(
                  subtitle ?? "NA",
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: ResponsiveService.fs(0.05),
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
