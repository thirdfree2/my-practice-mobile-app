import 'dart:math' as math;
import 'package:flutter/material.dart';

extension ContextExt on BuildContext {
  MediaQueryData get mq => MediaQuery.of(this);

  double get screenWidth => mq.size.width;
  double get screenHeight => mq.size.height;

  bool get isSmallPhone => screenWidth < 360;
  bool get isPhone => screenWidth < 600;
  bool get isTablet => screenWidth >= 600 && screenWidth < 1024;
  bool get isDesktop => screenWidth >= 1024;

  // base size สำหรับออกแบบ UI (ปรับได้)
  static const double _baseWidth = 375;
  static const double _baseHeight = 812;

  double get _scaleW => screenWidth / _baseWidth;
  double get _scaleH => screenHeight / _baseHeight;

  /// scale แบบปลอดภัย (ใช้ตัวที่เล็กกว่า)
  double get scale => math.min(_scaleW, _scaleH);

  /// responsive width/height
  double rw(double value) => value * _scaleW;
  double rh(double value) => value * _scaleH;

  /// responsive font size (clamp กันใหญ่เกิน/เล็กเกิน)
  double sp(double fontSize, {double min = 10, double max = 40}) {
    final v = fontSize * scale;
    return v.clamp(min, max).toDouble();
  }

  ColorScheme get colors => Theme.of(this).colorScheme;
  TextTheme get textTheme => Theme.of(this).textTheme;
}
