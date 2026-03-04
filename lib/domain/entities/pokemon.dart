
import 'package:freezed_annotation/freezed_annotation.dart';
part 'pokemon.freezed.dart';

/// [genderRate] is the chance of being female in eighths (0-8), or -1 for genderless.
@freezed
abstract class Pokemon with _$Pokemon {
  const factory Pokemon({
    required int id,
    required String name,
    required String description,
    required double height,
    required double weight,
    required List<String> types,
    required List<String> abilities,
    required String imageUrl,
    required String category,
    required int genderRate,
    required List<String> weaknesses,
  }) = _Pokemon;
}