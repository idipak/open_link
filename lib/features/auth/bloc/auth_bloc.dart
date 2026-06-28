import 'package:flutter_bloc/flutter_bloc.dart';
import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(const AuthState()) {
    on<LoginSubmitted>(_onLoginSubmitted);
    on<GoogleSignInRequested>(_onGoogleSignIn);
  }

  Future<void> _onLoginSubmitted(
    LoginSubmitted event,
    Emitter<AuthState> emit,
  ) async {
    if (event.email.isEmpty || event.password.isEmpty) {
      emit(state.copyWith(
        status: AuthStatus.failure,
        errorMessage: 'Email and password are required',
      ));
      return;
    }

    emit(state.copyWith(status: AuthStatus.loading));

    // Simulate network delay for demo purposes.
    // In production, this would call an auth repository.
    await Future<void>.delayed(const Duration(milliseconds: 500));

    emit(state.copyWith(status: AuthStatus.success));
  }

  Future<void> _onGoogleSignIn(
    GoogleSignInRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(state.copyWith(status: AuthStatus.loading));

    await Future<void>.delayed(const Duration(milliseconds: 500));

    emit(state.copyWith(status: AuthStatus.success));
  }
}
