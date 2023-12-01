import '/auth/auth_repository.dart';
import '/main.dart';
import '/providers/controllers/auth_controller_provider.dart';
import '/providers/controllers/error_message_controller_provider.dart';
import '/providers/controllers/local_storage/secure_storage.dart';
import '/providers/states/login_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../localization/messages.i18n.dart';

class LoginController extends StateNotifier<LoginState> {
  LoginController(this.ref) : super(const LoginStateInitial()) {
    autoLogin();
  }

  final Ref ref;

  void login(String email, String password, bool autoLogin) async {
    state = const LoginStateLoading();
    Messages _locale = ref.watch(messagesProvider);
    String? bearerToken;
    try {
      bearerToken =
          await ref.read(authRepositoryProvider).login(email, password);
    } catch (e) {
      state = LoginStateError(e.toString());
      ref
          .read(errorMessageControllerProvider)
          .setError(_locale.authErrors.invalid_credentials);
      return;
    }
    if (autoLogin && bearerToken != null) {
      await ref
          .read(secureStorageProvider)
          .write(KEYS.business_bearerToken.name, bearerToken);

      ///todo:autologin
      /// save to local storage  -- done
      /// attempt auto login if local storage has info
      /// after logout clear autologin <<- wazne
    }
    state = const LoginStateSuccess();
    showApp();
  }

  void autoLogin() async {
    state = const AutoLoginState();
    Messages _locale = ref.watch(messagesProvider);
    String? bearerToken = await ref
        .read(secureStorageProvider)
        .read(KEYS.business_bearerToken.name);
    if (bearerToken == null) {
      reset();
      return;
    }
    try {
      bearerToken =
          await ref.read(authRepositoryProvider).autoLogin(bearerToken);
    } catch (e) {
      state = LoginStateError(e.toString());
      ref
          .read(errorMessageControllerProvider)
          .setError(_locale.authErrors.invalid_credentials);
      return;
    }
    state = const LoginStateSuccess();
    showApp();
  }

  void debugLogin() async {
    state = const LoginStateLoading();
    await ref.read(authRepositoryProvider).debugLogin();
    state = const LoginStateSuccess();
    showApp();
  }

  void showChoice() {
    ref.read(authControllerProvider.notifier).showChoice();
  }

  void showApp() {
    ref.read(authControllerProvider.notifier).showApp();
  }

  void reset() {
    state = LoginStateInitial();
  }
}

final loginControllerProvider =
    StateNotifierProvider<LoginController, LoginState>((ref) {
  return LoginController(ref);
});
