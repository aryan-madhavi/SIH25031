import 'package:flutter/material.dart';

class ResponsiveService {
  static late double screenWidth;
  static late double screenHeight;
  static late TextScaler textScaler;

  static void init(BuildContext context) {
    final size = MediaQuery.of(context).size;
    screenWidth = size.width;
    screenHeight = size.height;
    textScaler = MediaQuery.of(context).textScaler;
  }

  static double h(double percentage) => screenHeight * percentage;
  static double w(double percentage) => screenWidth * percentage;
  static double fs(double percentage) =>
      textScaler.scale(screenWidth * percentage);
}
