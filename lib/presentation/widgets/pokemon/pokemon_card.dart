import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pokedex_global66/domain/entities/pokemon_list_item.dart';
import '../../../../l10n/app_localizations.dart';
import 'package:pokedex_global66/utils/helpers.dart';
import 'package:pokedex_global66/presentation/widgets/pokemon/type_chip.dart';

class PokemonCard extends StatelessWidget {
  const PokemonCard({
    super.key,
    required this.pokemon,
    this.onTap,
    this.isFavorite = false,
    this.onFavoriteTap,
  });

  final PokemonListItem pokemon;
  final VoidCallback? onTap;
  final bool isFavorite;
  final VoidCallback? onFavoriteTap;

  @override
  Widget build(BuildContext context) {
    final primaryType = pokemon.types.isNotEmpty ? pokemon.types.first : '';
    final cardColor = Helpers.colorForType(primaryType);
    final typeAssetPath = Helpers.imagePathForType(primaryType);

    return FadeIn(
      duration: const Duration(milliseconds: 300),
      child: Card(
        margin: const EdgeInsets.only(bottom: 12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: onTap,
          child: Container(
            decoration: BoxDecoration(
              color: cardColor.withValues(alpha: 0.5),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              children: [
                Expanded(
                  flex: 3,
                  child: Padding(
                    padding: const EdgeInsets.only(
                      left: 16,
                      top: 16,
                      bottom: 16,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          AppLocalizations.of(context)!.pokemonNumber(
                            pokemon.id.toString().padLeft(3, '0'),
                          ),
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          Helpers.capitalize(pokemon.name),
                          style: Theme.of(context).textTheme.headlineSmall
                              ?.copyWith(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 8),
                        Wrap(
                          spacing: 6,
                          runSpacing: 4,
                          children: pokemon.types
                              .map((type) => TypeChip(pokemonType: type))
                              .toList(),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: cardColor,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    height: 140,
                    child: Stack(
                      clipBehavior: Clip.none,
                      alignment: Alignment.center,
                      children: [
                        if (typeAssetPath != null)
                          Positioned(
                            bottom: -20,
                            child: ShaderMask(
                              shaderCallback: (rect) => LinearGradient(
                                colors: [
                                  cardColor.withValues(alpha: 0.1),
                                  cardColor.withValues(alpha: 0.7),
                                ],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ).createShader(rect),
                              child: SvgPicture.asset(
                                typeAssetPath,
                                width: 120,
                                height: 140,
                                fit: BoxFit.contain,
                                alignment: Alignment.bottomLeft,
                              ),
                            ),
                          ),
                        Center(
                          child: pokemon.imageUrl.isNotEmpty
                              ? Image.network(
                                  pokemon.imageUrl,
                                  height: 150,
                                  width: 150,
                                  fit: BoxFit.contain,
                                  filterQuality: FilterQuality.none,
                                  errorBuilder: (context, error, stackTrace) =>
                                      const Icon(
                                        Icons.image_not_supported,
                                        size: 48,
                                      ),
                                )
                              : const Icon(Icons.pest_control, size: 48),
                        ),
                        if (onFavoriteTap != null)
                          Positioned(
                            top: 0,
                            right: 0,
                            child: Builder(
                              builder: (context) {
                                final colorScheme =
                                    Theme.of(context).colorScheme;
                                return Material(
                                  color: colorScheme.surface
                                      .withValues(alpha: 0.9),
                                  shape: const CircleBorder(),
                                  elevation: 2,
                                  child: InkWell(
                                    onTap: onFavoriteTap,
                                    customBorder: const CircleBorder(),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8),
                                      child: Icon(
                                        isFavorite
                                            ? Icons.favorite_rounded
                                            : Icons.favorite_border,
                                        size: 20,
                                        color: isFavorite
                                            ? colorScheme.error
                                            : colorScheme.onSurfaceVariant,
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
