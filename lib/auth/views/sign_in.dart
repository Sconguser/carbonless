import 'dart:math';

import 'package:carbonless/providers/states/login_state.dart';
import 'package:carbonless/shared/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../providers/controllers/login_controller_provider.dart';

final emailStateProvider = StateProvider<String>((ref) {
  return '';
});
final passwordStateProvider = StateProvider<String>((ref) {
  return '';
});

class SignIn extends ConsumerWidget {
  SignIn({Key? key}) : super(key: key);
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loginState = ref.read(loginControllerProvider);
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    String email = ref.watch(emailStateProvider);
    String password = ref.watch(passwordStateProvider);
    return Scaffold(
      // appBar: AppBar(),
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: Center(
            child: Container(
              alignment: Alignment.center,
              width: width / 3 * 2,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('log in'),
                  buildSizedBoxBetweenTextInputs(),
                  buildTextFormField(
                      email, ref, emailStateProvider, false, 'email'),
                  buildSizedBoxBetweenTextInputs(),
                  buildTextFormField(
                      password, ref, passwordStateProvider, true, 'password'),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      buildIconButton(loginState, ref, email, password),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildIconButton(
      LoginState loginState, WidgetRef ref, String email, String password) {
    return loginState is LoginStateLoading
        ? spinner
        : IconButton(
            icon: Icon(Icons.arrow_forward_outlined),
            onPressed: () {
              if (loginState is LoginStateInitial ||
                  loginState is LoginStateError) {
                ref
                    .read(loginControllerProvider.notifier)
                    .login(email, password);
              }
            },
          );
  }
}
