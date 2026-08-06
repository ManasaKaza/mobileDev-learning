import 'refill_status.dart';

String buildRefillMessage({
  required RefillStatus status,
  required String medicineName,
  required int estimatedDaysRemaining,
}) {
  switch (status) {
    case RefillStatus.outOfStock:
      return '$medicineName is out of stock. Refill it immediately.';

    case RefillStatus.urgent:
      return '$medicineName has only $estimatedDaysRemaining full day remaining.';

    case RefillStatus.refillSoon:
      return '$medicineName has approximately '
          '$estimatedDaysRemaining full days remaining. Plan a refill.';

    case RefillStatus.sufficient:
      return '$medicineName has sufficient stock for now.';
  }
}
