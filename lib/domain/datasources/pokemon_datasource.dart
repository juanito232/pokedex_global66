import 'package:pokedex_global66/domain/entities/pokemon_list_entry.dart';

abstract class PokemonDatasource {
  Future<List<PokemonListEntry>> getPokemonList({
    int offset = 0,
    int limit = 20,
  });

  Future<Map<String, dynamic>> getPokemonDetails(String name);

  Future<Map<String, dynamic>> getPokemonSpecies(String name);

  Future<Map<String, dynamic>> getTypeDetails(String typeName);
}
