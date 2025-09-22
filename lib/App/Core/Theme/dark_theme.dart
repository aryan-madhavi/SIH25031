import 'package:civic_reporter/App/Core/Constants/color_constants.dart';
import 'package:flutter/material.dart';

ThemeData darkThemeData = ThemeData(
  fontFamily: 'Poppins',
  brightness: Brightness.dark,
  primaryColor: ColorConstants.primaryDarkBackgroundColor,
  useMaterial3: true,
  inputDecorationTheme: InputDecorationTheme(
    fillColor: ColorConstants.darkInputFillColor,
    filled: true,
  ),
  appBarTheme: const AppBarTheme(
    backgroundColor: ColorConstants.darkAppBarColor,
  ),
  scaffoldBackgroundColor: ColorConstants.primaryDarkBackgroundColor,
  shadowColor: ColorConstants.darkShadowColor,
  tabBarTheme: TabBarThemeData(
    indicatorColor: ColorConstants.darkInputFillColor,
  ),
  splashColor: ColorConstants.darkSplashColor,
);
