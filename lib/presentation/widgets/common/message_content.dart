import 'package:flutter/material.dart';
import '../../../../l10n/app_localizations.dart';

class MessageContent extends StatelessWidget {
  const MessageContent({
    super.key,
    this.imagePath = 'assets/images/magikarp.png',
    this.title,
    this.subtitle,
    this.buttonText,
    this.onButtonPressed,
  });

  final String imagePath;
  final String? title;
  final String? subtitle;
  final String? buttonText;
  final VoidCallback? onButtonPressed;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context)!;
    final displayTitle = title ?? l10n.errorTitle;
    final displaySubtitle = subtitle ?? l10n.errorSubtitle;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: 24),
          Image.asset(imagePath, fit: BoxFit.contain, height: 220, width: 220),
          const SizedBox(height: 32),
          Text(
            displayTitle,
            style: theme.textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.bold,
              color: const Color(0xFF333333),
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          Text(
            displaySubtitle,
            style: theme.textTheme.bodyLarge?.copyWith(
              color: const Color(0xFF757575),
            ),
            textAlign: TextAlign.center,
          ),
          if (buttonText != null && onButtonPressed != null) ...[
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: FilledButton(
                onPressed: onButtonPressed,
                style: FilledButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Text(buttonText!),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
