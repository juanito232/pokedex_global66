import 'package:flutter/material.dart';
import 'package:pokedex_global66/domain/entities/pokemon.dart';
import '../../../../l10n/app_localizations.dart';
import 'package:pokedex_global66/utils/helpers.dart';
import 'package:pokedex_global66/presentation/widgets/pokemon/type_chip.dart';
import 'package:pokedex_global66/presentation/widgets/pokemon/pokemon_info_card.dart';
import 'package:pokedex_global66/presentation/widgets/pokemon/pokemon_gender_bar.dart';

class PokemonDetailContent extends StatelessWidget {
  const PokemonDetailContent({super.key, required this.pokemon});

  final Pokemon pokemon;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            Helpers.capitalize(pokemon.name),
            style: Theme.of(
              context,
            ).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 4),
          Text(
            AppLocalizations.of(
              context,
            )!.pokemonNumber(pokemon.id.toString().padLeft(3, '0')),
            style: Theme.of(
              context,
            ).textTheme.titleMedium?.copyWith(color: Colors.grey.shade600),
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 6,
            children: pokemon.types
                .map((t) => TypeChip(pokemonType: t))
                .toList(),
          ),
          if (pokemon.description.isNotEmpty) ...[
            const SizedBox(height: 20),
            Text(
              pokemon.description,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ],
          const Divider(),
          GridView.count(
            crossAxisCount: 2,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            mainAxisSpacing: 20,
            crossAxisSpacing: 20,
            childAspectRatio: 2,
            children: [
              PokemonInfoCard(
                label: AppLocalizations.of(context)!.weightLabel,
                value: '${pokemon.weight / 10} kg',
                icon: Icons.monitor_weight_outlined,
              ),
              PokemonInfoCard(
                label: AppLocalizations.of(context)!.heightLabel,
                value: '${pokemon.height / 10} m',
                icon: Icons.straighten_outlined,
              ),
              PokemonInfoCard(
                label: AppLocalizations.of(context)!.categoryLabel,
                value: pokemon.category.isNotEmpty
                    ? Helpers.capitalize(pokemon.category)
                    : '-',
                icon: Icons.category_outlined,
              ),
              PokemonInfoCard(
                label: AppLocalizations.of(context)!.abilityLabel,
                value: pokemon.abilities.isNotEmpty
                    ? Helpers.capitalize(pokemon.abilities.first)
                    : '-',
                icon: Icons.psychology_outlined,
              ),
            ],
          ),
          if (pokemon.genderRate >= 0) ...[
            Center(
              child: Text(
                AppLocalizations.of(context)!.genderLabel,
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Colors.grey.shade700,
                ),
              ),
            ),
            const SizedBox(height: 8),
            PokemonGenderBar(genderRate: pokemon.genderRate),
          ],
          if (pokemon.weaknesses.isNotEmpty) ...[
            const SizedBox(height: 24),
            Text(
              AppLocalizations.of(context)!.weaknessesLabel,
              style: Theme.of(
                context,
              ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: pokemon.weaknesses
                  .map((w) => TypeChip(pokemonType: w))
                  .toList(),
            ),
          ],
          const SizedBox(height: 32),
        ],
      ),
    );
  }
}
