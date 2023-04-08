import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

Color textInputFillColor = const Color(0xFFFD9D9D9);

Widget spinner = SpinKitDualRing(color: textInputFillColor);

TextStyle authChoiceTextStyle = TextStyle(
  fontSize: authChoiceFontSize,
);
double authChoiceFontSize = 30;

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
