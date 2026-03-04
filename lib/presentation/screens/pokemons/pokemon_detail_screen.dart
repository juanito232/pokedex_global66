import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pokedex_global66/config/providers/providers.dart';
import '../../../../l10n/app_localizations.dart';
import 'package:pokedex_global66/presentation/widgets/common/message_content.dart';
import 'package:pokedex_global66/presentation/widgets/pokemon/pokemon_detail_content.dart';
import 'package:pokedex_global66/presentation/widgets/pokemon/pokemon_detail_header.dart';
import 'package:pokedex_global66/presentation/widgets/pokemon/pokemon_loader.dart';

class PokemonDetailScreen extends ConsumerWidget {
  const PokemonDetailScreen({super.key, required this.pokemonName});

  static const path = '/pokemon/:name';
  static const routeName = 'pokemon-detail';

  final String pokemonName;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncPokemon = ref.watch(pokemonDetailProvider(pokemonName));

    return Scaffold(
      body: asyncPokemon.when(
        data: (pokemon) {
          if (pokemon == null) {
            return Center(
              child: Text(AppLocalizations.of(context)!.pokemonNotFound),
            );
          }
          return CustomScrollView(
            slivers: [
              PokemonDetailHeader(pokemon: pokemon),
              SliverToBoxAdapter(child: PokemonDetailContent(pokemon: pokemon)),
            ],
          );
        },
        loading: () => const Center(child: PokemonLoader()),
        error: (e, _) => MessageContent(
          buttonText: AppLocalizations.of(context)!.retry,
          onButtonPressed: () =>
              ref.invalidate(pokemonDetailProvider(pokemonName)),
        ),
      ),
    );
  }
}
