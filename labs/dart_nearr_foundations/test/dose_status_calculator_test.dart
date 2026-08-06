import 'package:dart_nearr_foundations/dose_status.dart';
import 'package:dart_nearr_foundations/dose_status_calculator.dart';
import 'package:test/test.dart';

void main() {
  group('determineDoseStatus', () {
    test('returns taken when the dose is confirmed', () {
      final result = determineDoseStatus(
        isDoseConfirmed: true,
        isConfirmationWindowExpired: false,
      );

      expect(result, DoseStatus.taken);
    });

    test('keeps the dose taken even when the window has expired', () {
      final result = determineDoseStatus(
        isDoseConfirmed: true,
        isConfirmationWindowExpired: true,
      );

      expect(result, DoseStatus.taken);
    });

    test('returns pending while the confirmation window is open', () {
      final result = determineDoseStatus(
        isDoseConfirmed: false,
        isConfirmationWindowExpired: false,
      );

      expect(result, DoseStatus.pending);
    });

    test('returns missed after the confirmation window expires', () {
      final result = determineDoseStatus(
        isDoseConfirmed: false,
        isConfirmationWindowExpired: true,
      );

      expect(result, DoseStatus.missed);
    });
  });

  group('shouldSendMissedDoseAlert', () {
    test('returns true for a missed dose when alerts are enabled', () {
      final result = shouldSendMissedDoseAlert(
        status: DoseStatus.missed,
        caregiverAlertsEnabled: true,
      );

      expect(result, isTrue);
    });

    test('returns false when caregiver alerts are disabled', () {
      final result = shouldSendMissedDoseAlert(
        status: DoseStatus.missed,
        caregiverAlertsEnabled: false,
      );

      expect(result, isFalse);
    });

    test('returns false for a taken dose', () {
      final result = shouldSendMissedDoseAlert(
        status: DoseStatus.taken,
        caregiverAlertsEnabled: true,
      );

      expect(result, isFalse);
    });

    test('returns false for a pending dose', () {
      final result = shouldSendMissedDoseAlert(
        status: DoseStatus.pending,
        caregiverAlertsEnabled: true,
      );

      expect(result, isFalse);
    });
  });
}
