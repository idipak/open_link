import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:open_link/shared/widgets/progress_bar.dart';

void main() {
  group('AppProgressBar', () {
    testWidgets('clamps progress to 0 and 1', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: AppProgressBar(progress: 1.5), // Should clamp to 1.0
          ),
        ),
      );

      final fractionallySizedBoxFinder = find.byType(FractionallySizedBox);
      final fractionallySizedBox = tester.widget<FractionallySizedBox>(fractionallySizedBoxFinder);
      
      expect(fractionallySizedBox.widthFactor, 1.0);
    });
  });
}
