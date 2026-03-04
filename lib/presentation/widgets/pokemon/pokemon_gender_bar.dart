import 'package:flutter/material.dart';
import 'package:pokedex_global66/config/theme/app_theme.dart';

class PokemonGenderBar extends StatelessWidget {
  const PokemonGenderBar({super.key, required this.genderRate});

  /// gender_rate: chance of being female in eighths (0-8), -1 = genderless
  final int genderRate;

  @override
  Widget build(BuildContext context) {
    final femaleEighths = genderRate.clamp(0, 8);
    final femalePercent = (femaleEighths / 8) * 100;
    final malePercent = 100 - femalePercent;

    final maleFlex = ((malePercent * 100).round());
    final femaleFlex = ((femalePercent * 100).round());

    final labelColor = Theme.of(context).colorScheme.onSurfaceVariant;
    final labelStyle = Theme.of(context).textTheme.titleSmall?.copyWith(
          fontWeight: FontWeight.w600,
          color: labelColor,
        );

    return Column(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: SizedBox(
            height: 8,
            child: Row(
              children: [
                Expanded(
                  flex: maleFlex,
                  child: Container(
                    color: AppTheme.maleColor,
                    alignment: Alignment.center,
                  ),
                ),
                Expanded(
                  flex: femaleFlex,
                  child: Container(
                    color: AppTheme.femaleColor,
                    alignment: Alignment.center,
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 6),
        Row(
          children: [
            Expanded(
              child: Row(
                children: [
                  Icon(Icons.male, size: 18, color: labelColor),
                  const SizedBox(width: 4),
                  Text(
                    '${malePercent.toStringAsFixed(1)}%',
                    style: labelStyle,
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.female, size: 18, color: labelColor),
                const SizedBox(width: 4),
                Text(
                  '${femalePercent.toStringAsFixed(1)}%',
                  style: labelStyle,
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
