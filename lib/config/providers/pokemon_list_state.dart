import 'package:pokedex_global66/domain/entities/pokemon_list_item.dart';

class PokemonListState {
  const PokemonListState({
    this.items = const [],
    this.isLoading = false,
    this.isLoadingMore = false,
    this.error,
    this.hasMore = true,
    this.searchQuery = '',
    this.searchResults = const [],
    this.isSearching = false,
    this.selectedTypes = const {},
  });

  final List<PokemonListItem> items;
  final bool isLoading;
  final bool isLoadingMore;
  final Object? error;
  final bool hasMore;
  final String searchQuery;
  final List<PokemonListItem> searchResults;
  final bool isSearching;
  final Set<String> selectedTypes;

  bool get isSearchActive => searchQuery.trim().isNotEmpty;

  bool get isTypeFilterActive => selectedTypes.isNotEmpty;

  List<PokemonListItem> get displayItems {
    final source = isSearchActive ? searchResults : items;
    if (!isTypeFilterActive) return source;
    return source
        .where((p) => p.types.any((t) => selectedTypes.contains(t.toLowerCase())))
        .toList();
  }

  PokemonListState copyWith({
    List<PokemonListItem>? items,
    bool? isLoading,
    bool? isLoadingMore,
    Object? error,
    bool? hasMore,
    String? searchQuery,
    List<PokemonListItem>? searchResults,
    bool? isSearching,
    Set<String>? selectedTypes,
  }) {
    return PokemonListState(
      items: items ?? this.items,
      isLoading: isLoading ?? this.isLoading,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      error: error,
      hasMore: hasMore ?? this.hasMore,
      searchQuery: searchQuery ?? this.searchQuery,
      searchResults: searchResults ?? this.searchResults,
      isSearching: isSearching ?? this.isSearching,
      selectedTypes: selectedTypes ?? this.selectedTypes,
    );
  }

  static PokemonListState initial() => const PokemonListState();
}
