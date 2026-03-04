import 'package:freezed_annotation/freezed_annotation.dart';

part 'pokemon_list_entry.freezed.dart';

/// Domain DTO for a pokemon list item from the datasource.
/// Keeps the domain layer independent of API-specific models.
@freezed
abstract class PokemonListEntry with _$PokemonListEntry {
  const factory PokemonListEntry({
    required String name,
    required String url,
  }) = _PokemonListEntry;
}
