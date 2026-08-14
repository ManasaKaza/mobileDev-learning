Set<String> createActiveMedicineNames() {
  return {'Vitamin D', 'Metformin', 'Calcium'};
}

void addMedicineName({
  required Set<String> medicines,
  required String medicineName,
}) {
  medicines.add(medicineName);
}

bool removeMedicineName({
  required Set<String> medicines,
  required String medicineName,
}) {
  return medicines.remove(medicineName);
}

Map<String, int> createReminderCounts() {
  return {'Vitamin D': 3, 'Metformin': 2, 'Calcium': 1};
}

int getReminderCount({
  required Map<String, int> reminderCounts,
  required String medicineName,
}) {
  return reminderCounts[medicineName] ?? 0;
}

int? findReminderCount({
  required Map<String, int> reminderCounts,
  required String medicineName,
}) {
  return reminderCounts[medicineName];
}

void setReminderCount({
  required Map<String, int> reminderCounts,
  required String medicineName,
  required int reminderCount,
}) {
  if (reminderCount < 0) {
    throw ArgumentError.value(
      reminderCount,
      'reminderCount',
      'cannot be negative',
    );
  }

  reminderCounts[medicineName] = reminderCount;
}

String describeMedicineReminderCount({
  required Map<String, int> reminderCounts,
  required String medicineName,
}) {
  if (reminderCounts[medicineName] == null) {
    return '$medicineName is not registered';
  } else {
    return '$medicineName has ${reminderCounts[medicineName]} reminders';
  }
}
