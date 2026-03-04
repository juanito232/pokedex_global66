import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:pokedex_global66/config/providers/favorites_provider.dart';

void main() {
  setUp(() {
    SharedPreferences.setMockInitialValues({});
  });

  group('FavoritesNotifier', () {
    test('build returns empty set when no favorites saved', () async {
      final container = ProviderContainer();
      addTearDown(container.dispose);

      final state = await container.read(favoritesProvider.future);

      expect(state, isEmpty);
    });

    test('build returns saved favorites', () async {
      SharedPreferences.setMockInitialValues({
        'pokemon_favorites': jsonEncode(['pikachu', 'charizard']),
      });

      final container = ProviderContainer();
      addTearDown(container.dispose);

      final state = await container.read(favoritesProvider.future);

      expect(state, {'pikachu', 'charizard'});
    });

    test('toggle adds pokemon when not favorite', () async {
      final container = ProviderContainer();
      addTearDown(container.dispose);
      final notifier = container.read(favoritesProvider.notifier);

      await notifier.toggle('Pikachu');

      expect(container.read(favoritesProvider).value, {'pikachu'});
    });

    test('toggle removes pokemon when already favorite', () async {
      SharedPreferences.setMockInitialValues({
        'pokemon_favorites': jsonEncode(['pikachu']),
      });

      final container = ProviderContainer();
      addTearDown(container.dispose);
      final notifier = container.read(favoritesProvider.notifier);

      await container.read(favoritesProvider.future);
      await notifier.toggle('pikachu');

      expect(container.read(favoritesProvider).value, isEmpty);
    });

    test('toggle normalizes name to lowercase and trims', () async {
      final container = ProviderContainer();
      addTearDown(container.dispose);
      final notifier = container.read(favoritesProvider.notifier);

      await notifier.toggle('  PIKACHU  ');

      expect(container.read(favoritesProvider).value, {'pikachu'});
    });

    test('add adds pokemon when not present', () async {
      final container = ProviderContainer();
      addTearDown(container.dispose);
      final notifier = container.read(favoritesProvider.notifier);

      await notifier.add('pikachu');

      expect(container.read(favoritesProvider).value, {'pikachu'});
    });

    test('add does nothing when already present', () async {
      SharedPreferences.setMockInitialValues({
        'pokemon_favorites': jsonEncode(['pikachu']),
      });

      final container = ProviderContainer();
      addTearDown(container.dispose);
      final notifier = container.read(favoritesProvider.notifier);

      await container.read(favoritesProvider.future);
      await notifier.add('pikachu');

      expect(container.read(favoritesProvider).value, {'pikachu'});
    });

    test('remove removes pokemon when present', () async {
      SharedPreferences.setMockInitialValues({
        'pokemon_favorites': jsonEncode(['pikachu']),
      });

      final container = ProviderContainer();
      addTearDown(container.dispose);
      final notifier = container.read(favoritesProvider.notifier);

      await container.read(favoritesProvider.future);
      await notifier.remove('pikachu');

      expect(container.read(favoritesProvider).value, isEmpty);
    });

    test('remove does nothing when not present', () async {
      final container = ProviderContainer();
      addTearDown(container.dispose);
      await container.read(favoritesProvider.future);
      final notifier = container.read(favoritesProvider.notifier);

      await notifier.remove('pikachu');

      expect(container.read(favoritesProvider).value, isEmpty);
    });

    test('isFavorite returns true when pokemon is in favorites', () async {
      SharedPreferences.setMockInitialValues({
        'pokemon_favorites': jsonEncode(['pikachu']),
      });

      final container = ProviderContainer();
      addTearDown(container.dispose);
      await container.read(favoritesProvider.future);

      final notifier = container.read(favoritesProvider.notifier);

      expect(notifier.isFavorite('pikachu'), true);
      expect(notifier.isFavorite('PIKACHU'), true);
      expect(notifier.isFavorite('  pikachu  '), true);
    });

    test('isFavorite returns false when pokemon is not in favorites', () async {
      final container = ProviderContainer();
      addTearDown(container.dispose);
      await container.read(favoritesProvider.future);

      final notifier = container.read(favoritesProvider.notifier);

      expect(notifier.isFavorite('pikachu'), false);
    });

    test('persists favorites across provider rebuild', () async {
      final container = ProviderContainer();
      addTearDown(container.dispose);
      final notifier = container.read(favoritesProvider.notifier);

      await notifier.add('pikachu');
      container.dispose();

      final newContainer = ProviderContainer();
      addTearDown(newContainer.dispose);

      final state = await newContainer.read(favoritesProvider.future);

      expect(state, {'pikachu'});
    });
  });
}
