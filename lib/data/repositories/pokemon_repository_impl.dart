import 'package:pokedex_global66/domain/datasources/pokemon_datasource.dart';
import 'package:pokedex_global66/data/mappers/pokemon_mapper.dart';
import 'package:pokedex_global66/domain/entities/pokemon.dart';
import 'package:pokedex_global66/domain/entities/pokemon_list_item.dart';
import 'package:pokedex_global66/domain/repositories/pokemon_repository.dart';

class PokemonRepositoryImpl extends PokemonRepository {
  PokemonRepositoryImpl(this._datasource);

  final PokemonDatasource _datasource;

  @override
  Future<List<PokemonListItem>> getPokemonList({
    int offset = 0,
    int limit = 10,
  }) async {
    final entries = await _datasource.getPokemonList(
      offset: offset,
      limit: limit,
    );
    // /pokemon only returns name+url; fetch /pokemon/id for image and types
    final items = await Future.wait(
      entries.map((entry) async {
        final pokemonData = await _datasource.getPokemonDetails(entry.name);
        return PokemonMapper.toListItem(pokemonData);
      }),
    );
    return items;
  }

  @override
  Future<List<PokemonListItem>> searchPokemonByName(String query) async {
    if (query.trim().isEmpty) return [];

    final entries = await _datasource.getPokemonList(
      offset: 0,
      limit: 1500,
    );

    final queryLower = query.toLowerCase().trim();
    final matching =
        entries.where((e) => e.name.toLowerCase().contains(queryLower)).toList();

    if (matching.isEmpty) return [];

    final items = await Future.wait(
      matching.map((entry) async {
        final pokemonData = await _datasource.getPokemonDetails(entry.name);
        return PokemonMapper.toListItem(pokemonData);
      }),
    );
    return items;
  }

  @override
  Future<List<Pokemon>> getPokemonDetails({String name = ''}) async {
    if (name.isEmpty) return [];

    final pokemonData = await _datasource.getPokemonDetails(name);
    Map<String, dynamic>? speciesData;
    try {
      speciesData = await _datasource.getPokemonSpecies(name);
    } catch (_) {
      // Species might fail for some pokemon, continue without description
    }

    final types = (pokemonData['types'] as List<dynamic>?)
            ?.map((t) => (t['type']?['name'] as String?) ?? '')
            .where((s) => s.isNotEmpty)
            .toList() ??
        [];

    final weaknesses = <String>{};
    for (final typeName in types) {
      try {
        final typeData = await _datasource.getTypeDetails(typeName);
        final damageFrom = (typeData['damage_relations']?['double_damage_from']
                as List<dynamic>?)
            ?.map((t) => (t['name'] as String?) ?? '')
            .where((s) => s.isNotEmpty)
            .toList() ??
            [];
        weaknesses.addAll(damageFrom);
      } catch (_) {
        // Ignore type fetch errors
      }
    }

    final pokemon = PokemonMapper.fromApiResponses(
      pokemonData,
      speciesData,
      weaknesses.toList()..sort(),
    );
    return [pokemon];
  }

  @override
  Future<List<Pokemon>> getPokemonSpecies({String name = ''}) async {
    // Species endpoint returns species data; we need pokemon data for full entity.
    // Delegate to getPokemonDetails which fetches both.
    return getPokemonDetails(name: name);
  }

  @override
  Future<PokemonListItem?> getPokemonListItem(String name) async {
    final list = await getPokemonDetails(name: name);
    if (list.isEmpty) return null;
    final pokemon = list.first;
    return PokemonListItem(
      id: pokemon.id,
      name: pokemon.name,
      types: pokemon.types,
      imageUrl: pokemon.imageUrl,
    );
  }
}
