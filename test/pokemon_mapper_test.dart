import 'package:flutter_test/flutter_test.dart';
import 'package:pokedex_global66/data/mappers/pokemon_mapper.dart';
import 'package:pokedex_global66/domain/entities/pokemon.dart';
import 'package:pokedex_global66/domain/entities/pokemon_list_item.dart';

void main() {
  group('PokemonMapper', () {
    group('toListItem', () {
      test('maps valid pokemon data to PokemonListItem', () {
        final data = <String, dynamic>{
          'id': 25,
          'name': 'pikachu',
          'types': [
            <String, dynamic>{'type': <String, dynamic>{'name': 'electric'}},
          ],
          'sprites': <String, dynamic>{'front_default': 'https://example.com/pikachu.png'},
        };

        final result = PokemonMapper.toListItem(data);

        expect(result, isA<PokemonListItem>());
        expect(result.id, 25);
        expect(result.name, 'pikachu');
        expect(result.types, ['electric']);
        expect(result.imageUrl, 'https://example.com/pikachu.png');
      });

      test('handles missing optional fields with defaults', () {
        const data = <String, dynamic>{};

        final result = PokemonMapper.toListItem(data);

        expect(result.id, 0);
        expect(result.name, '');
        expect(result.types, isEmpty);
        expect(result.imageUrl, '');
      });

      test('handles multiple types', () {
        final data = <String, dynamic>{
          'id': 6,
          'name': 'charizard',
          'types': [
            <String, dynamic>{'type': <String, dynamic>{'name': 'fire'}},
            <String, dynamic>{'type': <String, dynamic>{'name': 'flying'}},
          ],
          'sprites': <String, dynamic>{'front_default': ''},
        };

        final result = PokemonMapper.toListItem(data);

        expect(result.types, ['fire', 'flying']);
      });

      test('filters out empty type names', () {
        final data = <String, dynamic>{
          'id': 1,
          'name': 'test',
          'types': [
            <String, dynamic>{'type': <String, dynamic>{'name': 'fire'}},
            <String, dynamic>{'type': <String, dynamic>{'name': null}},
            <String, dynamic>{'type': null},
          ],
          'sprites': <String, dynamic>{},
        };

        final result = PokemonMapper.toListItem(data);

        expect(result.types, ['fire']);
      });
    });

    group('fromApiResponses', () {
      test('maps valid pokemon and species data to Pokemon', () {
        final pokemonData = <String, dynamic>{
          'id': 25,
          'name': 'pikachu',
          'types': [
            <String, dynamic>{'type': <String, dynamic>{'name': 'electric'}},
          ],
          'abilities': [
            <String, dynamic>{'ability': <String, dynamic>{'name': 'static'}},
          ],
          'sprites': <String, dynamic>{'front_default': 'https://example.com/pikachu.png'},
          'height': 4,
          'weight': 60,
        };

        final speciesData = <String, dynamic>{
          'flavor_text_entries': [
            <String, dynamic>{
              'language': <String, dynamic>{'name': 'en'},
              'flavor_text': 'When several of these Pokémon gather, their electricity could build and cause lightning storms.',
            },
          ],
          'genera': [
            <String, dynamic>{'language': <String, dynamic>{'name': 'en'}, 'genus': 'Pokémon Mouse'},
          ],
          'gender_rate': 4,
        };

        final result = PokemonMapper.fromApiResponses(
          pokemonData,
          speciesData,
          ['ground'],
        );

        expect(result, isA<Pokemon>());
        expect(result.id, 25);
        expect(result.name, 'pikachu');
        expect(result.types, ['electric']);
        expect(result.abilities, ['static']);
        expect(result.imageUrl, 'https://example.com/pikachu.png');
        expect(result.height, 4.0);
        expect(result.weight, 60.0);
        expect(result.description, isNotEmpty);
        expect(result.category, 'Mouse');
        expect(result.genderRate, 4);
        expect(result.weaknesses, ['ground']);
      });

      test('handles null speciesData', () {
        final pokemonData = <String, dynamic>{
          'id': 1,
          'name': 'test',
          'types': [],
          'abilities': [],
          'sprites': <String, dynamic>{},
          'height': 0,
          'weight': 0,
        };

        final result = PokemonMapper.fromApiResponses(
          pokemonData,
          null,
          [],
        );

        expect(result.description, '');
        expect(result.category, '');
        expect(result.genderRate, -1);
      });

      test('strips "Pokémon " prefix from genus', () {
        final pokemonData = <String, dynamic>{
          'id': 1,
          'name': 'test',
          'types': [],
          'abilities': [],
          'sprites': <String, dynamic>{},
          'height': 0,
          'weight': 0,
        };

        final speciesData = <String, dynamic>{
          'genera': [
            <String, dynamic>{'language': <String, dynamic>{'name': 'en'}, 'genus': 'Pokémon Mouse'},
          ],
        };

        final result = PokemonMapper.fromApiResponses(
          pokemonData,
          speciesData,
          [],
        );

        expect(result.category, 'Mouse');
      });

      test('replaces newlines in flavor text with spaces', () {
        final pokemonData = <String, dynamic>{
          'id': 1,
          'name': 'test',
          'types': [],
          'abilities': [],
          'sprites': <String, dynamic>{},
          'height': 0,
          'weight': 0,
        };

        final speciesData = <String, dynamic>{
          'flavor_text_entries': [
            <String, dynamic>{
              'language': <String, dynamic>{'name': 'en'},
              'flavor_text': 'Line one\nLine two',
            },
          ],
        };

        final result = PokemonMapper.fromApiResponses(
          pokemonData,
          speciesData,
          [],
        );

        expect(result.description, 'Line one Line two');
      });
    });
  });
}
