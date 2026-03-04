import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../l10n/app_localizations.dart';
import 'package:pokedex_global66/utils/helpers.dart';

String _typeDisplayName(AppLocalizations l10n, String type) {
  switch (type.toLowerCase()) {
    case 'bug':
      return l10n.typeBug;
    case 'dark':
      return l10n.typeDark;
    case 'dragon':
      return l10n.typeDragon;
    case 'electric':
      return l10n.typeElectric;
    case 'fairy':
      return l10n.typeFairy;
    case 'fighting':
      return l10n.typeFighting;
    case 'fire':
      return l10n.typeFire;
    case 'flying':
      return l10n.typeFlying;
    case 'ghost':
      return l10n.typeGhost;
    case 'grass':
      return l10n.typeGrass;
    case 'ground':
      return l10n.typeGround;
    case 'ice':
      return l10n.typeIce;
    case 'normal':
      return l10n.typeNormal;
    case 'poison':
      return l10n.typePoison;
    case 'psychic':
      return l10n.typePsychic;
    case 'rock':
      return l10n.typeRock;
    case 'steel':
      return l10n.typeSteel;
    case 'water':
      return l10n.typeWater;
    default:
      return Helpers.capitalize(type);
  }
}

const _filterTypeOrder = [
  'water',
  'dragon',
  'electric',
  'fairy',
  'ghost',
  'fire',
  'bug',
  'dark',
  'fighting',
  'flying',
  'grass',
  'ground',
  'ice',
  'normal',
  'poison',
  'psychic',
  'rock',
  'steel',
];

void showPokemonFilterSheet(
  BuildContext context, {
  required Set<String> initialSelectedTypes,
  required void Function(Set<String>) onApply,
}) {
  showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (context) => PokemonFilterSheet(
      initialSelectedTypes: initialSelectedTypes,
      onApply: onApply,
    ),
  );
}

class PokemonFilterSheet extends StatefulWidget {
  const PokemonFilterSheet({
    super.key,
    required this.initialSelectedTypes,
    required this.onApply,
  });

  final Set<String> initialSelectedTypes;
  final void Function(Set<String> selectedTypes) onApply;

  @override
  State<PokemonFilterSheet> createState() => _PokemonFilterSheetState();
}

class _PokemonFilterSheetState extends State<PokemonFilterSheet> {
  late Set<String> _selectedTypes;

  @override
  void initState() {
    super.initState();
    _selectedTypes = Set.from(widget.initialSelectedTypes);
  }

  void _toggleType(String type) {
    setState(() {
      if (_selectedTypes.contains(type)) {
        _selectedTypes.remove(type);
      } else {
        _selectedTypes.add(type);
      }
    });
  }

  void _onApply() {
    widget.onApply(_selectedTypes);
    if (mounted) Navigator.of(context).pop();
  }

  void _onCancel() {
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(36)),
      ),
      child: SafeArea(
        top: false,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () => Navigator.of(context).pop(),
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                  ),
                  const Expanded(child: SizedBox()),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Text(
                AppLocalizations.of(context)!.filterTitle,
                style: TextStyle(
                  fontSize: Theme.of(context).textTheme.headlineSmall?.fontSize,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 24),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      AppLocalizations.of(context)!.typeLabel,
                      style: TextStyle(
                        fontSize: Theme.of(
                          context,
                        ).textTheme.titleMedium?.fontSize,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Icon(Icons.keyboard_arrow_up, color: Colors.grey[600]),
                ],
              ),
            ),
            const SizedBox(height: 12),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxHeight: 320),
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: _filterTypeOrder.length,
                  itemBuilder: (context, index) {
                    final type = _filterTypeOrder[index];
                    final isSelected = _selectedTypes.contains(type);
                    final l10n = AppLocalizations.of(context)!;
                    final displayName = _typeDisplayName(l10n, type);
                    final assetPath = Helpers.imagePathForType(type);

                    return CheckboxListTile(
                      value: isSelected,
                      onChanged: (_) => _toggleType(type),
                      title: Row(
                        children: [
                          if (assetPath != null) ...[
                            Container(
                              height: 24,
                              width: 24,
                              padding: const EdgeInsets.all(4),
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.white,
                              ),
                              child: SvgPicture.asset(assetPath),
                            ),
                            const SizedBox(width: 12),
                          ],
                          Text(
                            displayName,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                      controlAffinity: ListTileControlAffinity.trailing,
                      activeColor: Theme.of(context).colorScheme.primary,
                    );
                  },
                ),
              ),
            ),
            const SizedBox(height: 32),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                children: [
                  SizedBox(
                    width: double.infinity,
                    child: FilledButton(
                      onPressed: _onApply,
                      style: FilledButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                      ),
                      child: Text(AppLocalizations.of(context)!.apply),
                    ),
                  ),
                  const SizedBox(height: 12),
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton(
                      onPressed: _onCancel,
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        backgroundColor: Colors.grey[100],
                        foregroundColor: Colors.grey[700],
                      ),
                      child: Text(AppLocalizations.of(context)!.cancel),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}
