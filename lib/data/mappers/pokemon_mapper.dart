import 'dart:ui' as ui;

import 'package:pokedex_global66/domain/entities/pokemon.dart';
import 'package:pokedex_global66/domain/entities/pokemon_list_item.dart';

class PokemonMapper {
  static List<String> get _preferredLanguages {
    final locale = ui.PlatformDispatcher.instance.locale.languageCode;
    // Prefer app/device locale, then English, then Spanish
    const fallbacks = ['en', 'es'];
    if (fallbacks.contains(locale)) {
      return [locale, ...fallbacks.where((l) => l != locale)];
    }
    return [locale, ...fallbacks];
  }

  static PokemonListItem toListItem(Map<String, dynamic> data) {
    final id = data['id'] as int? ?? 0;
    final name = data['name'] as String? ?? '';
    final types = (data['types'] as List<dynamic>?)
            ?.map((t) => (t['type']?['name'] as String?) ?? '')
            .where((s) => s.isNotEmpty)
            .toList() ??
        [];
    final sprites = data['sprites'] as Map<String, dynamic>?;
    final imageUrl = sprites?['front_default'] as String? ?? '';

    return PokemonListItem(
      id: id,
      name: name,
      types: types,
      imageUrl: imageUrl,
    );
  }

  static String? _textForLanguage(List<dynamic>? entries, String key) {
    if (entries == null) return null;
    for (final lang in _preferredLanguages) {
      final match = entries
          .where((e) => (e['language']?['name'] as String?) == lang)
          .map((e) => e[key] as String? ?? '')
          .where((s) => s.isNotEmpty)
          .toList();
      if (match.isNotEmpty) return match.first.replaceAll('\n', ' ');
    }
    return null;
  }

  static String _genusForLanguage(List<dynamic>? genera) {
    if (genera == null) return '';
    for (final lang in _preferredLanguages) {
      final match = genera
          .where((g) => (g['language']?['name'] as String?) == lang)
          .map((g) => g['genus'] as String? ?? '')
          .where((s) => s.isNotEmpty)
          .toList();
      if (match.isNotEmpty) {
        final genus = match.first;
        return genus.replaceFirst('Pokémon ', '').trim();
      }
    }
    return '';
  }

  static Pokemon fromApiResponses(
    Map<String, dynamic> pokemonData,
    Map<String, dynamic>? speciesData,
    List<String> weaknesses,
  ) {
    final id = pokemonData['id'] as int? ?? 0;
    final name = pokemonData['name'] as String? ?? '';
    final types = (pokemonData['types'] as List<dynamic>?)
            ?.map((t) => (t['type']?['name'] as String?) ?? '')
            .where((s) => s.isNotEmpty)
            .toList() ??
        [];
    final abilities = (pokemonData['abilities'] as List<dynamic>?)
            ?.map((a) => (a['ability']?['name'] as String?) ?? '')
            .where((s) => s.isNotEmpty)
            .toList() ??
        [];
    final sprites = pokemonData['sprites'] as Map<String, dynamic>?;
    final imageUrl = sprites?['front_default'] as String? ?? '';
    final height = (pokemonData['height'] as num?)?.toDouble() ?? 0.0;
    final weight = (pokemonData['weight'] as num?)?.toDouble() ?? 0.0;

    final flavorEntries =
        speciesData?['flavor_text_entries'] as List<dynamic>?;
    final description =
        _textForLanguage(flavorEntries, 'flavor_text') ?? '';

    final genera = speciesData?['genera'] as List<dynamic>?;
    final category = _genusForLanguage(genera);

    final genderRate = speciesData?['gender_rate'] as int? ?? -1;

    return Pokemon(
      id: id,
      name: name,
      description: description,
      height: height,
      weight: weight,
      types: types,
      abilities: abilities,
      imageUrl: imageUrl,
      category: category,
      genderRate: genderRate,
      weaknesses: weaknesses,
    );
  }
}
