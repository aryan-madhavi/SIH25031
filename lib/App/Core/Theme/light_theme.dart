import 'package:civic_reporter/App/Core/Constants/color_constants.dart';
import 'package:flutter/material.dart';

ThemeData lightThemeData = ThemeData(
  useMaterial3: true,
  inputDecorationTheme: InputDecorationTheme(
    fillColor: ColorConstants.whiteColor,
    filled: true,
  ),
  // appBarTheme: const AppBarTheme(
  //   backgroundColor: ColorConstants.lightBackgroundColor,
  // ),
  scaffoldBackgroundColor: ColorConstants.lightBackgroundColor,
  shadowColor: ColorConstants.lightShadowColor,
  tabBarTheme: TabBarThemeData(indicatorColor: ColorConstants.whiteColor),
  splashColor: ColorConstants.whiteColor,
);
