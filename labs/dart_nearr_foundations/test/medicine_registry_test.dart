import 'package:dart_nearr_foundations/medicine_registry.dart';
import 'package:test/test.dart';

void main() {
  group('active medicine names', () {
    test('stores unique medicine names', () {
      final medicines = <String>{'Vitamin D', 'Vitamin D', 'Metformin'};

      expect(medicines, {'Vitamin D', 'Metformin'});
    });

    test('checks whether a medicine exists', () {
      final medicines = createActiveMedicineNames();

      expect(medicines.contains('Metformin'), isTrue);
    });
  });

  group('reminder counts', () {
    test('returns a reminder count when medicine exists', () {
      final counts = createReminderCounts();

      final result = findReminderCount(
        reminderCounts: counts,
        medicineName: 'Vitamin D',
      );

      expect(result, 3);
    });

    test('returns null when medicine does not exist', () {
      final counts = createReminderCounts();

      final result = findReminderCount(
        reminderCounts: counts,
        medicineName: 'Aspirin',
      );

      expect(result, isNull);
    });

    test('can add a new reminder count', () {
      final counts = createReminderCounts();

      setReminderCount(
        reminderCounts: counts,
        medicineName: 'Iron',
        reminderCount: 2,
      );

      expect(counts['Iron'], 2);
    });

    test('rejects negative reminder counts', () {
      final counts = createReminderCounts();

      expect(
        () => setReminderCount(
          reminderCounts: counts,
          medicineName: 'Iron',
          reminderCount: -1,
        ),
        throwsArgumentError,
      );
    });
  });
}
