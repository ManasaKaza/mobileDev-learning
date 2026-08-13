import 'dose_status.dart';

String buildDoseStatusMessage({
  required DoseStatus status,
  required String medicineName,
}) {
  switch (status) {
    case DoseStatus.missed:
      return '$medicineName was not confirmed in time.';
    case DoseStatus.taken:
      return '$medicineName was confirmed as taken.';
    case DoseStatus.pending:
      return '$medicineName is waiting for confirmation.';
  }
}
