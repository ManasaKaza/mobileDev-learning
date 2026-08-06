import 'package:dart_nearr_foundations/refill_message.dart';
import 'package:dart_nearr_foundations/refill_status.dart';
import 'package:test/test.dart';

void main() {
  group('buildRefillMessage', () {
    test('creates an out-of-stock message', () {
      final result = buildRefillMessage(
        status: RefillStatus.outOfStock,
        medicineName: 'Vitamin D',
        estimatedDaysRemaining: 0,
      );

      expect(result, 'Vitamin D is out of stock. Refill it immediately.');
    });

    test('creates an urgent message', () {
      final result = buildRefillMessage(
        status: RefillStatus.urgent,
        medicineName: 'Vitamin D',
        estimatedDaysRemaining: 1,
      );

      expect(result, 'Vitamin D has only 1 full day remaining.');
    });

    test('creates a refill-soon message', () {
      final result = buildRefillMessage(
        status: RefillStatus.refillSoon,
        medicineName: 'Vitamin D',
        estimatedDaysRemaining: 3,
      );

      expect(
        result,
        'Vitamin D has approximately 3 full days remaining. Plan a refill.',
      );
    });

    test('creates a sufficient-stock message', () {
      final result = buildRefillMessage(
        status: RefillStatus.sufficient,
        medicineName: 'Vitamin D',
        estimatedDaysRemaining: 10,
      );

      expect(result, 'Vitamin D has sufficient stock for now.');
    });
  });
}
