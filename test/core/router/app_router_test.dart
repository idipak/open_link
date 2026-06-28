import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:open_link/core/router/app_router.dart';
import 'package:open_link/features/auth/sign_in_screen.dart';
import 'package:open_link/features/auth/bloc/auth_bloc.dart';

void main() {
  group('AppRouter', () {
    testWidgets('initial route displays SignInScreen', (tester) async {
      await tester.pumpWidget(
        BlocProvider(
          create: (_) => AuthBloc(),
          child: MaterialApp.router(
            routerConfig: AppRouter.router,
          ),
        ),
      );
      
      // Wait for GoRouter to settle
      await tester.pumpAndSettle();

      expect(find.byType(SignInScreen), findsOneWidget);
    });
  });
}
