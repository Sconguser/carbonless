import 'package:carbonless/providers/login_controller_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SignIn extends ConsumerWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Container(
          alignment: Alignment.center,
          child: Column(
            children: [
              Text('Login'),
              ElevatedButton(
                onPressed: () {
                  ref
                      .read(loginControllerProvider.notifier)
                      .login('Gówno', 'Dupa');
                },
                child: Text('Zaloguj się'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
