import 'package:dart_nearr_foundations/dose_status_stream.dart';
import 'package:test/test.dart';

void main() {
  group('doseStatusUpdates', () {
    test('emits pending then taken', () async {
      final values = await doseStatusUpdates(delay: Duration.zero).toList();

      expect(values, ['pending', 'taken']);
    });
  });

  group('reminderCountdown', () {
    test('counts down to zero', () async {
      final values = await reminderCountdown(
        seconds: 3,
        interval: Duration.zero,
      ).toList();

      expect(values, [3, 2, 1, 0]);
    });

    test('rejects negative seconds', () async {
      expect(
        () => reminderCountdown(seconds: -1, interval: Duration.zero).toList(),
        throwsArgumentError,
      );
    });
  });

  group('stockUpdates', () {
    test('emits stock until zero', () async {
      final values = await stockUpdates(
        startingStock: 3,
        interval: Duration.zero,
      ).toList();

      expect(values, [3, 2, 1, 0]);
    });

    test('rejects negative starting stock', () async {
      expect(
        () => stockUpdates(startingStock: -1, interval: Duration.zero).toList(),
        throwsArgumentError,
      );
    });
  });
}
