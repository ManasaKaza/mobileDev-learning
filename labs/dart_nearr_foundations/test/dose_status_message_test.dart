import 'package:dart_nearr_foundations/dose_status.dart';
import 'package:dart_nearr_foundations/dose_status_message.dart';
import 'package:test/test.dart';

void main() {
  group('buildDoseStatusMessage', () {
    test('creates a pending-dose message', () {
      final result = buildDoseStatusMessage(
        status: DoseStatus.pending,
        medicineName: 'Morning Tablet',
      );

      expect(result, 'Morning Tablet is waiting for confirmation.');
    });

    test('creates a taken-dose message', () {
      final result = buildDoseStatusMessage(
        status: DoseStatus.taken,
        medicineName: 'Morning Tablet',
      );

      expect(result, 'Morning Tablet was confirmed as taken.');
    });

    test('creates a missed-dose message', () {
      final result = buildDoseStatusMessage(
        status: DoseStatus.missed,
        medicineName: 'Morning Tablet',
      );

      expect(result, 'Morning Tablet was not confirmed in time.');
    });
  });
}
