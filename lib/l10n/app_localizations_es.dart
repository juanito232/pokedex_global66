// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get appTitle => 'Pokédex';

  @override
  String get retry => 'Reintentar';

  @override
  String get searchNoResults => 'Sin resultados en la búsqueda';

  @override
  String get filterNoResults => 'Sin Pokémon con ese filtro';

  @override
  String get noPokemonFound => 'No se encontraron Pokémon';

  @override
  String get searchNoResultsSubtitle =>
      'Prueba con otro nombre o término de búsqueda.';

  @override
  String get filterNoResultsSubtitle =>
      'Cambia los tipos seleccionados para ver más resultados.';

  @override
  String get noPokemonSubtitle => 'No hay Pokémon disponibles en este momento.';

  @override
  String resultsFound(int count) {
    return '$count resultados encontrados';
  }

  @override
  String get clearFilter => 'Limpiar filtro';

  @override
  String get searchPlaceholder => 'Buscar Pokémon...';

  @override
  String get filterTitle => 'Filtra por tus preferencias';

  @override
  String get typeLabel => 'Tipo';

  @override
  String get apply => 'Aplicar';

  @override
  String get cancel => 'Cancelar';

  @override
  String get navPokedex => 'Pokedex';

  @override
  String get navRegions => 'Regiones';

  @override
  String get navFavorites => 'Favoritos';

  @override
  String get navProfile => 'Perfil';

  @override
  String get favoritesEmptyTitle =>
      'No has marcado ningún Pokémon como favorito';

  @override
  String get favoritesEmptySubtitle =>
      'Haz clic en el ícono de corazón de tus Pokémon favoritos y aparecerán aquí.';

  @override
  String get placeholderTitle => '¡Muy pronto disponible!';

  @override
  String get placeholderSubtitle =>
      'Estamos trabajando para traerte esta sección. Vuelve más adelante para descubrir todas las novedades.';

  @override
  String get onboardingTitle1 => 'Todos los Pokémon en un solo lugar';

  @override
  String get onboardingDesc1 =>
      'Accede a una amplia lista de Pokémon de todas las generaciones creadas por Nintendo';

  @override
  String get onboardingButtonContinue => 'Continuar';

  @override
  String get onboardingTitle2 => 'Mantén tu Pokédex actualizada';

  @override
  String get onboardingDesc2 =>
      'Regístrate y guarda tu perfil, Pokémon favoritos, configuraciones y mucho más en la aplicación';

  @override
  String get onboardingButtonStart => 'Empecemos';

  @override
  String get pokemonNotFound => 'Pokémon no encontrado';

  @override
  String get errorTitle => 'Algo salió mal...';

  @override
  String get errorSubtitle =>
      'No pudimos cargar la información en este momento. Verifica tu conexión o intenta nuevamente más tarde.';

  @override
  String get weightLabel => 'PESO';

  @override
  String get heightLabel => 'ALTURA';

  @override
  String get categoryLabel => 'CATEGORÍA';

  @override
  String get abilityLabel => 'HABILIDAD';

  @override
  String get abilityLabelPlural => 'HABILIDADES';

  @override
  String get genderLabel => 'GÉNERO';

  @override
  String get weaknessesLabel => 'Debilidades';

  @override
  String pokemonNumber(String number) {
    return 'N°$number';
  }

  @override
  String get typeBug => 'Bicho';

  @override
  String get typeDark => 'Siniestro';

  @override
  String get typeDragon => 'Dragón';

  @override
  String get typeElectric => 'Eléctrico';

  @override
  String get typeFairy => 'Hada';

  @override
  String get typeFighting => 'Lucha';

  @override
  String get typeFire => 'Fuego';

  @override
  String get typeFlying => 'Volador';

  @override
  String get typeGhost => 'Fantasma';

  @override
  String get typeGrass => 'Planta';

  @override
  String get typeGround => 'Tierra';

  @override
  String get typeIce => 'Hielo';

  @override
  String get typeNormal => 'Normal';

  @override
  String get typePoison => 'Veneno';

  @override
  String get typePsychic => 'Psíquico';

  @override
  String get typeRock => 'Roca';

  @override
  String get typeSteel => 'Acero';

  @override
  String get typeWater => 'Agua';
}
