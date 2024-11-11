import 'package:flutter/material.dart';

ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  colorScheme: ColorScheme.light(
    // background == surface
    surface: Colors.grey[300]!,
    primary: Colors.grey[200]!,
    secondary: Colors.grey[300]!,
  ),
  // Button
  buttonTheme: ButtonThemeData(
    buttonColor: Color(0x00ffc491),
    padding: EdgeInsets.all(13),
    textTheme: ButtonTextTheme.normal,
  ),
);
