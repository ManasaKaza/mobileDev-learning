import 'package:dart_nearr_foundations/string_extensions.dart';
import 'package:test/test.dart';

void main() {
  group('NearrStringExtensions', () {
    test('detects blank strings', () {
      expect('   '.isBlank, isTrue);
      expect('Vitamin D'.isBlank, isFalse);
    });

    test('normalizes strings', () {
      expect('  Vitamin D  '.normalized, 'Vitamin D');
    });

    test('capitalizes value', () {
      expect('vitamin D'.capitalized, 'Vitamin D');
    });
  });
}
