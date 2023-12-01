import '/auth/views/widgets.dart';
import '/main.dart';
import '/providers/states/login_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

import '../../localization/messages.i18n.dart';
import '../../providers/controllers/login_controller_provider.dart';
import '../../shared/widgets.dart';

final emailStateProvider = StateProvider<String>((ref) {
  return '';
});
final passwordStateProvider = StateProvider<String>((ref) {
  return '';
});
final autoLoginCheckboxStateProvider = StateProvider<bool>((ref) {
  return false;
});

class SignIn extends ConsumerWidget {
  SignIn({Key? key}) : super(key: key);
  final _formKey = GlobalKey<FormBuilderState>();
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Messages _locale = ref.watch(messagesProvider);
    final loginState = ref.read(loginControllerProvider);
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    String email = ref.watch(emailStateProvider);
    String password = ref.watch(passwordStateProvider);
    bool autoLogin = ref.watch(autoLoginCheckboxStateProvider);
    return Scaffold(
      body: SafeArea(
        child: FormBuilder(
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
                  buildSizedBoxBetweenTextInputs(),
                  buildTextFormField(
                    email,
                    ref,
                    emailStateProvider,
                    false,
                    _locale.forms.email,
                    'email',
                    FormBuilderValidators.compose([
                      FormBuilderValidators.email(
                          errorText:
                              _locale.validators.errors.invalid_email_format),
                      FormBuilderValidators.required(
                          errorText: _locale.validators.errors.cannot_be_empty),
                    ]),
                  ),
                  buildSizedBoxBetweenTextInputs(),
                  buildTextFormField(
                    password,
                    ref,
                    passwordStateProvider,
                    true,
                    _locale.forms.password,
                    'password',
                    FormBuilderValidators.required(
                      errorText: _locale.validators.errors.cannot_be_empty,
                    ),
                  ),
                  Row(
                    // mainAxisAlignment: MainAxisAlignment.spaceEve,
                    children: [
                      Checkbox(
                        value: ref.watch(autoLoginCheckboxStateProvider),
                        onChanged: (value) {
                          if (value != null) {
                            ref
                                .read(autoLoginCheckboxStateProvider.notifier)
                                .state = value;
                          }
                        },
                      ),
                      Text(_locale.checkbox.auto_login),
                    ],
                  ),
                  loginState is LoginStateLoading
                      ? Center(child: spinner)
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            ErrorMessage(),
                            SignInButton(
                              email: email,
                              password: password,
                              formKey: _formKey,
                              autoLogin: autoLogin,
                            ),
                            // SignInDebug(),
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
}
