import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:pokedex_global66/config/providers/favorites_provider.dart';
import 'package:pokedex_global66/domain/entities/pokemon.dart';
import 'package:pokedex_global66/utils/clippers.dart';
import 'package:pokedex_global66/utils/helpers.dart';

class PokemonDetailHeader extends ConsumerWidget {
  const PokemonDetailHeader({super.key, required this.pokemon});

  final Pokemon pokemon;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final primaryType = pokemon.types.isNotEmpty ? pokemon.types.first : '';
    final headerColor = Helpers.colorForType(primaryType);
    final typeAssetPath = Helpers.imagePathForType(primaryType);
    final isFavorite =
        ref
            .watch(favoritesProvider)
            .value
            ?.contains(pokemon.name.toLowerCase()) ??
        false;
    final colorScheme = Theme.of(context).colorScheme;
    final iconColor = colorScheme.onSurface;

    return SliverAppBar(
      expandedHeight: 300,
      pinned: true,
      backgroundColor: colorScheme.surface,
      leading: IconButton(
        icon: Icon(Icons.arrow_back_ios_new, color: iconColor),
        onPressed: () => context.pop(),
      ),
      actions: [
        IconButton(
          icon: Icon(
            isFavorite ? Icons.favorite_rounded : Icons.favorite_border,
            color: isFavorite ? colorScheme.error : iconColor,
          ),
          onPressed: () {
            ref.read(favoritesProvider.notifier).toggle(pokemon.name);
          },
        ),
      ],
      flexibleSpace: FlexibleSpaceBar(
        background: Stack(
          fit: StackFit.expand,
          children: [
            ClipPath(
              clipper: HeaderClipper(),
              child: Container(color: headerColor.withValues(alpha: 0.5)),
            ),
            if (typeAssetPath != null)
              Positioned(
                right: 80,
                left: 80,
                top: 50,
                bottom: 60,
                child: Opacity(
                  opacity: 0.3,
                  child: SvgPicture.asset(
                    typeAssetPath,
                    width: 200,
                    height: 200,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: pokemon.imageUrl.isNotEmpty
                  ? Image.network(
                      pokemon.imageUrl,
                      height: 300,
                      width: 300,
                      fit: BoxFit.contain,
                      filterQuality: FilterQuality.none,
                      errorBuilder: (_, error, stackTrace) =>
                          const Icon(Icons.pest_control, size: 80),
                    )
                  : const Icon(Icons.pest_control, size: 80),
            ),
          ],
        ),
      ),
    );
  }
}
