import 'package:flutter/material.dart';
import '../../../../l10n/app_localizations.dart';
import 'package:pokedex_global66/presentation/widgets/common/message_content.dart';

class PlaceholderScreen extends StatelessWidget {
  const PlaceholderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return MessageContent(
      imagePath: 'assets/images/jigglypuff.png',
      title: l10n.placeholderTitle,
      subtitle: l10n.placeholderSubtitle,
    );
  }
}
