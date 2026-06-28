import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:open_link/shared/widgets/streak_badge.dart';
import 'package:open_link/core/theme/app_colors.dart';

void main() {
  group('StreakBadge', () {
    testWidgets('displays the correct streak count', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: StreakBadge(streakCount: 42),
          ),
        ),
      );

      expect(find.text('42'), findsOneWidget);
      expect(find.byIcon(Icons.local_fire_department_rounded), findsOneWidget);
    });

    testWidgets('renders correct colors when filled', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: StreakBadge(streakCount: 5, filled: true),
          ),
        ),
      );

      final containerFinder = find.byType(Container);
      final container = tester.widget<Container>(containerFinder);
      final decoration = container.decoration as BoxDecoration;
      
      expect(decoration.color, AppColors.accent);
    });
  });
}
