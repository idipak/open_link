import 'package:flutter_bloc/flutter_bloc.dart';
import 'review_state.dart';

class ReviewCubit extends Cubit<ReviewState> {
  ReviewCubit() : super(const ReviewState());

  void loadCards(List<ReviewCard> cards) {
    emit(ReviewState(cards: cards));
  }

  void revealAnswer() {
    emit(state.copyWith(answerRevealed: true));
  }

  void gradeCard(ReviewGrade grade) {
    final isCorrect =
        grade == ReviewGrade.good || grade == ReviewGrade.easy;
    final newCorrectCount =
        isCorrect ? state.correctCount + 1 : state.correctCount;

    final nextIndex = state.currentIndex + 1;
    if (nextIndex >= state.totalCards) {
      emit(state.copyWith(
        sessionComplete: true,
        correctCount: newCorrectCount,
      ));
    } else {
      emit(state.copyWith(
        currentIndex: nextIndex,
        answerRevealed: false,
        correctCount: newCorrectCount,
      ));
    }
  }

  void resetSession() {
    emit(const ReviewState());
  }
}
