import '/auth/views/stylesheet.dart';
import '/providers/controllers/login_controller_provider.dart';
import '/views/loading_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../localization/messages.i18n.dart';
import '../../main.dart';
import '../../providers/controllers/auth_controller_provider.dart';
import '../../providers/states/login_state.dart';
import '../../shared/widgets.dart';

class AuthChoice extends ConsumerStatefulWidget {
  const AuthChoice({Key? key}) : super(key: key);

  @override
  ConsumerState<AuthChoice> createState() => _AuthChoiceState();
}

class _AuthChoiceState extends ConsumerState<AuthChoice>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    Messages _locale = ref.watch(messagesProvider);
    LoginState loginState = ref.watch(loginControllerProvider);
    return loginState == const AutoLoginState()
        ? const LoadingView()
        : Scaffold(
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  LogoText(),
                  TweenAnimationBuilder(
                    tween: Tween<double>(
                      begin: 0,
                      end: 1,
                    ),
                    duration: const Duration(seconds: 2),
                    builder: (context, double val, child) {
                      return Opacity(
                        opacity: val,
                        child: Padding(
                          padding: EdgeInsets.only(top: val * 10),
                          child: child,
                        ),
                      );
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextButton(
                          child: Text(
                            _locale.button.log_in,
                            style: authChoiceTextStyle,
                          ),
                          onPressed: () {
                            ref
                                .read(authControllerProvider.notifier)
                                .showLogin();
                          },
                        ),
                        Text(
                          '/',
                          style: authChoiceTextStyle,
                        ),
                        TextButton(
                          child: Text(
                            _locale.button.sign_up,
                            style: authChoiceTextStyle,
                          ),
                          onPressed: () {
                            ref
                                .read(authControllerProvider.notifier)
                                .showSignUp();
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
  }
}
