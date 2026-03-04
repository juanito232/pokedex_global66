import 'package:dio/dio.dart';
import 'package:pokedex_global66/data/models/pokeapi/pokeapi_list_response.dart';
import 'package:pokedex_global66/domain/datasources/pokemon_datasource.dart';
import 'package:pokedex_global66/domain/entities/pokemon_list_entry.dart';

class PokeAPIDatasourceImpl extends PokemonDatasource {
  final _dio = Dio(BaseOptions(baseUrl: 'https://pokeapi.co/api/v2'));

  @override
  Future<List<PokemonListEntry>> getPokemonList({
    int offset = 0,
    int limit = 10,
  }) async {
    final response = await _dio.get<Map<String, dynamic>>(
      '/pokemon',
      queryParameters: {'offset': offset, 'limit': limit},
    );
    final apiResponse =
        PokeApiListResponse.fromJson(response.data ?? <String, dynamic>{});
    return apiResponse.results
        .map((r) => PokemonListEntry(name: r.name, url: r.url))
        .toList();
  }

  @override
  Future<Map<String, dynamic>> getPokemonDetails(String name) async {
    final response = await _dio.get<Map<String, dynamic>>('/pokemon/$name');
    return response.data ?? <String, dynamic>{};
  }

  @override
  Future<Map<String, dynamic>> getPokemonSpecies(String name) async {
    final response = await _dio.get<Map<String, dynamic>>(
      '/pokemon-species/$name',
    );
    return response.data ?? <String, dynamic>{};
  }

  @override
  Future<Map<String, dynamic>> getTypeDetails(String typeName) async {
    final response = await _dio.get<Map<String, dynamic>>('/type/$typeName');
    return response.data ?? <String, dynamic>{};
  }
}
