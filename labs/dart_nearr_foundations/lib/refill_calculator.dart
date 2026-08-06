import 'refill_status.dart';

int calculateTabletsNeededPerDay({
  required int tabletsPerDose,
  required int dosesPerDay,
}) {
  if (tabletsPerDose <= 0) {
    throw ArgumentError.value(
      tabletsPerDose,
      'tabletsPerDose',
      'must be greater than zero',
    );
  }

  if (dosesPerDay <= 0) {
    throw ArgumentError.value(
      dosesPerDay,
      'dosesPerDay',
      'must be greater than zero',
    );
  }

  return tabletsPerDose * dosesPerDay;
}

int estimateFullDaysRemaining({
  required int remainingTablets,
  required int tabletsNeededPerDay,
}) {
  if (remainingTablets < 0) {
    throw ArgumentError.value(
      remainingTablets,
      'remainingTablets',
      'cannot be negative',
    );
  }

  if (tabletsNeededPerDay <= 0) {
    throw ArgumentError.value(
      tabletsNeededPerDay,
      'tabletsNeededPerDay',
      'must be greater than zero',
    );
  }

  return remainingTablets ~/ tabletsNeededPerDay;
}

bool isRefillNeededSoon({
  required int estimatedDaysRemaining,
  int thresholdDays = 3,
}) {
  if (estimatedDaysRemaining < 0) {
    throw ArgumentError.value(
      estimatedDaysRemaining,
      'estimatedDaysRemaining',
      'cannot be negative',
    );
  }

  if (thresholdDays < 0) {
    throw ArgumentError.value(
      thresholdDays,
      'thresholdDays',
      'cannot be negative',
    );
  }

  return estimatedDaysRemaining <= thresholdDays;
}

RefillStatus determineRefillStatus({
  required int estimatedDaysRemaining,
  int urgentThresholdDays = 1,
  int refillThresholdDays = 3,
}) {
  if (estimatedDaysRemaining < 0) {
    throw ArgumentError.value(
      estimatedDaysRemaining,
      'estimatedDaysRemaining',
      'cannot be negative',
    );
  }

  if (urgentThresholdDays < 0) {
    throw ArgumentError.value(
      urgentThresholdDays,
      'urgentThresholdDays',
      'cannot be negative',
    );
  }

  if (refillThresholdDays < urgentThresholdDays) {
    throw ArgumentError.value(
      refillThresholdDays,
      'refillThresholdDays',
      'must be greater than or equal to urgentThresholdDays',
    );
  }

  if (estimatedDaysRemaining == 0) {
    return RefillStatus.outOfStock;
  }

  if (estimatedDaysRemaining <= urgentThresholdDays) {
    return RefillStatus.urgent;
  }

  if (estimatedDaysRemaining <= refillThresholdDays) {
    return RefillStatus.refillSoon;
  }

  return RefillStatus.sufficient;
}

bool shouldSendRefillAlert({
  required RefillStatus status,
  required bool alertsEnabled,
  required bool caregiverLinked,
}) {
  final refillRequiresAttention = status != RefillStatus.sufficient;

  return refillRequiresAttention && alertsEnabled && caregiverLinked;
}

bool requiresImmediateAttention(RefillStatus status) {
  return status == RefillStatus.outOfStock || status == RefillStatus.urgent;
}

bool canWaitUntilNextWeek({
  required RefillStatus status,
  required int estimatedDaysRemaining,
}) {
  if (estimatedDaysRemaining < 0) {
    throw ArgumentError.value(
      estimatedDaysRemaining,
      'estimatedDaysRemaining',
      'cannot be negative',
    );
  }

  return status == RefillStatus.sufficient && estimatedDaysRemaining >= 7;
}
