import '/auth/views/stylesheet.dart';
import '/main.dart';
import '/providers/controllers/auth_controller_provider.dart';
import '/providers/controllers/error_message_controller_provider.dart';
import '/providers/controllers/signup_controller_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../localization/messages.i18n.dart';
import '../../providers/controllers/login_controller_provider.dart';
import '../../providers/states/login_state.dart';
import '../../providers/states/signup_state.dart';
import '../../shared/constants.dart';
import '../../shared/widgets.dart';

class SignInButton extends ConsumerWidget {
  String email;
  String password;
  bool autoLogin;
  GlobalKey<FormBuilderState> formKey;
  SignInButton({
    Key? key,
    required this.email,
    required this.password,
    required this.formKey,
    this.autoLogin = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loginState = ref.read(loginControllerProvider);
    Messages _locale = ref.watch(messagesProvider);
    return ElevatedButton(
      child: Text(_locale.button.cont),
      onPressed: () {
        if (formKey.currentState!.validate() &&
            (loginState is LoginStateInitial ||
                loginState is LoginStateError)) {
          // ref
          //     .read(loginControllerProvider.notifier)
          //     .login(email, password, autoLogin);
          ref.read(loginControllerProvider.notifier).debugLogin();
        }
      },
    );
  }
}

class SignInDebug extends ConsumerWidget {
  const SignInDebug({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Messages _locale = ref.watch(messagesProvider);
    return ElevatedButton(
        child: Text('Debug'),
        onPressed: () {
          ref.read(loginControllerProvider.notifier).debugLogin();
        });
  }
}

class SignUpButton extends ConsumerWidget {
  String email;
  String password;
  String passwordConfirmation;
  String name;
  String lastname;
  GlobalKey<FormBuilderState> formKey;
  SignUpButton({
    Key? key,
    required this.email,
    required this.password,
    required this.passwordConfirmation,
    required this.name,
    required this.lastname,
    required this.formKey,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final signUpState = ref.read(signUpControllerProvider);
    Messages _locale = ref.watch(messagesProvider);
    return ElevatedButton(
      child: Text(_locale.button.cont),
      onPressed: () {
        if (formKey.currentState!.validate() &&
            (signUpState is SignUpStateInitial ||
                signUpState is SignUpStateError)) {
          ref.read(signUpControllerProvider.notifier).signUp(
                email,
                password,
                passwordConfirmation,
                name,
                lastname,
              );
        }
      },
    );
  }
}

class AuthSwitchButton extends ConsumerWidget {
  int selectedIndex;

  AuthSwitchButton({
    Key? key,
    required this.selectedIndex,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Messages _locale = ref.watch(messagesProvider);
    return Row(
      children: [
        TextButton(
          child: Text(
            _locale.button.log_in,
            style: authChoiceTextStyle.copyWith(
              color: selectedIndex == 0 ? highlightedTextColor : null,
            ),
          ),
          onPressed: selectedIndex == 1
              ? () {
                  ref.read(authControllerProvider.notifier).showLogin();
                }
              : null,
        ),
        Text('/'),
        TextButton(
          child: Text(
            _locale.button.sign_up,
            style: authChoiceTextStyle.copyWith(
              color: selectedIndex == 1 ? highlightedTextColor : null,
            ),
          ),
          onPressed: selectedIndex == 0
              ? () {
                  ref.read(authControllerProvider.notifier).showSignUp();
                }
              : null,
        ),
      ],
    );
  }
}

class ErrorMessage extends ConsumerWidget {
  const ErrorMessage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ErrorMessageController errorMessageController =
        ref.watch(errorMessageControllerProvider);
    return Visibility(
      visible: errorMessageController.getError() != null,
      child: Row(
        children: [
          warningIcon,
          SizedBox(
            width: 10,
          ),
          Text(
            errorMessageController.getError() ?? '',
            style: warningTextStyle,
          ),
        ],
      ),
    );
  }
}
