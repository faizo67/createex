import 'package:flutter/material.dart';

ThemeData drakTheme = ThemeData(
  brightness: Brightness.dark,
  colorScheme: ColorScheme.dark(
    // background == surface
    surface: Colors.black,
    primary: Colors.grey[900]!,
    secondary: Colors.grey[800]!,
  ),
  // Button
  buttonTheme: ButtonThemeData(
    buttonColor: Color(0x00ffc491),
  ),
);
