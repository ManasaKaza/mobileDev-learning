import 'package:dart_nearr_foundations/medicine.dart';
import 'package:test/test.dart';

void main() {
  group('Medicine construction', () {
    test('creates a valid medicine', () {
      final medicine = Medicine(
        name: 'Vitamin D',
        remainingTablets: 14,
        reminderHours: [20, 8, 14],
      );

      expect(medicine.name, 'Vitamin D');
      expect(medicine.remainingTablets, 14);
      expect(medicine.reminderHours, [8, 14, 20]);
    });

    test('rejects an empty name', () {
      expect(
        () => Medicine(name: '   ', remainingTablets: 14, reminderHours: [8]),
        throwsArgumentError,
      );
    });

    test('rejects negative stock', () {
      expect(
        () => Medicine(
          name: 'Vitamin D',
          remainingTablets: -1,
          reminderHours: [8],
        ),
        throwsArgumentError,
      );
    });

    test('rejects invalid reminder hours', () {
      expect(
        () => Medicine(
          name: 'Vitamin D',
          remainingTablets: 14,
          reminderHours: [8, 25],
        ),
        throwsArgumentError,
      );
    });

    test('rejects duplicate reminder hours', () {
      expect(
        () => Medicine(
          name: 'Vitamin D',
          remainingTablets: 14,
          reminderHours: [8, 8],
        ),
        throwsArgumentError,
      );
    });
  });

  group('Medicine behaviour', () {
    test('records a dose and reduces stock', () {
      final medicine = Medicine(
        name: 'Vitamin D',
        remainingTablets: 2,
        reminderHours: [8],
      );

      medicine.recordDoseTaken();

      expect(medicine.remainingTablets, 1);
    });

    test('does not allow stock to go below zero', () {
      final medicine = Medicine(
        name: 'Vitamin D',
        remainingTablets: 0,
        reminderHours: [8],
      );

      expect(medicine.recordDoseTaken, throwsStateError);
    });

    test('adds and sorts a reminder', () {
      final medicine = Medicine(
        name: 'Vitamin D',
        remainingTablets: 14,
        reminderHours: [14, 20],
      );

      medicine.addRemainderHour(8);

      expect(medicine.reminderHours, [8, 14, 20]);
    });

    test('does not add duplicate reminder hours', () {
      final medicine = Medicine(
        name: 'Vitamin D',
        remainingTablets: 14,
        reminderHours: [8, 14],
      );

      medicine.addRemainderHour(8);

      expect(medicine.reminderHours, [8, 14]);
    });

    test('calculates complete remaining days', () {
      final medicine = Medicine(
        name: 'Vitamin D',
        remainingTablets: 14,
        reminderHours: [8, 14, 20],
      );

      expect(medicine.estimateFullDaysRemaining(), 4);
    });
  });

  test('reports whether medicine is out of stock', () {
    final medicine = Medicine(
      name: 'Vitamin D',
      remainingTablets: 0,
      reminderHours: [8],
    );

    expect(medicine.isOutOfStock, isTrue);
  });

  test('returns the first reminder hour', () {
    final medicine = Medicine(
      name: 'Vitamin D',
      remainingTablets: 14,
      reminderHours: [14, 8, 20],
    );

    expect(medicine.nextReminderHour, 8);
  });

  test('returns null when no reminders are scheduled', () {
    final medicine = Medicine(
      name: 'Vitamin D',
      remainingTablets: 14,
      reminderHours: [],
    );

    expect(medicine.nextReminderHour, null);
  });
}
