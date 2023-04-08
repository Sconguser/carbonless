import 'package:carbonless/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../localization/messages.i18n.dart';
import 'constants.dart';

FormBuilderTextField buildTextFormField(
  String inValue,
  WidgetRef ref,
  StateProvider stateProvider,
  bool isSecret,
  String hintText,
  String name,
  String? Function(String?) validator, {
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled,
}) {
  return FormBuilderTextField(
    validator: validator,
    autovalidateMode: autovalidateMode,
    name: name,
    decoration: InputDecoration(
      border: InputBorder.none,
      hintText: hintText,
      filled: true,
    ),
    obscureText: isSecret,
    initialValue: inValue,
    onChanged: (value) {
      ref.read(stateProvider.notifier).state = value;
    },
  );
}

SizedBox buildSizedBoxBetweenTextInputs() {
  return SizedBox(
    height: 21,
  );
}

class LogoText extends ConsumerWidget {
  const LogoText({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Messages _locale = ref.watch(messagesProvider);
    return Text(
      _locale.text.appName,
      style: logoTextStyle,
    );
  }
}
