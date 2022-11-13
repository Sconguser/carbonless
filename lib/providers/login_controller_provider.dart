import 'package:carbonless/auth/auth_repository.dart';
import 'package:carbonless/providers/states/login_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoginController extends StateNotifier<LoginState> {
  LoginController(this.ref) : super(const LoginStateInitial());

  final Ref ref;

  void login(String email, String password) async {
    state = const LoginStateLoading();
    try {
      await ref.read(authRepositoryProvider).login(email, password);
    } catch (e) {
      print(e);
      state = LoginStateError(e.toString());
      return;
    }
    state = const LoginStateSuccess();
  }
}

final loginControllerProvider =
    StateNotifierProvider<LoginController, LoginState>((ref) {
  return LoginController(ref);
});
