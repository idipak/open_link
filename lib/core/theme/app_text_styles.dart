import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';

class AppTextStyles {
  AppTextStyles._();

  /// Editorial Serif (Newsreader)
  static TextStyle get editorialHeadline => GoogleFonts.newsreader(
        color: AppColors.onSurface,
        fontWeight: FontWeight.w500,
        letterSpacing: -0.015,
        height: 1.1,
      );

  /// Modern Sans-Serif (Hanken Grotesk)
  static TextStyle get sans => GoogleFonts.hankenGrotesk(
        color: AppColors.onSurface,
      );
}
