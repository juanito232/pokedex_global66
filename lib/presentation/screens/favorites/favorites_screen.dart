import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:pokedex_global66/config/providers/favorites_provider.dart';
import 'package:pokedex_global66/config/providers/providers.dart';
import 'package:pokedex_global66/l10n/app_localizations.dart';
import 'package:pokedex_global66/presentation/widgets/common/message_content.dart';
import 'package:pokedex_global66/presentation/widgets/pokemon/pokemon_card.dart';
import 'package:pokedex_global66/presentation/widgets/pokemon/pokemon_loader.dart';

class FavoritesScreen extends ConsumerWidget {
  const FavoritesScreen({super.key});

  static const path = '/favoritos';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favoritesAsync = ref.watch(favoritePokemonListProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.navFavorites),
        centerTitle: true,
      ),
      body: favoritesAsync.when(
        data: (items) {
          if (items.isEmpty) {
            final l10n = AppLocalizations.of(context)!;
            return MessageContent(
              title: l10n.favoritesEmptyTitle,
              subtitle: l10n.favoritesEmptySubtitle,
            );
          }
          return ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: items.length,
            itemBuilder: (context, index) => PokemonCard(
              pokemon: items[index],
              isFavorite: true,
              onTap: () => context.push('/pokemon/${items[index].name}'),
              onFavoriteTap: () {
                ref.read(favoritesProvider.notifier).toggle(items[index].name);
              },
            ),
          );
        },
        loading: () => const Center(child: PokemonLoader()),
        error: (e, _) => MessageContent(
          buttonText: AppLocalizations.of(context)!.retry,
          onButtonPressed: () => ref.invalidate(favoritePokemonListProvider),
        ),
      ),
    );
  }
}
