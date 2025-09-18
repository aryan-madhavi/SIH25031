import 'dart:ui';

import 'package:civic_reporter/App/Core/Constants/color_constants.dart';
import 'package:flutter/material.dart';

class ThemeHelper {
  
  static Color ButtonBackground(ThemeMode mode) {
    return mode == ThemeMode.light
        ? ColorConstants.whiteColor
        : ColorConstants.darkInputFillColor;
  }

  static Color buttonBorder(ThemeMode mode) {
    return mode == ThemeMode.light
        ? ColorConstants.blackColor
        : ColorConstants.whiteColor;
  }

  static Color textColor(ThemeMode mode) {
    return mode == ThemeMode.light
        ? ColorConstants.blackColor
        : ColorConstants.whiteColor;
  }
}
