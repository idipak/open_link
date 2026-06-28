import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:open_link/features/auth/bloc/auth_bloc.dart';
import 'package:open_link/features/auth/bloc/auth_event.dart';
import 'package:open_link/features/auth/bloc/auth_state.dart';

void main() {
  group('AuthBloc', () {
    late AuthBloc authBloc;

    setUp(() {
      authBloc = AuthBloc();
    });

    tearDown(() {
      authBloc.close();
    });

    test('initial state is AuthState()', () {
      expect(authBloc.state, const AuthState());
    });

    blocTest<AuthBloc, AuthState>(
      'emits [loading, success] on valid LoginSubmitted',
      build: () => authBloc,
      act: (bloc) => bloc.add(const LoginSubmitted(email: 'test@example.com', password: 'password123')),
      wait: const Duration(milliseconds: 600),
      expect: () => [
        const AuthState(status: AuthStatus.loading),
        const AuthState(status: AuthStatus.success),
      ],
    );

    blocTest<AuthBloc, AuthState>(
      'emits [failure] on empty email or password',
      build: () => authBloc,
      act: (bloc) => bloc.add(const LoginSubmitted(email: '', password: '')),
      expect: () => [
        const AuthState(
          status: AuthStatus.failure,
          errorMessage: 'Email and password are required',
        ),
      ],
    );
  });
}
