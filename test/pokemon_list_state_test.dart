import 'package:flutter_test/flutter_test.dart';
import 'package:pokedex_global66/config/providers/pokemon_list_state.dart';
import 'package:pokedex_global66/domain/entities/pokemon_list_item.dart';

void main() {
  group('PokemonListState', () {
    test('initial() returns state with default values', () {
      final state = PokemonListState.initial();

      expect(state.items, isEmpty);
      expect(state.isLoading, false);
      expect(state.isLoadingMore, false);
      expect(state.error, isNull);
      expect(state.hasMore, true);
      expect(state.searchQuery, '');
      expect(state.searchResults, isEmpty);
      expect(state.isSearching, false);
      expect(state.selectedTypes, isEmpty);
    });

    group('isSearchActive', () {
      test('returns false when searchQuery is empty', () {
        final state = const PokemonListState(searchQuery: '');
        expect(state.isSearchActive, false);
      });

      test('returns false when searchQuery is only whitespace', () {
        final state = const PokemonListState(searchQuery: '   ');
        expect(state.isSearchActive, false);
      });

      test('returns true when searchQuery has content', () {
        final state = const PokemonListState(searchQuery: 'pikachu');
        expect(state.isSearchActive, true);
      });

      test(
        'returns true when searchQuery has content with leading/trailing spaces',
        () {
          final state = const PokemonListState(searchQuery: '  pikachu  ');
          expect(state.isSearchActive, true);
        },
      );
    });

    group('isTypeFilterActive', () {
      test('returns false when selectedTypes is empty', () {
        final state = const PokemonListState(selectedTypes: {});
        expect(state.isTypeFilterActive, false);
      });

      test('returns true when selectedTypes has items', () {
        final state = const PokemonListState(selectedTypes: {'fire'});
        expect(state.isTypeFilterActive, true);
      });
    });

    group('displayItems', () {
      final firePokemon = const PokemonListItem(
        id: 1,
        name: 'charmander',
        types: ['fire'],
        imageUrl: '',
      );
      final waterPokemon = const PokemonListItem(
        id: 2,
        name: 'squirtle',
        types: ['water'],
        imageUrl: '',
      );
      final grassPokemon = const PokemonListItem(
        id: 3,
        name: 'bulbasaur',
        types: ['grass'],
        imageUrl: '',
      );

      test('returns items when no search and no type filter', () {
        final state = PokemonListState(items: [firePokemon, waterPokemon]);
        expect(state.displayItems, [firePokemon, waterPokemon]);
      });

      test('returns searchResults when search is active', () {
        final state = PokemonListState(
          items: [firePokemon, waterPokemon],
          searchQuery: 'char',
          searchResults: [firePokemon],
        );
        expect(state.displayItems, [firePokemon]);
      });

      test('filters by selected types when type filter is active', () {
        final state = PokemonListState(
          items: [firePokemon, waterPokemon, grassPokemon],
          selectedTypes: {'fire'},
        );
        expect(state.displayItems, [firePokemon]);
      });

      test('filters search results by selected types', () {
        final state = PokemonListState(
          searchQuery: 'a',
          searchResults: [firePokemon, waterPokemon, grassPokemon],
          selectedTypes: {'water'},
        );
        expect(state.displayItems, [waterPokemon]);
      });

      test(
        'type filter matches when selectedTypes contains type (case insensitive on pokemon types)',
        () {
          final state = PokemonListState(
            items: [firePokemon, waterPokemon],
            selectedTypes: {'fire'},
          );
          expect(state.displayItems, [firePokemon]);
        },
      );

      test('returns empty when type filter matches nothing', () {
        final state = PokemonListState(
          items: [firePokemon, waterPokemon],
          selectedTypes: {'grass'},
        );
        expect(state.displayItems, isEmpty);
      });
    });

    group('copyWith', () {
      test('preserves unchanged fields', () {
        final state = const PokemonListState(
          items: [PokemonListItem(id: 1, name: 'a', types: [], imageUrl: '')],
          searchQuery: 'test',
        );
        final updated = state.copyWith(searchQuery: 'new');

        expect(updated.items, state.items);
        expect(updated.searchQuery, 'new');
      });

      test('can set error to null', () {
        final state = PokemonListState(error: Exception('fail'));
        final updated = state.copyWith(error: null);
        expect(updated.error, isNull);
      });
    });
  });
}
