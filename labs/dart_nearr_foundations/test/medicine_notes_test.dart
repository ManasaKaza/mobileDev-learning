import 'package:dart_nearr_foundations/medicine_notes.dart';
import 'package:test/test.dart';

void main() {
  group('buildMedicineNoteLabel', () {
    test('includes a medicine note when available', () {
      final result = buildMedicineNoteLabel(
        medicineName: 'Vitamin D',
        note: 'Take after breakfast',
      );

      expect(result, 'Vitamin D: Take after breakfast');
    });

    test('uses fallback text when note is null', () {
      final result = buildMedicineNoteLabel(
        medicineName: 'Vitamin D',
        note: null,
      );

      expect(result, 'Vitamin D: No additional note');
    });

    test('also works when note is omitted', () {
      final result = buildMedicineNoteLabel(medicineName: 'Vitamin D');

      expect(result, 'Vitamin D: No additional note');
    });
  });
}
