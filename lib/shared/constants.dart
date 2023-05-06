import 'package:carbonless/shared/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

int maxCharactersInForm = 20;
int minPasswordCharacters = 6;
Color textInputFillColor = const Color(0xFFFD9D9D9);
Color warningTextColor = Colors.red;
Color warningIconColor = Colors.red;
Color buttonColor = const Color(0xFFC9E8D7);
Color primaryColor = const Color(0xFF516E5E);
Color secondaryColor = const Color(0xFFAAA5F2);
String defaultFontFamily = 'Baloo Da 2';
TextStyle warningTextStyle = TextStyle(
  fontFamily: defaultFontFamily,
  fontSize: warningFontSize,
);
TextStyle logoTextStyle = TextStyle(
  fontFamily: defaultFontFamily,
  fontSize: logoFontSize,
  fontWeight: FontWeight.bold,
  color: primaryColor,
);

const double logoFontSize = 25;
const double warningFontSize = 15;
Color highlightedTextColor = buttonColor;
ThemeData appTheme = ThemeData(
  colorScheme: ColorScheme.fromSwatch().copyWith(
    primary: primaryColor,
    secondary: secondaryColor,
  ),
  inputDecorationTheme: InputDecorationTheme(
    fillColor: textInputFillColor,
  ),
  textButtonTheme: TextButtonThemeData(
    style: ButtonStyle(
      foregroundColor: MaterialStateProperty.all(primaryColor),
    ),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ButtonStyle(
      foregroundColor: MaterialStateProperty.all(primaryColor),
      backgroundColor: MaterialStateProperty.all(buttonColor),
      elevation: MaterialStateProperty.all(0),
      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
          // side: BorderSide(color: Colors.red),
        ),
      ),
    ),
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    backgroundColor: primaryColor,
    selectedItemColor: secondaryColor,
    unselectedItemColor: Colors.white,
    selectedLabelStyle: TextStyle(
      color: secondaryColor,
    ),
    unselectedLabelStyle: TextStyle(
      color: Colors.white,
    ),
    selectedIconTheme: IconThemeData(
      color: secondaryColor,
    ),
    unselectedIconTheme: IconThemeData(
      color: Colors.white,
    ),
  ),
);
