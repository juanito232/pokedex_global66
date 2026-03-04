import 'package:flutter/material.dart';
import 'package:pokedex_global66/config/theme/app_theme.dart';

class Helpers {
  static Color colorForType(String type) =>
      AppTheme.typeColors[type.toLowerCase()] ?? const Color(0xFFA8A878);

  static String capitalize(String s) =>
      s.isEmpty ? s : '${s[0].toUpperCase()}${s.substring(1)}';

  static String? imagePathForType(String type) {
    final normalized = type.toLowerCase().trim();
    if (normalized.isEmpty) return null;

    const supportedTypes = [
      'bug', 'dark', 'dragon', 'electric', 'fairy', 'fighting', 'fire',
      'flying', 'ghost', 'grass', 'ground', 'ice', 'normal', 'poison',
      'psychic', 'rock', 'steel', 'water',
    ];

    if (supportedTypes.contains(normalized)) {
      return 'assets/types/$normalized.svg';
    }
    return null;
  }
}