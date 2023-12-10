import '/providers/controllers/qr_generator_controller_provider.dart';

import '/providers/controllers/app_navigation_controller_provider.dart';
import '/providers/controllers/error_message_controller_provider.dart';
import '/providers/controllers/local_storage/secure_storage.dart';
import '/providers/controllers/prize_list/prize_controller_provider.dart';
import '/providers/controllers/qr_scanner_controller_provider.dart';
import '/providers/controllers/signup_controller_provider.dart';
import '/providers/states/auth_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'login_controller_provider.dart';

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
    initializeMain();
  }

  void initializeMain() {
    ref.read(qrGeneratorControllerProvider.notifier).initialize();
    // ref.read(prizesProvider.notifier).initialize();
  }

  void logout() {
    state = AuthStateChoice();
    ref.read(secureStorageProvider).delete(KEYS.business_bearerToken.name);
    ref.read(appNavigationControllerProvider.notifier).reset();
    ref.read(errorMessageControllerProvider.notifier).reset();
    ref.read(loginControllerProvider.notifier).reset();
    ref.read(qrScannerControllerProvider.notifier).reset();
    ref.read(signUpControllerProvider.notifier).reset();
  }
}

final authControllerProvider =
    StateNotifierProvider<AuthController, AuthState>((ref) {
  return AuthController(ref);
});
