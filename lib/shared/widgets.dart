import '/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../localization/messages.i18n.dart';
import 'constants.dart';

Widget buildTextFormField(
  String inValue,
  WidgetRef ref,
  StateProvider stateProvider,
  bool isSecret,
  String hintText,
  String name,
  String? Function(String?) validator, {
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled,
}) {
  return ClipRRect(
    borderRadius: BorderRadius.circular(10),
    child: FormBuilderTextField(
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
    ),
  );
}

SizedBox buildSizedBoxBetweenTextInputs() {
  return SizedBox(
    height: 10,
  );
}

class LogoText extends ConsumerWidget {
  Color? color;
  LogoText({Key? key, this.color}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Messages _locale = ref.watch(messagesProvider);
    return Text(
      _locale.text.appName,
      style: logoTextStyle.copyWith(color: color),
    );
  }
}

Widget spinner = SpinKitWaveSpinner(
  color: primaryColor,
  trackColor: secondaryColor,
  waveColor: primaryColor,
  size: 50,
);
Widget warningIcon = Icon(
  Icons.error_outline,
  color: warningIconColor,
);
