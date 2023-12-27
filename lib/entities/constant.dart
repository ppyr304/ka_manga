import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

const Color Primary = Color.fromRGBO(34, 35, 37, 1);
const Color offPrimary = Color.fromRGBO(24, 25, 26, 1);
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

String formatDate(String date) {
  String formatted = '';

  var inputFormat = DateFormat("yyyy-MM-dd'T'HH:mm:ssZ");
  var outputFormat = DateFormat("dd/MM/yyyy");

  var inputDate = inputFormat.parse(date);
  formatted = outputFormat.format(inputDate);

  return formatted;
}
