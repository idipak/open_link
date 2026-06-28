import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';

class SectionHeader extends StatelessWidget {
  final String title;
  final String? trailingText;
  final VoidCallback? onTrailingTap;
  final bool uppercase;

  const SectionHeader({
    super.key,
    required this.title,
    this.trailingText,
    this.onTrailingTap,
    this.uppercase = true,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.baseline,
      textBaseline: TextBaseline.alphabetic,
      children: [
        Text(
          uppercase ? title.toUpperCase() : title,
          style: uppercase
              ? AppTextStyles.sans.copyWith(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: AppColors.mutedText,
                  letterSpacing: 0.02,
                )
              : AppTextStyles.editorialHeadline.copyWith(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
        ),
        if (trailingText != null)
          GestureDetector(
            onTap: onTrailingTap,
            child: Text(
              trailingText!,
              style: AppTextStyles.sans.copyWith(
                fontSize: 13,
                color: AppColors.mutedText,
              ),
            ),
          ),
      ],
    );
  }
}
