import 'package:flutter/material.dart';

class Themes {
  static ThemeData get defaultTheme => ThemeData(
      brightness: Brightness.light,
      primarySwatch: grayColor,
      primaryColor: grayColor,
      shadowColor: Themes.themeColor.shade900,
      splashColor: Themes.themeColor.shade100,
      cardColor: Colors.white,
      textTheme: const TextTheme(bodyMedium: TextStyle(color: Colors.black)),
      iconTheme: IconThemeData(color: grayColor[500]),
      fontFamily: 'inter',
      colorScheme: ColorScheme(
        background: Colors.grey.shade50,
        brightness: Brightness.light,
        primary: Themes.grayColor.shade900,
        onPrimary: grayColor,
        secondary: Themes.themeColor,
        onSecondary: grayColor,
        error: Colors.red,
        onError: Colors.white,
        onBackground: grayColor,
        surface: Colors.white,
        onSurface: grayColor,
      ));

  static ThemeData get darkTheme => ThemeData(
      brightness: Brightness.dark,
      primaryColor: Colors.white,
      shadowColor: Themes.themeColor.shade800,
      splashColor: Themes.themeColor,
      cardColor: const Color(0xFF464646),
      iconTheme: IconThemeData(color: grayColor[50]),
      textTheme: const TextTheme(bodyMedium: TextStyle(color: Colors.white)),
      colorScheme: const ColorScheme(
        background: Color(0xFF242424),
        brightness: Brightness.dark,
        primary: Colors.white,
        onPrimary: Colors.black,
        secondary: Themes.themeColor,
        onSecondary: Colors.white,
        error: Colors.red,
        onError: Colors.white,
        onBackground: Colors.white,
        surface: Color(0xFF5F625F),
        onSurface: Colors.white,
      ));

  static const MaterialColor themeColor =
      MaterialColor(_accentPrimaryValue, <int, Color>{
    50: Color(0xFFADE0CE),
    100: Color(0xFF96CCB4),
    200: Color(0xFF9EE0C3),
    300: Color(0xFF6DDCAB),
    400: Color(0xFF4EE5A1),
    500: Color(0xFF36C485),
    600: Color(0xFF3CA576),
    700: Color(0xFF3F8366),
    800: Color(0xFF294D3C),
    900: Color(0xFF1C3D2F),
  });
  static const int _accentPrimaryValue = 0xFF36C485;

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
