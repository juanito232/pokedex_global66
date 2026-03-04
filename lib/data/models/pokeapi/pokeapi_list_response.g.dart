// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pokeapi_list_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_PokeApiListResponse _$PokeApiListResponseFromJson(Map<String, dynamic> json) =>
    _PokeApiListResponse(
      count: (json['count'] as num).toInt(),
      next: json['next'] as String?,
      previous: json['previous'] as String?,
      results: (json['results'] as List<dynamic>)
          .map((e) => PokeApiResult.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$PokeApiListResponseToJson(
  _PokeApiListResponse instance,
) => <String, dynamic>{
  'count': instance.count,
  'next': instance.next,
  'previous': instance.previous,
  'results': instance.results,
};

_PokeApiResult _$PokeApiResultFromJson(Map<String, dynamic> json) =>
    _PokeApiResult(name: json['name'] as String, url: json['url'] as String);

Map<String, dynamic> _$PokeApiResultToJson(_PokeApiResult instance) =>
    <String, dynamic>{'name': instance.name, 'url': instance.url};
