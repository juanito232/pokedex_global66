import 'package:freezed_annotation/freezed_annotation.dart';

part 'pokemon_list_item.freezed.dart';

@freezed
abstract class PokemonListItem with _$PokemonListItem {
  const factory PokemonListItem({
    required int id,
    required String name,
    required List<String> types,
    required String imageUrl,
  }) = _PokemonListItem;
}