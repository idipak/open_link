import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';
import '../../shared/widgets/article_thumbnail.dart';
import '../../shared/widgets/section_header.dart';

class LibraryScreen extends StatefulWidget {
  const LibraryScreen({super.key});

  @override
  State<LibraryScreen> createState() => _LibraryScreenState();
}

class _LibraryScreenState extends State<LibraryScreen> {
  final TextEditingController _searchController = TextEditingController();
  final FocusNode _searchFocusNode = FocusNode();
  String _searchQuery = '';

  // Sample category data for filtering
  static const _categories = [
    _CategoryData(
      title: 'Neuroscience',
      trailing: '8 saved',
      articles: ['The Deep Roots of Human Memory', 'Why we forget what we read'],
    ),
    _CategoryData(
      title: 'Economics',
      trailing: '5 saved',
      articles: [
        'How interest rates ripple out',
        'The quiet power of compounding',
      ],
    ),
    _CategoryData(
      title: 'Productivity',
      trailing: '6 saved',
      articles: [],
    ),
  ];

  @override
  void initState() {
    super.initState();
    _searchController.addListener(() {
      setState(() {
        _searchQuery = _searchController.text.trim().toLowerCase();
      });
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    _searchFocusNode.dispose();
    super.dispose();
  }

  /// Filter categories: show a category if its title or any article title
  /// matches the query. Within matched categories, only show matched articles.
  List<_CategoryData> get _filteredCategories {
    if (_searchQuery.isEmpty) return _categories;

    final results = <_CategoryData>[];
    for (final cat in _categories) {
      final titleMatch = cat.title.toLowerCase().contains(_searchQuery);
      final matchedArticles = cat.articles
          .where((a) => a.toLowerCase().contains(_searchQuery))
          .toList();

      if (titleMatch) {
        // Category title matches — show all its articles
        results.add(cat);
      } else if (matchedArticles.isNotEmpty) {
        // Only some articles match — show only those
        results.add(_CategoryData(
          title: cat.title,
          trailing: cat.trailing,
          articles: matchedArticles,
        ));
      }
    }
    return results;
  }

  @override
  Widget build(BuildContext context) {
    final categories = _filteredCategories;

    return Scaffold(
      body: SafeArea(
        child: GestureDetector(
          onTap: () => _searchFocusNode.unfocus(),
          behavior: HitTestBehavior.translucent,
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

                // Search Bar — real TextField
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 13, vertical: 2),
                  decoration: BoxDecoration(
                    color: AppColors.searchBarBg,
                    borderRadius: BorderRadius.circular(13),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.search,
                          color: AppColors.mutedText, size: 20),
                      const SizedBox(width: 8),
                      Expanded(
                        child: TextField(
                          controller: _searchController,
                          focusNode: _searchFocusNode,
                          style: AppTextStyles.sans.copyWith(
                            fontSize: 14,
                            color: AppColors.onSurface,
                          ),
                          decoration: InputDecoration(
                            hintText: 'Search title, tag or text...',
                            hintStyle: AppTextStyles.sans.copyWith(
                              fontSize: 14,
                              color: AppColors.mutedText,
                            ),
                            border: InputBorder.none,
                            isDense: true,
                            contentPadding:
                                const EdgeInsets.symmetric(vertical: 10),
                          ),
                          textInputAction: TextInputAction.search,
                        ),
                      ),
                      if (_searchQuery.isNotEmpty)
                        GestureDetector(
                          onTap: () {
                            _searchController.clear();
                            _searchFocusNode.unfocus();
                          },
                          child: const Icon(Icons.close_rounded,
                              color: AppColors.mutedText, size: 18),
                        ),
                    ],
                  ),
                ),

                const SizedBox(height: 20),

                // Filtered category rows
                if (categories.isEmpty)
                  Padding(
                    padding: const EdgeInsets.only(top: 40),
                    child: Center(
                      child: Text(
                        'No results for "$_searchQuery"',
                        style: AppTextStyles.sans.copyWith(
                          fontSize: 14,
                          color: AppColors.mutedText,
                        ),
                      ),
                    ),
                  )
                else
                  ...List.generate(categories.length, (i) {
                    final cat = categories[i];
                    final cards = <Widget>[
                      ...cat.articles.map((a) => _buildCard(a)),
                      _buildEmptyCard(),
                    ];
                    return Padding(
                      padding: EdgeInsets.only(
                          bottom: i < categories.length - 1 ? 20 : 0),
                      child: _buildCategoryRow(
                          cat.title, cat.trailing, cards),
                    );
                  }),
              ],
            ),
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

class _CategoryData {
  final String title;
  final String trailing;
  final List<String> articles;

  const _CategoryData({
    required this.title,
    required this.trailing,
    required this.articles,
  });
}
