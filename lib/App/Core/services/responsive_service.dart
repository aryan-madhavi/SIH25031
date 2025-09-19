import 'package:flutter/material.dart';

enum DeviceType { mobile, tablet, desktop }

class ResponsiveService {
  static late double _screenWidth;
  static late double _screenHeight;
  static late TextScaler _textScaler;
  static late DeviceType _deviceType;

  /// Initialize with MediaQuery data (call in MaterialApp.builder)
  static void init(BuildContext context) {
    
    final size = MediaQuery.of(context).size;
    _screenWidth = size.width;
    _screenHeight = size.height;
    _textScaler = MediaQuery.of(context).textScaler;

    if (_screenWidth >= 1024) {
      _deviceType = DeviceType.desktop;
    } else if (_screenWidth >= 600) {
      _deviceType = DeviceType.tablet;
    } else {
      _deviceType = DeviceType.mobile;
    }
  }

  // ------------ Layout Utilities ------------ //

  /// Height as % of screen
  static double h(double fraction) => _screenHeight * fraction;

  /// Width as % of screen
  static double w(double fraction) => _screenWidth * fraction;

  /// Padding scaled by device type
  static double p(double fraction) {
    switch (_deviceType) {
      case DeviceType.desktop:
        return _screenWidth * fraction * 0.8;
      case DeviceType.tablet:
        return _screenWidth * fraction * 0.9;
      case DeviceType.mobile:
        return _screenWidth * fraction;
    }
  }

  /// Font size (scales with device + textScaler)
  static double fs(double fraction) {
    double baseSize;
    switch (_deviceType) {
      case DeviceType.desktop:
        baseSize = _screenWidth * fraction * 0.85;
        break;
      case DeviceType.tablet:
        baseSize = _screenWidth * fraction * 0.92;
        break;
      case DeviceType.mobile:
        baseSize = _screenWidth * fraction;
        break;
    }
    return _textScaler.scale(baseSize.clamp(12, 28)); // tighter bounds
  }

  /// Icon size (independent from font scaling)
  static double icon(double fraction) {
    double baseSize = _screenWidth * fraction;
    // icons should not scale as much → apply smaller clamp
    return baseSize.clamp(18, 40);
  }

  // ------------ Breakpoints ------------ //

  static bool get isMobile => _deviceType == DeviceType.mobile;
  static bool get isTablet => _deviceType == DeviceType.tablet;
  static bool get isDesktop => _deviceType == DeviceType.desktop;

  static DeviceType get deviceType => _deviceType;
}
