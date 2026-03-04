import 'package:pokedex_global66/domain/entities/pokemon.dart';
import 'package:pokedex_global66/domain/entities/pokemon_list_item.dart';

abstract class PokemonRepository {
  Future<List<PokemonListItem>> getPokemonList({int offset = 0, int limit = 10});

  Future<List<PokemonListItem>> searchPokemonByName(String query);

  Future<List<Pokemon>> getPokemonDetails({String name = ''});

  Future<List<Pokemon>> getPokemonSpecies({String name = ''});

  Future<PokemonListItem?> getPokemonListItem(String name);
}
