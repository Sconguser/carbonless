import 'package:carbonless/shared/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../providers/controllers/auth_controller_provider.dart';

class AuthChoice extends ConsumerWidget {
  const AuthChoice({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(
              child: Text(
                'log in',
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
                'sign up',
                style: authChoiceTextStyle,
              ),
              onPressed: () {
                ref.read(authControllerProvider.notifier).showSignUp();
              },
            ),
          ],
        ),
      ),
    );
  }
}
