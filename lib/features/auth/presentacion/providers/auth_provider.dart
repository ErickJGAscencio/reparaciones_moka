import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reparaciones_moka/core/auth/user_session.dart';
import 'package:reparaciones_moka/features/auth/presentacion/providers/auth_dependencies.dart';

class AuthState {
  final UserSession? session;
  final bool isLoading;
  final String? error;

  const AuthState({this.session, this.isLoading = false, this.error});

  AuthState copyWith({UserSession? session, bool? isLoading, String? error}) {
    return AuthState(
      session: session ?? this.session,
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }
}

class AuthNotifier extends Notifier<AuthState> {
  @override
  AuthState build() {
    return const AuthState();
  }

  Future<void> login({
    required String username,
    required String password,
  }) async {
    try {
      state = state.copyWith(isLoading: true, error: null);

      final loginUseCase = ref.read(loginUseCaseProvider);

      final session = await loginUseCase.execute(username, password);

      state = state.copyWith(session: session, isLoading: false);
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: e.toString()
      );
    } 
  }
}

final authProvider = NotifierProvider<AuthNotifier, AuthState>(
  AuthNotifier.new,
);
