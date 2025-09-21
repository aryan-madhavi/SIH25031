import 'package:civic_reporter/App/Core/Constants/color_constants.dart';
import 'package:flutter/material.dart';

ThemeData darkThemeData = ThemeData(
  brightness: Brightness.dark,
  primaryColor: Colors.lightBlueAccent[100], 
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
  
  cardColor: const Color(0xFF2D2D2D),
  textTheme: const TextTheme(
    bodyMedium: TextStyle(color: Colors.white70), 
    bodySmall: TextStyle(color: Colors.white54),  
    titleLarge: TextStyle(color: Colors.white),   
  ),
  iconTheme: const IconThemeData(
    color: Colors.white70 
  ),
);