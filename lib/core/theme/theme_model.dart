import 'package:firstapp/core/theme/divider_theme.dart';
import 'package:flutter/material.dart';

class ThemeModel {
  static final darkTheme = ThemeData(
    scaffoldBackgroundColor: Colors.black,
    colorScheme: const ColorScheme.dark(),
    primaryColor: const Color(0xff121212),
    iconTheme: const IconThemeData(color: Color(0xffF9F9F9)),
    textTheme: const TextTheme(
      headline1: TextStyle(
        color: Color(0xffF9F9F9),
      ),
    ),
    extensions: const <ThemeExtension<dynamic>>[
      DividerColors(
        color: Color(0xff111113),
      ),
    ],
  );

  static final lightTheme = ThemeData(
    scaffoldBackgroundColor: Colors.white,
    colorScheme: const ColorScheme.light(),
    primaryColor: const Color(0xffFAFAFA),
    iconTheme: const IconThemeData(color: Color(0xff262626)),
    textTheme: const TextTheme(
      headline1: TextStyle(
        color: Color(0xff262626),
      ),
    ),
    extensions: const <ThemeExtension<dynamic>>[
      DividerColors(
        color: Color(0xff111113),
      ),
    ],
  );
}
