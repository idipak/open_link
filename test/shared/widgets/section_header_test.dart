import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:open_link/shared/widgets/section_header.dart';

void main() {
  group('SectionHeader', () {
    testWidgets('displays title and trailing text', (tester) async {
      bool trailingTapped = false;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SectionHeader(
              title: 'My Title',
              trailingText: 'See All',
              onTrailingTap: () => trailingTapped = true,
              uppercase: false,
            ),
          ),
        ),
      );

      expect(find.text('My Title'), findsOneWidget);
      expect(find.text('See All'), findsOneWidget);

      await tester.tap(find.text('See All'));
      expect(trailingTapped, true);
    });

    testWidgets('displays uppercase title when specified', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: SectionHeader(
              title: 'My Title',
              uppercase: true,
            ),
          ),
        ),
      );

      expect(find.text('MY TITLE'), findsOneWidget);
    });
  });
}
