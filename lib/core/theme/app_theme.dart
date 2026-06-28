import 'package:flutter/material.dart';
import 'app_colors.dart';
import 'app_text_styles.dart';

class AppTheme {
  AppTheme._();

  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      scaffoldBackgroundColor: AppColors.background,
      colorScheme: const ColorScheme.light(
        primary: AppColors.accent,
        secondary: AppColors.accentSurface,
        surface: AppColors.surface,
        onSurface: AppColors.onSurface,
        error: AppColors.error,
      ),
      textTheme: TextTheme(
        displayLarge: AppTextStyles.editorialHeadline.copyWith(fontSize: 44, fontWeight: FontWeight.w600),
        displayMedium: AppTextStyles.editorialHeadline.copyWith(fontSize: 36),
        displaySmall: AppTextStyles.editorialHeadline.copyWith(fontSize: 30),
        headlineLarge: AppTextStyles.editorialHeadline.copyWith(fontSize: 25),
        headlineMedium: AppTextStyles.editorialHeadline.copyWith(fontSize: 21),
        headlineSmall: AppTextStyles.editorialHeadline.copyWith(fontSize: 18),
        bodyLarge: AppTextStyles.sans.copyWith(fontSize: 17, color: AppColors.bodyText),
        bodyMedium: AppTextStyles.sans.copyWith(fontSize: 15, color: AppColors.onSurface),
        bodySmall: AppTextStyles.sans.copyWith(fontSize: 13, color: AppColors.subtleText),
        labelLarge: AppTextStyles.sans.copyWith(fontSize: 15, fontWeight: FontWeight.w600),
        labelMedium: AppTextStyles.sans.copyWith(fontSize: 13, fontWeight: FontWeight.w600),
        labelSmall: AppTextStyles.sans.copyWith(fontSize: 11, fontWeight: FontWeight.w700, letterSpacing: 0.1),
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.background,
        elevation: 0,
        centerTitle: true,
        iconTheme: IconThemeData(color: AppColors.onSurface),
      ),
      dividerTheme: const DividerThemeData(
        color: AppColors.border,
        thickness: 1,
      ),
      iconTheme: const IconThemeData(
        color: AppColors.onSurface,
      ),
    );
  }
}
