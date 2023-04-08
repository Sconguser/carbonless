import 'package:carbonless/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../localization/messages.i18n.dart';
import '../../providers/controllers/login_controller_provider.dart';
import '../../providers/states/login_state.dart';

class SignInButton extends ConsumerWidget {
  String email;
  String password;

  SignInButton({
    Key? key,
    required this.email,
    required this.password,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loginState = ref.read(loginControllerProvider);
    Messages _locale = ref.watch(messagesProvider);
    return ElevatedButton(
      child: Text(_locale.button.cont),
      onPressed: () {
        if (loginState is LoginStateInitial || loginState is LoginStateError) {
          ref.read(loginControllerProvider.notifier).login(email, password);
        }
      },
    );
  }
}
