import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

Color textInputFillColor = const Color(0xFFFD9D9D9);

Widget spinner = SpinKitDualRing(color: textInputFillColor);

TextStyle logoTextStyle = TextStyle(
  fontFamily: 'Baloo Da 2',
  fontSize: logoFontSize,
  fontWeight: FontWeight.bold,
);

const double logoFontSize = 25;
Color highlightedTextColor = Colors.green;
ThemeData appTheme = ThemeData(
  primarySwatch: Colors.grey,
  inputDecorationTheme: InputDecorationTheme(
    fillColor: textInputFillColor,
  ),
  textButtonTheme: TextButtonThemeData(
    style: ButtonStyle(
      foregroundColor: MaterialStateProperty.all(Colors.black),
    ),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ButtonStyle(
      backgroundColor: MaterialStateProperty.all(highlightedTextColor),
      elevation: MaterialStateProperty.all(0),
      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
          // side: BorderSide(color: Colors.red),
        ),
      ),
    ),
  ),
);
