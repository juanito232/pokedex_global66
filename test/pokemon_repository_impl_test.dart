import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pokedex_global66/data/repositories/pokemon_repository_impl.dart';
import 'package:pokedex_global66/domain/datasources/pokemon_datasource.dart';
import 'package:pokedex_global66/domain/entities/pokemon_list_entry.dart';

class MockPokemonDatasource extends Mock implements PokemonDatasource {}

void main() {
  late MockPokemonDatasource mockDatasource;
  late PokemonRepositoryImpl repository;

  setUp(() {
    mockDatasource = MockPokemonDatasource();
    repository = PokemonRepositoryImpl(mockDatasource);
  });

  group('getPokemonList', () {
    test('fetches list and maps entries to list items', () async {
      when(
        () => mockDatasource.getPokemonList(offset: 0, limit: 10),
      ).thenAnswer(
        (_) async => [
          const PokemonListEntry(
            name: 'pikachu',
            url: 'https://pokeapi.co/api/v2/pokemon/25',
          ),
        ],
      );
      when(() => mockDatasource.getPokemonDetails('pikachu')).thenAnswer(
        (_) async => <String, dynamic>{
          'id': 25,
          'name': 'pikachu',
          'types': [
            <String, dynamic>{
              'type': <String, dynamic>{'name': 'electric'},
            },
          ],
          'sprites': <String, dynamic>{
            'front_default': 'https://example.com/pikachu.png',
          },
        },
      );

      final result = await repository.getPokemonList(offset: 0, limit: 10);

      expect(result, hasLength(1));
      expect(result.first.id, 25);
      expect(result.first.name, 'pikachu');
      expect(result.first.types, ['electric']);
      verify(
        () => mockDatasource.getPokemonList(offset: 0, limit: 10),
      ).called(1);
      verify(() => mockDatasource.getPokemonDetails('pikachu')).called(1);
    });

    test('uses custom offset and limit', () async {
      when(
        () => mockDatasource.getPokemonList(offset: 20, limit: 5),
      ).thenAnswer((_) async => []);

      await repository.getPokemonList(offset: 20, limit: 5);

      verify(
        () => mockDatasource.getPokemonList(offset: 20, limit: 5),
      ).called(1);
    });
  });

  group('searchPokemonByName', () {
    test('returns empty list for empty query', () async {
      final result = await repository.searchPokemonByName('');
      expect(result, isEmpty);
      verifyNever(
        () => mockDatasource.getPokemonList(
          offset: any(named: 'offset'),
          limit: any(named: 'limit'),
        ),
      );
    });

    test('returns empty list for whitespace-only query', () async {
      final result = await repository.searchPokemonByName('   ');
      expect(result, isEmpty);
      verifyNever(
        () => mockDatasource.getPokemonList(
          offset: any(named: 'offset'),
          limit: any(named: 'limit'),
        ),
      );
    });

    test('searches and returns matching pokemon', () async {
      when(
        () => mockDatasource.getPokemonList(offset: 0, limit: 1500),
      ).thenAnswer(
        (_) async => [
          const PokemonListEntry(name: 'pikachu', url: ''),
          const PokemonListEntry(name: 'raichu', url: ''),
          const PokemonListEntry(name: 'charizard', url: ''),
        ],
      );
      when(() => mockDatasource.getPokemonDetails(any())).thenAnswer((
        invocation,
      ) async {
        final name = invocation.positionalArguments.first as String;
        return <String, dynamic>{
          'id': name == 'pikachu' ? 25 : 26,
          'name': name,
          'types': [],
          'sprites': <String, dynamic>{},
        };
      });

      final result = await repository.searchPokemonByName('pika');

      expect(result, hasLength(1));
      expect(result.first.name, 'pikachu');
    });

    test('returns empty when no matches', () async {
      when(
        () => mockDatasource.getPokemonList(offset: 0, limit: 1500),
      ).thenAnswer(
        (_) async => [const PokemonListEntry(name: 'charizard', url: '')],
      );

      final result = await repository.searchPokemonByName('pikachu');

      expect(result, isEmpty);
    });
  });

  group('getPokemonDetails', () {
    test('returns empty list for empty name', () async {
      final result = await repository.getPokemonDetails(name: '');
      expect(result, isEmpty);
      verifyNever(() => mockDatasource.getPokemonDetails(any()));
    });

    test('fetches pokemon with species and type details', () async {
      when(() => mockDatasource.getPokemonDetails('pikachu')).thenAnswer(
        (_) async => <String, dynamic>{
          'id': 25,
          'name': 'pikachu',
          'types': [
            <String, dynamic>{
              'type': <String, dynamic>{'name': 'electric'},
            },
          ],
          'abilities': [],
          'sprites': <String, dynamic>{'front_default': ''},
          'height': 4,
          'weight': 60,
        },
      );
      when(() => mockDatasource.getPokemonSpecies('pikachu')).thenAnswer(
        (_) async => <String, dynamic>{
          'flavor_text_entries': [
            <String, dynamic>{
              'language': <String, dynamic>{'name': 'en'},
              'flavor_text': 'A mouse.',
            },
          ],
          'genera': [],
          'gender_rate': 4,
        },
      );
      when(() => mockDatasource.getTypeDetails('electric')).thenAnswer(
        (_) async => <String, dynamic>{
          'damage_relations': <String, dynamic>{
            'double_damage_from': [
              <String, dynamic>{'name': 'ground'},
            ],
          },
        },
      );

      final result = await repository.getPokemonDetails(name: 'pikachu');

      expect(result, hasLength(1));
      expect(result.first.name, 'pikachu');
      expect(result.first.weaknesses, contains('ground'));
    });

    test('continues when species fetch fails', () async {
      when(() => mockDatasource.getPokemonDetails('pikachu')).thenAnswer(
        (_) async => <String, dynamic>{
          'id': 25,
          'name': 'pikachu',
          'types': [],
          'abilities': [],
          'sprites': <String, dynamic>{},
          'height': 0,
          'weight': 0,
        },
      );
      when(
        () => mockDatasource.getPokemonSpecies('pikachu'),
      ).thenThrow(Exception('API error'));

      final result = await repository.getPokemonDetails(name: 'pikachu');

      expect(result, hasLength(1));
      expect(result.first.description, '');
    });
  });

  group('getPokemonListItem', () {
    test('throws when datasource throws', () async {
      when(
        () => mockDatasource.getPokemonDetails('unknown'),
      ).thenThrow(Exception('Not found'));

      expect(
        () => repository.getPokemonListItem('unknown'),
        throwsA(isA<Exception>()),
      );
    });

    test('returns PokemonListItem when pokemon exists', () async {
      when(() => mockDatasource.getPokemonDetails('pikachu')).thenAnswer(
        (_) async => <String, dynamic>{
          'id': 25,
          'name': 'pikachu',
          'types': [
            <String, dynamic>{
              'type': <String, dynamic>{'name': 'electric'},
            },
          ],
          'abilities': [],
          'sprites': <String, dynamic>{'front_default': 'https://img.png'},
          'height': 0,
          'weight': 0,
        },
      );
      when(
        () => mockDatasource.getPokemonSpecies('pikachu'),
      ).thenAnswer((_) async => <String, dynamic>{});
      when(() => mockDatasource.getTypeDetails('electric')).thenAnswer(
        (_) async => <String, dynamic>{
          'damage_relations': <String, dynamic>{'double_damage_from': []},
        },
      );

      final result = await repository.getPokemonListItem('pikachu');

      expect(result, isNotNull);
      expect(result!.id, 25);
      expect(result.name, 'pikachu');
      expect(result.types, ['electric']);
      expect(result.imageUrl, 'https://img.png');
    });
  });
}
