import 'dose_status.dart';

DoseStatus determineDoseStatus({
  required bool isDoseConfirmed,
  required bool isConfirmationWindowExpired,
}) {
  if (isDoseConfirmed && !isConfirmationWindowExpired) {
    return DoseStatus.taken;
  }
  if (isDoseConfirmed && isConfirmationWindowExpired) {
    return DoseStatus.taken;
  }
  if (!isDoseConfirmed && isConfirmationWindowExpired) {
    return DoseStatus.missed;
  }
  if (!isDoseConfirmed && !isConfirmationWindowExpired) {
    return DoseStatus.pending;
  }

  return DoseStatus.pending;
}

bool shouldSendMissedDoseAlert({
  required DoseStatus status,
  required bool caregiverAlertsEnabled,
}) {
  return status == DoseStatus.missed && caregiverAlertsEnabled;
}
