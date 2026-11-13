import 'package:flutter/material.dart';

class AppTypography {
  static const String fontFamily = 'Roboto';

  static TextStyle _style({
    required double fontSize,
    required Color color,
    FontWeight fontWeight = FontWeight.w400,
    double? height,
    double? letterSpacing,
  }) {
    return TextStyle(
      fontFamily: fontFamily,
      fontSize: fontSize,
      fontWeight: fontWeight,
      color: color,
      height: height,
      letterSpacing: letterSpacing,
    );
  }

  static TextStyle display(Color color) => _style(
        fontSize: 32,
        color: color,
        height: 1.25,
      );

  static TextStyle h1(Color color) => _style(
        fontSize: 24,
        color: color,
        height: 1.333,
      );

  static TextStyle h2(Color color) => _style(
        fontSize: 18,
        color: color,
        height: 1.333,
        fontWeight: FontWeight.w500,
      );

  static TextStyle h3(Color color) => _style(
        fontSize: 16,
        color: color,
        height: 1.5,
      );

  static TextStyle h4(Color color) => _style(
        fontSize: 18,
        color: color,
        height: 1.333,
      );

  static TextStyle bodyLarge(Color color) => _style(
        fontSize: 16,
        color: color,
        height: 1.5,
      );

  static TextStyle body(Color color) => _style(
        fontSize: 14,
        color: color,
        height: 1.571,
      );

  static TextStyle bodyMedium(Color color) => _style(
        fontSize: 14,
        color: color,
        height: 1.571,
      );

  static TextStyle caption(Color color) => _style(
        fontSize: 12,
        color: color,
        height: 1.667,
      );

  static TextStyle overline(Color color) => _style(
        fontSize: 11,
        color: color,
        height: 1.455,
        letterSpacing: 1.4,
      );

  static TextStyle button(Color color) => _style(
        fontSize: 15,
        color: color,
        height: 1.333,
        letterSpacing: 0.2,
      );
}
