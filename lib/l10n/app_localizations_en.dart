// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Pokédex';

  @override
  String get retry => 'Retry';

  @override
  String get searchNoResults => 'No search results';

  @override
  String get filterNoResults => 'No Pokémon with that filter';

  @override
  String get noPokemonFound => 'No Pokémon found';

  @override
  String get searchNoResultsSubtitle => 'Try another name or search term.';

  @override
  String get filterNoResultsSubtitle =>
      'Change the selected types to see more results.';

  @override
  String get noPokemonSubtitle => 'No Pokémon available at this time.';

  @override
  String resultsFound(int count) {
    return '$count results found';
  }

  @override
  String get clearFilter => 'Clear filter';

  @override
  String get searchPlaceholder => 'Search Pokémon...';

  @override
  String get filterTitle => 'Filter by your preferences';

  @override
  String get typeLabel => 'Type';

  @override
  String get apply => 'Apply';

  @override
  String get cancel => 'Cancel';

  @override
  String get navPokedex => 'Pokedex';

  @override
  String get navRegions => 'Regions';

  @override
  String get navFavorites => 'Favorites';

  @override
  String get navProfile => 'Profile';

  @override
  String get favoritesEmptyTitle =>
      'You haven\'t marked any Pokémon as favorite';

  @override
  String get favoritesEmptySubtitle =>
      'Tap the heart icon on your favorite Pokémon and they will appear here.';

  @override
  String get placeholderTitle => 'Coming soon!';

  @override
  String get placeholderSubtitle =>
      'We\'re working to bring you this section. Come back later to discover all the new features.';

  @override
  String get onboardingTitle1 => 'All Pokémon in one place';

  @override
  String get onboardingDesc1 =>
      'Access a wide list of Pokémon from all generations created by Nintendo';

  @override
  String get onboardingButtonContinue => 'Continue';

  @override
  String get onboardingTitle2 => 'Keep your Pokédex updated';

  @override
  String get onboardingDesc2 =>
      'Sign up and save your profile, favorite Pokémon, settings and much more in the app';

  @override
  String get onboardingButtonStart => 'Let\'s get started';

  @override
  String get pokemonNotFound => 'Pokémon not found';

  @override
  String get errorTitle => 'Something went wrong...';

  @override
  String get errorSubtitle =>
      'We couldn\'t load the information right now. Check your connection or try again later.';

  @override
  String get weightLabel => 'WEIGHT';

  @override
  String get heightLabel => 'HEIGHT';

  @override
  String get categoryLabel => 'CATEGORY';

  @override
  String get abilityLabel => 'ABILITY';

  @override
  String get abilityLabelPlural => 'ABILITIES';

  @override
  String get genderLabel => 'GENDER';

  @override
  String get weaknessesLabel => 'Weaknesses';

  @override
  String pokemonNumber(String number) {
    return 'No. $number';
  }

  @override
  String get typeBug => 'Bug';

  @override
  String get typeDark => 'Dark';

  @override
  String get typeDragon => 'Dragon';

  @override
  String get typeElectric => 'Electric';

  @override
  String get typeFairy => 'Fairy';

  @override
  String get typeFighting => 'Fighting';

  @override
  String get typeFire => 'Fire';

  @override
  String get typeFlying => 'Flying';

  @override
  String get typeGhost => 'Ghost';

  @override
  String get typeGrass => 'Grass';

  @override
  String get typeGround => 'Ground';

  @override
  String get typeIce => 'Ice';

  @override
  String get typeNormal => 'Normal';

  @override
  String get typePoison => 'Poison';

  @override
  String get typePsychic => 'Psychic';

  @override
  String get typeRock => 'Rock';

  @override
  String get typeSteel => 'Steel';

  @override
  String get typeWater => 'Water';
}
