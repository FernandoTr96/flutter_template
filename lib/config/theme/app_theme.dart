import 'package:flutter/material.dart';

class AppTheme {
  
  ThemeData colorTheme(Color color) {
    return ThemeData(colorSchemeSeed: color);
  }

  ColorScheme get lightThemeSchema {
    return const ColorScheme.light(
      brightness: Brightness.light,
      primary: Color.fromARGB(255, 25, 72, 121),
      onPrimary: Color.fromARGB(255, 255, 255, 255),
      secondary: Color.fromARGB(255, 36, 130, 188),
      onSecondary: Color.fromARGB(255, 255, 255, 255),
      error: Color.fromARGB(255, 182, 61, 71),
      onError: Color(0xFFFFFFFF),
      surface: Color.fromARGB(255, 246, 252, 255),
      onSurface: Color.fromARGB(255, 97, 97, 97),
    );
  }

  ColorScheme get darkThemeSchema {
    return const ColorScheme.dark(
      brightness: Brightness.dark,
      primary: Color.fromARGB(255, 72, 175, 249),
      onPrimary: Color(0xFFFFFFFF),
      secondary: Color.fromARGB(255, 24, 33, 57),
      onSecondary: Color(0xFFAAB8C2),
      error: Color(0xFFCF6679),
      onError: Color(0xFFFFFFFF),
      surface: Color.fromARGB(255, 20, 25, 42),
      onSurface: Color(0xFFEEEEEE),
    );
  }
}
