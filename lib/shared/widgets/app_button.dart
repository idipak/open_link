import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';

enum AppButtonVariant { primary, secondary, dark, outline }

class AppButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final AppButtonVariant variant;
  final Widget? icon;
  final double? width;
  final EdgeInsetsGeometry? padding;

  const AppButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.variant = AppButtonVariant.primary,
    this.icon,
    this.width,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    final (bgColor, textColor, borderSide) = _resolveStyle();

    return SizedBox(
      width: width,
      child: Material(
        color: bgColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14),
          side: borderSide,
        ),
        child: InkWell(
          onTap: onPressed,
          borderRadius: BorderRadius.circular(14),
          child: Padding(
            padding: padding ??
                const EdgeInsets.symmetric(vertical: 15, horizontal: 24),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (icon != null) ...[
                  icon!,
                  const SizedBox(width: 8),
                ],
                Text(
                  text,
                  style: AppTextStyles.sans.copyWith(
                    color: textColor,
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  (Color, Color, BorderSide) _resolveStyle() {
    return switch (variant) {
      AppButtonVariant.primary => (
          AppColors.accent,
          Colors.white,
          BorderSide.none,
        ),
      AppButtonVariant.secondary => (
          AppColors.accentSurface,
          AppColors.accent,
          BorderSide.none,
        ),
      AppButtonVariant.dark => (
          AppColors.darkCard,
          Colors.white,
          BorderSide.none,
        ),
      AppButtonVariant.outline => (
          Colors.transparent,
          AppColors.onSurface,
          const BorderSide(color: AppColors.border, width: 1.5),
        ),
    };
  }
}
