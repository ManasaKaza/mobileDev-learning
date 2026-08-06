import 'package:dart_nearr_foundations/refill_calculator.dart';
import 'package:dart_nearr_foundations/refill_status.dart';
import 'package:test/test.dart';

void main() {
  group('calculateTabletsNeededPerDay', () {
    test('calculates daily tablet consumption', () {
      final result = calculateTabletsNeededPerDay(
        tabletsPerDose: 1,
        dosesPerDay: 2,
      );

      expect(result, 2);
    });

    test('rejects zero tablets per dose', () {
      expect(
        () => calculateTabletsNeededPerDay(tabletsPerDose: 0, dosesPerDay: 2),
        throwsArgumentError,
      );
    });
  });

  group('estimateFullDaysRemaining', () {
    test('returns the number of complete remaining days', () {
      final result = estimateFullDaysRemaining(
        remainingTablets: 15,
        tabletsNeededPerDay: 2,
      );

      expect(result, 7);
    });

    test('rejects a zero daily requirement', () {
      expect(
        () => estimateFullDaysRemaining(
          remainingTablets: 14,
          tabletsNeededPerDay: 0,
        ),
        throwsArgumentError,
      );
    });
  });

  group('isRefillNeededSoon', () {
    test('returns true when days equal the default threshold', () {
      final result = isRefillNeededSoon(estimatedDaysRemaining: 3);

      expect(result, isTrue);
    });

    test('returns false when enough days remain', () {
      final result = isRefillNeededSoon(estimatedDaysRemaining: 7);

      expect(result, isFalse);
    });

    test('supports a custom refill threshold', () {
      final result = isRefillNeededSoon(
        estimatedDaysRemaining: 5,
        thresholdDays: 7,
      );

      expect(result, isTrue);
    });

    group('determineRefillStatus', () {
      test('returns outOfStock when no full days remain', () {
        final result = determineRefillStatus(estimatedDaysRemaining: 0);

        expect(result, RefillStatus.outOfStock);
      });

      test('returns urgent at the urgent boundary', () {
        final result = determineRefillStatus(estimatedDaysRemaining: 1);

        expect(result, RefillStatus.urgent);
      });

      test('returns refillSoon between urgent and refill thresholds', () {
        final result = determineRefillStatus(estimatedDaysRemaining: 2);

        expect(result, RefillStatus.refillSoon);
      });

      test('returns refillSoon at the refill threshold', () {
        final result = determineRefillStatus(estimatedDaysRemaining: 3);

        expect(result, RefillStatus.refillSoon);
      });

      test('returns sufficient above the refill threshold', () {
        final result = determineRefillStatus(estimatedDaysRemaining: 4);

        expect(result, RefillStatus.sufficient);
      });

      test('rejects negative estimated days', () {
        expect(
          () => determineRefillStatus(estimatedDaysRemaining: -1),
          throwsArgumentError,
        );
      });

      test('rejects a refill threshold below the urgent threshold', () {
        expect(
          () => determineRefillStatus(
            estimatedDaysRemaining: 2,
            urgentThresholdDays: 3,
            refillThresholdDays: 2,
          ),
          throwsArgumentError,
        );
      });

      group('shouldSendRefillAlert', () {
        test(
          'returns true when attention is needed and alerts can be sent',
          () {
            final result = shouldSendRefillAlert(
              status: RefillStatus.refillSoon,
              alertsEnabled: true,
              caregiverLinked: true,
            );

            expect(result, isTrue);
          },
        );

        test('returns false when stock is sufficient', () {
          final result = shouldSendRefillAlert(
            status: RefillStatus.sufficient,
            alertsEnabled: true,
            caregiverLinked: true,
          );

          expect(result, isFalse);
        });

        test('returns false when alerts are disabled', () {
          final result = shouldSendRefillAlert(
            status: RefillStatus.urgent,
            alertsEnabled: false,
            caregiverLinked: true,
          );

          expect(result, isFalse);
        });

        test('returns false when no caregiver is linked', () {
          final result = shouldSendRefillAlert(
            status: RefillStatus.urgent,
            alertsEnabled: true,
            caregiverLinked: false,
          );

          expect(result, isFalse);
        });
      });
    });

    group('canWaitUntilNextWeek', () {
      test('returns true with sufficient stock for at least seven days', () {
        final result = canWaitUntilNextWeek(
          status: RefillStatus.sufficient,
          estimatedDaysRemaining: 7,
        );

        expect(result, isTrue);
      });

      test('returns false when fewer than seven days remain', () {
        final result = canWaitUntilNextWeek(
          status: RefillStatus.sufficient,
          estimatedDaysRemaining: 6,
        );

        expect(result, isFalse);
      });

      test('returns false when refill is already needed', () {
        final result = canWaitUntilNextWeek(
          status: RefillStatus.refillSoon,
          estimatedDaysRemaining: 7,
        );

        expect(result, isFalse);
      });
    });
  });
}
