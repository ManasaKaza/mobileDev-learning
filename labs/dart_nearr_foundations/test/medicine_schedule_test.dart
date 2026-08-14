import 'package:dart_nearr_foundations/medicine_schedule.dart';
import 'package:test/test.dart';

void main() {
  group('createDefaultReminderHours', () {
    test('creates the default reminder schedule', () {
      final result = createDefaultReminderHours();

      expect(result, [8, 14, 20]);
    });
  });

  group('addReminderHour', () {
    test('adds and sorts a valid reminder hour', () {
      final reminders = [8, 14, 20];

      addReminderHour(reminderHours: reminders, hour: 6);

      expect(reminders, [6, 8, 14, 20]);
    });

    test('does not add duplicate reminder hours', () {
      final reminders = [8, 14, 20];

      addReminderHour(reminderHours: reminders, hour: 8);

      expect(reminders, [8, 14, 20]);
    });

    test('rejects an hour below zero', () {
      final reminders = [8, 14, 20];

      expect(
        () => addReminderHour(reminderHours: reminders, hour: -1),
        throwsArgumentError,
      );
    });

    test('rejects an hour above 23', () {
      final reminders = [8, 14, 20];

      expect(
        () => addReminderHour(reminderHours: reminders, hour: 24),
        throwsArgumentError,
      );
    });
  });

  group('removeReminderHour', () {
    test('removes an existing reminder', () {
      final reminders = [8, 14, 20];

      final removed = removeReminderHour(reminderHours: reminders, hour: 14);

      expect(removed, isTrue);
      expect(reminders, [8, 20]);
    });

    test('returns false when reminder does not exist', () {
      final reminders = [8, 14, 20];

      final removed = removeReminderHour(reminderHours: reminders, hour: 6);

      expect(removed, isFalse);
      expect(reminders, [8, 14, 20]);
    });
  });

  group('buildReminderLabels', () {
    test('creates a label for each reminder', () {
      final result = buildReminderLabels([8, 14, 20]);

      expect(result, ['8:00', '14:00', '20:00']);
    });

    test('returns an empty list for no reminders', () {
      final result = buildReminderLabels([]);

      expect(result, isEmpty);
    });
  });

  group('countMorningReminders', () {
    test('counts morning reminders correctly', () {
      final result = countMorningReminders([8, 14, 20]);

      expect(result, 1);
    });

    test('returns zero when there are no morning reminders', () {
      final result = countMorningReminders([14, 20]);

      expect(result, 0);
    });

    test('returns count for an empty list', () {
      final result = countMorningReminders([]);

      expect(result, 0);
    });
  });

  group('hasEveningReminders', () {
    test('detects an evening reminder', () {
      final result = hasEveningReminders([8, 14, 20]);

      expect(result, isTrue);
    });

    test('returns false when there is no evening reminder', () {
      final result = hasEveningReminders([6, 8, 14]);

      expect(result, isFalse);
    });
  });

  group('areAllRemindersValid', () {
    test('validates all reminder hours', () {
      final result = areAllRemindersValid([6, 8, 14, 20]);

      expect(result, isTrue);
    });

    test('returns false when any reminder hour is invalid', () {
      final result = areAllRemindersValid([6, 25]);

      expect(result, isFalse);
    });
  });
}
