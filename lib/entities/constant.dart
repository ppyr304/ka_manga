import 'package:flutter/material.dart';

const Color Primary = Color.fromRGBO(34, 35, 37, 1);
const Color Secondary = Color.fromRGBO(53, 21, 93, 1);
const Color SecondaryAccent = Color.fromRGBO(68, 119, 206, 1);
const Color Tertiary = Color.fromRGBO(140, 171, 255, 1);

ThemeData CustomTheme() {
  return ThemeData(
    colorScheme: const ColorScheme(
      brightness: Brightness.light,
      primary: Tertiary,
      onPrimary: Secondary,
      secondary: Tertiary,
      onSecondary: SecondaryAccent,
      error: Colors.red,
      onError: Colors.red,
      background: Primary,
      onBackground: Tertiary,
      surface: Secondary,
      onSurface: Tertiary,
    ),
  );
}
