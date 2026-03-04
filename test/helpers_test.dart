import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pokedex_global66/utils/helpers.dart';

void main() {
  group('Helpers', () {
    group('capitalize', () {
      test('returns empty string for empty input', () {
        expect(Helpers.capitalize(''), '');
      });

      test('capitalizes first letter of single character', () {
        expect(Helpers.capitalize('a'), 'A');
      });

      test('capitalizes first letter of word', () {
        expect(Helpers.capitalize('pikachu'), 'Pikachu');
      });

      test('leaves rest of string unchanged', () {
        expect(Helpers.capitalize('hello world'), 'Hello world');
      });
    });

    group('colorForType', () {
      test('returns color for known type (lowercase)', () {
        final color = Helpers.colorForType('fire');
        expect(color, isA<Color>());
        expect(color.toARGB32(), 0xFFFF9D55);
      });

      test('returns color for known type (uppercase)', () {
        final color = Helpers.colorForType('FIRE');
        expect(color, isA<Color>());
        expect(color.toARGB32(), 0xFFFF9D55);
      });

      test('returns fallback color for unknown type', () {
        final color = Helpers.colorForType('unknown');
        expect(color, isA<Color>());
        expect(color.toARGB32(), 0xFFA8A878);
      });
    });

    group('imagePathForType', () {
      test('returns null for empty string', () {
        expect(Helpers.imagePathForType(''), isNull);
      });

      test('returns null for whitespace only', () {
        expect(Helpers.imagePathForType('   '), isNull);
      });

      test('returns path for supported type', () {
        expect(Helpers.imagePathForType('fire'), 'assets/types/fire.svg');
      });

      test('normalizes to lowercase', () {
        expect(Helpers.imagePathForType('FIRE'), 'assets/types/fire.svg');
      });

      test('trims whitespace', () {
        expect(Helpers.imagePathForType('  fire  '), 'assets/types/fire.svg');
      });

      test('returns null for unsupported type', () {
        expect(Helpers.imagePathForType('unknown'), isNull);
      });

      test('returns path for all supported types', () {
        const supportedTypes = [
          'bug', 'dark', 'dragon', 'electric', 'fairy', 'fighting', 'fire',
          'flying', 'ghost', 'grass', 'ground', 'ice', 'normal', 'poison',
          'psychic', 'rock', 'steel', 'water',
        ];
        for (final type in supportedTypes) {
          expect(
            Helpers.imagePathForType(type),
            'assets/types/$type.svg',
            reason: 'Failed for type: $type',
          );
        }
      });
    });
  });
}
