import 'package:dart_nearr_foundations/refill_calculator.dart';
import 'package:dart_nearr_foundations/refill_message.dart';

void main() {
  const appName = 'Nearr';
  const tabletsPerDose = 1;
  const dosesPerDay = 2;
  const refillThresholdDays = 3;

  final medicineName = 'Morning Tablet';
  final lovedOneName = 'Amma';
  final remainingTablets = 6;
  final createdAt = DateTime.now();

  final tabletsNeededPerDay = calculateTabletsNeededPerDay(
    tabletsPerDose: tabletsPerDose,
    dosesPerDay: dosesPerDay,
  );

  final estimatedDaysRemaining = estimateFullDaysRemaining(
    remainingTablets: remainingTablets,
    tabletsNeededPerDay: tabletsNeededPerDay,
  );

  final refillStatus = determineRefillStatus(
    estimatedDaysRemaining: estimatedDaysRemaining,
    refillThresholdDays: refillThresholdDays,
  );

  final refillMessage = buildRefillMessage(
    status: refillStatus,
    medicineName: medicineName,
    estimatedDaysRemaining: estimatedDaysRemaining,
  );

  final shouldSendAlert = shouldSendRefillAlert(
    status: refillStatus,
    alertsEnabled: true,
    caregiverLinked: true,
  );

  final immediateAttention = requiresImmediateAttention(refillStatus);

  print('$appName medicine summary');
  print('Medicine: $medicineName');
  print('Loved one: $lovedOneName');
  print('Tablets remaining: $remainingTablets');
  print('Tablets required each day: $tabletsNeededPerDay');
  print('Estimated full days remaining: $estimatedDaysRemaining');
  print('Refill status: ${refillStatus.name}');
  print('Message: $refillMessage');
  print('Should send alert: $shouldSendAlert');
  print('Requires immediate attention: $immediateAttention');
  print('Summary created at: $createdAt');
}
