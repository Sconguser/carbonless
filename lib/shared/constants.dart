import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

Color textInputFillColor = const Color(0xFFFD9D9D9);

Widget spinner = SpinKitDualRing(color: textInputFillColor);

// TextDecoration authChoiceTextDecoration = TextDecoration(
//
// )
TextStyle authChoiceTextStyle = TextStyle(
  fontSize: authChoiceFontSize,
);
double authChoiceFontSize = 30;

TextFormField buildTextFormField(String inValue, WidgetRef ref,
    StateProvider stateProvider, bool isSecret, String hintText) {
  return TextFormField(
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
