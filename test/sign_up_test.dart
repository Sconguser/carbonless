import 'dart:math';

import 'package:carbonless_free/auth/views/sign_up.dart';
import 'package:carbonless_free/auth/views/widgets.dart';
import 'package:carbonless_free/localization/messages.i18n.dart';
import 'package:carbonless_free/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  widgetRenderTest();
  testWidgetError();
}

void testWidgetError() {
  // testWidgets('Checks if error fields display correctly',
  //     (WidgetTester tester) async {
  //   await initView(tester);
  //   final continueButton = find.widgetWithText(ElevatedButton, 'continue');
  //   await tester.press(continueButton);
  //   final errorTextFinder = find.text('this field cannot be empty');
  //   expect(errorTextFinder, findsExactly(4));
  // });
}

void widgetRenderTest() {
  testWidgets('Checks if all widgets in Sign Up view render correctly',
      (WidgetTester tester) async {
    await initView(tester);
    final logoFinder = find.text("carbonless free");
    final buttonFinder = find.widgetWithText(ElevatedButton, 'continue');
    final formFieldFinder = find.byType(FormBuilderTextField);
    final textButtonFinder = find.byType(TextButton);
    expect(textButtonFinder, findsExactly(2));
    expect(logoFinder, findsOneWidget);
    expect(buttonFinder, findsOneWidget);
    expect(formFieldFinder, findsExactly(5));
  });
}

Future<void> initView(WidgetTester tester) async {
  await tester.pumpWidget(ProviderScope(
      overrides: [
        messagesProvider.overrideWith((ref) => Messages()),
      ],
      child: MaterialApp(
        home: SignUp(),
      )));
}
