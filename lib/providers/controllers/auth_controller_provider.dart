import 'package:carbonless/providers/states/auth_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AuthController extends StateNotifier<AuthState> {
  AuthController(this.ref) : super(const AuthStateChoice());

  final Ref ref;

  void showSignUp() {
    state = AuthStateSignup();
  }

  void showLogin() {
    state = AuthStateLogin();
  }

  void showChoice() {
    state = AuthStateChoice();
  }

  void showApp() {
    state = AuthStateSuccess();
  }
}

final authControllerProvider =
    StateNotifierProvider<AuthController, AuthState>((ref) {
  return AuthController(ref);
});
