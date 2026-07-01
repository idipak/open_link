import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';
import '../../shared/widgets/streak_badge.dart';
import '../../shared/widgets/section_header.dart';
import '../../shared/widgets/article_thumbnail.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _linkController = TextEditingController();
  final FocusNode _linkFocusNode = FocusNode();
  String? _clipboardUrl;

  @override
  void initState() {
    super.initState();
    _readClipboard();
  }

  @override
  void dispose() {
    _linkController.dispose();
    _linkFocusNode.dispose();
    super.dispose();
  }

  Future<void> _readClipboard() async {
    try {
      final data = await Clipboard.getData(Clipboard.kTextPlain);
      if (data != null && data.text != null && data.text!.isNotEmpty) {
        final text = data.text!.trim();
        // Simple check: if it looks like a URL, show it
        if (text.startsWith('http://') ||
            text.startsWith('https://') ||
            text.contains('.') && !text.contains(' ')) {
          setState(() {
            _clipboardUrl = text;
          });
        }
      }
    } catch (_) {
      // Clipboard not available – ignore
    }
  }

  void _saveLink() {
    final link = _linkController.text.trim();
    if (link.isEmpty) return;

    // TODO: Implement actual save logic
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Link saved: $link'),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
    _linkController.clear();
    _linkFocusNode.unfocus();
  }

  void _useClipboardUrl() {
    if (_clipboardUrl != null) {
      _linkController.text = _clipboardUrl!;
      _linkController.selection = TextSelection.fromPosition(
        TextPosition(offset: _linkController.text.length),
      );
      _linkFocusNode.requestFocus();
    }
  }

  /// Display-friendly version of the clipboard URL
  String get _clipboardDisplayUrl {
    if (_clipboardUrl == null) return '';
    var url = _clipboardUrl!;
    url = url.replaceFirst(RegExp(r'^https?://'), '');
    url = url.replaceFirst(RegExp(r'^www\.'), '');
    if (url.length > 32) url = '${url.substring(0, 32)}…';
    return url;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: GestureDetector(
          onTap: () => _linkFocusNode.unfocus(),
          behavior: HitTestBehavior.translucent,
          child: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(22, 6, 22, 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Header
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Saturday, Jun 28',
                          style: AppTextStyles.sans.copyWith(
                            fontSize: 13,
                            color: AppColors.mutedText,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(
                          'Today',
                          style:
                              AppTextStyles.editorialHeadline.copyWith(fontSize: 30),
                        ),
                      ],
                    ),
                    const StreakBadge(streakCount: 7),
                  ],
                ),
                const SizedBox(height: 18),

                // Input Bar — real TextField
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                  decoration: BoxDecoration(
                    border: Border.all(color: AppColors.onSurface, width: 1.5),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.link_rounded,
                          color: AppColors.mutedText, size: 20),
                      const SizedBox(width: 8),
                      Expanded(
                        child: TextField(
                          controller: _linkController,
                          focusNode: _linkFocusNode,
                          style: AppTextStyles.sans.copyWith(
                            fontSize: 14.5,
                            color: AppColors.onSurface,
                          ),
                          decoration: InputDecoration(
                            hintText: 'Paste a link to save...',
                            hintStyle: AppTextStyles.sans.copyWith(
                              fontSize: 14.5,
                              color: AppColors.inputHint,
                            ),
                            border: InputBorder.none,
                            isDense: true,
                            contentPadding:
                                const EdgeInsets.symmetric(vertical: 8),
                          ),
                          keyboardType: TextInputType.url,
                          textInputAction: TextInputAction.done,
                          onSubmitted: (_) => _saveLink(),
                        ),
                      ),
                      GestureDetector(
                        onTap: _saveLink,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 18, vertical: 9),
                          decoration: BoxDecoration(
                            color: AppColors.accent,
                            borderRadius: BorderRadius.circular(11),
                          ),
                          child: Text(
                            'Save',
                            style: AppTextStyles.sans.copyWith(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                // Clipboard Suggestion — tappable, reads real clipboard
                if (_clipboardUrl != null) ...[
                  const SizedBox(height: 9),
                  GestureDetector(
                    onTap: _useClipboardUrl,
                    child: Container(
                      padding:
                          const EdgeInsets.symmetric(horizontal: 12, vertical: 9),
                      decoration: BoxDecoration(
                        color: AppColors.accentSurface,
                        borderRadius: BorderRadius.circular(11),
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.content_paste_rounded,
                              color: AppColors.accent, size: 16),
                          const SizedBox(width: 8),
                          Expanded(
                            child: RichText(
                              text: TextSpan(
                                style: AppTextStyles.sans.copyWith(
                                  fontSize: 13,
                                  color: AppColors.accentDark,
                                ),
                                children: [
                                  const TextSpan(text: 'From clipboard · '),
                                  TextSpan(
                                    text: _clipboardDisplayUrl,
                                    style: AppTextStyles.editorialHeadline.copyWith(
                                      fontSize: 13,
                                      color: AppColors.accentDark,
                                    ),
                                  ),
                                ],
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          const Icon(Icons.chevron_right_rounded,
                              color: AppColors.accent, size: 18),
                        ],
                      ),
                    ),
                  ),
                ],

                // Due for Review Card
                const SizedBox(height: 16),
                Container(
                  padding: const EdgeInsets.all(17),
                  decoration: BoxDecoration(
                    color: AppColors.darkCard,
                    borderRadius: BorderRadius.circular(18),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Due for review',
                            style: AppTextStyles.sans.copyWith(
                              fontSize: 13,
                              color: AppColors.darkCardText,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Text(
                            '~2 min',
                            style: AppTextStyles.sans.copyWith(
                              fontSize: 13,
                              color: AppColors.darkCardAccent,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '5 cards ready',
                        style: AppTextStyles.editorialHeadline.copyWith(
                          fontSize: 25,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 13),
                      Row(
                        children: List.generate(5, (i) {
                          return Expanded(
                            child: Padding(
                              padding: EdgeInsets.only(left: i == 0 ? 0 : 5),
                              child: Container(
                                height: 5,
                                decoration: BoxDecoration(
                                  color: i < 2
                                      ? AppColors.accent
                                      : AppColors.darkCardMuted,
                                  borderRadius: BorderRadius.circular(3),
                                ),
                              ),
                            ),
                          );
                        }),
                      ),
                      const SizedBox(height: 14),
                      GestureDetector(
                        onTap: () => context.push('/review'),
                        child: Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: AppColors.accent,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            'Start review',
                            style: AppTextStyles.sans.copyWith(
                              color: Colors.white,
                              fontSize: 14.5,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                // Recently Saved
                const SizedBox(height: 18),
                const SectionHeader(title: 'Recently saved'),
                const SizedBox(height: 12),

                _ArticleListItem(
                  title: 'The Deep Roots of Human Memory',
                  onTap: () => context.push('/article/1'),
                  meta: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 9, vertical: 3),
                    decoration: BoxDecoration(
                      color: AppColors.accentSurface,
                      borderRadius: BorderRadius.circular(999),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.auto_awesome,
                            color: AppColors.accent, size: 12),
                        const SizedBox(width: 4),
                        Text(
                          'AI summarizing...',
                          style: AppTextStyles.sans.copyWith(
                            fontSize: 11,
                            color: AppColors.accent,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 14),
                _ArticleListItem(
                  title: 'How interest rates ripple out',
                  onTap: () => context.push('/article/2'),
                  meta: Text(
                    'Economics · 6 min',
                    style: AppTextStyles.sans.copyWith(
                      fontSize: 12,
                      color: AppColors.mutedText,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _ArticleListItem extends StatelessWidget {
  final String title;
  final Widget meta;
  final VoidCallback? onTap;

  const _ArticleListItem({
    required this.title,
    required this.meta,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const ArticleThumbnail(width: 46, height: 46, borderRadius: 11),
          const SizedBox(width: 11),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: AppTextStyles.editorialHeadline.copyWith(
                    fontSize: 15.5,
                    fontWeight: FontWeight.w500,
                    height: 1.15,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 6),
                meta,
              ],
            ),
          ),
        ],
      ),
    );
  }
}
