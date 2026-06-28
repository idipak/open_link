import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';
import '../../shared/widgets/section_header.dart';
import '../../shared/widgets/progress_bar.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(22, 6, 22, 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Header
              Row(
                children: [
                  Container(
                    width: 46,
                    height: 46,
                    decoration: const BoxDecoration(
                      color: AppColors.darkCard,
                      shape: BoxShape.circle,
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      'D',
                      style: AppTextStyles.sans.copyWith(
                        fontSize: 17,
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Your progress',
                        style: AppTextStyles.editorialHeadline.copyWith(
                          fontSize: 21,
                          height: 1.0,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        'Member since Mar 2026',
                        style: AppTextStyles.sans.copyWith(
                          fontSize: 12.5,
                          color: AppColors.mutedText,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 18),

              // Stats Row
              Row(
                children: [
                  _buildStatCard('42', 'Saved'),
                  const SizedBox(width: 10),
                  _buildStatCard('128', 'Reviewed', highlight: true),
                  const SizedBox(width: 10),
                  _buildStatCard('87%', 'Recall'),
                ],
              ),

              const SizedBox(height: 22),
              const SectionHeader(title: 'Last 5 weeks'),
              const SizedBox(height: 11),

              // Heatmap
              _buildHeatmap(),

              const SizedBox(height: 22),
              const SectionHeader(title: 'Top topics'),
              const SizedBox(height: 12),

              // Top Topics
              _buildTopicItem('Neuroscience', '8', 0.8),
              _buildTopicItem('Productivity', '6', 0.6),
              _buildTopicItem('Economics', '5', 0.48),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatCard(String value, String label, {bool highlight = false}) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 13, horizontal: 6),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: AppColors.border),
          borderRadius: BorderRadius.circular(14),
        ),
        child: Column(
          children: [
            Text(
              value,
              style: AppTextStyles.editorialHeadline.copyWith(
                fontSize: 24,
                color: highlight ? AppColors.accent : AppColors.onSurface,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              label,
              style: AppTextStyles.sans.copyWith(
                fontSize: 11,
                color: AppColors.mutedText,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeatmap() {
    const colors = [
      AppColors.progressBackground,
      AppColors.heatmapLight,
      AppColors.accent,
      AppColors.progressBackground,
      AppColors.heatmapMedium,
      AppColors.accent,
      AppColors.accent,
    ];

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 7,
        crossAxisSpacing: 6,
        mainAxisSpacing: 6,
      ),
      itemCount: 35,
      itemBuilder: (context, index) {
        final cIndex = (index * 7 + index % 3) % colors.length;
        return Container(
          decoration: BoxDecoration(
            color: colors[cIndex],
            borderRadius: BorderRadius.circular(5),
          ),
        );
      },
    );
  }

  Widget _buildTopicItem(String name, String count, double progress) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                name,
                style: AppTextStyles.sans.copyWith(fontSize: 13),
              ),
              Text(
                count,
                style: AppTextStyles.sans.copyWith(
                  fontSize: 13,
                  color: AppColors.mutedText,
                ),
              ),
            ],
          ),
          const SizedBox(height: 5),
          AppProgressBar(progress: progress, height: 7),
        ],
      ),
    );
  }
}
