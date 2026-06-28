import 'package:equatable/equatable.dart';

class ReviewCard extends Equatable {
  final String question;
  final String answer;
  final String source;

  const ReviewCard({
    required this.question,
    required this.answer,
    required this.source,
  });

  @override
  List<Object?> get props => [question, answer, source];
}

enum ReviewGrade { again, hard, good, easy }

class ReviewState extends Equatable {
  final List<ReviewCard> cards;
  final int currentIndex;
  final bool answerRevealed;
  final bool sessionComplete;
  final int correctCount;

  const ReviewState({
    this.cards = const [],
    this.currentIndex = 0,
    this.answerRevealed = false,
    this.sessionComplete = false,
    this.correctCount = 0,
  });

  int get totalCards => cards.length;
  double get progress =>
      totalCards == 0 ? 0 : (currentIndex + 1) / totalCards;
  ReviewCard? get currentCard =>
      cards.isEmpty ? null : cards[currentIndex];

  ReviewState copyWith({
    List<ReviewCard>? cards,
    int? currentIndex,
    bool? answerRevealed,
    bool? sessionComplete,
    int? correctCount,
  }) {
    return ReviewState(
      cards: cards ?? this.cards,
      currentIndex: currentIndex ?? this.currentIndex,
      answerRevealed: answerRevealed ?? this.answerRevealed,
      sessionComplete: sessionComplete ?? this.sessionComplete,
      correctCount: correctCount ?? this.correctCount,
    );
  }

  @override
  List<Object?> get props => [
        cards,
        currentIndex,
        answerRevealed,
        sessionComplete,
        correctCount,
      ];
}
