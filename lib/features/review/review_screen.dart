import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';
import '../../shared/widgets/progress_bar.dart';
import 'bloc/review_cubit.dart';
import 'bloc/review_state.dart';

class ReviewScreen extends StatefulWidget {
  const ReviewScreen({super.key});

  @override
  State<ReviewScreen> createState() => _ReviewScreenState();
}

class _ReviewScreenState extends State<ReviewScreen> {
  @override
  void initState() {
    super.initState();
    // Load demo cards if session hasn't started
    final cubit = context.read<ReviewCubit>();
    if (cubit.state.cards.isEmpty) {
      cubit.loadCards(const [
        ReviewCard(
          question: 'Why does spaced review beat cramming?',
          answer:
              'Each spaced recall forces your brain to rebuild the memory trace — strengthening long-term retention far more than massed repetition does.',
          source: 'Human Memory',
        ),
        ReviewCard(
          question: 'What happens to a memory each time you recall it?',
          answer:
              'The memory is reconstructed and slightly rewritten, not simply played back like a recording.',
          source: 'Human Memory',
        ),
        ReviewCard(
          question: 'How does sleep affect memory formation?',
          answer:
              'Sleep consolidates the day\'s encoding, transferring short-term memories into long-term storage.',
          source: 'Human Memory',
        ),
        ReviewCard(
          question: 'When central banks raise rates, borrowing costs generally…',
          answer: 'Rise across the economy.',
          source: 'Economics',
        ),
        ReviewCard(
          question: 'Why is compounding considered powerful?',
          answer:
              'Small, consistent returns accumulate exponentially over time, making early investing far more impactful.',
          source: 'Economics',
        ),
      ]);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ReviewCubit, ReviewState>(
      listener: (context, state) {
        if (state.sessionComplete) {
          context.push('/session-complete');
        }
      },
      child: BlocBuilder<ReviewCubit, ReviewState>(
        builder: (context, state) {
          final card = state.currentCard;
          if (card == null) {
            return const Scaffold(
              body: Center(child: Text('No cards to review')),
            );
          }

          return Scaffold(
            backgroundColor: AppColors.background,
            body: SafeArea(
              child: Column(
                children: [
                  // Top Bar
                  Padding(
                    padding: const EdgeInsets.fromLTRB(22, 6, 22, 16),
                    child: Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            context.read<ReviewCubit>().resetSession();
                          },
                          child: const Icon(Icons.close,
                              color: AppColors.inactiveTab),
                        ),
                        const SizedBox(width: 13),
                        Expanded(
                          child: AppProgressBar(
                              progress: state.progress, height: 6),
                        ),
                        const SizedBox(width: 13),
                        Text(
                          '${state.currentIndex + 1}/${state.totalCards}',
                          style: AppTextStyles.sans.copyWith(
                            fontSize: 13,
                            color: AppColors.mutedText,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Flashcard
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 22),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Source badge
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 11, vertical: 5),
                            decoration: BoxDecoration(
                              color: AppColors.searchBarBg,
                              borderRadius: BorderRadius.circular(999),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Icon(Icons.menu_book,
                                    color: AppColors.subtleText, size: 12),
                                const SizedBox(width: 6),
                                Text(
                                  card.source,
                                  style: AppTextStyles.sans.copyWith(
                                    fontSize: 11.5,
                                    color: AppColors.secondaryText,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 16),

                          // Card Content
                          Expanded(
                            child: Container(
                              width: double.infinity,
                              padding: const EdgeInsets.all(24),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(color: AppColors.border),
                                borderRadius: BorderRadius.circular(22),
                                boxShadow: [
                                  BoxShadow(
                                    color: AppColors.onSurface
                                        .withValues(alpha: 0.07),
                                    blurRadius: 30,
                                    offset: const Offset(0, 8),
                                  ),
                                ],
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'QUESTION',
                                    style: AppTextStyles.sans.copyWith(
                                      fontSize: 11,
                                      fontWeight: FontWeight.w700,
                                      color: AppColors.mutedText,
                                      letterSpacing: 0.1,
                                    ),
                                  ),
                                  const SizedBox(height: 12),
                                  Text(
                                    card.question,
                                    style: AppTextStyles.editorialHeadline
                                        .copyWith(
                                      fontSize: 25,
                                      height: 1.18,
                                    ),
                                  ),
                                  const Spacer(),
                                  if (state.answerRevealed) ...[
                                    const Divider(color: AppColors.divider),
                                    const SizedBox(height: 18),
                                    Text(
                                      'ANSWER',
                                      style: AppTextStyles.sans.copyWith(
                                        fontSize: 11,
                                        fontWeight: FontWeight.w700,
                                        color: AppColors.accent,
                                        letterSpacing: 0.1,
                                      ),
                                    ),
                                    const SizedBox(height: 9),
                                    Flexible(
                                      child: SingleChildScrollView(
                                        child: Text(
                                          card.answer,
                                          style: AppTextStyles.sans.copyWith(
                                            fontSize: 15,
                                            height: 1.42,
                                            color: AppColors.bodyText,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ] else
                                    Center(
                                      child: GestureDetector(
                                        onTap: () => context
                                            .read<ReviewCubit>()
                                            .revealAnswer(),
                                        child: Text(
                                          'Tap to reveal answer',
                                          style: AppTextStyles.sans.copyWith(
                                            fontSize: 14,
                                            color: AppColors.accent,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  // Grading Buttons (visible only when answer is revealed)
                  if (state.answerRevealed)
                    Padding(
                      padding: const EdgeInsets.fromLTRB(22, 16, 22, 26),
                      child: Row(
                        children: [
                          _gradeButton('Again', AppColors.error, false,
                              ReviewGrade.again),
                          const SizedBox(width: 8),
                          _gradeButton('Hard', AppColors.secondaryText, false,
                              ReviewGrade.hard),
                          const SizedBox(width: 8),
                          _gradeButton('Good', AppColors.success, false,
                              ReviewGrade.good),
                          const SizedBox(width: 8),
                          _gradeButton('Easy', AppColors.success, true,
                              ReviewGrade.easy),
                        ],
                      ),
                    )
                  else
                    const SizedBox(height: 74),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _gradeButton(
      String text, Color color, bool filled, ReviewGrade grade) {
    return Expanded(
      child: GestureDetector(
        onTap: () => context.read<ReviewCubit>().gradeCard(grade),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            color: filled ? color : Colors.transparent,
            border: filled ? null : Border.all(color: AppColors.border),
            borderRadius: BorderRadius.circular(13),
          ),
          alignment: Alignment.center,
          child: Text(
            text,
            style: AppTextStyles.sans.copyWith(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: filled ? Colors.white : color,
            ),
          ),
        ),
      ),
    );
  }
}
