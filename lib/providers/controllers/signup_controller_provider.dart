import 'package:carbonless/providers/controllers/auth_controller_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../states/signup_state.dart';

class SignUpController extends StateNotifier<SignUpState> {
  final Ref ref;

  SignUpController(this.ref) : super(const SignUpStateInitial());

  void signUp(String email, String password, String passwordConfirmation,
      String name, String lastname) async {
    state = const SignUpStateLoading();
    await Future.delayed(Duration(seconds: 5));
    showChoice();
  }

  void showChoice() {
    ref.read(authControllerProvider.notifier).showChoice();
  }
}

final signUpControllerProvider =
    StateNotifierProvider<SignUpController, SignUpState>((ref) {
  return SignUpController(ref);
});
