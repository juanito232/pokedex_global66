import 'package:flutter/material.dart';

class AppTheme {
  static const _seedColor = Color(0xFF1E88E5);

  ThemeData getTheme() => ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: _seedColor,
          primary: _seedColor,
          brightness: Brightness.light,
        ),
      );

  static const typeColors = {
    'bug': Color(0xFF91C12F),
    'dark': Color(0xFF5A5465),
    'dragon': Color(0xFF0B6DC3),
    'electric': Color(0xFFF4D23C),
    'fairy': Color(0xFFEC8FE6),
    'fighting': Color(0xFFCE416B),
    'fire': Color(0xFFFF9D55),
    'flying': Color(0xFF98AAE3),
    'ghost': Color(0xFF5269AD),
    'grass': Color(0xFF63BC5A),
    'ground': Color(0xFFD97845),
    'ice': Color(0xFF73CEC0),
    'normal': Color(0xFF919AA2),
    'poison': Color(0xFFB567CE),
    'psychic': Color(0xFFFA7179),
    'rock': Color(0xFFC5B78C),
    'steel': Color(0xFF5A8EA2),
    'water': Color(0xFF5090D6),
  };
}
