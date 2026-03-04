import 'package:freezed_annotation/freezed_annotation.dart';

part 'pokeapi_list_response.freezed.dart';
part 'pokeapi_list_response.g.dart';

@freezed
abstract class PokeApiListResponse with _$PokeApiListResponse {
  const factory PokeApiListResponse({
    required int count,
    required String? next,
    required String? previous,
    required List<PokeApiResult> results,
  }) = _PokeApiListResponse;

  factory PokeApiListResponse.fromJson(Map<String, dynamic> json)
  => _$PokeApiListResponseFromJson(json);
}

@freezed
abstract class PokeApiResult with _$PokeApiResult {
  const factory PokeApiResult({
    required String name,
    required String url,
  }) = _PokeApiResult;

  factory PokeApiResult.fromJson(Map<String, dynamic> json)
  => _$PokeApiResultFromJson(json);
}