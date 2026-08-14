String buildMedicineNoteLabel({required String medicineName, String? note}) {
  final noteText = note ?? 'No additional note';

  return '$medicineName: $noteText';
}
