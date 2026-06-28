import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';

class StreakBadge extends StatelessWidget {
  final int streakCount;
  final bool filled;

  const StreakBadge({
    super.key,
    required this.streakCount,
    this.filled = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: filled ? AppColors.accent : AppColors.accentSurface,
        borderRadius: BorderRadius.circular(999),
        border: filled ? null : Border.all(color: AppColors.accent, width: 1.5),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.local_fire_department_rounded,
            color: filled ? Colors.white : AppColors.accent,
            size: 16,
          ),
          const SizedBox(width: 4),
          Text(
            '$streakCount',
            style: AppTextStyles.sans.copyWith(
              fontSize: 14,
              fontWeight: FontWeight.w700,
              color: filled ? Colors.white : AppColors.accent,
            ),
          ),
        ],
      ),
    );
  }
}
