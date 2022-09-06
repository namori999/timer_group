import 'package:flutter/material.dart';

class Themes {
  static ThemeData get defaultTheme => ThemeData(primarySwatch: grayColor);

  static ThemeData get darkTheme =>
      defaultTheme.copyWith(brightness: Brightness.dark);

  static const MaterialColor themeColor =
  MaterialColor(_accentPrimaryValue, <int, Color>{
    50: Color(0xFFD2E7C9),
    100: Color(0xFFB4D0A7),
    200: Color(0xFFA1CE80),
    300: Color(0xFF97D471),
    400: Color(0xFF89D45F),
    500: Color(_accentPrimaryValue),
    600: Color(0xFF64A53C),
    700: Color(0xFF4C8B28),
    800: Color(0xFF458020),
    900: Color(0xFF224707),
  });
  static const int _accentPrimaryValue = 0xFF7AC74A;

  static const MaterialColor grayColor =
  MaterialColor(_grayPrimaryValue, <int, Color>{
    50: Color(0xFFFFFFFF),
    100: Color(0xFFE7E5E5),
    200: Color(0xFFDBDBDB),
    300: Color(0xFFC2C2C2),
    400: Color(0xFFB6B6B6),
    500: Color(0xFFA1A1A1),
    600: Color(0xFF7D7D7D),
    700: Color(0xFF616161),
    800: Color(0xFF494949),
    900: Color(0xFF343434),
  });
  static const int _grayPrimaryValue = 0xFFA1A1A1;
}
