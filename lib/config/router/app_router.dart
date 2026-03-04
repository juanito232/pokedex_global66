import 'package:go_router/go_router.dart';
import 'package:pokedex_global66/presentation/screens/placeholders/placeholder_screen.dart';
import 'package:pokedex_global66/presentation/screens/screens.dart';
import 'package:pokedex_global66/presentation/widgets/shell/main_shell.dart';

GoRouter createAppRouter({required String initialLocation}) => GoRouter(
  initialLocation: initialLocation,
  routes: [
    GoRoute(
      path: OnboardingScreen.path,
      name: OnboardingScreen.name,
      builder: (context, state) => const OnboardingScreen(),
    ),
    ShellRoute(
      builder: (context, state, child) => MainShell(
        currentPath: state.uri.path,
        child: child,
      ),
      routes: [
        GoRoute(
          path: '/',
          name: HomeScreen.name,
          builder: (context, state) => const HomeScreen(),
        ),
        GoRoute(
          path: '/regiones',
          builder: (context, state) => const PlaceholderScreen(),
        ),
        GoRoute(
          path: '/favoritos',
          builder: (context, state) => const FavoritesScreen(),
        ),
        GoRoute(
          path: '/perfil',
          builder: (context, state) => const PlaceholderScreen(),
        ),
      ],
    ),
    GoRoute(
      path: '/pokemon/:name',
      name: PokemonDetailScreen.routeName,
      builder: (context, state) {
        final name = state.pathParameters['name'] ?? '';
        return PokemonDetailScreen(pokemonName: name);
      },
    ),
  ],
);
