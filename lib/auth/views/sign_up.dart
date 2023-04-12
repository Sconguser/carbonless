import 'package:carbonless/auth/views/widgets.dart';
import 'package:carbonless/main.dart';
import 'package:carbonless/providers/states/signup_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

import '../../localization/messages.i18n.dart';
import '../../providers/controllers/signup_controller_provider.dart';
import '../../shared/widgets.dart';

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
    Messages _locale = ref.watch(messagesProvider);

    return Scaffold(
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: Center(
            child: Container(
              alignment: Alignment.center,
              width: width / 4 * 3,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(child: LogoText()),
                  Center(child: AuthSwitchButton(selectedIndex: 1)),
                  buildTextFormField(
                    name,
                    ref,
                    nameStateProvider,
                    false,
                    _locale.forms.name,
                    'name',
                    FormBuilderValidators.required(),
                  ),
                  buildSizedBoxBetweenTextInputs(),
                  buildTextFormField(
                    lastname,
                    ref,
                    lastnameStateProvider,
                    false,
                    _locale.forms.lastname,
                    'lastname',
                    FormBuilderValidators.required(),
                  ),
                  buildSizedBoxBetweenTextInputs(),
                  buildTextFormField(
                    email,
                    ref,
                    emailStateProvider,
                    false,
                    _locale.forms.email,
                    'email',
                    FormBuilderValidators.email(),
                  ),
                  buildSizedBoxBetweenTextInputs(),
                  buildTextFormField(
                    password,
                    ref,
                    passwordStateProvider,
                    true,
                    _locale.forms.password,
                    'password',
                    FormBuilderValidators.required(),
                  ),
                  buildSizedBoxBetweenTextInputs(),
                  buildTextFormField(
                    passwordConfirmation,
                    ref,
                    passwordConfirmationStateProvider,
                    true,
                    _locale.forms.password_confirmation,
                    'confirm password',
                    FormBuilderValidators.equal(
                      password,
                      errorText: _locale.validators.errors.passwords_must_match,
                    ),
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ErrorMessage(),
                      SignUpButton(
                        email: email,
                        password: password,
                        passwordConfirmation: passwordConfirmation,
                        name: name,
                        lastname: lastname,
                      ),
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
