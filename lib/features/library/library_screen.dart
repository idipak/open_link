import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';
import '../../shared/widgets/article_thumbnail.dart';
import '../../shared/widgets/section_header.dart';

class LibraryScreen extends StatelessWidget {
  const LibraryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(22, 6, 22, 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Library',
                style:
                    AppTextStyles.editorialHeadline.copyWith(fontSize: 30),
              ),
              const SizedBox(height: 14),

              // Search Bar
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 13, vertical: 11),
                decoration: BoxDecoration(
                  color: AppColors.searchBarBg,
                  borderRadius: BorderRadius.circular(13),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.search,
                        color: AppColors.mutedText, size: 20),
                    const SizedBox(width: 8),
                    Text(
                      'Search title, tag or text...',
                      style: AppTextStyles.sans.copyWith(
                        fontSize: 14,
                        color: AppColors.mutedText,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),
              _buildCategoryRow('Neuroscience', '8 saved', [
                _buildCard('The Deep Roots of Human Memory'),
                _buildCard('Why we forget what we read'),
                _buildEmptyCard(),
              ]),
              const SizedBox(height: 20),
              _buildCategoryRow('Economics', '5 saved', [
                _buildCard('How interest rates ripple out'),
                _buildCard('The quiet power of compounding'),
                _buildEmptyCard(),
              ]),
              const SizedBox(height: 20),
              _buildCategoryRow('Productivity', '6 saved', [
                _buildEmptyCard(width: 130),
                _buildEmptyCard(width: 130),
              ]),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCategoryRow(
      String title, String trailing, List<Widget> children) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SectionHeader(
          title: title,
          trailingText: trailing,
          uppercase: false,
        ),
        const SizedBox(height: 11),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          clipBehavior: Clip.none,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: children
                .map((w) => Padding(
                    padding: const EdgeInsets.only(right: 11), child: w))
                .toList(),
          ),
        ),
      ],
    );
  }

  Widget _buildCard(String title) {
    return SizedBox(
      width: 130,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const ArticleThumbnail(
              width: 130, height: 84, borderRadius: 13),
          const SizedBox(height: 8),
          Text(
            title,
            style: AppTextStyles.editorialHeadline.copyWith(
              fontSize: 13.5,
              height: 1.2,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyCard({double width = 46}) {
    return ArticleThumbnail(
        width: width, height: 84, borderRadius: 13, isEmpty: true);
  }
}
