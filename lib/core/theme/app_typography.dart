import 'package:flutter/material.dart';
import '../ui/context_ext.dart';
import '../ui/app_tokens.dart';

class AppTypography {
  static TextStyle h1(BuildContext context) =>
      TextStyle(fontSize: context.sp(24), fontWeight: AppFontWeight.bold);

  static TextStyle h2(BuildContext context) =>
      TextStyle(fontSize: context.sp(20), fontWeight: AppFontWeight.bold);

  static TextStyle body(BuildContext context) =>
      TextStyle(fontSize: context.sp(14), fontWeight: AppFontWeight.regular);

  static TextStyle caption(BuildContext context) =>
      TextStyle(fontSize: context.sp(12), fontWeight: AppFontWeight.medium);
}
