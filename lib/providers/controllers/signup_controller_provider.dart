import 'package:carbonless/localization/messages.i18n.dart';
import 'package:carbonless/main.dart';
import 'package:carbonless/providers/controllers/auth_controller_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../auth/auth_repository.dart';
import '../states/signup_state.dart';
import 'error_message_controller_provider.dart';

class SignUpController extends StateNotifier<SignUpState> {
  final Ref ref;

  SignUpController(this.ref) : super(const SignUpStateInitial());

  void signUp(String email, String password, String passwordConfirmation,
      String name, String lastname) async {
    state = const SignUpStateLoading();
    Messages _locale = ref.watch(messagesProvider);
    try {
      await ref
          .read(authRepositoryProvider)
          .signup(email, password, passwordConfirmation, name, lastname);
    } catch (e) {
      state = SignUpStateError(error: e.toString());
      ref
          .read(errorMessageControllerProvider)
          .setError(_locale.authErrors.invalid_credentials);
      return;
    }
    state = const SignUpStateSuccess();
    showApp();
  }

  void showChoice() {
    ref.read(authControllerProvider.notifier).showChoice();
  }

  void showApp() {
    ref.read(authControllerProvider.notifier).showApp();
  }

  void reset() {
    state = SignUpStateInitial();
  }
}

final signUpControllerProvider =
    StateNotifierProvider<SignUpController, SignUpState>((ref) {
  return SignUpController(ref);
});
