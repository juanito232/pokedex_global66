import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:pokedex_global66/config/preferences/onboarding_preferences.dart';
import 'package:pokedex_global66/config/router/app_router.dart';
import 'package:pokedex_global66/config/theme/app_theme.dart';
import 'package:pokedex_global66/l10n/app_localizations.dart';
import 'package:pokedex_global66/presentation/screens/screens.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final onboardingSeen = await isOnboardingSeen();
  final router = createAppRouter(
    initialLocation: onboardingSeen ? '/' : OnboardingScreen.path,
  );
  runApp(ProviderScope(child: MyApp(router: router)));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.router});

  final GoRouter router;

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: router,
      debugShowCheckedModeBanner: false,
      title: 'Pokédex',
      theme: AppTheme().getTheme(),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
    );
  }
}
