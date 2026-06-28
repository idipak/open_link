import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:open_link/features/review/bloc/review_cubit.dart';
import 'package:open_link/features/review/bloc/review_state.dart';

void main() {
  group('ReviewCubit', () {
    late ReviewCubit reviewCubit;

    final testCards = [
      const ReviewCard(question: 'Q1', answer: 'A1', source: 'S1'),
      const ReviewCard(question: 'Q2', answer: 'A2', source: 'S2'),
    ];

    setUp(() {
      reviewCubit = ReviewCubit();
    });

    tearDown(() {
      reviewCubit.close();
    });

    test('initial state is empty', () {
      expect(reviewCubit.state, const ReviewState());
    });

    blocTest<ReviewCubit, ReviewState>(
      'loadCards updates cards',
      build: () => reviewCubit,
      act: (cubit) => cubit.loadCards(testCards),
      expect: () => [
        ReviewState(cards: testCards),
      ],
    );

    blocTest<ReviewCubit, ReviewState>(
      'revealAnswer sets answerRevealed to true',
      build: () => reviewCubit,
      act: (cubit) {
        cubit.loadCards(testCards);
        cubit.revealAnswer();
      },
      expect: () => [
        ReviewState(cards: testCards),
        ReviewState(cards: testCards, answerRevealed: true),
      ],
    );

    blocTest<ReviewCubit, ReviewState>(
      'gradeCard advances index and increments correctCount for good grade',
      build: () => reviewCubit,
      act: (cubit) {
        cubit.loadCards(testCards);
        cubit.revealAnswer();
        cubit.gradeCard(ReviewGrade.good);
      },
      expect: () => [
        ReviewState(cards: testCards),
        ReviewState(cards: testCards, answerRevealed: true),
        ReviewState(
          cards: testCards,
          currentIndex: 1,
          answerRevealed: false,
          correctCount: 1,
        ),
      ],
    );

    blocTest<ReviewCubit, ReviewState>(
      'gradeCard completes session on last card',
      build: () => reviewCubit,
      seed: () => ReviewState(cards: testCards, currentIndex: 1),
      act: (cubit) => cubit.gradeCard(ReviewGrade.hard),
      expect: () => [
        ReviewState(
          cards: testCards,
          currentIndex: 1,
          sessionComplete: true,
          correctCount: 0,
        ),
      ],
    );
  });
}
