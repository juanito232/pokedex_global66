import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pokedex_global66/config/preferences/onboarding_preferences.dart';
import 'package:pokedex_global66/l10n/app_localizations.dart';
import 'package:pokedex_global66/presentation/widgets/widgets.dart';

class OnboardingScreen extends StatefulWidget {
  static const name = 'onboarding';
  static const path = '/onboarding';

  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final _pageController = PageController();
  int _currentPage = 0;

  List<OnboardingPageData> _buildPages(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return [
      OnboardingPageData(
        imagePath: 'assets/images/tour_1.png',
        title: l10n.onboardingTitle1,
        description: l10n.onboardingDesc1,
        buttonText: l10n.onboardingButtonContinue,
      ),
      OnboardingPageData(
        imagePath: 'assets/images/tour_2.png',
        title: l10n.onboardingTitle2,
        description: l10n.onboardingDesc2,
        buttonText: l10n.onboardingButtonStart,
      ),
    ];
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onButtonPressed() async {
    final pages = _buildPages(context);
    if (_currentPage < pages.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      await setOnboardingSeen();
      if (!mounted) return;
      context.go('/');
    }
  }

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).colorScheme.primary;
    final pages = _buildPages(context);

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                onPageChanged: (index) => setState(() => _currentPage = index),
                itemCount: pages.length,
                itemBuilder: (context, index) =>
                    OnboardingPageContent(page: pages[index]),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
              child: Column(
                children: [
                  OnboardingPageIndicator(
                    pageCount: pages.length,
                    currentPage: _currentPage,
                    activeColor: primaryColor,
                  ),
                  const SizedBox(height: 24),
                  OnboardingActionButton(
                    text: pages[_currentPage].buttonText,
                    onPressed: _onButtonPressed,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
