import 'package:carbonless/auth/views/stylesheet.dart';
import 'package:carbonless/shared/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../localization/messages.i18n.dart';
import '../../main.dart';
import '../../providers/controllers/auth_controller_provider.dart';
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
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            LogoText(),
            TweenAnimationBuilder(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                    child: Text(
                      _locale.button.log_in,
                      style: authChoiceTextStyle,
                    ),
                    onPressed: () {
                      ref.read(authControllerProvider.notifier).showLogin();
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
                      ref.read(authControllerProvider.notifier).showSignUp();
                    },
                  ),
                ],
              ),
              tween: Tween<double>(
                begin: 0,
                end: 1,
              ),
              duration: Duration(seconds: 2),
              builder: (context, double val, child) {
                return Opacity(
                  opacity: val,
                  child: Padding(
                    padding: EdgeInsets.only(top: val * 10),
                    child: child,
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
