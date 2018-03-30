import 'package:flutter/material.dart';

final ThemeData ProtofiThemeData = new ThemeData(
  brightness: Brightness.light,
  primarySwatch: ProtofiColors.darkBlue,
  primaryColor: ProtofiColors.darkBlue[500],
  primaryColorBrightness: Brightness.light,

  accentColor: ProtofiColors.darkBlue[500],
  accentColorBrightness: Brightness.light,

  canvasColor: Colors.black,
  scaffoldBackgroundColor: Colors.black,
  cardColor: ProtofiColors.darkBlue[500],
  dividerColor: Colors.black,
  highlightColor: Colors.black,
  splashColor: Colors.black,
  selectedRowColor: Colors.black,
  unselectedWidgetColor: Colors.black,
  disabledColor: Colors.black,
  buttonColor: ProtofiColors.darkBlue[500],
  secondaryHeaderColor: Colors.black,
  textSelectionColor: Colors.black,
  textSelectionHandleColor: Colors.black,
  backgroundColor: ProtofiColors.lightGray[500],
  dialogBackgroundColor: Colors.black,
  indicatorColor: Colors.black,
  hintColor: Colors.black,
  errorColor: Colors.black, 
);

const primaryDarkBlueValue = 0x3A3D48;
const primaryLightGrayValue = 0xE0E1E2;

class ProtofiColors {
  ProtofiColors._();

  static const MaterialColor darkBlue = const MaterialColor(
    primaryDarkBlueValue,
    const <int, Color>{
      50: const Color(0xE7E8E9),
      100: const Color(0xC4C5C8),
      200: const Color(0x9D9EA4),
      300: const Color(0x75777F),
      400: const Color(0x585A63),
      500: const Color(primaryDarkBlueValue),
      600: const Color(0x343741),
      700: const Color(0x2C2F38),
      800: const Color(0x252730),
      900: const Color(0x181A21)
    },
  );

  static const MaterialColor lightGray = const MaterialColor(
    primaryLightGrayValue,
    const <int, Color>{
      50: const Color(0xFBFBFC),
      100: const Color(0xF6F6F6),
      200: const Color(0xF0F0F1),
      300: const Color(0xE9EAEB),
      400: const Color(0xE5E6E6),
      500: const Color(primaryLightGrayValue),
      600: const Color(0xDCDDDF),
      700: const Color(0xD8D9DA),
      800: const Color(0xD3D5D6),
      900: const Color(0xCBCDCF)
    },
  );

}