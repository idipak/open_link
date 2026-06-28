import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:open_link/features/auth/sign_in_screen.dart';
import 'package:open_link/features/auth/bloc/auth_bloc.dart';

void main() {
  group('SignInScreen', () {
    testWidgets('renders login button and text fields', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: BlocProvider(
            create: (_) => AuthBloc(),
            child: const SignInScreen(),
          ),
        ),
      );

      expect(find.text('Email address'), findsOneWidget);
      expect(find.text('Password'), findsOneWidget);
      expect(find.text('Log in'), findsOneWidget);
    });
  });
}
