import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pokedex_global66/config/providers/favorites_provider.dart';
import 'package:pokedex_global66/config/providers/pokemon_list_state.dart';
import 'package:pokedex_global66/data/datasources/pokeapi_datasource_impl.dart';
import 'package:pokedex_global66/data/repositories/pokemon_repository_impl.dart';
import 'package:pokedex_global66/domain/entities/pokemon.dart';
import 'package:pokedex_global66/domain/entities/pokemon_list_item.dart';
import 'package:pokedex_global66/domain/repositories/pokemon_repository.dart';

final repositoryProvider = Provider<PokemonRepository>((ref) {
  return PokemonRepositoryImpl(PokeAPIDatasourceImpl());
});

final pokemonDetailProvider =
    FutureProvider.family<Pokemon?, String>((ref, name) async {
  final repository = ref.watch(repositoryProvider);
  final list = await repository.getPokemonDetails(name: name);
  return list.isNotEmpty ? list.first : null;
});

final favoritePokemonListProvider = FutureProvider<List<PokemonListItem>>((ref) async {
  final repository = ref.watch(repositoryProvider);
  final favorites = ref.watch(favoritesProvider).value ?? <String>{};
  if (favorites.isEmpty) return [];
  final items = <PokemonListItem>[];
  for (final name in favorites) {
    final item = await repository.getPokemonListItem(name);
    if (item != null) items.add(item);
  }
  items.sort((a, b) => a.id.compareTo(b.id));
  return items;
});

const _pageSize = 10;

final paginatedPokemonListProvider =
    NotifierProvider<PaginatedPokemonList, PokemonListState>(
  PaginatedPokemonList.new,
);

class PaginatedPokemonList extends Notifier<PokemonListState> {
  @override
  PokemonListState build() => PokemonListState.initial();

  PokemonRepository get _repository => ref.read(repositoryProvider);

  Future<void> loadInitial() async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final items = await _repository.getPokemonList(
        offset: 0,
        limit: _pageSize,
      );
      state = state.copyWith(
        items: items,
        isLoading: false,
        hasMore: items.length >= _pageSize,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: e,
      );
    }
  }

  Future<void> loadMore() async {
    if (state.isLoadingMore || !state.hasMore || state.items.isEmpty) return;
    if (state.isSearchActive) return;

    state = state.copyWith(isLoadingMore: true, error: null);
    try {
      final newItems = await _repository.getPokemonList(
        offset: state.items.length,
        limit: _pageSize,
      );
      state = state.copyWith(
        items: [...state.items, ...newItems],
        isLoadingMore: false,
        hasMore: newItems.length >= _pageSize,
      );
    } catch (e) {
      state = state.copyWith(
        isLoadingMore: false,
        error: e,
      );
    }
  }

  void setSearchQuery(String query) {
    state = state.copyWith(searchQuery: query);
    if (query.trim().isEmpty) {
      state = state.copyWith(searchResults: [], isSearching: false);
    }
  }

  Future<void> search(String query) async {
    if (query.trim().isEmpty) {
      state = state.copyWith(searchResults: [], isSearching: false);
      return;
    }

    state = state.copyWith(isSearching: true, error: null);
    try {
      final results = await _repository.searchPokemonByName(query);
      state = state.copyWith(
        searchResults: results,
        isSearching: false,
      );
    } catch (e) {
      state = state.copyWith(
        isSearching: false,
        error: e,
      );
    }
  }

  void setSelectedTypes(Set<String> types) {
    state = state.copyWith(selectedTypes: types);
  }

  void clearTypeFilter() {
    state = state.copyWith(selectedTypes: {});
  }
}
