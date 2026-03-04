import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

const _favoritesKey = 'pokemon_favorites';

Future<Set<String>> _loadFavorites() async {
  final prefs = await SharedPreferences.getInstance();
  final json = prefs.getString(_favoritesKey);
  if (json != null) {
    try {
      final list = jsonDecode(json) as List<dynamic>;
      return list.map((e) => e.toString()).toSet();
    } catch (_) {}
  }
  return {};
}

Future<void> _saveFavorites(Set<String> favorites) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setString(_favoritesKey, jsonEncode(favorites.toList()));
}

class FavoritesNotifier extends AsyncNotifier<Set<String>> {
  @override
  Future<Set<String>> build() => _loadFavorites();

  Future<void> toggle(String pokemonName) async {
    final name = pokemonName.toLowerCase().trim();
    final current = state.value ?? <String>{};
    final next = current.contains(name)
        ? (Set<String>.from(current)..remove(name))
        : {...current, name};
    state = AsyncData(next);
    await _saveFavorites(next);
  }

  Future<void> add(String pokemonName) async {
    final name = pokemonName.toLowerCase().trim();
    final current = state.value ?? <String>{};
    if (!current.contains(name)) {
      final next = {...current, name};
      state = AsyncData(next);
      await _saveFavorites(next);
    }
  }

  Future<void> remove(String pokemonName) async {
    final name = pokemonName.toLowerCase().trim();
    final current = state.value ?? <String>{};
    if (current.contains(name)) {
      final next = Set<String>.from(current)..remove(name);
      state = AsyncData(next);
      await _saveFavorites(next);
    }
  }

  bool isFavorite(String pokemonName) {
    return (state.value ?? <String>{}).contains(pokemonName.toLowerCase().trim());
  }
}

final favoritesProvider =
    AsyncNotifierProvider<FavoritesNotifier, Set<String>>(FavoritesNotifier.new);
