import 'package:flutter/material.dart';
import 'package:pokedex_global66/presentation/screens/tour/onboarding_page_data.dart';

class OnboardingPageContent extends StatelessWidget {
  const OnboardingPageContent({super.key, required this.page});

  final OnboardingPageData page;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        children: [
          const SizedBox(height: 24),
          if (page.imagePaths.length > 1) ...[
            Expanded(
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Positioned(
                    left: -50,
                    top: 0,
                    right: 50,
                    bottom: 0,
                    child: Image.asset(
                      page.imagePaths[0],
                      filterQuality: FilterQuality.none,
                      fit: BoxFit.contain,
                    ),
                  ),
                  Positioned(
                    left: 50,
                    top: 0,
                    right: -50,
                    bottom: 0,
                    child: Image.asset(
                      page.imagePaths[1],
                      filterQuality: FilterQuality.none,
                      fit: BoxFit.contain,
                    ),
                  ),
                ],
              ),
            ),
          ] else ...[
            Expanded(
              child: Image.asset(
                page.imagePaths[0],
                filterQuality: FilterQuality.none,
                fit: BoxFit.contain,
              ),
            ),
          ],
          const SizedBox(height: 32),
          Text(
            page.title,
            style: theme.textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.bold,
              color: theme.colorScheme.onSurface,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          Text(
            page.description,
            style: theme.textTheme.bodyLarge?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
