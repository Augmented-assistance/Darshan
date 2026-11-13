import 'package:flutter/material.dart';

class AppColors {
  static const Color bgPrimaryLight = Color(0xFFF6F2FC);
  static const Color bgSecondaryLight = Color(0xFFFFFFFF);
  static const Color surfaceLight = Color(0xFFFFFFFF);
  static const Color textPrimaryLight = Color(0xFF28252D);
  static const Color textSecondaryLight = Color(0xFF8D8994);
  static const Color borderHairlineLight = Color(0xFFE6E1EE);
  static const Color accentLight = Color(0xFF17151A);
  static const Color lavenderLight = Color(0xFFEDE4FA);

  static const Color bgPrimaryDark = Color(0xFF121212);
  static const Color bgSecondaryDark = Color(0xFF1C1C1C);
  static const Color surfaceDark = Color(0xFF1C1C1C);
  static const Color textPrimaryDark = Color(0xFFF2F0EC);
  static const Color textSecondaryDark = Color(0xFFA8A39A);
  static const Color borderHairlineDark = Color(0xFF2C2C2C);
  static const Color accentDark = Color(0xFFB5502C);

  static Color bgPrimary(bool isDark) => isDark ? bgPrimaryDark : bgPrimaryLight;
  static Color bgSecondary(bool isDark) => isDark ? bgSecondaryDark : bgSecondaryLight;
  static Color surface(bool isDark) => isDark ? surfaceDark : surfaceLight;
  static Color textPrimary(bool isDark) => isDark ? textPrimaryDark : textPrimaryLight;
  static Color textSecondary(bool isDark) => isDark ? textSecondaryDark : textSecondaryLight;
  static Color borderHairline(bool isDark) => isDark ? borderHairlineDark : borderHairlineLight;
  static Color accent(bool isDark) => isDark ? accentDark : accentLight;
}
