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
Color secondaryColor = const Color(0xFFC9E8D7);
Color primaryColor = const Color(0xFF516E5E);
Color tertiaryColor = const Color(0xFFE0EDE1);
Color activeColor = const Color(0xFFAAA5F2);
Color inactiveColor = const Color(0xFFB7B8B7);
Color cardBackgroundColor = const Color(0xFFF7F7F2);
Color darkSecondaryColor = primaryColor;
Color darkPrimaryColor = secondaryColor;
String defaultFontFamily = 'Baloo Da 2';
EdgeInsetsGeometry standardOuterPadding = const EdgeInsets.all(10);
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
TextStyle labelTextStyle = TextStyle(
  fontFamily: defaultFontFamily,
  fontSize: labelFontSize,
  fontWeight: FontWeight.bold,
  color: secondaryColor,
);
TextStyle highscoresTileTextStyle = TextStyle(
  fontFamily: defaultFontFamily,
  fontSize: labelFontSize,
  fontWeight: FontWeight.bold,
  color: primaryColor,
);
TextStyle sliderTextStyle = TextStyle(
  fontFamily: defaultFontFamily,
  fontSize: sliderFontSize,
  fontWeight: FontWeight.bold,
  color: primaryColor,
  decoration: TextDecoration.none,
);
ButtonStyle selectedButtonStyle = ButtonStyle(
  textStyle: MaterialStateProperty.all(labelTextStyle),
  foregroundColor: MaterialStateProperty.all(Colors.white),
  backgroundColor: MaterialStateProperty.all(activeColor),
  elevation: MaterialStateProperty.all(0),
  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
    RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10),
      // side: BorderSide(color: Colors.red),
    ),
  ),
);
ButtonStyle unselectedButtonStyle = ButtonStyle(
  textStyle: MaterialStateProperty.all(labelTextStyle),
  foregroundColor: MaterialStateProperty.all(primaryColor),
  backgroundColor: MaterialStateProperty.all(secondaryColor),
  elevation: MaterialStateProperty.all(0),
  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
    RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10),
      // side: BorderSide(color: Colors.red),
    ),
  ),
);
const double logoFontSize = 25;
const double labelFontSize = 20;
const double warningFontSize = 15;
const double sliderFontSize = 15;
Color highlightedTextColor = secondaryColor;
ThemeData appTheme = ThemeData(
  colorScheme: ColorScheme.fromSwatch().copyWith(
    primary: primaryColor,
    secondary: activeColor,
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
      backgroundColor: MaterialStateProperty.all(secondaryColor),
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
    selectedItemColor: activeColor,
    unselectedItemColor: Colors.white,
    selectedLabelStyle: TextStyle(
      color: activeColor,
    ),
    unselectedLabelStyle: TextStyle(
      color: Colors.white,
    ),
    selectedIconTheme: IconThemeData(
      color: activeColor,
    ),
    unselectedIconTheme: IconThemeData(
      color: Colors.white,
    ),
  ),
);

ThemeData darkTheme = ThemeData(
  colorScheme: ColorScheme.fromSwatch().copyWith(
    primary: darkPrimaryColor,
    secondary: activeColor,
  ),
  inputDecorationTheme: InputDecorationTheme(
    fillColor: textInputFillColor,
  ),
  textButtonTheme: TextButtonThemeData(
    style: ButtonStyle(
      foregroundColor: MaterialStateProperty.all(darkPrimaryColor),
    ),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ButtonStyle(
      foregroundColor: MaterialStateProperty.all(darkPrimaryColor),
      backgroundColor: MaterialStateProperty.all(darkSecondaryColor),
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
    backgroundColor: darkPrimaryColor,
    selectedItemColor: activeColor,
    unselectedItemColor: Colors.white,
    selectedLabelStyle: TextStyle(
      color: activeColor,
    ),
    unselectedLabelStyle: TextStyle(
      color: Colors.white,
    ),
    selectedIconTheme: IconThemeData(
      color: activeColor,
    ),
    unselectedIconTheme: IconThemeData(
      color: Colors.white,
    ),
  ),
);
