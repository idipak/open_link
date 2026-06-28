import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';
import '../../shared/widgets/app_button.dart';
import '../../shared/widgets/article_thumbnail.dart';

class ArticleDetailScreen extends StatelessWidget {
  final String articleId;

  const ArticleDetailScreen({super.key, required this.articleId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
          onPressed: () => context.pop(),
        ),
        actions: [
          IconButton(
              icon: const Icon(Icons.bookmark_outline), onPressed: () {}),
          IconButton(icon: const Icon(Icons.more_horiz), onPressed: () {}),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 22),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const ArticleThumbnail(
                      width: double.infinity, height: 120, borderRadius: 16),
                  const SizedBox(height: 14),
                  Text(
                    'The Deep Roots of Human Memory',
                    style: AppTextStyles.editorialHeadline
                        .copyWith(fontSize: 24),
                  ),
                  const SizedBox(height: 7),
                  Text(
                    'nautil.us · 11 min read · saved 2d ago',
                    style: AppTextStyles.sans.copyWith(
                      fontSize: 12.5,
                      color: AppColors.mutedText,
                    ),
                  ),
                  const SizedBox(height: 16),
                  // Tabs
                  Container(
                    padding: const EdgeInsets.all(3),
                    decoration: BoxDecoration(
                      color: AppColors.searchBarBg,
                      borderRadius: BorderRadius.circular(11),
                    ),
                    child: Row(
                      children: [
                        _buildTab('TL;DR', true),
                        _buildTab('Key points', false),
                        _buildTab('Full', false),
                      ],
                    ),
                  ),
                  const SizedBox(height: 13),
                  // Summary Box
                  Container(
                    padding: const EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      color: AppColors.accentSurface,
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const Icon(Icons.auto_awesome,
                                color: AppColors.accent, size: 13),
                            const SizedBox(width: 6),
                            Text(
                              'TL;DR',
                              style: AppTextStyles.sans.copyWith(
                                fontSize: 11.5,
                                color: AppColors.accent,
                                fontWeight: FontWeight.w700,
                                letterSpacing: 0.04,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Text(
                          "Memory isn't a recording — it's reconstruction. Every time you recall something you rebuild and slightly rewrite it, which is why spaced review beats re-reading.",
                          style: AppTextStyles.editorialHeadline.copyWith(
                            fontSize: 17,
                            height: 1.32,
                            color: AppColors.bodyText,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 13),
                  // Audio player
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 14, vertical: 11),
                    decoration: BoxDecoration(
                      border: Border.all(color: AppColors.border),
                      borderRadius: BorderRadius.circular(13),
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 34,
                          height: 34,
                          decoration: const BoxDecoration(
                            color: AppColors.darkCard,
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(Icons.play_arrow_rounded,
                              color: Colors.white, size: 20),
                        ),
                        const SizedBox(width: 11),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Listen to summary',
                              style: AppTextStyles.sans.copyWith(
                                fontSize: 13.5,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              '0:48 · narrated',
                              style: AppTextStyles.sans.copyWith(
                                fontSize: 11.5,
                                color: AppColors.mutedText,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                ],
              ),
            ),
          ),

          // Bottom Actions
          Container(
            padding: const EdgeInsets.fromLTRB(22, 13, 22, 24),
            decoration: const BoxDecoration(
              color: AppColors.background,
              border: Border(top: BorderSide(color: AppColors.border)),
            ),
            child: Row(
              children: [
                Expanded(
                  child: AppButton(
                    text: 'Read full ↗',
                    variant: AppButtonVariant.outline,
                    onPressed: () {},
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: AppButton(
                    text: 'Quiz me',
                    onPressed: () {},
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTab(String text, bool isSelected) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8),
        decoration: isSelected
            ? BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                boxShadow: [
                  BoxShadow(
                      color: Colors.black.withValues(alpha: 0.06),
                      blurRadius: 3,
                      offset: const Offset(0, 1)),
                ],
              )
            : null,
        alignment: Alignment.center,
        child: Text(
          text,
          style: AppTextStyles.sans.copyWith(
            fontSize: 12.5,
            fontWeight: FontWeight.w600,
            color: isSelected ? AppColors.onSurface : AppColors.inactiveTab,
          ),
        ),
      ),
    );
  }
}
