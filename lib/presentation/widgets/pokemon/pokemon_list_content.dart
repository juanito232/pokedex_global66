import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:pokedex_global66/config/providers/favorites_provider.dart';
import 'package:pokedex_global66/config/providers/pokemon_list_state.dart';
import '../../../../l10n/app_localizations.dart';
import 'package:pokedex_global66/presentation/widgets/common/message_content.dart';
import 'package:pokedex_global66/presentation/widgets/pokemon/pokemon_card.dart';
import 'package:pokedex_global66/presentation/widgets/pokemon/pokemon_loader.dart';

class PokemonListContent extends ConsumerWidget {
  const PokemonListContent({
    super.key,
    required this.state,
    required this.scrollController,
    required this.onRetry,
  });

  final PokemonListState state;
  final ScrollController scrollController;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(favoritesProvider);
    final displayItems = state.displayItems;
    final showPagination =
        !state.isSearchActive && state.hasMore && state.isLoadingMore;

    if (state.isSearching || (state.isLoading && state.items.isEmpty)) {
      return const Center(child: PokemonLoader());
    }

    if (state.error != null && displayItems.isEmpty) {
      return MessageContent(
        buttonText: AppLocalizations.of(context)!.retry,
        onButtonPressed: onRetry,
      );
    }

    if (displayItems.isEmpty) {
      final l10n = AppLocalizations.of(context)!;
      final isSearch = state.isSearchActive;
      final isFilter = state.isTypeFilterActive;
      return MessageContent(
        title: isSearch
            ? l10n.searchNoResults
            : isFilter
            ? l10n.filterNoResults
            : l10n.noPokemonFound,
        subtitle: isSearch
            ? l10n.searchNoResultsSubtitle
            : isFilter
            ? l10n.filterNoResultsSubtitle
            : l10n.noPokemonSubtitle,
      );
    }

    return ListView.builder(
      controller: scrollController,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      itemCount: displayItems.length + (showPagination ? 1 : 0),
      itemBuilder: (context, index) {
        if (index >= displayItems.length) {
          return const Padding(
            padding: EdgeInsets.symmetric(vertical: 24),
            child: Center(child: PokemonLoader()),
          );
        }
        final pokemon = displayItems[index];
        final favoritesNotifier = ref.read(favoritesProvider.notifier);
        final isFavorite = favoritesNotifier.isFavorite(pokemon.name);
        return PokemonCard(
          pokemon: pokemon,
          isFavorite: isFavorite,
          onTap: () => context.push('/pokemon/${pokemon.name}'),
          onFavoriteTap: () => favoritesNotifier.toggle(pokemon.name),
        );
      },
    );
  }
}
