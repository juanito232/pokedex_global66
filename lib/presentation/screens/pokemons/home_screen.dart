import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pokedex_global66/config/providers/providers.dart';
import '../../../../l10n/app_localizations.dart';
import 'package:pokedex_global66/presentation/widgets/widgets.dart';

class HomeScreen extends ConsumerStatefulWidget {
  static const name = 'home-screen';

  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  final _scrollController = ScrollController();
  final _searchController = TextEditingController();
  Timer? _searchDebounce;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final state = ref.read(paginatedPokemonListProvider);
      if (state.items.isEmpty && !state.isLoading) {
        ref.read(paginatedPokemonListProvider.notifier).loadInitial();
      }
    });
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _searchDebounce?.cancel();
    _searchController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    final state = ref.read(paginatedPokemonListProvider);
    if (!state.hasMore || state.isLoadingMore || state.isSearchActive) return;

    final position = _scrollController.position;
    if (position.pixels >= position.maxScrollExtent - 200) {
      ref.read(paginatedPokemonListProvider.notifier).loadMore();
    }
  }

  void _onFilterTap() {
    final state = ref.read(paginatedPokemonListProvider);
    showPokemonFilterSheet(
      context,
      initialSelectedTypes: state.selectedTypes,
      onApply: (types) {
        ref.read(paginatedPokemonListProvider.notifier).setSelectedTypes(types);
      },
    );
  }

  void _onSearchChanged(String query) {
    ref.read(paginatedPokemonListProvider.notifier).setSearchQuery(query);

    _searchDebounce?.cancel();
    if (query.trim().isEmpty) return;

    _searchDebounce = Timer(const Duration(milliseconds: 400), () {
      ref.read(paginatedPokemonListProvider.notifier).search(query);
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(paginatedPokemonListProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.appTitle),
        centerTitle: true,
      ),
      body: Column(
        children: [
          PokemonSearchBar(
            controller: _searchController,
            onChanged: _onSearchChanged,
            hintText: AppLocalizations.of(context)!.searchPlaceholder,
            trailing: Container(
              padding: const EdgeInsets.all(3),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: Badge(
                isLabelVisible: state.isTypeFilterActive,
                child: IconButton(
                  icon: const Icon(Icons.filter_list),
                  onPressed: _onFilterTap,
                ),
              ),
            ),
          ),
          if (state.isTypeFilterActive)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Row(
                children: [
                  Text(
                    AppLocalizations.of(
                      context,
                    )!.resultsFound(state.displayItems.length),
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Colors.grey[600],
                    ),
                  ),
                  const SizedBox(width: 8),
                  GestureDetector(
                    onTap: () => ref
                        .read(paginatedPokemonListProvider.notifier)
                        .clearTypeFilter(),
                    child: Text(
                      AppLocalizations.of(context)!.clearFilter,
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: Theme.of(context).colorScheme.primary,
                        decoration: TextDecoration.underline,
                        decorationColor: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          Expanded(
            child: PokemonListContent(
              state: state,
              scrollController: _scrollController,
              onRetry: () =>
                  ref.read(paginatedPokemonListProvider.notifier).loadInitial(),
            ),
          ),
        ],
      ),
    );
  }
}
