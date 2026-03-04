import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pokedex_global66/config/providers/providers.dart';
import 'package:pokedex_global66/domain/entities/pokemon_list_item.dart';
import 'package:pokedex_global66/domain/repositories/pokemon_repository.dart';

class MockPokemonRepository extends Mock implements PokemonRepository {}

void main() {
  late MockPokemonRepository mockRepository;

  setUp(() {
    mockRepository = MockPokemonRepository();
  });

  ProviderContainer createContainer() {
    return ProviderContainer(
      overrides: [repositoryProvider.overrideWithValue(mockRepository)],
    );
  }

  group('PaginatedPokemonList', () {
    test('loadInitial fetches and sets items', () async {
      final items = [
        const PokemonListItem(
          id: 1,
          name: 'bulbasaur',
          types: ['grass'],
          imageUrl: '',
        ),
      ];
      when(
        () => mockRepository.getPokemonList(offset: 0, limit: 10),
      ).thenAnswer((_) async => items);

      final container = createContainer();
      addTearDown(container.dispose);
      final notifier = container.read(paginatedPokemonListProvider.notifier);

      await notifier.loadInitial();

      expect(container.read(paginatedPokemonListProvider).items, items);
      expect(container.read(paginatedPokemonListProvider).isLoading, false);
    });

    test('loadInitial sets error on failure', () async {
      when(
        () => mockRepository.getPokemonList(offset: 0, limit: 10),
      ).thenThrow(Exception('Network error'));

      final container = createContainer();
      addTearDown(container.dispose);
      final notifier = container.read(paginatedPokemonListProvider.notifier);

      await notifier.loadInitial();

      expect(container.read(paginatedPokemonListProvider).error, isNotNull);
      expect(container.read(paginatedPokemonListProvider).isLoading, false);
    });

    test('loadMore fetches next page and appends items', () async {
      final initialItems = List.generate(
        10,
        (i) => PokemonListItem(id: i + 1, name: 'p$i', types: [], imageUrl: ''),
      );
      final moreItems = [
        const PokemonListItem(id: 11, name: 'p10', types: [], imageUrl: ''),
      ];

      when(
        () => mockRepository.getPokemonList(offset: 0, limit: 10),
      ).thenAnswer((_) async => initialItems);
      when(
        () => mockRepository.getPokemonList(offset: 10, limit: 10),
      ).thenAnswer((_) async => moreItems);

      final container = createContainer();
      addTearDown(container.dispose);
      final notifier = container.read(paginatedPokemonListProvider.notifier);

      await notifier.loadInitial();
      await notifier.loadMore();

      expect(container.read(paginatedPokemonListProvider).items.length, 11);
      expect(
        container.read(paginatedPokemonListProvider).items.last.name,
        'p10',
      );
    });

    test('loadMore does nothing when search is active', () async {
      when(
        () => mockRepository.getPokemonList(offset: 0, limit: 10),
      ).thenAnswer(
        (_) async => [
          const PokemonListItem(id: 1, name: 'a', types: [], imageUrl: ''),
        ],
      );

      final container = createContainer();
      addTearDown(container.dispose);
      final notifier = container.read(paginatedPokemonListProvider.notifier);

      await notifier.loadInitial();
      notifier.setSearchQuery('pika');
      await notifier.loadMore();

      verifyNever(() => mockRepository.getPokemonList(offset: 10, limit: 10));
      expect(container.read(paginatedPokemonListProvider).items.length, 1);
    });

    test('loadMore does nothing when hasMore is false', () async {
      final fewItems = [
        const PokemonListItem(id: 1, name: 'a', types: [], imageUrl: ''),
      ];
      when(
        () => mockRepository.getPokemonList(offset: 0, limit: 10),
      ).thenAnswer((_) async => fewItems);

      final container = createContainer();
      addTearDown(container.dispose);
      final notifier = container.read(paginatedPokemonListProvider.notifier);

      await notifier.loadInitial();
      await notifier.loadMore();

      verify(
        () => mockRepository.getPokemonList(offset: 0, limit: 10),
      ).called(1);
      verifyNever(() => mockRepository.getPokemonList(offset: 1, limit: 10));
    });

    test('setSearchQuery updates query and clears results when empty', () {
      final container = createContainer();
      addTearDown(container.dispose);
      final notifier = container.read(paginatedPokemonListProvider.notifier);

      notifier.setSearchQuery('pika');
      expect(container.read(paginatedPokemonListProvider).searchQuery, 'pika');

      notifier.setSearchQuery('');
      expect(container.read(paginatedPokemonListProvider).searchQuery, '');
      expect(
        container.read(paginatedPokemonListProvider).searchResults,
        isEmpty,
      );
      expect(container.read(paginatedPokemonListProvider).isSearching, false);
    });

    test('search fetches and sets results', () async {
      final results = [
        const PokemonListItem(
          id: 25,
          name: 'pikachu',
          types: ['electric'],
          imageUrl: '',
        ),
      ];
      when(
        () => mockRepository.searchPokemonByName('pika'),
      ).thenAnswer((_) async => results);

      final container = createContainer();
      addTearDown(container.dispose);
      final notifier = container.read(paginatedPokemonListProvider.notifier);

      await notifier.search('pika');

      expect(
        container.read(paginatedPokemonListProvider).searchResults,
        results,
      );
      expect(container.read(paginatedPokemonListProvider).isSearching, false);
    });

    test('search clears results for empty query', () async {
      final container = createContainer();
      addTearDown(container.dispose);
      final notifier = container.read(paginatedPokemonListProvider.notifier);

      await notifier.search('');

      expect(
        container.read(paginatedPokemonListProvider).searchResults,
        isEmpty,
      );
      verifyNever(() => mockRepository.searchPokemonByName(any()));
    });

    test('setSelectedTypes updates filter', () {
      final container = createContainer();
      addTearDown(container.dispose);
      final notifier = container.read(paginatedPokemonListProvider.notifier);

      notifier.setSelectedTypes({'fire', 'water'});

      expect(container.read(paginatedPokemonListProvider).selectedTypes, {
        'fire',
        'water',
      });
    });

    test('clearTypeFilter removes type filter', () {
      final container = createContainer();
      addTearDown(container.dispose);
      final notifier = container.read(paginatedPokemonListProvider.notifier);

      notifier.setSelectedTypes({'fire'});
      notifier.clearTypeFilter();

      expect(
        container.read(paginatedPokemonListProvider).selectedTypes,
        isEmpty,
      );
    });
  });
}
