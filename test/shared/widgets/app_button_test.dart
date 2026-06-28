import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:open_link/shared/widgets/app_button.dart';
import 'package:open_link/core/theme/app_colors.dart';

void main() {
  group('AppButton', () {
    testWidgets('renders correctly with primary variant', (tester) async {
      bool pressed = false;
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: AppButton(
              text: 'Primary Button',
              onPressed: () => pressed = true,
              variant: AppButtonVariant.primary,
            ),
          ),
        ),
      );

      final materialFinder = find.descendant(
        of: find.byType(AppButton),
        matching: find.byType(Material),
      );

      final material = tester.widget<Material>(materialFinder);
      expect(material.color, AppColors.accent);

      await tester.tap(find.byType(AppButton));
      expect(pressed, true);
    });

    testWidgets('renders outline variant with correct border', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: AppButton(
              text: 'Outline Button',
              onPressed: () {},
              variant: AppButtonVariant.outline,
            ),
          ),
        ),
      );

      final materialFinder = find.descendant(
        of: find.byType(AppButton),
        matching: find.byType(Material),
      );

      final material = tester.widget<Material>(materialFinder);
      expect(material.color, Colors.transparent);
      final shape = material.shape as RoundedRectangleBorder;
      expect(shape.side.color, AppColors.border);
    });
  });
}
