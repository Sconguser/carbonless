import 'package:carbonless/providers/states/signup_state.dart';
import 'package:carbonless/shared/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

import '../../providers/controllers/signup_controller_provider.dart';

final emailStateProvider = StateProvider<String>((ref) {
  return '';
});
final passwordStateProvider = StateProvider<String>((ref) {
  return '';
});
final passwordConfirmationStateProvider = StateProvider<String>((ref) {
  return '';
});
final nameStateProvider = StateProvider<String>((ref) {
  return '';
});
final lastnameStateProvider = StateProvider<String>((ref) {
  return '';
});

class SignUp extends ConsumerWidget {
  SignUp({Key? key}) : super(key: key);

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    final signUpState = ref.read(signUpControllerProvider);
    String email = ref.watch(emailStateProvider);
    String password = ref.watch(passwordStateProvider);
    String passwordConfirmation = ref.watch(passwordConfirmationStateProvider);
    String name = ref.watch(nameStateProvider);
    String lastname = ref.watch(lastnameStateProvider);

    return Scaffold(
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
                  Text('sign up'),
                  buildTextFormField(
                    name,
                    ref,
                    nameStateProvider,
                    false,
                    'name',
                    'name',
                    FormBuilderValidators.required(),
                  ),
                  buildSizedBoxBetweenTextInputs(),
                  buildTextFormField(
                    lastname,
                    ref,
                    lastnameStateProvider,
                    false,
                    'lastname',
                    'lastname',
                    FormBuilderValidators.required(),
                  ),
                  buildSizedBoxBetweenTextInputs(),
                  buildTextFormField(
                    email,
                    ref,
                    emailStateProvider,
                    false,
                    'email',
                    'email',
                    FormBuilderValidators.email(),
                  ),
                  buildSizedBoxBetweenTextInputs(),
                  buildTextFormField(
                    password,
                    ref,
                    passwordStateProvider,
                    true,
                    'password',
                    'password',
                    FormBuilderValidators.required(),
                  ),
                  buildSizedBoxBetweenTextInputs(),
                  buildTextFormField(
                    passwordConfirmation,
                    ref,
                    passwordConfirmationStateProvider,
                    true,
                    'confirm password',
                    'confirm password',
                    FormBuilderValidators.equal(password,
                        errorText: 'Hasła muszą się zgadzać'),
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      buildSignUpIconButton(signUpState, ref, email, password,
                          passwordConfirmation, name, lastname),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildSignUpIconButton(
      SignUpState signUpState,
      WidgetRef ref,
      String email,
      String password,
      String passwordConfirmation,
      String name,
      String lastname) {
    return signUpState is SignUpStateLoading
        ? spinner
        : IconButton(
            icon: Icon(Icons.arrow_forward_outlined),
            onPressed: () {
              if (signUpState is SignUpStateInitial ||
                  signUpState is SignUpStateError) {
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
