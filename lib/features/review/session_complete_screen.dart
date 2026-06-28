import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';
import '../../shared/widgets/app_button.dart';
import '../../shared/widgets/progress_bar.dart';
import 'bloc/review_cubit.dart';

class SessionCompleteScreen extends StatelessWidget {
  const SessionCompleteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 96,
                      height: 96,
                      decoration: const BoxDecoration(
                        color: AppColors.accentSurface,
                        shape: BoxShape.circle,
                      ),
                      child: const Center(
                        child: Icon(
                          Icons.local_fire_department_rounded,
                          color: AppColors.accent,
                          size: 46,
                        ),
                      ),
                    ),
                    const SizedBox(height: 22),
                    Text(
                      '8-day streak',
                      style: AppTextStyles.editorialHeadline.copyWith(
                        fontSize: 34,
                        letterSpacing: -0.015,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      'You recalled 4 of 5 cards today',
                      style: AppTextStyles.sans.copyWith(
                        fontSize: 15,
                        color: AppColors.subtleText,
                      ),
                    ),
                    const SizedBox(height: 30),
                    // XP Card
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(18),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: AppColors.border),
                        borderRadius: BorderRadius.circular(18),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.baseline,
                            textBaseline: TextBaseline.alphabetic,
                            children: [
                              Text(
                                'Level 4 · Scholar',
                                style: AppTextStyles.sans.copyWith(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text(
                                '320 / 500 XP',
                                style: AppTextStyles.sans.copyWith(
                                  fontSize: 12.5,
                                  color: AppColors.mutedText,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 11),
                          const AppProgressBar(progress: 0.64, height: 9),
                          const SizedBox(height: 9),
                          Text(
                            '+40 XP this session',
                            style: AppTextStyles.sans.copyWith(
                              fontSize: 13,
                              color: AppColors.accent,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.check_circle_outline,
                            color: AppColors.mutedText, size: 16),
                        const SizedBox(width: 8),
                        Text(
                          'Next review · tomorrow, 9:00 AM',
                          style: AppTextStyles.sans.copyWith(
                            fontSize: 13.5,
                            color: AppColors.subtleText,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            // Bottom Actions
            Padding(
              padding: const EdgeInsets.fromLTRB(30, 0, 30, 28),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  AppButton(
                    text: 'Done',
                    variant: AppButtonVariant.dark,
                    onPressed: () {
                      context.read<ReviewCubit>().resetSession();
                      context.go('/home');
                    },
                  ),
                  const SizedBox(height: 12),
                  GestureDetector(
                    onTap: () {},
                    child: Text(
                      'Share streak',
                      textAlign: TextAlign.center,
                      style: AppTextStyles.sans.copyWith(
                        fontSize: 14,
                        color: AppColors.subtleText,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
