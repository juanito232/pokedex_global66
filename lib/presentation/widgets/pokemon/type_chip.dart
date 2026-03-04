import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pokedex_global66/utils/helpers.dart';

class TypeChip extends StatelessWidget {
  const TypeChip({super.key, required this.pokemonType});

  final String pokemonType;

  @override
  Widget build(BuildContext context) {
    final color = Helpers.colorForType(pokemonType);
    final assetPath = Helpers.imagePathForType(pokemonType);
    final colorScheme = Theme.of(context).colorScheme;
    final textStyle = Theme.of(context).textTheme.labelMedium?.copyWith(
          fontWeight: FontWeight.w600,
        );

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.8),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (assetPath != null) ...[
            Container(
              height: 24,
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: colorScheme.surface,
              ),
              child: SvgPicture.asset(assetPath, width: 16, height: 16),
            ),
            const SizedBox(width: 6),
          ],
          Text(
            Helpers.capitalize(pokemonType),
            style: textStyle,
          ),
        ],
      ),
    );
  }
}
