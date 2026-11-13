import 'package:flutter/material.dart';
import 'app_colors.dart';
import 'app_radius.dart';
import 'app_typography.dart';

class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: false,
      brightness: Brightness.light,
      fontFamily: AppTypography.fontFamily,
      primaryColor: AppColors.accentLight,
      scaffoldBackgroundColor: AppColors.bgPrimaryLight,
      colorScheme: const ColorScheme.light(
        primary: AppColors.accentLight,
        secondary: AppColors.textSecondaryLight,
        surface: AppColors.surfaceLight,
        onSurface: AppColors.textPrimaryLight,
        onPrimary: Colors.white,
        outline: AppColors.borderHairlineLight,
      ),
      textTheme: TextTheme(
        displayLarge: AppTypography.display(AppColors.textPrimaryLight),
        headlineLarge: AppTypography.h1(AppColors.textPrimaryLight),
        headlineMedium: AppTypography.h2(AppColors.textPrimaryLight),
        headlineSmall: AppTypography.h3(AppColors.textPrimaryLight),
        titleLarge: AppTypography.h4(AppColors.textPrimaryLight),
        bodyLarge: AppTypography.bodyLarge(AppColors.textPrimaryLight),
        bodyMedium: AppTypography.body(AppColors.textPrimaryLight),
        bodySmall: AppTypography.caption(AppColors.textSecondaryLight),
        labelLarge: AppTypography.button(AppColors.textPrimaryLight),
        labelSmall: AppTypography.overline(AppColors.textSecondaryLight),
      ),
      dividerTheme: const DividerThemeData(
        color: AppColors.borderHairlineLight,
        thickness: 1.0,
        space: 1.0,
      ),
      cardTheme: CardThemeData(
        color: AppColors.surfaceLight,
        elevation: 0.0, // NO drop shadows anywhere
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppRadius.card),
          side: const BorderSide(color: AppColors.borderHairlineLight, width: 1.0),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.surfaceLight,
        contentPadding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 12.0),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadius.input),
          borderSide: const BorderSide(color: AppColors.borderHairlineLight, width: 1.0),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadius.input),
          borderSide: const BorderSide(color: AppColors.borderHairlineLight, width: 1.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadius.input),
          borderSide: const BorderSide(color: AppColors.accentLight, width: 1.5),
        ),
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.bgPrimaryLight,
        elevation: 0.0,
        scrolledUnderElevation: 0.0,
        centerTitle: true,
        iconTheme: IconThemeData(color: AppColors.textPrimaryLight, size: 22.0),
      ),
      bottomSheetTheme: const BottomSheetThemeData(
        backgroundColor: AppColors.bgPrimaryLight,
        elevation: 0.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(AppRadius.modal)),
        ),
      ),
    );
  }

  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: false,
      brightness: Brightness.dark,
      fontFamily: AppTypography.fontFamily,
      primaryColor: AppColors.accentDark,
      scaffoldBackgroundColor: AppColors.bgPrimaryDark,
      colorScheme: const ColorScheme.dark(
        primary: AppColors.accentDark,
        secondary: AppColors.textSecondaryDark,
        surface: AppColors.surfaceDark,
        onSurface: AppColors.textPrimaryDark,
        onPrimary: Colors.white,
        outline: AppColors.borderHairlineDark,
      ),
      textTheme: TextTheme(
        displayLarge: AppTypography.display(AppColors.textPrimaryDark),
        headlineLarge: AppTypography.h1(AppColors.textPrimaryDark),
        headlineMedium: AppTypography.h2(AppColors.textPrimaryDark),
        headlineSmall: AppTypography.h3(AppColors.textPrimaryDark),
        titleLarge: AppTypography.h4(AppColors.textPrimaryDark),
        bodyLarge: AppTypography.bodyLarge(AppColors.textPrimaryDark),
        bodyMedium: AppTypography.body(AppColors.textPrimaryDark),
        bodySmall: AppTypography.caption(AppColors.textSecondaryDark),
        labelLarge: AppTypography.button(AppColors.textPrimaryDark),
        labelSmall: AppTypography.overline(AppColors.textSecondaryDark),
      ),
      dividerTheme: const DividerThemeData(
        color: AppColors.borderHairlineDark,
        thickness: 1.0,
        space: 1.0,
      ),
      cardTheme: CardThemeData(
        color: AppColors.bgSecondaryDark,
        elevation: 0.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppRadius.card),
          side: const BorderSide(color: AppColors.borderHairlineDark, width: 1.0),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.bgSecondaryDark,
        contentPadding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 12.0),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadius.input),
          borderSide: const BorderSide(color: AppColors.borderHairlineDark, width: 1.0),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadius.input),
          borderSide: const BorderSide(color: AppColors.borderHairlineDark, width: 1.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadius.input),
          borderSide: const BorderSide(color: AppColors.accentDark, width: 1.5),
        ),
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.bgPrimaryDark,
        elevation: 0.0,
        scrolledUnderElevation: 0.0,
        centerTitle: false,
        iconTheme: IconThemeData(color: AppColors.textPrimaryDark, size: 22.0),
      ),
      bottomSheetTheme: const BottomSheetThemeData(
        backgroundColor: AppColors.bgSecondaryDark,
        elevation: 0.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(AppRadius.modal)),
        ),
      ),
    );
  }
}
